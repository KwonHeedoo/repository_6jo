package com.scit6jo.web.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.scit6jo.web.repository.MypageRepository;
import com.scit6jo.web.vo.User;


@Controller
public class MypageController {

	@Autowired
	MypageRepository repository;
	
	@RequestMapping(value = "/goInfoUpdate", method = RequestMethod.GET)
	public String goInfoUpdate() {
		System.out.println("going to InfoUpdate...");
		
		return "mypage/infoUpdate";
	}
	
	@RequestMapping(value = "nicknameCheck", method = RequestMethod.POST)
	public @ResponseBody Integer nicknameCheck(User user) {
		System.out.println("nickname Checking...");
		
		User u = repository.nicknameCheck(user);
		
		if(u != null) return 1;		// 사용 불가능한 닉네임
		else		  return 0;		// 사용 가능한 닉네임
	}
	
	@RequestMapping(value = "/infoUpdate", method = RequestMethod.POST)
	public void infoUpdate(String userid, String userpwd, String username, String nickname, String email, String birthdate, User user, Model model) {
		
		user.setUserid(userid);
		user.setUserpwd(userpwd);
		user.setUsername(username);
		user.setNickname(nickname);
		user.setEmail(email);
		user.setBirthdate(birthdate);
				
		int result = repository.infoUpdate(user);
		
		String message = null;
		
		if(result == 1) {
			message = "Information Update Completed";
		}else {
			message = "Information Update Failed";
		}
		
		model.addAttribute("msg", message);

	}
	
}
