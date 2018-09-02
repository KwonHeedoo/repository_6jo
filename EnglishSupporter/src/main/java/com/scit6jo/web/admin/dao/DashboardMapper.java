package com.scit6jo.web.admin.dao;

import java.util.ArrayList;

import com.scit6jo.web.admin.vo.GraphData;

public interface DashboardMapper {
	// 방문자 수 요청(주 별, 월 별)
	public ArrayList<GraphData> visitorCount(String period);
	// 가입자 수 요청(주 별, 월 별)
	public ArrayList<GraphData> joinCount(String period);

}
