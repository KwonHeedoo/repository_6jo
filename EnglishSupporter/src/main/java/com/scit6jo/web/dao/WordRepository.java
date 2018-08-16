package com.scit6jo.web.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.scit6jo.web.vo.Word;

@Repository
public class WordRepository {
	@Autowired
	SqlSession session;
	
	public List<Word> getWordList(String wordlevel){
		WordMapper dao= session.getMapper(WordMapper.class);
		List<Word>wordlist = dao.selectAllWord(wordlevel);
		
		if(wordlist==null) {
			System.out.println("단어리스트 불러오기 실패!");
		}
		
		return wordlist;
	}
	
}
