package com.scit6jo.web.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.scit6jo.web.repository.MypageRepository;
import com.scit6jo.web.vo.Schedule;


@Controller
public class MypageController {
	@Autowired
	MypageRepository repository;
	
	/* 스케쥴 관련  메소드 시작 */
	//스케쥴러 페이지로 가기 
	@RequestMapping(value = "/goMyschedule", method = RequestMethod.GET)
	public String goMyschedule() {
		System.out.println("going to PwdChange...");
		
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
		System.out.println(id);
		int cnt = repository.deleteSchedule(id);
		if(cnt>0) {
			return "schedule deleted";
		}
		return "schedule delete failed";
	}
	
	@RequestMapping(value = "/getschedule", method = RequestMethod.POST)
	public @ResponseBody List<Schedule> getSchedule(String userid) {
		List<Schedule> result = repository.selectAllSchedule(userid);
		return result;
	}
	
}
