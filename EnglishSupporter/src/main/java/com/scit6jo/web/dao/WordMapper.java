package com.scit6jo.web.dao;

import java.util.List;

import com.scit6jo.web.vo.Word;

public interface WordMapper {
	
	public List<Word> selectAllWord(String wordlevel);

}
