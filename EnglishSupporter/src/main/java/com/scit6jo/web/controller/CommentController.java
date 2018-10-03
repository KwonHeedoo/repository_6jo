package com.scit6jo.web.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.scit6jo.web.repository.BoardRepository;
import com.scit6jo.web.repository.CommentRepository;
import com.scit6jo.web.repository.MypageRepository;
import com.scit6jo.web.vo.Board;
import com.scit6jo.web.vo.Comment;
import com.scit6jo.web.vo.Schedule;

@Controller
public class CommentController {
	@Autowired
	CommentRepository repository;
	@Autowired
	BoardRepository boardRepository;
	@Autowired
	MypageRepository mypageRepository;
	
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
		System.out.println(board.getAppointedTime());
		String userid = board.getUserid();
		String matchingId = board.getMatchingId();
		
		String title = "1:1 Practice Appointment-"+userid+"/"+matchingId;
		Schedule meetings = new Schedule(userid, title, "false", board.getAppointedTime());
		Schedule meetings2 = new Schedule(matchingId, title, "false", board.getAppointedTime());
		// 아이디별로 각각 저장 
		mypageRepository.saveSchedule(meetings);
		mypageRepository.saveSchedule(meetings2);
		
		// 매칭 처리
		Map<String, Object> map = new HashMap<>();
		map.put("board", board);
		map.put("boardType", boardType);
		map.put("comment", comment);
		
	    String roomnum = getRandomString(15);
	    board.setRoomNum(roomnum);
		// 게시판에 매칭 여부 추가
		boardRepository.matching(board);
		System.out.println(roomnum);
		// 매칭 처리
		int result = repository.matching(map);
		
		return result;
	}
	
	// 1:1 화상 채팅 매칭 취소
	@RequestMapping(value = "/unmatching", method = RequestMethod.POST)
	public @ResponseBody int unmatching(Board board, String boardType, Comment comment){
		// 스케줄 처리 
		System.out.println(board);
		String userid = board.getUserid();
		String matchingId = board.getMatchingId();
		String title = "1:1 Practice Appointment-"+userid+"/"+matchingId;
		Schedule s1 = new Schedule(userid, title);
		Schedule s2 = new Schedule(matchingId, title);
		System.out.println(s1);
		System.out.println(s2);
		System.out.println(title);
		//아이디별로 삭제해주기 
		mypageRepository.deleteSchedule(s1);
		mypageRepository.deleteSchedule(s2);
		
		//매칭 취소 처리
		board.setMatchingId(null);
		comment.setMatchingId(null);
		Map<String, Object> map = new HashMap<>();
		map.put("board", board);
		map.put("boardType", boardType);
		map.put("comment", comment);
		map.put("roomnum", null);
		
		// 게시판에 매칭 여부 취소
		boardRepository.unmatching(board);
		// 매칭 취소 처리
		int result = repository.matching(map);
		
		return result;
	}
	
	// 평가 평균 가져오기
	@RequestMapping(value = "/getRatingAvg", method = RequestMethod.POST)
	public @ResponseBody Comment getRatingAvg(Board board){
		System.out.println("avg board : " + board);
		// 게시판에 매칭 여부 취소
		// 매칭 취소 처리
		Comment result = repository.selectRatingAvg(board);
		System.out.println("avg result : " + result);
		return result;
	}
	
	private static String getRandomString(int length)
	{
	  StringBuffer buffer = new StringBuffer();
	  Random random = new Random();
	  String chars[] = "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z".split(",");
	    
	 
	  for (int i=0 ; i<length ; i++)
	  {
	    buffer.append(chars[random.nextInt(chars.length)]);
	  }
	  return buffer.toString();
	}
}
