package com.scit6jo.web.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.scit6jo.web.repository.BoardRepository;
import com.scit6jo.web.repository.CommentRepository;
import com.scit6jo.web.vo.Board;
import com.scit6jo.web.vo.Comment;

@Controller
public class CommentController {
	@Autowired
	CommentRepository repository;
	@Autowired
	BoardRepository boardRepository;
	
	// 코멘트 리스트 요청
	@RequestMapping(value = "/commentList", method = RequestMethod.GET)
	public @ResponseBody ArrayList<Comment> commentList(String boardNum, String boardType){
		Map<String, Object> map = new HashMap<>();
		map.put("boardNum", Integer.parseInt(boardNum));
		map.put("boardType", boardType);
		
		ArrayList<Comment> commentList = repository.selectAll(map);
		
		return commentList;
	}
	
	// 코멘트 작성 처리
	@RequestMapping(value="/insertComment", method=RequestMethod.POST)
	public @ResponseBody int insertComment(HttpSession session, Comment comment, String reply, String boardType) {
		Map<String, Object> map = new HashMap<>();
		map.put("comment", comment);
		map.put("boardType", boardType);
		map.put("reply", reply);
		
		int result = repository.insertComment(map);
	
		return result;
	}
	
	// 코멘트 수정 처리
	@RequestMapping(value="/updateComment", method=RequestMethod.POST)
	public @ResponseBody int updateComment(HttpSession session, Comment comment, String boardType) {
		Map<String, Object> map = new HashMap<>();
		map.put("comment", comment);
		map.put("boardType", boardType);
		
		int result = repository.updateComment(map); 
		
		return result;
	}
	
	// 코멘트 삭제 처리
	@RequestMapping(value="/deleteComment", method=RequestMethod.GET)
	public @ResponseBody int deleteComment(String commentNum, String groupNum, String boardType) {
		int result = 0;
		
		Map<String, Object> map = new HashMap<>();
		map.put("commentNum", Integer.parseInt(commentNum));
		map.put("groupNum", Integer.parseInt(groupNum));
		map.put("boardType", boardType);
		map.put("check", true);
		
		// 부모 코멘트이면서 자식 코멘트가 달린 경우 삭제하지 않고 내용을 삭제댓글로 변경
		Comment check = repository.selectOne(map);
		if(check != null) {
			map.put("check", false);
			Comment comment = repository.selectOne(map);
			if(comment.getCommentNum() == Integer.parseInt(commentNum)) {
				//comment.setUserid("*****");
				comment.setNickname("*****");
				comment.setComments("[ 삭제된 코멘트 입니다. ]");
				
				map.put("comment", comment);
				int update = repository.updateComment(map);
				
				return update;
			}else {
				result = repository.deleteComment(map);
			}
		}else {
			result = repository.deleteComment(map);
		}
		
		return result;
	}
	
	// 1:1 화상 채팅 매칭 처리
	@RequestMapping(value = "/matching", method = RequestMethod.POST)
	public @ResponseBody int matching(Board board, String boardType, Comment comment){
		// 스케줄 처리
		
		// 매칭 처리
		Map<String, Object> map = new HashMap<>();
		map.put("board", board);
		map.put("boardType", boardType);
		map.put("comment", comment);
		
		// 게시판에 매칭 여부 추가
		boardRepository.matching(board);
		// 매칭 처리
		int result = repository.matching(map);
		
		return result;
	}
	
	// 1:1 화상 채팅 매칭 취소
	@RequestMapping(value = "/unmatching", method = RequestMethod.POST)
	public @ResponseBody int unmatching(Board board, String boardType, Comment comment){
		// 스케줄 처리
		
		//매칭 취소 처리
		board.setMatchingId(null);
		comment.setMatchingId(null);
		Map<String, Object> map = new HashMap<>();
		map.put("board", board);
		map.put("boardType", boardType);
		map.put("comment", comment);
		
		// 게시판에 매칭 여부 취소
		boardRepository.unmatching(board);
		// 매칭 취소 처리
		int result = repository.matching(map);
		
		return result;
	}
}
