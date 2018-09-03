package com.scit6jo.web.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.scit6jo.web.dao.UserMapper;
import com.scit6jo.web.vo.User;

@Repository
public class UserRepository {
	
	@Autowired
	SqlSession session;
	
	public User selectOne(User user) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		User u = mapper.selectOne(user);
	
		return u;
	}
	
	public int attendNum(User user) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		int result = mapper.attendNum(user);
		
		return result; 
	}

	public int insertUser(User user) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		int result = mapper.insertUser(user);
		
		return result;
	}

	public User idcheck(User user) {
		UserMapper mapper=session.getMapper(UserMapper.class);
		User result=mapper.idcheck(user);
		
		return result;
	}
	
	public User nicknameCheck(User user) {
		UserMapper mapper=session.getMapper(UserMapper.class);
		User result=mapper.nicknameCheck(user);
		
		return result;
	}
	
	
	
}
