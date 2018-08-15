package com.scit6jo.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.scit6jo.web.dao.WordRepository;

@Controller
public class WordController {
	@Autowired
	WordRepository repository;
	
	/*@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		
		return "home";
	}*/
	
	@RequestMapping(value = "/wordtest", method = RequestMethod.GET)
	public String home(Model model) {
		
	return "wordpractice";
	}
	
}
