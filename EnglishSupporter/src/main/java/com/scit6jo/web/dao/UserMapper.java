package com.scit6jo.web.dao;

import com.scit6jo.web.vo.User;

public interface UserMapper {
	
	public int insertUser(User user);

	//로그인
	public User selectOne(User  user);
	
	//출석일수
	public int attendNum(User user);

	public User idcheck(User user);
	
	public User nicknameCheck(User user);


	
	//
}

