package com.scit6jo.web.controller;


import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Date;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.scit6jo.web.repository.UserRepository;
import com.scit6jo.web.vo.User;

@Controller
public class UserController {
	@Autowired
	UserRepository repository;
	
	private final String IMG_PATH = "C:\\ES_uploadPath\\profile";
	// 회원가입 폼 요청
	@RequestMapping(value = "/goRegisterForm", method = RequestMethod.GET)
	public String goRegisterForm() {

		return "user/registerForm";
	}
	
	// ID 체크
	@RequestMapping(value ="/idcheck" , method=RequestMethod.POST)
	public @ResponseBody Integer idcheck(User user) {
		if(user.getUserid().length() < 3 || user.getUserid().length() > 10 ) return -1;
		
		User u = repository.selectOne(user);
		
		if( u != null) return 1;
		else return 0;
	}
	
	@RequestMapping(value = "/getProfileImg", method = RequestMethod.GET)
	   public String getProfileImg(HttpServletResponse response,HttpSession session, String userid) {
		User user = new User();
		user.setUserid(userid);
	      User result = repository.selectOne(user);
	      String temp = result.getImgFilePath();
	      String originalfile = temp.substring(0, temp.lastIndexOf("."));
	      String fullPath = IMG_PATH + "/" + result.getImgFilePath();
	      
	      // 전체 경로 uploadPath +"/"+ board.getSavedfile() 하면 경로가됨
	      // header에 다운로드할 정보를 실어 보냄
	      try {
	         response.setHeader("Content-Disposition",
	               " attachment;filename=" + URLEncoder.encode(originalfile, "UTF-8"));
	         // 컴퓨터는 컨텐츠 타입을 중요하게 생각함
	         // String name에 아무정보를 넣으면 안되고 보낼 곳의 정보를 해줘야 한다. 브라우저에 어떤 파일이 전송되어 간다를 알려줌
	         // 그리고 만약 originalfile이름이 한글일 경우에는 utf-8로 변경해 줘야 한다.
	         // 소스, 어떤 방식으로 인코딩할래? 를 넣어주면 됨
	      } catch (UnsupportedEncodingException e) {
	         e.printStackTrace();
	      }

	      // stream을 통해 실제 다운로드 실시
	      FileInputStream fin = null;
	      ServletOutputStream fileout = null;

	      try {
	         fin = new FileInputStream(fullPath); // 경로를 넣어서 스트림을 생성
	         fileout = response.getOutputStream(); // outputStream 객체만 생성, 객체만 받아온다. 실제로 값을 뿌리는 것이 아니라
	         // 클라이언트가 요청한 것을 서버에서 자료를 보낼 때 reponse를 하는데 response를 할 때 stream타입에 request한 자료를
	         // 담아둔다.
	         // 긁어오는게 getOutStream의 역할이고, 그걸 SevletOutputStream에 담는다.

	         FileCopyUtils.copy(fin, fileout); // 실제 파일을 복사함
	         // 원래는 스트림에 넣어서 하나하나 담아서 뿌려야 하는데 FileCopyUtils가 알아서 해준다.

	         fin.close(); // 스트림 닫아주기
	         fileout.close(); // 스트림 닫아주기

	      } catch (Exception e) {
	         e.printStackTrace();
	      }

	      return null; // 다운하고 화면전환같은건 필요없어
	   }
	
