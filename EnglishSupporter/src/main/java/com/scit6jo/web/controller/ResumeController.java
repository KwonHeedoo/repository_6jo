package com.scit6jo.web.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.w3c.dom.stylesheets.LinkStyle;

import com.scit6jo.web.vo.resume.Additional_info;
import com.scit6jo.web.vo.resume.Education;
import com.scit6jo.web.vo.resume.Experience;
import com.scit6jo.web.vo.resume.Resume;

@Controller
public class ResumeController {
	
	@RequestMapping(value = "/goResumeForm", method = RequestMethod.GET)
	public String goLoginForm() {
		System.out.println("going to ResumeForm...");
		
		return "resume/resumeForm";
	}
	
	@RequestMapping(value = "/sendresumeForm", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public @ResponseBody String newResume(@RequestBody Resume resume) {
		System.out.println("saving a new Resume...");

		System.out.println(resume);
		
		
		return "컨트롤러단에서 받음";
	}
	
}
