package com.scit6jo.web.repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.scit6jo.web.dao.MypageMapper;
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
	
	// 회원가입
	public int insertUser(User user) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		int result = 0;
		
		try {
			result = mapper.insertUser(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// ID 중복체크
	public User idcheck(User user) {
		UserMapper mapper=session.getMapper(UserMapper.class);
		User result = null;
		
		try {
			result = mapper.idcheck(user);
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
	
	// 유저 계정 사용 정지 해제
	public int cancelSanction(int sanctionNum) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		int result = 0;
		
		try {
			result = mapper.cancelSanction(sanctionNum);
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
	
	// 닉네임 중복체크 처리
	public User nicknameCheck(User user) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		User u = null;
		
		try {
			u = mapper.nicknameCheck(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		return u;
	}
	
	// 개인정보수정 처리
	public int infoUpdate(User user) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		int result = 0;
		
		try {
			result = mapper.infoUpdate(user);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 비밀번호수정 처리
	public int pwdChange(String loginId, String currpwd, String newpwd) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		int result = 0;
		
		Map<String, String> map = new HashMap<>();
		map.put("userid", loginId);
		map.put("currpwd", currpwd);
		map.put("newpwd", newpwd);
		
		try {
			result = mapper.pwdChange(map);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 회원탈퇴 처리
	public int unregister(User user) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		int result = 0;
		
		try {
			result = mapper.unregister(user);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

}
