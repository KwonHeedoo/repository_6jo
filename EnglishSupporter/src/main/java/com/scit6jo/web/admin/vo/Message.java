package com.scit6jo.web.admin.vo;

public class Message {
	private int messageNum;
	private String userid;
	private String nickname;
	private String receiveId;
	private String message;
	private String regdate;
	private int status;
	
	public Message() {
		super();
	}

	public Message(int messageNum, String userid, String nickname, String receiveId, String message,
			String regdate, int status) {
		super();
		this.messageNum = messageNum;
		this.userid = userid;
		this.nickname = nickname;
		this.receiveId = receiveId;
		this.message = message;
		this.regdate = regdate;
		this.status = status;
	}

	public int getMessageNum() {
		return messageNum;
	}

	public void setMessageNum(int messageNum) {
		this.messageNum = messageNum;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getReceiveId() {
		return receiveId;
	}

	public void setReceiveId(String receiveId) {
		this.receiveId = receiveId;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "Message [messageNum=" + messageNum + ", userid=" + userid + ", nickname=" + nickname + ", receiveId="
				+ receiveId + ", message=" + message + ", regdate=" + regdate + ", status=" + status + "]";
	}
	
}
