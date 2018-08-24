package com.scit6jo.web.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.scit6jo.web.dao.repository.UserRepository;
import com.scit6jo.web.vo.User;

@Controller
public class UserController {
	
	@Autowired
	UserRepository repository;
	
	@RequestMapping(value = "/goLoginForm", method = RequestMethod.GET)
	public String goLoginForm() {
		System.out.println("going to LoginForm...");
		
		return "user/loginForm";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(User user, HttpSession session, Model model) {
		System.out.println("login");
		
		User u = repository.selectOne(user);
	    
		if(u != null) {
			session.setAttribute("u", u);
			
			repository.attendNum(user); //출석일수
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
