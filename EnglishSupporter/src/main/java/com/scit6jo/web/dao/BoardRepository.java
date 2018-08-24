package com.scit6jo.web.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	
	// 게시글 파일 삭제 처리
	public int deleteFile(int boardnum) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int result = 0;
		
		try {
			result = mapper.deleteFile(boardnum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
}
