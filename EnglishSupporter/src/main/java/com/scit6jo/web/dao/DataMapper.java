package com.scit6jo.web.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.scit6jo.web.vo.IData;
import com.scit6jo.web.vo.IQuestion;
import com.scit6jo.web.vo.Word;

public interface DataMapper {
	// 회원가입
	public int insertIData(IData iData);
	public int updateAnswer(IData iData);
	public int updateConfidence(IData iData);
	//public ArrayList<IQuestion> selectAllQuestion();
	public IData selectOneIData(int dataNum);
	public ArrayList<IData> selectAllIData(String userid);
	// 관리자페이지 IQuestionManager에 띄울 모든 질문 개수 (페이징처리)
	public int getTotal(); 
	// 관리자페이지 IQuestionManager에 띄울 모든 질문리스트 (페이징처리)
	public ArrayList<IQuestion> selectAllQuestion(RowBounds rb);
	// 관리자페이지 IQuestionManager 질문추가 처리
	public int addQuestion(IQuestion iq);
	// 관리자페이지 IQuestionManager 업데이트 처리
	public int updateQuestion(IQuestion iq);
	// 관리자페이지 IQuestionManager 삭제 처리
	public int deleteQuestion(IQuestion iq);
}

