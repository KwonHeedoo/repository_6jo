package com.scit6jo.web.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.scit6jo.web.repository.ResumeRepository;
import com.scit6jo.web.vo.resume.CoverLetter;
import com.scit6jo.web.vo.resume.Resume;

@Controller
public class ResumeController {
	@Autowired
	ResumeRepository repository;	
	
	@RequestMapping(value = "/goResumeForm", method = RequestMethod.GET)
	public String goResumeForm(Model model) {
		System.out.println("going to ResumeForm...");
		
		return "resume/resumeForm";
	}
		

	@RequestMapping(value = "/goCoverletter", method = RequestMethod.GET)
	public String goCoverletter(Model model) {
		System.out.println("going to goCoverletter...");
		CoverLetter vo = new CoverLetter();
		vo.setUserid("admin");
		vo.setTitle("sample1");
		
		CoverLetter sample= repository.getCoverletter(vo);
		//System.out.println(sample);
		
		model.addAttribute("sample", sample);
		return "resume/coverletterForm";
	}
	
	// 이력서랑 커버레터 개괄 받기 
	@RequestMapping(value = "/goMyDocs", method = RequestMethod.GET)
	public String myDocs(Model model, HttpSession session) {
		System.out.println("going to myDocs...");
		String userid = (String) session.getAttribute("loginId");
		
		List<Resume> resumeList = repository.resumeList(userid);
		List<CoverLetter> clList = repository.coverletterList(userid);
		
		model.addAttribute("resumeList", resumeList);
		model.addAttribute("clList", clList);
				
		
		return "resume/myDocs";
	}
	
	@RequestMapping(value = "/sendCoverletter", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public @ResponseBody String saveCoverletter(@RequestBody CoverLetter coverletter) {
		System.out.println("saving a new CoverLetter...");
		String text =null;
		int num = repository.insertCoverLetter(coverletter);
		if(num>0) {
			text = "커버레터 저장 완료 ";
		}else {
			text = "커버레터 저장 실패! 동일한 title로 중복 저장되지 않으니 확인해주세요.";
		}
		return text;
	}
	

	@RequestMapping(value = "/sendresumeForm", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public @ResponseBody String newResume(@RequestBody Resume resume) {
		System.out.println("saving a new Resume...");
		String text=null;

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
		
		if(insertResume>0||insertEdu>0||insertExp>0||insertInfo>0) {
			text = "이력서 저장 완료";
		}else {
			text = "이력서 저장 실패! 동일한 title로 중복 저장되지 않으니 확인해주세요.";
		}
		
		return text;
	}
	
	// 이력서 상세보기 페이지 
	@RequestMapping(value = "/viewMyResume", method = RequestMethod.GET, produces = "application/text; charset=utf8")
	public String viewMyResume(String userid, String title, Model model) {
		  // resume_no 로 처리되는 것을 확인하면 파라매터/ 매퍼 변경하자 resume+_no 로 
		 Resume myResume = repository.selectResume(userid, title);
		 System.out.println(myResume);
		 model.addAttribute("resume", myResume);
		 
		return "resume/viewResume";
	}
	
	//커버레터 상세보기 페이지 
	@RequestMapping(value = "/viewMyCoverletter", method = RequestMethod.GET, produces = "application/text; charset=utf8")
	public String viewCoverLetter(String title, String userid, Model model) {
		
		
		return "resume/viewCoverletter";
	}
	
	//이력서 및 커버레터 삭제 
	@RequestMapping(value = "/deleteDocs", method = RequestMethod.GET, produces = "application/text; charset=utf8")
	public @ResponseBody String deleteDocs(String title, String userid, String type) {
		System.out.println(type);
		String result = null;
		int cntR =0;
		int cntC =0;
		if(type.equals("resume")) {
			Resume resume = new Resume(userid, title);
			String resume_no = repository.getResumeNo(resume);
			cntR = repository.removeResumes(resume_no);
		}else{ // 커버레터
			CoverLetter vo = new CoverLetter(title, userid);
			cntC = repository.removeCoverLetter(vo);
		}
		
		if(cntR>0||cntC>0) {
			result = "삭제가 완료되었습니다.";
		}else {
			result="삭제실패!";
			System.out.println("삭제실패"+cntR+"이력서/커버레터"+cntC);
		}
		return result;
	}
	
}
