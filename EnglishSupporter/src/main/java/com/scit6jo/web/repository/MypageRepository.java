package com.scit6jo.web.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.scit6jo.web.dao.MypageMapper;
import com.scit6jo.web.vo.Schedule;

@Repository
public class MypageRepository {
	@Autowired
	SqlSession session;
	
	
	// 스케줄 리스트 불러오는 메소드 유저아이디 받아서 할것 
	public List<Schedule> selectAllSchedule() {
		MypageMapper mapper = session.getMapper(MypageMapper.class);
		
		
		return null;
	}
	
}
