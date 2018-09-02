package com.scit6jo.web.admin.repository;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.scit6jo.web.admin.dao.DashboardMapper;
import com.scit6jo.web.admin.vo.GraphData;

@Repository
public class DashboardRepository {
	@Autowired
	SqlSession session;
	
	// 방문자 수 요청(주 별, 월 별)
	public ArrayList<GraphData> visitorCount(String period) {
		DashboardMapper mapper = session.getMapper(DashboardMapper.class);
		ArrayList<GraphData> visitorCount = null;
		
		try {
			visitorCount = mapper.visitorCount(period); 
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return visitorCount;
	}
	
	// 가입자 수 요청(주 별, 월 별)
	public ArrayList<GraphData> joinCount(String period) {
		DashboardMapper mapper = session.getMapper(DashboardMapper.class);
		ArrayList<GraphData> joinCount = null;
		
		try {
			joinCount = mapper.joinCount(period); 
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return joinCount;
	}

}
