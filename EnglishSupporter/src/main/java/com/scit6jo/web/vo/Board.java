package com.scit6jo.web.vo;

public class Board {
	private int boardNum;
	private String userid;
	private String title;
	private String contents;
	private int hitcount;
	private String regdate;
	private int status;
	private String matchingId;
	private int datanum;
	
	public Board() {
		super();
	}

	public Board(int boardNum, String userid, String title, String contents, int hitcount, String regdate, int status) {
		super();
		this.boardNum = boardNum;
		this.userid = userid;
		this.title = title;
		this.contents = contents;
		this.hitcount = hitcount;
		this.regdate = regdate;
		this.status = status;
	}

	public Board(int boardNum, String userid, String title, String contents, int hitcount, String regdate, int status,
			String matchingId) {
		super();
		this.boardNum = boardNum;
		this.userid = userid;
		this.title = title;
		this.contents = contents;
		this.hitcount = hitcount;
		this.regdate = regdate;
		this.status = status;
		this.matchingId = matchingId;
	}

	public Board(int boardNum, String userid, String title, String contents, int hitcount, String regdate, int status,
			int datanum) {
		super();
		this.boardNum = boardNum;
		this.userid = userid;
		this.title = title;
		this.contents = contents;
		this.hitcount = hitcount;
		this.regdate = regdate;
		this.status = status;
		this.datanum = datanum;
	}

	public int getBoardNum() {
		return boardNum;
	}

	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public int getHitcount() {
		return hitcount;
	}

	public void setHitcount(int hitcount) {
		this.hitcount = hitcount;
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

	public String getMatchingId() {
		return matchingId;
	}

	public void setMatchingId(String matchingId) {
		this.matchingId = matchingId;
	}

	
	public int getDatanum() {
		return datanum;
	}

	public void setDatanum(int datanum) {
		this.datanum = datanum;
	}

	@Override
	public String toString() {
		return "Board [boardNum=" + boardNum + ", userid=" + userid + ", title=" + title + ", contents=" + contents
				+ ", hitcount=" + hitcount + ", regdate=" + regdate + ", status=" + status + ", matchingId="
				+ matchingId + ", datanum=" + datanum + "]";
	}
	
	
}
