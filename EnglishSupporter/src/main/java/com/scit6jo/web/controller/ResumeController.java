package com.scit6jo.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.scit6jo.web.repository.ResumeRepository;
import com.scit6jo.web.vo.resume.Resume;

@Controller
public class ResumeController {
	@Autowired
	ResumeRepository repository;
	
	@RequestMapping(value = "/goResumeForm", method = RequestMethod.GET)
	public String goLoginForm() {
		System.out.println("going to ResumeForm...");
		
		return "resume/resumeForm";
	}

	@RequestMapping(value = "/goCoverletter", method = RequestMethod.GET)
	public String goCoverletter() {
		System.out.println("going to goCoverletter...");
		
		return "resume/coverletterForm";
	}
	
	@RequestMapping(value = "/goMyDocs", method = RequestMethod.GET)
	public String myDocs() {
		System.out.println("going to myDocs...");
		
		return "resume/myDocs";
	}


	@RequestMapping(value = "/sendresumeForm", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public @ResponseBody String newResume(@RequestBody Resume resume) {
		System.out.println("saving a new Resume...");

		System.out.println(resume);
		int insertResume = repository.insertResume(resume);
		String resume_no = repository.getResumeNo(resume);
		System.out.println(insertResume+"/이력서드감/"+resume_no);
		
		
		int insertEdu = repository.insertEdu(resume_no,resume.getEducation());
		int insertExp = repository.insertExp(resume_no,resume.getExperience());
		int insertInfo = repository.insertInfo(resume_no,resume.getAdditional_info());
		System.out.println("학력삽입수"+insertEdu);
		System.out.println("경력삽입수"+insertExp);
		System.out.println("정보삽입수"+insertInfo);
		
		
		return "컨트롤러단에서 받음";
	}
	
}
