package com.scit6jo.web.controller;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.scit6jo.web.repository.MypageRepository;
import com.scit6jo.web.vo.Schedule;
import com.scit6jo.web.vo.User;


@Controller
public class MypageController {
	@Autowired
	MypageRepository repository;
	
	@RequestMapping(value = "/goMypage", method = RequestMethod.GET)
	public String goMypage(HttpSession session, Model model) {
		String userid = (String) session.getAttribute("loginId");
		
		User user = repository.getUserInfo(userid);
		model.addAttribute("info", user);
		
		return "mypage/myInfo";
	}
	
	/* 스케쥴 관련  메소드 시작 */
	//스케쥴러 페이지로 가기 
	@RequestMapping(value = "/goMyschedule", method = RequestMethod.GET)
	public String goMyschedule() {
		
		return "mypage/scheduler";
	}
	
	//새 스케쥴 생성창 
	@RequestMapping(value = "/saveMyschedule", method = RequestMethod.POST)
	public @ResponseBody String makeMyschedule(Schedule vo) {
		System.out.println(vo);
		int cnt = repository.saveSchedule(vo);
		if(cnt>0) {
			return "schedule saved";
		}
		return "schedule saving failed";
	}
	//스케쥴 상세보기창 
	@RequestMapping(value = "/deleteMyschedule", method = RequestMethod.POST)
	public @ResponseBody String deleteMyschedule(String id) {
		System.out.println("delete schedule");
		System.out.println(id);
		 Schedule ss= new Schedule();
			ss.setS_id(id);
		int cnt = repository.deleteSchedule(ss);
		if(cnt>0) {
			return "schedule deleted";
		}
		return "schedule delete failed";
	}
	
	@RequestMapping(value = "/getschedule", method = RequestMethod.POST)
	public @ResponseBody List<Schedule> getSchedule(String userid) {
		List<Schedule> result = repository.selectAllSchedule(userid);
		//System.out.println(result.size());
		//System.out.println(result.get(0));
		return result;
	}
	
}
