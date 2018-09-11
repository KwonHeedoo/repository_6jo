package com.scit6jo.web.vo;

public class IData {
	private int dataNum;
	private String userid;
	private int questionNum;
	private String answer;
	private String regdate;
	private String saveFile;
	private float confidence;
	public IData() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	public IData(int dataNum, String userid, int questionNum, String answer, String regdate, String saveFile,
			float confidence) {
		super();
		this.dataNum = dataNum;
		this.userid = userid;
		this.questionNum = questionNum;
		this.answer = answer;
		this.regdate = regdate;
		this.saveFile = saveFile;
		this.confidence = confidence;
	}


	public int getDataNum() {
		return dataNum;
	}
	public void setDataNum(int dataNum) {
		this.dataNum = dataNum;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getQuestionNum() {
		return questionNum;
	}
	public void setQuestionNum(int questionNum) {
		this.questionNum = questionNum;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getSaveFile() {
		return saveFile;
	}
	public void setSaveFile(String saveFile) {
		this.saveFile = saveFile;
	}

	public float getConfidence() {
		return confidence;
	}
	public void setConfidence(float confidence) {
		this.confidence = confidence;
	}
	@Override
	public String toString() {
		return "IData [dataNum=" + dataNum + ", userid=" + userid + ", questionNum=" + questionNum + ", answer="
				+ answer + ", regdate=" + regdate + ", saveFile=" + saveFile + ", confidence=" + confidence + "]";
	}
	
	
	
	
}
