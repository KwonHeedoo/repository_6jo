package com.scit6jo.web.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.scit6jo.web.vo.User;

public interface UserMapper {
	
	public int insertUser(User user);

	public User idcheck(User user);
	
	public User nicknameCheck(User user);


	
	//
	// 로그인
	public User selectOne(User user);
	// 출석 처리
	public int attendNum(User user);
	// 방문자 등록
	public int visit(String visitor);
	// 블랙리스트 정보 요청
	public ArrayList<User> blackList(@Param(value="orderByType")String orderByType);
	// 관리자 페이지 회원 검색
	public ArrayList<User> searchUser(String userid);
	// 유저 계정 사용 일시 정지
	public int sanctionUser(String userid);
	// 유저 계정이 정지 중인지 체크
	public User checkSanction(String userid);
}

