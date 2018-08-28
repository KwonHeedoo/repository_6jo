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

import com.scit6jo.web.dao.CommentRepository;
import com.scit6jo.web.vo.Comment;

@Controller
public class CommentController {
	@Autowired
	CommentRepository repository;
	
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
	public @ResponseBody int insertComment(Comment comment, String boardType) {
		Map<String, Object> map = new HashMap<>();
		map.put("comment", comment);
		map.put("boardType", boardType);
		
		int result = repository.insertComment(map);
	
		return result;
	}
	
	// 코멘트 수정 처리
	@RequestMapping(value="/updateComment", method=RequestMethod.POST)
	public @ResponseBody int updateComment(HttpSession session, Comment comment, String boardType) {
		String userid = (String)session.getAttribute("loginId");
		comment.setUserid(userid);
		
		Map<String, Object> map = new HashMap<>();
		map.put("comment", comment);
		map.put("boardType", boardType);
		
		int result = repository.updateComment(map);
			
		return result;
	}
	
	// 코멘트 삭제 처리
	@RequestMapping(value="/deleteComment", method=RequestMethod.GET)
	public @ResponseBody int deleteComment(String commentNum, String boardType) {
		Map<String, Object> map = new HashMap<>();
		map.put("commentNum", Integer.parseInt(commentNum));
		map.put("boardType", boardType);
		
		int result = repository.deleteComment(map);
				
		return result;
	}
}
