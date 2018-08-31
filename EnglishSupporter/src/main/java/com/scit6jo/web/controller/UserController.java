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
	UserRepository Repository;

	@RequestMapping(value = "/goRegisterForm", method = RequestMethod.GET)
	public String goRegisterForm() {

		return "user/registerForm";
	}
	
	@RequestMapping(value ="/idcheck" , method=RequestMethod.POST)
	public @ResponseBody Integer idcheck(User user) {
		if(user.getUserid().length() < 3 || user.getUserid().length() > 10 ) return -1;
		
		User u = Repository.selectOne(user);
		
		if( u != null) return 1;
		else return 0;
	}
	
	
	
	
	@RequestMapping(value = "/goLoginForm", method = RequestMethod.GET)
	public String goLoginForm() {
		System.out.println("going to LoginForm...");
		
		return "user/loginForm";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(User user, HttpSession session, Model model) {
		System.out.println("login");
		
		User u = Repository.selectOne(user);
	    
		if(u != null) {
			session.setAttribute("loginId", u.getUserid());
			session.setAttribute("loginNick", u.getNickname());
			session.setAttribute("email", u.getEmail());
			session.setAttribute("username", u.getUsername());
			session.setAttribute("loginType", u.getUsertype());
			
			Repository.attendNum(user); //출석일수
		}
	
		System.out.println(user);
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		System.out.println("logout");
		
		session.invalidate();
		
		return "redirect:/";

	}
	
}
