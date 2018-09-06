package com.scit6jo.web.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.scit6jo.web.dao.MypageMapper;
import com.scit6jo.web.dao.UserMapper;
import com.scit6jo.web.vo.Schedule;
import com.scit6jo.web.vo.User;

@Repository
public class MypageRepository {
	
	@Autowired
	SqlSession session;
	
	// 닉네임 중복체크 처리
	public User nicknameCheck(User user) {
		MypageMapper mapper = session.getMapper(MypageMapper.class);
		User u = mapper.nicknameCheck(user);
	
		return u;
	}
	
	// 개인정보수정 처리
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
	
	// 비밀번호수정 처리
	public int pwdChange(String loginId, String currpwd, String newpwd) {
		MypageMapper mapper = session.getMapper(MypageMapper.class);
		
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
	
	// 스케줄 리스트 불러오는 메소드 유저아이디 받아서 할것 
	public List<Schedule> selectAllSchedule() {
		MypageMapper mapper = session.getMapper(MypageMapper.class);
		
		
		return null;
	}
	
}
