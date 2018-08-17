package com.scit6jo.web.vo;

public class Word {
	private int wordNum;
	private String word;
	private String meaningK;
	private String meaningJ;
	private int level;
	
	public Word() {
		super();
	}

	public Word(String word) {
		super();
		this.word = word;
	}

	public Word(int wordNum, String word, String meaningK, String meaningJ, int level) {
		super();
		this.wordNum = wordNum;
		this.word = word;
		this.meaningK = meaningK;
		this.meaningJ = meaningJ;
		this.level = level;
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

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	@Override
	public String toString() {
		return "Word [wordNum=" + wordNum + ", word=" + word + ", meaningK=" + meaningK + ", meaningJ=" + meaningJ
				+ ", level=" + level + "]";
	}
	
}
