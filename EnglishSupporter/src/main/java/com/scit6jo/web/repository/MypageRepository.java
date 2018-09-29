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
	
	
	// 스케줄 리스트 불러오는 메소드 유저아이디 받아서 할것 
	public List<Schedule> selectAllSchedule(String userid){
		MypageMapper mapper = session.getMapper(MypageMapper.class);
		List<Schedule> list=null;
		try {
			list = mapper.getSchedule(userid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
		
	}

	public int saveSchedule(Schedule vo) {
		MypageMapper mapper = session.getMapper(MypageMapper.class);
		int cnt=0;
		try {
			cnt = mapper.saveSchedule(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	public int deleteSchedule(Schedule ss) {
		MypageMapper mapper = session.getMapper(MypageMapper.class);
		int cnt=0;
		try {
			cnt = mapper.removeSchedule(ss);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}
	// 가입일, 출석일수 등을 띄우는 메소드 
	public User getUserInfo(String userid) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		User u = null;
		try {
			u = mapper.userInfoPage(userid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return u;
	}

	public int updateSchedult(Schedule vo) {
		MypageMapper mapper = session.getMapper(MypageMapper.class);
		int cnt=0;
		try {
			cnt = mapper.updateSchedule(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}
	

	
}
