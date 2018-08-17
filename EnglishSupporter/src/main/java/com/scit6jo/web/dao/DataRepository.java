package com.scit6jo.web.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.scit6jo.web.vo.InterviewData;

@Repository
public class DataRepository {

	@Autowired
	SqlSession session;

	/**
	 * 회원 가입 처리
	 * @param Member 사용자가 입력한 가입 정보
	 */
	public int insert(InterviewData interData) {
		DataMapper mapper = session.getMapper(DataMapper.class);

		int result = 0;
		try {
			result = mapper.insert(interData);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	
}

