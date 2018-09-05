package com.scit6jo.web.repository;

import java.util.ArrayList;

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
	
	// 블랙리스트 정보 요청
	public ArrayList<User> blackList(String orderByType) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		ArrayList<User> blackList = null;
				
		try {
			blackList = mapper.blackList(orderByType);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return blackList;
	}
	
	// 관리자 페이지 회원 검색
	public ArrayList<User> searchUser(String userid) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		ArrayList<User> user = null;
				
		try {
			user = mapper.searchUser(userid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}
	
	// 유저 계정 사용 일시 정지
	public int sanctionUser(String userid) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		int result = 0;
		
		try {
			result = mapper.sanctionUser(userid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 유저 계정이 정지 중인지 체크
	public User checkSanction(String userid) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		User user = null;
		
		try {
			user = mapper.checkSanction(userid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return user;
	}
}
