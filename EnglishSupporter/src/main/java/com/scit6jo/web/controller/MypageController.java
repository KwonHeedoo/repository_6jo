package com.scit6jo.web.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.scit6jo.web.repository.MypageRepository;
import com.scit6jo.web.repository.UserRepository;
import com.scit6jo.web.vo.User;


@Controller
public class MypageController {

	@Autowired
	MypageRepository repository;
	
	@Autowired
	UserRepository urepository;
	
	@RequestMapping(value = "/goInfoUpdate", method = RequestMethod.GET)
	public String goInfoUpdate(HttpSession session, Model model) {
		System.out.println("going to InfoUpdate...");
		
		// 세션의 loginId로 개인정보 가져오기  
		String userid = (String) session.getAttribute("loginId");
		User u = new User();
		u.setUserid(userid);
		User user = urepository.selectOne(u);
		
		user.setUserpwd("0000");	// 비밀번호 노출 방지 
		System.out.println(user);
		
		model.addAttribute("u", user);	// 기존 개인정보 띄워주는 용도
		
		return "mypage/infoUpdate";
	}
	
	
	
	@RequestMapping(value = "/infoUpdate", method = RequestMethod.POST)
	public String infoUpdate(String userid, String userpwd, String username, String nickname, String email, String birthdate, User u, Model model) {
		
		// 받아온 아이디와 패스워드로 해당 회원의 정보 가져오기  
		u.setUserid(userid);
		u.setUserpwd(userpwd);
		User user = urepository.selectOne(u);
		
		// 새로 입력받은 정보로 업데이트 
		user.setUsername(username);
		user.setNickname(nickname);
		user.setEmail(email);
		user.setBirthdate(birthdate);
				
		System.out.println(user);
		
		int result = repository.infoUpdate(user);
		
		// 업데이트 성공 여부에 따라 메시지 출력 
		String message = null;
		
		if(result == 1) {
			message = "Information Update Completed";
		}else {
			message = "Information Update Failed";
		}
		
		model.addAttribute("msg", message);
		
		return "mypage/infoUpdate";
	}
	
}
