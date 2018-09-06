package com.scit6jo.web.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.scit6jo.web.vo.User;

public interface UserMapper {
	// 회원가입
	public int insertUser(User user);
	// ID 중복체크
	public User idcheck(User user);
	// 닉네임 중복체크
	public User nicknameCheck(User user);
	// 개인정보수정 
	public int infoUpdate(User user);
	// 비밀번호수정
	public int pwdChange(Map<String, String> map);
	// 회원탈퇴
	public int unregister(User user);
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

