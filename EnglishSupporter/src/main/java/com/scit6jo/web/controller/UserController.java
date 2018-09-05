package com.scit6jo.web.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.scit6jo.web.repository.UserRepository;
import com.scit6jo.web.vo.User;

@Controller
public class UserController {
	@Autowired
	UserRepository repository;
	
	// 회원가입 폼 요청
	@RequestMapping(value = "/goRegisterForm", method = RequestMethod.GET)
	public String goRegisterForm() {

		return "user/registerForm";
	}
	
	// ID 체크
	@RequestMapping(value ="/idcheck" , method=RequestMethod.POST)
	public @ResponseBody Integer idcheck(User user) {
		if(user.getUserid().length() < 3 || user.getUserid().length() > 10 ) return -1;
		
		User u = repository.selectOne(user);
		
		if( u != null) return 1;
		else return 0;
	}
	
	//회원가입 정보기입
	@RequestMapping(value ="/insertUser" , method=RequestMethod.POST) 
	public String insertUser(User user) {
		
		System.out.println(user);
		int u = repository.insertUser(user);
		
		System.out.println(u);
		
		return "home";
	}
	
	
	@RequestMapping(value = "/goinsert", method = RequestMethod.GET)
	public String goinsert(User user) {
		
		
		return "user/register";
	}

	// 로그인 폼 요청
	@RequestMapping(value = "/goLoginForm", method = RequestMethod.GET)
	public String goLoginForm() {
		System.out.println("going to LoginForm...");
		
		return "user/loginForm";
	}
	
	// 로그인 처리
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(User user, HttpSession session, Model model) {
		System.out.println("login");
		
		User u = repository.selectOne(user);
	    
		if(u != null) {
			session.setAttribute("loginId", u.getUserid());
			session.setAttribute("loginNick", u.getNickname());
			session.setAttribute("email", u.getEmail());
			session.setAttribute("loginType", u.getUsertype());
			
			// 출석일수
			repository.attendNum(user); 
			
			// 방문자 등록
			repository.visit(u.getUserid());
		}
	
		System.out.println(user);
		
		return "redirect:/";
	}
	
	// 로그아웃 처리
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		System.out.println("logout");
		
		session.invalidate();
		
		return "redirect:/";

	}
	
	// 유저정보를 ajax로 받아옴..
	@RequestMapping(value = "/getUserInfo", method = RequestMethod.POST)
	public @ResponseBody User getUserInfo(String userid) {
		System.out.println(userid);
		User user = new User();
		user.setUserid(userid);
		User findUser =repository.selectOne(user);
		findUser.setUserpwd("0000");

		return findUser;
	}
	
}
