package com.scit6jo.web.vo;

public class Word {
	private int wordNum;
	private String word;
	private String meaningK;
	private String meaningJ;
	private String wordlevel;
	
	
	
	
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
				+ ", wordlevel=" + wordlevel + "]";
	}
	
	
	
	
	
	
}