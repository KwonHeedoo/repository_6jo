package com.scit6jo.web.dao;

import java.util.ArrayList;

import com.scit6jo.web.vo.Report;

public interface ReportMapper {
	// 신고 처리
	public int insertReport(Report report);
	// 신고 리스트 요청
	public ArrayList<Report> selectAll();

}
