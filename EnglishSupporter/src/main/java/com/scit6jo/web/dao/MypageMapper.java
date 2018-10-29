package com.scit6jo.web.dao;

import java.util.List;

import com.scit6jo.web.vo.Schedule;

public interface MypageMapper {
	/**
	 * 스케줄 저장하기
	 * @param vo
	 * @return
	 */
	public int saveSchedule(Schedule vo);
	/**
	 * 로그인한 유저의 전체 스케쥴 불러오기 (스케줄러 로딩화면)
	 * @param userid
	 * @return
	 */
	public List<Schedule> getSchedule(String userid);
	/**
	 * 스케줄 삭제하기
	 * @param vo
	 * @return
	 */
	public int removeSchedule(Schedule vo);
	/**
	 * 스케줄 업데이트(스케줄러에서 s_id 이용)
	 * @param vo
	 * @return
	 */
	public int updateSchedule(Schedule vo);
	/**
	 * 1:1 매칭 약속시간 변경하는 경우(게시글 내 시간대 변경) s_id 없이 update 하는 경우
	 * @param vo
	 * @return
	 */
	public int updateAppointment(Schedule vo);
}
