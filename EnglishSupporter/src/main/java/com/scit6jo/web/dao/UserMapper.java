package com.scit6jo.web.dao;

import com.scit6jo.web.vo.User;

public interface UserMapper {
	
	//로그인
	public User selectOne(User user);
	
	//출석일수
	public int attendNum(User user);
}
