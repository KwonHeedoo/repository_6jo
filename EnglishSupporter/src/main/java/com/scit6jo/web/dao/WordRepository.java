package com.scit6jo.web.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class WordRepository {
	@Autowired
	SqlSession session;

	public List<String> exceptionWord() {
		WordMapper mapper = session.getMapper(WordMapper.class);

		List<String> exceptionWord = null;
		try {
			exceptionWord = mapper.exceptionWord();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return exceptionWord;
	}
}
