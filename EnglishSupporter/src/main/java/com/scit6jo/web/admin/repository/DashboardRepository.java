package com.scit6jo.web.admin.repository;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.scit6jo.web.admin.dao.DashboardMapper;
import com.scit6jo.web.admin.vo.GraphData;
import com.scit6jo.web.vo.Board;

@Repository
public class DashboardRepository {
	@Autowired
	SqlSession session;
	
	// 방문자 & 가입자 수 요청(주 별, 월 별)
	public ArrayList<GraphData> countByJoinVisit(String period) {
		DashboardMapper mapper = session.getMapper(DashboardMapper.class);
		ArrayList<GraphData> countByJoinVisit = null;
		
		try {
			countByJoinVisit = mapper.countByJoinVisit(period); 
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return countByJoinVisit;
	}
	
	// 신고 & 재제 수 요청(주 별, 월 별)
	public ArrayList<GraphData> countByRptSanc(String period) {
		DashboardMapper mapper = session.getMapper(DashboardMapper.class);
		ArrayList<GraphData> countByRptSanc = null;
		
		try {
			countByRptSanc = mapper.countByRptSanc(period); 
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return countByRptSanc;
	}
	
	// 회원 연령대 별 인원수 요청
	public GraphData countByUserAge() {
		DashboardMapper mapper = session.getMapper(DashboardMapper.class);
		GraphData countByUserAge = null;
		
		try {
			countByUserAge = mapper.countByUserAge(); 
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return countByUserAge;
	}
	
	// 오늘의 게시물, 코멘트, Coverlette, Resume 수
	public GraphData countToday() {
		DashboardMapper mapper = session.getMapper(DashboardMapper.class);
		GraphData countToday = null;
		
		try {
			countToday = mapper.countToday(); 
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return countToday;
	}

}
