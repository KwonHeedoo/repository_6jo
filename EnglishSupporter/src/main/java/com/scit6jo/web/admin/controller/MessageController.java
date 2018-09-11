package com.scit6jo.web.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	public String goAdminPage(){
		System.out.println("Going to Administrator Page...");
		
		return "redirect:/goDashboard";
	}
	
	// 유저 페이지 요청
	@RequestMapping(value = "/goUserPage", method = RequestMethod.GET)
	public String goUserPage(){
		System.out.println("Going to User Page...");
		
		return "redirect:/";
	}
	
	// 읽지 않은 쪽지 요청
	@RequestMapping(value = "/msgList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> msgList(String userid){
		Map<String, Object> map = new HashMap<>();
		ArrayList<Message> messageList = repository.unReadMsg(userid);
		map.put("messageList", messageList);
		map.put("msgCount", messageList.size());
		
		return map;
	}
	
	// 쪽지 창 열기(보내기)
	@RequestMapping(value = "/goSendMsgBox", method = RequestMethod.GET)
	public String goMessageBox(Model model, String receiveId){
		model.addAttribute("receiveId", receiveId);
		System.out.println("Open the Send Message Box...");
		return "admin/sendMsgBox";
	}
	
	// 쪽지 창 열기(읽기)
	@RequestMapping(value = "/goReceiveMsgBox", method = RequestMethod.POST)
	public String goReceiveMsgBox(Model model, int messageNum, String userid, String nickname, String message){
		int result = repository.readMsg(messageNum);
		
		if(result == 1) {
			model.addAttribute("receiveId", userid);
			model.addAttribute("nickname", nickname);
			model.addAttribute("message", message);
			
			System.out.println("Open the Receive Message Box...");
		}
		return "admin/receiveMsgBox";
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
