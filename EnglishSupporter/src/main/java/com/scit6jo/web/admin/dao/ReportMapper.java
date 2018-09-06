package com.scit6jo.web.admin.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;

import com.scit6jo.web.admin.vo.Report;

public interface ReportMapper {
	// 신고 접수
	public int insertReport(Report report);
	// 신고 전체 개수 조회
		public int getTotal();
	// 신고 리스트 요청
	public ArrayList<Report> selectAll(RowBounds rb);
	// 신고 수리 처리
	public int reportAccept(int reportNum);
	// 신고 수리 취소 처리
	public int acceptCancel(int reportNum);
	
}
