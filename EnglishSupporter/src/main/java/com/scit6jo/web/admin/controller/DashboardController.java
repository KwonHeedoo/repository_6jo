package com.scit6jo.web.admin.controller;

import java.util.ArrayList;

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
	@RequestMapping(value = "/goDashboard", method = RequestMethod.GET)
	public String goDashboard(){
		System.out.println("Going to Dashboard...");
		
		return "admin/dashboard";
	}
	
	// 회원가입 & 방문자 수 정보 요청
	@RequestMapping(value = "/countByJoinVisit", method = RequestMethod.GET)
	public @ResponseBody ArrayList<GraphData> countByJoinVisit(String period){
		// 방문자 & 가입자 수 요청(주 별, 월 별)
		ArrayList<GraphData> countByJoinVisit = repository.countByJoinVisit(period);
		
		return countByJoinVisit;
	}
	
	// 신고 & 재제 수 정보 요청
	@RequestMapping(value = "/countByRptSanc", method = RequestMethod.GET)
	public @ResponseBody ArrayList<GraphData> countBySanction(String period){
		// 신고 & 재제 수 요청(주 별, 월 별)
		ArrayList<GraphData> countByRptSanc = repository.countByRptSanc(period);
		
		return countByRptSanc;
	}
}
