package com.scit6jo.web.dao;

import java.util.Map;

import com.scit6jo.web.vo.User;

public interface MypageMapper {
	
	// 닉네임 중복체크
	public User nicknameCheck(User user);
	
	// 개인정보수정 
	public int infoUpdate(User user);
	
	// 비밀번호수정
	public int pwdChange(Map<String, String> map);
	
	// 회원탈퇴
	public int unregister(User user);
}
