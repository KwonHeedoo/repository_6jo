package com.scit6jo.web.vo;

public class Word {
	
	//myword 와 word 를 동시에 받아서 사용할 VO
	
	private int wordNum;
	private String word;
	private String meaningK;
	private String meaningJ;
	private String wordlevel;
	private String userid;
	private String wordtype;
	
	
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getWordtype() {
		return wordtype;
	}
	public void setWordtype(String wordtype) {
		this.wordtype = wordtype;
	}
	public int getWordNum() {
		return wordNum;
	}
	public void setWordNum(int wordNum) {
		this.wordNum = wordNum;
	}
	public String getWord() {
		return word;
	}
	public void setWord(String word) {
		this.word = word;
	}
	public String getMeaningK() {
		return meaningK;
	}
	public void setMeaningK(String meaningK) {
		this.meaningK = meaningK;
	}
	public String getMeaningJ() {
		return meaningJ;
	}
	public void setMeaningJ(String meaningJ) {
		this.meaningJ = meaningJ;
	}
	public String getWordlevel() {
		return wordlevel;
	}
	public void setWordlevel(String wordlevel) {
		this.wordlevel = wordlevel;
	}
	@Override
	public String toString() {
		return "Word [wordNum=" + wordNum + ", word=" + word + ", meaningK=" + meaningK + ", meaningJ=" + meaningJ
				+ ", wordlevel=" + wordlevel + ", userid=" + userid + ", wordtype=" + wordtype + "]";
	}
	
	
	
	
}