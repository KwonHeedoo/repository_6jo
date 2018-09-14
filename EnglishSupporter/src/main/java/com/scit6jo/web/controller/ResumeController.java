package com.scit6jo.web.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.scit6jo.web.repository.ResumeRepository;
import com.scit6jo.web.repository.UserRepository;
import com.scit6jo.web.util.PageNavigator;
import com.scit6jo.web.vo.User;
import com.scit6jo.web.vo.resume.CoverLetter;
import com.scit6jo.web.vo.resume.Resume;

@Controller
public class ResumeController {
	@Autowired
	ResumeRepository repository;	
	@Autowired
	UserRepository userRepository;
	
	private static final int countPerPage = 10;
	private static final int pagePerGroup = 5;
	
	@RequestMapping(value = "/goResumeForm", method = RequestMethod.GET)
	public String goResumeForm(Model model) {
		System.out.println("going to ResumeForm...");
		
		return "resume/resumeForm";
	}
	
	//커버레터 샘플값 바꿔주기 
	@RequestMapping(value = "/selectSamples", method = RequestMethod.POST)
	public @ResponseBody String selectSamples(CoverLetter vo) {
		//System.out.println(vo);
		CoverLetter sample = repository.getCoverletter(vo);
		String sampletext="sampletext";
		if(sample!=null) {
			sampletext = sample.getMaintext();
		}
		return sampletext;
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
		model.addAttribute("type", "insert");
		return "resume/coverletterForm";
	}
	
	// 이력서랑 커버레터 개괄 받기 
	@RequestMapping(value = "/goMyDocs", method = RequestMethod.GET)
	public String myDocs(Model model, HttpSession session
			, @RequestParam(value="rpage", defaultValue="1") int rpage //resume
			, @RequestParam(value="cpage", defaultValue="1") int cpage // coverletter
			, @RequestParam(value="selectedTab", defaultValue="coverletter") String selectedTab ) {
		System.out.println("going to myDocs...");
		String userid = (String) session.getAttribute("loginId");
		
		int r_total = repository.getTotal("resume",userid);
		int c_total = repository.getTotal("coverletter",userid);
		
		PageNavigator r_navi = new PageNavigator(countPerPage, pagePerGroup, rpage, r_total);
		PageNavigator c_navi = new PageNavigator(countPerPage, pagePerGroup, cpage, c_total);
		
		RowBounds rbR = new RowBounds(r_navi.getStartRecord(), r_navi.getCountPerPage());
		RowBounds rbC = new RowBounds(c_navi.getStartRecord(), c_navi.getCountPerPage());
		
		List<Resume> resumeList = repository.resumeList(userid,rbR);
		List<CoverLetter> clList = repository.coverletterList(userid,rbC);
		
		model.addAttribute("resumeList", resumeList);
		model.addAttribute("clList", clList);
		model.addAttribute("selectedTab", selectedTab);
		model.addAttribute("r_navi", r_navi);
		model.addAttribute("c_navi", c_navi);
				
		return "resume/myDocs";
	}
	
	//커버레터 저장하기 
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
	
	//이력서 수정 페이지로 이동
	@RequestMapping(value = "/goUpdateResume", method = RequestMethod.GET)
	public String goUpdateResume(Model model, String resume_no) {
		Resume myResume = repository.getResume(resume_no);
		
		model.addAttribute("resume_no", resume_no);
		model.addAttribute("resume", myResume);
		return "resume/editResume";
	}
	
	//이력서 ajax로 받아오기...
	@RequestMapping(value = "/getResume", method = RequestMethod.POST)
	public @ResponseBody Resume getResume(Model model, String resume_no) {
		Resume myResume = repository.getResume(resume_no);
		
		return myResume;
	}

	
	
