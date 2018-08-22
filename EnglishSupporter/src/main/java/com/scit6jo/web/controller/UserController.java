package com.scit6jo.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.scit6jo.web.dao.UserRepository;
import com.scit6jo.web.vo.User;

@Controller
public class UserController {
	@Autowired
	UserRepository Repository;

	@RequestMapping(value = "/registerForm", method = RequestMethod.GET)
	public String registerForm(Model model) {

		return "user/registerForm";
	}
	
	@RequestMapping(value = "/goinsert", method = RequestMethod.GET)
	public String goinsert(User user) {
		
		
		return "user/register";
	}
	
}
