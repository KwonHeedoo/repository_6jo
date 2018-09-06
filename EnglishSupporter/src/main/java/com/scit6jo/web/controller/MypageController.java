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

import com.scit6jo.web.repository.MypageRepository;
import com.scit6jo.web.repository.UserRepository;
import com.scit6jo.web.repository.WordRepository;
import com.scit6jo.web.vo.User;
import com.scit6jo.web.vo.Word;


@Controller
public class MypageController {

	@Autowired
	MypageRepository repository;
	
	@Autowired
	WordRepository wrepository;
	
	@Autowired
	UserRepository urepository;
	
	// 내단어장 화면 요청 
	@RequestMapping(value = "/goMyWords", method = RequestMethod.GET)
	public String goMyWords(HttpSession session, Model model) {
		System.out.println("going to MyWords...");
		
		// 세션의 loginId로 내단어장 목록 가져오기  
		String userid = (String) session.getAttribute("loginId");
		List<Word> wordlist = wrepository.getMyWords(userid);
		
		model.addAttribute("wordlist", wordlist);	
		
		return "mypage/myWords";
	}
	
	// 개인정보수정 화면 요청 
	@RequestMapping(value = "/goInfoUpdate", method = RequestMethod.GET)
	public String goInfoUpdate(HttpSession session, Model model) {
		System.out.println("going to InfoUpdate...");
		
		// 세션의 loginId로 개인정보 가져오기  
		String userid = (String) session.getAttribute("loginId");
		User u = new User();
		u.setUserid(userid);
		User user = urepository.selectOne(u);
		
		user.setUserpwd("0000");	// 비밀번호 노출 방지 
		System.out.println(user);
		
		model.addAttribute("u", user);	// 기존 개인정보 띄워주는 용도
		
		return "mypage/infoUpdate";
	}
	
	// 닉네임 중복체크 
	@RequestMapping(value = "nicknameCheck", method = RequestMethod.POST)
	public @ResponseBody Integer nicknameCheck(User user) {
		
		User u = repository.nicknameCheck(user);
		
		if(u != null) return 1;		// 사용 불가능한 닉네임
		else		  return 0;		// 사용 가능한 닉네임
	}
	
	// 개인정보수정 처리 요청 
	@RequestMapping(value = "/infoUpdate", method = RequestMethod.POST)
	public String infoUpdate(User u, HttpSession session, Model model) {
		
		System.out.println(u);
		
		int result = repository.infoUpdate(u);
		
		// 업데이트 성공 여부에 따라 메시지 출력 
		String message = null;
		
		if(result == 1) {
			message = "Information Update Completed";
			
			// 새로 업데이트된 정보로 재로그인 
			User uu = urepository.selectOne(u);		    
			if(uu != null) {
				session.setAttribute("loginId", uu.getUserid());
				session.setAttribute("loginNick", uu.getNickname());
				session.setAttribute("email", uu.getEmail());
				session.setAttribute("username", uu.getUsername());
				session.setAttribute("loginType", uu.getUsertype());
			}
			
		}else {
			message = "Information Update Failed";
		}
		
		model.addAttribute("msg", message);
		
		return "mypage/infoUpdate";
	}
	
	// 비밀번호수정 화면 요청
	@RequestMapping(value = "/goPwdChange", method = RequestMethod.GET)
	public String goPwdChange() {
		System.out.println("going to PwdChange...");
		
		return "mypage/pwdChange";
	}
	
	// 비밀번호수정 처리 요청
	@RequestMapping(value = "/pwdChange", method = RequestMethod.POST)
	public String pwdChange(String currpwd, String newpwd, HttpSession session, Model model) {
		System.out.println("PwdChange submitted...");
		
		String loginId = (String) session.getAttribute("loginId");
		
		int result = repository.pwdChange(loginId, currpwd, newpwd);
		
		String message = null;
		
		if(result==1) {
			message = "Password Change Completed. Please Login Again.";
			session.invalidate();
		}else {
			message = "Password Change Failed.";
		}
		
		model.addAttribute("msg", message);
		
		return "mypage/pwdChange";
	}

	// 회원탈퇴 화면 요청
	@RequestMapping(value = "/goUnregister", method = RequestMethod.GET)
	public String goUnregister() {
		System.out.println("going to Unregister...");
		
		return "mypage/unregister";
	}
	
	// 회원탈퇴시 비밀번호 인증 처리
	@RequestMapping(value = "pwdCheck", method = RequestMethod.POST)
	public @ResponseBody Integer pwdCheck(@RequestBody User user) {
		System.out.println("pwdCheck...");
		
		User u = urepository.selectOne(user);
		
		if(u != null) 	return 1;
		else 			return 0;
	}
	
	// 회원탈퇴 처리 요청
	@RequestMapping(value = "unregister", method = RequestMethod.POST)
	public @ResponseBody Integer unregister(@RequestBody User user, HttpSession session, Model model) {
		System.out.println("unregister...");
		
		int result = repository.unregister(user);        
		
		if(result == 1) {
			session.invalidate();
		}
		
		return result;
	}
}
