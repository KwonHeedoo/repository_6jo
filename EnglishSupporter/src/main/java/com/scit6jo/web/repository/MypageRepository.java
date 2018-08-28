package com.scit6jo.web.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.scit6jo.web.dao.MypageMapper;
import com.scit6jo.web.dao.UserMapper;
import com.scit6jo.web.vo.User;

@Repository
public class MypageRepository {
	
	@Autowired
	SqlSession session;
	
	public User nicknameCheck(User user) {
		MypageMapper mapper = session.getMapper(MypageMapper.class);
		User u = mapper.nicknameCheck(user);
	
		return u;
	}
	
	public int infoUpdate(User user) {
		MypageMapper mapper = session.getMapper(MypageMapper.class);
		
		int result = 0;
		
		try {
			result = mapper.infoUpdate(user);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
}
