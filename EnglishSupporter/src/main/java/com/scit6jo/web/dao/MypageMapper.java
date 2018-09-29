package com.scit6jo.web.dao;

import java.util.List;

import com.scit6jo.web.vo.Schedule;

public interface MypageMapper {
	
	public int saveSchedule(Schedule vo);
	
	public List<Schedule> getSchedule(String userid);
	
	public int removeSchedule(Schedule vo);
	
	public int updateSchedule(Schedule vo);
}
