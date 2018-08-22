package com.scit6jo.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.scit6jo.web.dao.BoardRepository;

@Controller
public class BoardController {
	@Autowired
	BoardRepository repository;
	
	// 1:1 화상 스터디 모집 게시판 요청
	@RequestMapping(value = "/goMatchingBoard", method = RequestMethod.GET)
	public String goMatchingBoard() {
		System.out.println("going to MatchingBoard...");
		
		return "interview/matchingBoard";
	}
}
