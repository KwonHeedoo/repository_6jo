package com.scit6jo.web.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.scit6jo.web.repository.ReportRepository;
import com.scit6jo.web.vo.Report;

@Controller
public class ReportController {
	@Autowired
	ReportRepository repository;
	
	// 신고 새창 페이지 요청
	@RequestMapping(value = "/goReportBox", method = RequestMethod.POST)
	public String goReportBox(Model model, Report report, String page, String boardNum
								, String boardType, String searchItem, String searchText) {
		String reportURL = "detailBoard?boardNum=" + boardNum + "&boardType=" + boardType + "&page="
							+ page + "&back=false&searchItem=" + searchItem + "&searchText=" + searchText;
		model.addAttribute("report", report);
		model.addAttribute("reportURL", reportURL);
		
		System.out.println("going to ReportBox...");
		
		return "admin/reportBox";
	}
	
	// 신고 처리
	@RequestMapping(value = "/report", method = RequestMethod.POST)
	public @ResponseBody int report(@RequestBody Report report) {
		int result = repository.insertReport(report);
		return result;
	}
	
	// 신고 리스트 요청
	@RequestMapping(value = "/reportList", method = RequestMethod.GET)
	public ArrayList<Report> reportList() {
		ArrayList<Report> reportList = new ArrayList<>();
		
		reportList = repository.selectAll();
		
		return reportList;
	}
}
