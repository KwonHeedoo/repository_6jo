package com.scit6jo.web.repository;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.scit6jo.web.admin.vo.Report;
import com.scit6jo.web.dao.ReportMapper;

@Repository
public class ReportRepository {
	@Autowired
	SqlSession session;
	
	// 신고 처리
	public int insertReport(Report report) {
		ReportMapper mapper = session.getMapper(ReportMapper.class);
		int result = 0;
		
		try {
			result = mapper.insertReport(report);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 신고 리스트 요청
	public ArrayList<Report> selectAll() {
		ReportMapper mapper = session.getMapper(ReportMapper.class);
		ArrayList<Report> reportList = null;
		
		try {
			reportList = mapper.selectAll();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return reportList;
	}
	
	
}
