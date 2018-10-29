package com.scit6jo.web.repository;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.scit6jo.web.dao.BoardMapper;
import com.scit6jo.web.vo.Board;



@Repository
public class BoardRepository {
	@Autowired
	SqlSession session;
	
	// 총 게시글 수
	public int getTotal(Map<String, String> map) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int result = 0;
		
		try {
			result = mapper.getTotal(map); 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 게시글 리스트 요청
	public ArrayList<Board> boardList(RowBounds rb, Map<String, String> map) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		ArrayList<Board> boardList = null;
		
		try {
			boardList = mapper.boardList(rb, map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return boardList;
	}
	
	// 게시글 보기
	public Board selectOne(Map<String, Object> map) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		Board board = null;
		
		try {
			board = mapper.selectOne(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return board;
	}
	
	// 조회수 증가
	public int updateHitcount(Map<String, Object> map) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int result = 0;
		
		try {
			result = mapper.updateHitcount(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 게시글 작성 처리
	public int writeBoard(Map<String, Object> map) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int result = 0;
		
		try {
			result = mapper.writeBoard(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 게시글 삭제 처리
	public int deleteBoard(Map<String, Object> map) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int result = 0;
		
		try {
			result = mapper.deleteBoard(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 게시글 수정 처리
	public int updateBoard(Map<String, Object> map) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int result = 0;
		
		try {
			result = mapper.updateBoard(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 게시판에 매칭 여부 추가
	public int matching(Board board) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int result = 0;
		
		try {
			result = mapper.matching(board);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 게시판에 매칭 여부 취소
	public int unmatching(Board board) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int result = 0;
		
		try {
			result = mapper.unmatching(board);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 공지글 리스트 요청
	public ArrayList<Board> noticeList(Map<String, String> map) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		ArrayList<Board> noticeList = null;
		
		try {
			noticeList = mapper.noticeList(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return noticeList;
	}
	// Room 넘버 리스트 요청
	public ArrayList<Board> roomNumList(String userid) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		ArrayList<Board> roomNumList = null;
		
		try {
			roomNumList = mapper.roomNumList(userid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return roomNumList;
	}
	
	
}
