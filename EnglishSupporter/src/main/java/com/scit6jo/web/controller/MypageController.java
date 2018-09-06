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
	@RequestMapping(value = "/goMyschedule", method = RequestMethod.GET)
	public String goMyschedule() {
		System.out.println("going to PwdChange...");
		
		return "mypage/mySchedule";
	}
	
	@RequestMapping(value = "/makeMyschedule", method = RequestMethod.GET)
	public String makeMyschedule(String date, Model model) {
		
		model.addAttribute("date", date);
		return "mypage/writeSchedule";
	}
	
	@RequestMapping(value = "/reviseMyschedule", method = RequestMethod.GET)
	public String reviseMyschedule(String date, Model model) {

		model.addAttribute("date", date);
		return "mypage/writeSchedule";
	}
	
	@RequestMapping(value = "/getschedule", method = RequestMethod.POST)
	public @ResponseBody List<Schedule> getSchedule() {
		List<Schedule> result = repository.selectAllSchedule();
		return result;
	}
	
}
