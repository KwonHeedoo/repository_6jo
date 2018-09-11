package com.scit6jo.web.admin.repository;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.scit6jo.web.admin.dao.ReportMapper;
import com.scit6jo.web.admin.vo.Report;

@Repository
public class ReportRepository {
	@Autowired
	SqlSession session;
	
	// 신고 접수
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
	
	// 신고 전체 개수 조회
	public int getTotal() {
		ReportMapper mapper = session.getMapper(ReportMapper.class);
		int total = 0;
		
		try {
			total = mapper.getTotal();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return total;
	}

	// 신고 리스트 요청
	public ArrayList<Report> selectAll(RowBounds rb) {
		ReportMapper mapper = session.getMapper(ReportMapper.class);
		ArrayList<Report> reportList = null;
		
		try {
			reportList = mapper.selectAll(rb);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return reportList;
	}
	
	// 신고 수리 처리
	public int reportAccept(int reportNum) {
		ReportMapper mapper = session.getMapper(ReportMapper.class);
		int result = 0;
		
		try {
			result = mapper.reportAccept(reportNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 신고 수리 취소 처리
	public int acceptCancel(int reportNum) {
		ReportMapper mapper = session.getMapper(ReportMapper.class);
		int result = 0;
		
		try {
			result = mapper.acceptCancel(reportNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
}
