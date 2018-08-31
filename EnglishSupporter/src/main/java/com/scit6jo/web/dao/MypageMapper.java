package com.scit6jo.web.dao;

import com.scit6jo.web.vo.User;

public interface MypageMapper {
	
	//닉네임 중복 검사
	public User nicknameCheck(User user);
	
	//개인 정보 수정 
	public int infoUpdate(User user);
}
