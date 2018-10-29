package com.scit6jo.web.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.scit6jo.web.vo.Board;

public interface BoardMapper {
	// 총 게시글 수
	public int getTotal(Map<String, String> map);
	// 게시글 리스트 요청
	public ArrayList<Board> boardList(RowBounds rb, Map<String, String> map);
	// 게시글 보기
	public Board selectOne(Map<String, Object> map);
	// 조회수 증가
	public int updateHitcount(Map<String, Object> map);
	// 게시글 작성 처리
	public int writeBoard(Map<String, Object> map);
	// 게시글 삭제 처리
	public int deleteBoard(Map<String, Object> map);
	// 게시글 수정 처리
	public int updateBoard(Map<String, Object> map);
	// 게시판에 매칭 여부 추가
	public int matching(Board board);
	// 게시판에 매칭 여부 취소
	public int unmatching(Board board);
	// 공지글 리스트 요청
	public ArrayList<Board> noticeList(Map<String, String> map);
	// Room 넘버 리스트 요청
	public ArrayList<Board> roomNumList(String userid);

}
