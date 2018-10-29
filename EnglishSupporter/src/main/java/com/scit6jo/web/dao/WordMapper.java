package com.scit6jo.web.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import com.scit6jo.web.vo.Word;

public interface WordMapper {
	
	// 마이페이지 내단어장 모든 단어 개수 (페이징처리)
	public int getMyTotal();
	
	// 관리자페이지 wordManager에 띄울 모든 단어 개수 (페이징처리)
	public int getTotal();
	
	// 관리자페이지 wordManager에 띄울 모든 단어리스트 불러오기
	public List<Word> selectAll(RowBounds rb, String wordlevel);
	
	// 관리자페이지 wordManager 단어추가 처리
	public int addWord(Word word);
	
	// 관리자페이지 wordManager 업데이트 처리
	public int updateWord(Word word);
	
	// 관리자페이지 wordManager 삭제 처리
	public int deleteWord(Word word);
	
	/**
	 * 수준별 상 중 하 단어 레벨별로 가져옴
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
	public List<Word> getMyWords(RowBounds rb, String userid);

	public List<String> exceptionWord();
	/**
	 * myword table 에 단어추가
	 * @param word
	 * @return
	 */
	public int insertMyWord(Word word);
	
	/**
	 * myword table 에 단어 update
	 * @param word
	 * @return
	 */
	public int updateMyWord(Word word);
	
	/**
	 * myword table 에 단어 delete하기
	 * @param word
	 * @return
	 */
	public int deleteMyWord(Word word);
	

}
