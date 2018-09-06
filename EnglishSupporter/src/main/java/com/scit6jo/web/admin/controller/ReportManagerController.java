package com.scit6jo.web.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.scit6jo.web.admin.repository.ReportRepository;
import com.scit6jo.web.admin.vo.Report;
import com.scit6jo.web.repository.UserRepository;
import com.scit6jo.web.util.PageNavigator;
import com.scit6jo.web.vo.User;

@Controller
public class ReportManagerController {
	@Autowired
	ReportRepository repository;
	
	@Autowired
	UserRepository userRepository;
	
	private static final int countPerPage = 15;
	private static final int pagePerGroup = 5;
	
	// 관리자 신고 관리 페이지 요청
	@RequestMapping(value = "/goReportManager", method = RequestMethod.GET)
	public String goReportManager() {
		System.out.println("going to Report Management...");
		
		return "admin/reportManager";
	}
	
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
	
	// 신고 접수
	@RequestMapping(value = "/report", method = RequestMethod.POST)
	public @ResponseBody int report(@RequestBody Report report) {
		int result = repository.insertReport(report);
		return result;
	}
	
	// 신고 리스트 요청
	@RequestMapping(value = "/reportList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> reportList(@RequestParam(value="page", defaultValue="1") int page) {
		Map<String, Object> map = new HashMap<>();
		
		// 신고 전체 개수 조회
		int total = repository.getTotal();
		// 페이지 계산을 위한 객체 생성
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		// 페이지당 글 수를 전달하여 목록 읽기
		RowBounds rb = new RowBounds(navi.getStartRecord(), navi.getCountPerPage());
		
		// 신고 리스트 요청
		ArrayList<Report> reportList = repository.selectAll(rb);
		
		map.put("reportList", reportList);
		map.put("navi", navi);
		
		return map;
	}
	
	// 신고 수리 처리
	@RequestMapping(value = "/reportAccept", method = RequestMethod.GET)
	public @ResponseBody int reportAccept(int reportNum, String reportee) {
		int result = repository.reportAccept(reportNum);
		
		// 신고 된 유저의 재제 체크
		if(result == 1) {
			ArrayList<User> user = userRepository.searchUser(reportee);
			int reportCount = 0;
			for(User u : user) {
				reportCount = u.getReportCount();
			}
			// 수리 된 신고가 3개일 경우 유저 계정 정지
			if(reportCount % 3 == 0) {
				// 유저 계정이 정지 중인지 체크
				User check = userRepository.checkSanction(reportee);
				// 해당 계정이 정지 중이 아니면 정지
				if(check == null) {
					int resultSanction = userRepository.sanctionUser(reportee);
				}
			}
		}
		
		return result;
	}
	
	// 신고 수리 취소 처리
	@RequestMapping(value = "/acceptCancel", method = RequestMethod.GET)
	public @ResponseBody int acceptCancel(int reportNum, String reportee) {
		int result = 0;
		// 신고 된 유저의 재제 체크
		ArrayList<User> user = userRepository.searchUser(reportee);
		int reportCount = 0;
		for(User u : user) {
			reportCount = u.getReportCount();
		}
		
		if(reportCount % 3 == 0) {
			result = repository.acceptCancel(reportNum);
			// 유저 계정이 정지 중인지 체크
			User check = userRepository.checkSanction(reportee);
			// 해당 계정이 정지 중이면 정지 해제
			if(check != null) {
				userRepository.cancelSanction(check.getAttendNum());
			}
		}else {
			result = repository.acceptCancel(reportNum);
		}
		
		return result;
	}
}
