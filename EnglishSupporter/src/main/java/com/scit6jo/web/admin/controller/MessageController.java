package com.scit6jo.web.admin.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.scit6jo.web.admin.repository.MessageRepository;
import com.scit6jo.web.admin.vo.Message;

@Controller
public class MessageController {
	@Autowired
	MessageRepository repository;
	
	// 관리자 페이지 요청
	@RequestMapping(value = "/goAdminPage", method = RequestMethod.GET)
	public String goAdminPage(HttpSession session){
		System.out.println("Going to Administrator Page...");
		String userid = (String)session.getAttribute("loginId");
		
		// 읽지 않은 쪽지 요청
		ArrayList<Message> messageList = repository.unReadMsg(userid);
		session.setAttribute("messageList", messageList);
		session.setAttribute("msgCount", messageList.size());
		
		return "redirect:/goDashboard";
	}
	
	// 유저 페이지 요청
	@RequestMapping(value = "/goUserPage", method = RequestMethod.GET)
	public String goUserPage(HttpSession session){
		System.out.println("Going to User Page...");
		
		// 세션에 담긴 메세지 리스트 삭제
		session.removeAttribute("messageList");
		session.removeAttribute("msgCount");
		
		return "redirect:/";
	}
	
	// 쪽지 창 열기
	@RequestMapping(value = "/goMessageBox", method = RequestMethod.GET)
	public String goMessageBox(){
		System.out.println("Open the Message Box...");
		return "admin/messageBox";
	}
	
	// 쪽지 보내기
	@RequestMapping(value = "/sendMsg", method = RequestMethod.POST)
	public @ResponseBody int sendMsg(@RequestBody Message message){
		int result = repository.sendMsg(message);
		return result;
	}
	
	// 쪽지 페이지 요청
	@RequestMapping(value = "/goMessageList", method = RequestMethod.GET)
	public String goMessageList(){
		System.out.println("Going to MessageList Page...");
		
		return "admin/messageList";
	}
	
	// 모든 쪽지 리스트 요청
	@RequestMapping(value = "/messageList", method = RequestMethod.GET)
	public @ResponseBody ArrayList<Message> messageList(HttpSession session){
		System.out.println("Going to Administrator Page...");
		String userid = (String)session.getAttribute("loginId");
		
		ArrayList<Message> messageList = repository.selectAll(userid);
		return messageList;
	}
	
	// 쪽지 읽음 처리
	@RequestMapping(value = "/readMsg", method = RequestMethod.GET)
	public @ResponseBody int readMsg(int messageNum){
		int result = repository.readMsg(messageNum);
		return result;
	}
}
