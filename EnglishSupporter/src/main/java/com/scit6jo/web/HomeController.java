package com.scit6jo.web;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.scit6jo.web.repository.DataRepository;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	DataRepository repository;
	
	final String video_uploadPath = "/ES_uploadPath/video";
	final String image_uploadPath = "/ES_uploadPath/images";
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		
		return "home";
	}

	@RequestMapping(value = "/goMypage", method = RequestMethod.GET)
	public String goMypage() {
		
		return "mypage/myInfo";
	}

}