	//회원가입 정보기입
	@RequestMapping(value ="/insertUser" , method=RequestMethod.POST) 
	public String insertUser(User user, MultipartFile imgInp, Model model) {
		File path = new File(IMG_PATH);
		if (!path.isDirectory()) {
			path.mkdirs();
		}
		if(!imgInp.isEmpty()) {
			String arr[] = imgInp.getContentType().split("/");
			// 이미지 파일인지 아닌지 확인
			if(!arr[0].equals("image")) {
				model.addAttribute("msg", "JPG 또는 JPEG, PNG등 사진파일만 올려주세요");
				return "user/registerForm";
			}
			Date date = new Date();
			String fileName = "" + date.getYear() + "-" + date.getMonth() + "_" + date.getDay() + "_"
							+ date.getHours() + "_" + date.getMinutes() + "_" + date.getSeconds() + imgInp.getOriginalFilename();
			String imgFilePath = IMG_PATH + "/" + fileName;
			try {
				FileOutputStream fos = new FileOutputStream(new File(imgFilePath));
				fos.write(imgInp.getBytes());
				System.out.println("fileName : " + fileName);
				user.setImgFilePath(fileName);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		int u = repository.insertUser(user);
		
		return "redirect:/";
	}
	
	
	@RequestMapping(value = "/goinsert", method = RequestMethod.GET)
	public String goinsert(User user) {
		
		return "user/register";
	}

	// 로그인 폼 요청
	@RequestMapping(value = "/goLoginForm", method = RequestMethod.GET)
	public String goLoginForm() {
		System.out.println("going to LoginForm...");
		
		return "user/loginForm";
	}
	
	// 로그인 처리
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String login(User user, HttpSession session, Model model) {
		User u = repository.selectOne(user);
		System.out.println(u);
	    
		if(u != null) {
			session.setAttribute("loginId", u.getUserid());
			session.setAttribute("loginNick", u.getNickname());
			session.setAttribute("email", u.getEmail());
			session.setAttribute("loginType", u.getUsertype());
			session.setAttribute("img", u.getImgFilePath());
			
			// 출석일수
			repository.attendNum(user); 
			// 방문자 등록
			repository.visit(u.getUserid());
			
			return "redirect:/";
		}else {
			String msg = "Please Check your ID and Password";
			model.addAttribute("msg", msg);
			
			return "user/loginForm";
		}
	}
	
	// 로그아웃 처리
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		System.out.println("logout");
		
		session.invalidate();
		
		return "redirect:/";

	}
	
	// 유저정보를 ajax로 받아옴..
	@RequestMapping(value = "/getUserInfo", method = RequestMethod.POST)
	public @ResponseBody User getUserInfo(String userid) {
		User user = new User();
		user.setUserid(userid);
		User findUser =repository.selectOne(user);
		findUser.setUserpwd("0000");

		return findUser;
	}
	
	// 개인정보수정 화면 요청 
	@RequestMapping(value = "/goInfoUpdate", method = RequestMethod.GET)
	public String goInfoUpdate(HttpSession session, Model model) {
		System.out.println("going to InfoUpdate...");
		
		// 세션의 loginId로 개인정보 가져오기  
		String userid = (String) session.getAttribute("loginId");
		User u = new User();
		u.setUserid(userid);
		User user = repository.selectOne(u);
		
		user.setUserpwd("0000");	// 비밀번호 노출 방지 
		
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
	public String infoUpdate(User u, HttpSession session, MultipartFile imgInp, Model model) {
	      
		System.out.println(imgInp.getOriginalFilename());
	      
		if(!imgInp.isEmpty()) {
			String arr[] = imgInp.getContentType().split("/");
			// 이미지 파일인지 아닌지 확인
			if(!arr[0].equals("image")) {
				model.addAttribute("msg", "JPG 또는 JPEG, PNG등 사진파일만 올려주세요");
				return "user/registerForm";
			}
			Date date = new Date();
			String fileName = "" + date.getYear() + "-" + date.getMonth() + "_" + date.getDay() + "_"
						+ date.getHours() + "_" + date.getMinutes() + "_" + date.getSeconds() + imgInp.getOriginalFilename();
			String imgFilePath = IMG_PATH + "/" + fileName;
			try {
				FileOutputStream fos = new FileOutputStream(new File(imgFilePath));
				fos.write(imgInp.getBytes());
				System.out.println("fileName : " + fileName);
				u.setImgFilePath(fileName);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		int result = repository.infoUpdate(u);
		
		// 업데이트 성공 여부에 따라 메시지 출력 
		String message = null;
		
		if(result == 1) {
			message = "Information Update Completed";
			
			// 새로 업데이트된 정보로 재로그인 
			User uu = repository.selectOne(u);		
			System.out.println(uu);
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
		
		return goInfoUpdate(session, model);
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
		
		User u = repository.selectOne(user);
		
		if(u != null) 	return 1;
		else 			return 0;
	}
	
	// 회원탈퇴 처리 요청
	@RequestMapping(value = "unregister", method = RequestMethod.POST)
	public @ResponseBody Integer unregister(@RequestBody User user, HttpSession session) {
		System.out.println("unregister...");
		
		int result = repository.unregister(user);        
		
		if(result == 1) {
			session.invalidate();
		}
	
		return result;
	}
}
