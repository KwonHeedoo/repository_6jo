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
	
	// 관리자 Dashboard 페이지 요청
	@RequestMapping(value = "/goDashboard", method = RequestMethod.GET)
	public String goDashboard(){
		System.out.println("Going to Dashboard...");
		
		return "admin/dashboard";
	}
	
	// 방문자 & 가입자 수 요청(주 별, 월 별)
	@RequestMapping(value = "/countByJoinVisit", method = RequestMethod.GET)
	public @ResponseBody ArrayList<GraphData> countByJoinVisit(String period){
		ArrayList<GraphData> countByJoinVisit = repository.countByJoinVisit(period);
		
		return countByJoinVisit;
	}
	
	// 신고 & 재제 수 요청(주 별, 월 별)
	@RequestMapping(value = "/countByRptSanc", method = RequestMethod.GET)
	public @ResponseBody ArrayList<GraphData> countBySanction(String period){
		ArrayList<GraphData> countByRptSanc = repository.countByRptSanc(period);
		
		return countByRptSanc;
	}
	
	// 회원 연령대 별 인원수 요청
	@RequestMapping(value = "/countByUserAge", method = RequestMethod.GET)
	public @ResponseBody GraphData countByUserAge(){
		GraphData countByUserAge = repository.countByUserAge();
		
		return countByUserAge;
	}
	
	// 오늘의 게시물, 코멘트, Coverlette, Resume 수
	@RequestMapping(value = "/countToday", method = RequestMethod.GET)
	public @ResponseBody GraphData countToday(){
		GraphData countToday = repository.countToday();
		
		return countToday;
	}
	
}
