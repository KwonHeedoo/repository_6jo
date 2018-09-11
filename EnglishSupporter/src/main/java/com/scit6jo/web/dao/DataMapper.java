package com.scit6jo.web.dao;

import java.util.ArrayList;
import java.util.Map;

import com.scit6jo.web.vo.IData;
import com.scit6jo.web.vo.IQuestion;

public interface DataMapper {
	// 회원가입
	public int insertIData(IData iData);
	public int updateAnswer(IData iData);
	public int updateConfidence(IData iData);
	public ArrayList<IQuestion> selectAllQuestion();
	public IData selectOneIData(int dataNum);
	public ArrayList<IData> selectAllIData(String userid);
}

