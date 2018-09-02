package com.scit6jo.web.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.scit6jo.web.admin.repository.DashboardRepository;
import com.scit6jo.web.admin.vo.GraphData;

@Controller
public class DashboardController {
	@Autowired
	DashboardRepository repository;
	
	// 회원가입 & 방문자 수 정보 요청
	@RequestMapping(value = "/countByJoinVisit", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> countByJoinVisit(String period){
		Map<String, Object> map = new HashMap<>();
		
		// 방문자 수 요청(주 별, 월 별)
		ArrayList<GraphData> visitorCount = repository.visitorCount(period);
		// 가입자 수 요청(주 별, 월 별)
		ArrayList<GraphData> joinCount = repository.joinCount(period);
		
		return map;
	}
	
	// 신고 & 재제 수 정보 요청
	/*@RequestMapping(value = "/countBySanction", method = RequestMethod.GET)
	public @ResponseBody ArrayList<GraphData> countBySanction(String period){
		// 신고 & 재제 수 요청(주 별, 월 별)
		ArrayList<GraphData> sanctionCount = repository.sanctionCount(period);
		
		return sanctionCount;
	}*/
}
