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
	
	// 로그인
	public User selectOne(User user) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		User u = null;

		try {
			u = mapper.selectOne(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		return u;
	}
	
	// 출석 처리
	public int attendNum(User user) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		int result = 0;
		
		try {
			result = mapper.attendNum(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result; 
	}
	
	// 방문자 등록
	public int visit(String visitor) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		int result = 0;
		
		try {
			result = mapper.visit(visitor);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
}
