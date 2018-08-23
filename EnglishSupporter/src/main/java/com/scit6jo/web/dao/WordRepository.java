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

	
	public List<Word> getWordList(String wordlevel, String userid){
		WordMapper mapper= session.getMapper(WordMapper.class);
		List<Word>wordlist = mapper.selectAllWord(wordlevel, userid);
		
		if(wordlist==null) {
			System.out.println("단어리스트 불러오기 실패!");
		}
		
		return wordlist;
	}

	public List<Word> getMyWords(String userid) {
		WordMapper mapper= session.getMapper(WordMapper.class);
		List<Word>wordlist = mapper.getMyWords(userid);
		
		
		return wordlist;
	}
	


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

	public boolean insertMyWord(Word word) {
		WordMapper mapper = session.getMapper(WordMapper.class);
		int cnt = mapper.insertMyWord(word);
		
		if(cnt>0) {
			return true;
		}
			return false;
	}

	public boolean deleteMyWord(Word word) {
		WordMapper mapper = session.getMapper(WordMapper.class);
		int cnt = mapper.deleteMyWord(word);
		
		if(cnt>0) {
			return true;
		}
			return false;
	}


}
