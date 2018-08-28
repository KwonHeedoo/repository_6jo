package com.scit6jo.web.dao;

import java.util.ArrayList;
import java.util.Map;

import com.scit6jo.web.vo.Comment;

public interface CommentMapper {
	// 코멘트 리스트 요청
	public ArrayList<Comment> selectAll(Map<String, Object> map);
	// 코멘트 작성 처리
	public int insertComment(Map<String, Object> map);
	// 코멘트 수정 처리
	public int updateComment(Map<String, Object> map);
	// 코멘트 삭제 처리
	public int deleteComment(Map<String, Object> map);
	// 코멘트 하나 요청
	public Comment selectOne(Map<String, Object> map);
	// 매칭 여부 처리
	public int matching(Map<String, Object> map);

}
