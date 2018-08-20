package com.scit6jo.web.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.scit6jo.web.vo.IData;
import com.scit6jo.web.vo.IQuestion;

@Repository
public class DataRepository {

	@Autowired
	SqlSession session;

	/**
	 * 회원 가입 처리
	 * @param Member 사용자가 입력한 가입 정보
	 */
	public int insertIData(IData iData) {
		DataMapper mapper = session.getMapper(DataMapper.class);

		int result = 0;
		try {
			result = mapper.insertIData(iData);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public ArrayList<IQuestion> selectAllQuestion() {
		DataMapper mapper = session.getMapper(DataMapper.class);

		ArrayList<IQuestion> result = null;
		try {
			result = mapper.selectAllQuestion();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public IData selectOneIdata(int dataNum) {
		DataMapper mapper = session.getMapper(DataMapper.class);

		IData result = null;
		try {
			result = mapper.selectOneIdata(dataNum);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}

