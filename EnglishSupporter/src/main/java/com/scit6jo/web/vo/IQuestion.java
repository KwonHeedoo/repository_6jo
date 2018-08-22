package com.scit6jo.web.vo;

public class IQuestion {
	private int questionNum;	
	private String question;
	
	
	
	public IQuestion() {
		super();
		// TODO Auto-generated constructor stub
	}



	public IQuestion(int questionNum, String question) {
		super();
		this.questionNum = questionNum;
		this.question = question;
	}



	public int getQuestionNum() {
		return questionNum;
	}



	public void setQuestionNum(int questionNum) {
		this.questionNum = questionNum;
	}



	public String getQuestion() {
		return question;
	}



	public void setQuestion(String question) {
		this.question = question;
	}



	@Override
	public String toString() {
		return "InterviewQuestion [questionNum=" + questionNum + ", question=" + question + "]";
	}
	
	
}