	//커버레터 수정
	@RequestMapping(value = "/updateCoverletter", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public @ResponseBody String updateCoverletter(@RequestBody CoverLetter coverletter) {
		System.out.println("saving a new CoverLetter...");
		String text =null;
		int num = repository.updateCoverletter(coverletter);
		if(num>0) {
			text = "커버레터 수정 완료 ";
		}else {
			text = "커버레터 수정 실패!";
		}
		return text;
	}
	//이력서 수정하기 
	@RequestMapping(value = "/updateResumeForm", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public @ResponseBody String updateResumeForm(@RequestBody Resume resume) {
		String text=null;
		System.out.println(resume);
		int check1 = repository.updateResume(resume);
		System.out.println("이력서 업데 + 학력경력이력삭제 :"+check1);
		
		int insertEdu = repository.insertEdu(resume.getResume_no(),resume.getEducation());
		int insertExp = repository.insertExp(resume.getResume_no(),resume.getExperience());
		int insertInfo = repository.insertInfo(resume.getResume_no(),resume.getAdditional_info());
		
		System.out.println("학력삽입수"+insertEdu);
		System.out.println("경력삽입수"+insertExp);
		System.out.println("정보삽입수"+insertInfo);
		
		if(check1>0&&(insertEdu>0||insertExp>0||insertInfo>0)) {
			text = "이력서 수정 완료";
		}else {
			text = "이력서 수정 실패!";
		}
		return text;
	}
	
	//이력서 저장하기 
	@RequestMapping(value = "/sendresumeForm", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public @ResponseBody String newResume(@RequestBody Resume resume) {
		System.out.println("saving a new Resume...");
		String text=null;
		//이력서 스케쥴 저장하기 
		System.out.println(resume);
		if(resume.getDeadline()!=null) {
			int rcnt=repository.insertResumeScedule(resume);
			System.out.println("스케줄 저장:"+rcnt);
		}
		
		int insertResume = repository.insertResume(resume);
		String resume_no = repository.getResumeNo(resume);
		System.out.println(insertResume+"/이력서드감/"+resume_no);		
		
		int insertEdu = repository.insertEdu(resume_no,resume.getEducation());
		int insertExp = repository.insertExp(resume_no,resume.getExperience());
		int insertInfo = repository.insertInfo(resume_no,resume.getAdditional_info());
		System.out.println("학력삽입수"+insertEdu);
		System.out.println("경력삽입수"+insertExp);
		System.out.println("정보삽입수"+insertInfo);
		
		if(insertResume>0&&(insertEdu>0||insertExp>0||insertInfo>0)) {
			text = "이력서 저장 완료";
		}else {
			text = "이력서 저장 실패! 동일한 title로 중복 저장되지 않으니 확인해주세요.";
		}
		
		return text;
	}
	
	// 이력서 상세보기 페이지 
	@RequestMapping(value = "/viewMyResume", method = RequestMethod.GET, produces = "application/text; charset=utf8")
	public String viewMyResume(String resume_no, Model model) {
		 Resume myResume = repository.getResume(resume_no);
		 
		 User user = userRepository.selectOne(new User(myResume.getUserid()));
		 
		 System.out.println(myResume);
		 System.out.println(user);
		 model.addAttribute("resume", myResume);
		 model.addAttribute("user", user);
		return "resume/viewResume";
	}
	
	//커버레터 상세보기 페이지 
	@RequestMapping(value = "/viewMyCoverletter", method = RequestMethod.GET, produces = "application/text; charset=utf8")
	public String viewCoverLetter(CoverLetter vo, Model model, HttpSession session) {
		CoverLetter myCL = repository.getCoverletter(vo);
		//System.out.println(myCL);
		model.addAttribute("myCL", myCL);
		return "resume/viewCoverletter";
	}

	//커버레터 update 양식으로 가기 
	@RequestMapping(value = "/updateMyCoverletter", method = RequestMethod.GET, produces = "application/text; charset=utf8")
	public String updateCoverLetter(CoverLetter vo, Model model, HttpSession session) {
		CoverLetter myCL = repository.getCoverletter(vo);
		System.out.println("go update cover letter");

		System.out.println(myCL);
		model.addAttribute("myCL", myCL);
		model.addAttribute("type", "update");
		return "resume/coverletterForm";
	}
	
	//이력서 및 커버레터 삭제 
	@RequestMapping(value = "/deleteDocs", method = {RequestMethod.POST,RequestMethod.GET}, produces = "application/text; charset=utf8")
	public @ResponseBody String deleteDocs(String title, String userid, String type, String resume_no) {
		// 이력서는 type resume_no
		// 커버레터는 type title, userid 필요
		System.out.println(type);
		String result = null;
		int cntR =0;
		int cntC =0;
		if(type.equals("resume")) {
			Resume findR = repository.getResume(resume_no); // 이력서 번호로 이력서값 읽어오기
			cntR = repository.removeResumes(resume_no);
			
			//이력서 데드라인 스케줄 삭제 
			repository.removeRschedule(findR.getTitle(),findR.getUserid());
			
		}else{ // 커버레터
			CoverLetter vo = new CoverLetter(title, userid);
			cntC = repository.removeCoverLetter(vo);
		}
		
		if(cntC==0&&cntR==0) {
			result="삭제실패!";
			System.out.println("삭제실패"+cntR+"이력서/커버레터"+cntC);
		}else {
			result = "삭제가 완료되었습니다.";
		}
		return result;
	}
	

	
}
