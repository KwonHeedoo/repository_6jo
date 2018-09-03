package com.scit6jo.web.admin.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.scit6jo.web.admin.vo.GraphData;

public interface DashboardMapper {
	// 방문자 & 가입자 수 요청(주 별, 월 별)
	public ArrayList<GraphData> countByJoinVisit(@Param(value="period")String period);
	// 신고 & 재제 수 요청(주 별, 월 별)
	public ArrayList<GraphData> countByRptSanc(@Param(value="period")String period);
	// 회원 연령대 별 인원수 요청
	public GraphData countByUserAge();

}
