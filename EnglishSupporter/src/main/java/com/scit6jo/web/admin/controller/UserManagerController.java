package com.scit6jo.web.admin.controller;

import java.util.ArrayList;

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
	public @ResponseBody int sanctionUser(String userid){
		int result = 0;
		// 유저 계정이 정지 중인지 체크
		User check = repository.checkSanction(userid);
		
		// 해당 계정이 정지 중이 아니면 정지
		if(check == null) {
			result = repository.sanctionUser(userid);
		}
		
		return result;
	}
	
	// 유저 강제 탈퇴
	@RequestMapping(value = "/releaseUser", method = RequestMethod.GET)
	public @ResponseBody int releaseUser(User user){
		int result = repository.unregister(user);
		
		return result;
	}
}
