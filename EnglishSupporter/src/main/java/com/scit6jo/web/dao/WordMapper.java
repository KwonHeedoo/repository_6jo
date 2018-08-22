package com.scit6jo.web.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.scit6jo.web.vo.Word;

public interface WordMapper {
	/**
	 * 수준별 상 중 하 단어 레벨을 가져옴
	 * @param wordlevel
	 * @param userid 
	 * @return
	 */
	public List<Word> selectAllWord(@Param(value = "wordlevel")String wordlevel, @Param(value = "userid")String userid);
	/**
	 * 내가 즐찾한 단어들이나 직접작성한 단어들을 가져옴 
	 * @param userid
	 * @return
	 */
	public List<Word> getMyWords(String userid);

	public List<String> exceptionWord();
	/**
	 * myword table 에 단어추가
	 * @param word
	 * @return
	 */
	public int insertMyWord(Word word);
	/**
	 * myword table 에 단어 delete하기
	 * @param word
	 * @return
	 */
	public int deleteMyWord(Word word);
	

}
