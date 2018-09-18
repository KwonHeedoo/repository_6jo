package com.scit6jo.web.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.scit6jo.web.repository.UserRepository;
import com.scit6jo.web.vo.User;

@Controller
public class UserManagerController {
	@Autowired
	UserRepository repository;
	
	// User Management 페이지 요청
	@RequestMapping(value = "/goUserManager", method = RequestMethod.GET)
	public String goUserManager(){
		System.out.println("Going to UserManagement...");
		
		return "admin/userManager";
	}
	
	// 블랙리스트 정보 요청
	@RequestMapping(value = "/blackList", method = RequestMethod.GET)
	public @ResponseBody ArrayList<User> blackList(String orderByType){
		ArrayList<User> blackList = repository.blackList(orderByType);
		
		return blackList;
	}
	
	// 관리자 페이지 회원 검색
	@RequestMapping(value = "/searchUser", method = RequestMethod.GET)
	public @ResponseBody ArrayList<User> searchUser(String userid){
		ArrayList<User> user = repository.searchUser(userid);
		
		return user;
	}
	
	// 유저 계정 사용 일시 정지
	@RequestMapping(value = "/sanctionUser", method = RequestMethod.GET)
	public @ResponseBody Map<String, Integer> sanctionUser(String userid){
		Map<String, Integer> map = new HashMap<>();
		int result = 0;
		// 유저 계정이 정지 중인지 체크
		User check = repository.checkSanction(userid);
		
		// 해당 계정이 정지 중이 아니면 정지
		if(check == null) {
			result = repository.sanctionUser(userid);
		}
		
		// 해당 계정이 정지 중이면 정지 번호를 map에 추가
		if(check != null) {
			map.put("sanctionNum", check.getAttendNum());
		}
		// 정지 결과 map에 추가
		map.put("result", result);
		
		return map;
	}
	
	// 유저 계정 사용 일시 정지 해제
	@RequestMapping(value = "/cancelSanction", method = RequestMethod.GET)
	public @ResponseBody int cancelSanction(int sanctionNum){
		int result = repository.cancelSanction(sanctionNum);
		
		return result;
	}
	
	// 유저 강제 탈퇴
	@RequestMapping(value = "/releaseUser", method = RequestMethod.GET)
	public @ResponseBody int releaseUser(User user){
		int result = repository.unregister(user);
		
		return result;
	}
	
	/**
	 * 일반유저를 관리자로 권한상승
 	 * @param userid String 타입의 유저의 id
	 * @return 성공시 1, 실패시 0
	 */
		@RequestMapping(value = "/beAdmin", method = RequestMethod.POST)
		public @ResponseBody int beAdmin(User user) {
			user.setUsertype("admin");
			return repository.changeAuth(user);
		}
		/**
		 * 관리자가 일반유저로 권한내리기
		 * @param user String 타입의 유저의 id
		 * @return 성공시 1, 실패시 0
		 */
		@RequestMapping(value = "/beUser", method = RequestMethod.POST)
		public @ResponseBody int beUser(User user) {
			user.setUsertype("user");
			return repository.changeAuth(user);
		}
}
