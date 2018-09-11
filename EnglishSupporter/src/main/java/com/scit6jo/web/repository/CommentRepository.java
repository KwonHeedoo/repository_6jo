package com.scit6jo.web.repository;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.scit6jo.web.dao.CommentMapper;
import com.scit6jo.web.vo.Board;
import com.scit6jo.web.vo.Comment;

@Repository
public class CommentRepository {
	@Autowired
	SqlSession session;
	
	// 코멘트 리스트 요청
	public ArrayList<Comment> selectAll(Map<String, Object> map) {
		CommentMapper mapper = session.getMapper(CommentMapper.class);
		ArrayList<Comment> commentList = null;
		
		try {
			commentList = mapper.selectAll(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return commentList;
	}
	
	// 코멘트 작성 처리
	public int insertComment(Map<String, Object> map) {
		CommentMapper mapper = session.getMapper(CommentMapper.class);
		int result = 0;

		try {
			result = mapper.insertComment(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 코멘트 수정 처리
	public int updateComment(Map<String, Object> map) {
		CommentMapper mapper = session.getMapper(CommentMapper.class);
		int result = 0;

		try {
			result = mapper.updateComment(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 코멘트 삭제 처리
	public int deleteComment(Map<String, Object> map) {
		CommentMapper mapper = session.getMapper(CommentMapper.class);
		int result = 0;

		try {
			result = mapper.deleteComment(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 코멘트 하나 요청
	public Comment selectOne(Map<String, Object> map) {
		CommentMapper mapper = session.getMapper(CommentMapper.class);
		Comment comment = null;
		
		try {
			comment = mapper.selectOne(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return comment;
	}
	
	// 매칭 여부 처리
	public int matching(Map<String, Object> map) {
		CommentMapper mapper = session.getMapper(CommentMapper.class);
		int result = 0;
		
		try {
			result = mapper.matching(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public Comment selectRatingAvg(Board board) {
		CommentMapper mapper = session.getMapper(CommentMapper.class);
		Comment result = null;
		try {
			result = mapper.selectRatingAvg(board);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
}
