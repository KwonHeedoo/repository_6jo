package com.scit6jo.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ResumeController {
	
	@RequestMapping(value = "/goResumeForm", method = RequestMethod.GET)
	public String goLoginForm() {
		System.out.println("going to ResumeForm...");
		
		return "resume/resumeForm";
	}
	
	@RequestMapping(value = "/newResume", method = RequestMethod.GET)
	public String newResume() {
		System.out.println("saving a new Resume...");
		
		return "resume/resumeForm";
	}
	
}
