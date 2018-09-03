package com.scit6jo.web.dao;

import com.scit6jo.web.vo.User;

public interface UserMapper {
	
	public int insertUser(User user);

	public User idcheck(User user);
	
	public User nicknameCheck(User user);


	
	//
	// 로그인
	public User selectOne(User user);
	// 출석 처리
	public int attendNum(User user);
	// 방문자 등록
	public int visit(String visitor);
}

