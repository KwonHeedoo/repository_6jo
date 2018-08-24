package com.scit6jo.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MypageController {
	
	@RequestMapping(value = "/goInfoModify", method = RequestMethod.GET)
	public String goInfoModify() {
		System.out.println("going to InfoModify...");
		
		return "mypage/infoModify";
	}
	
}
