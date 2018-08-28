package com.scit6jo.web.vo;

public class Board {
	private int boardNum;
	private String userid;
	private String title;
	private String contents;
	private String regdate;
	private int hitcount;
	private String matchingId;
	private String originalfile;
	private String savedfile;
	
	public Board() {
		super();
	}
	
	public Board(int boardNum, String userid, String title, String contents, String regdate, int hitcount) {
		super();
		this.boardNum = boardNum;
		this.userid = userid;
		this.title = title;
		this.contents = contents;
		this.regdate = regdate;
		this.hitcount = hitcount;
	}

	public Board(int boardNum, String userid, String title, String contents, String regdate, int hitcount,
			String matchingId) {
		super();
		this.boardNum = boardNum;
		this.userid = userid;
		this.title = title;
		this.contents = contents;
		this.regdate = regdate;
		this.hitcount = hitcount;
		this.matchingId = matchingId;
	}

	public Board(int boardNum, String userid, String title, String contents, String regdate, int hitcount,
			String originalfile, String savedfile) {
		super();
		this.boardNum = boardNum;
		this.userid = userid;
		this.title = title;
		this.contents = contents;
		this.regdate = regdate;
		this.hitcount = hitcount;
		this.originalfile = originalfile;
		this.savedfile = savedfile;
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

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public int getHitcount() {
		return hitcount;
	}

	public void setHitcount(int hitcount) {
		this.hitcount = hitcount;
	}

	public String getMatchingId() {
		return matchingId;
	}

	public void setMatchingId(String matchingId) {
		this.matchingId = matchingId;
	}

	public String getOriginalfile() {
		return originalfile;
	}

	public void setOriginalfile(String originalfile) {
		this.originalfile = originalfile;
	}

	public String getSavedfile() {
		return savedfile;
	}

	public void setSavedfile(String savedfile) {
		this.savedfile = savedfile;
	}

	@Override
	public String toString() {
		return "Board [boardNum=" + boardNum + ", userid=" + userid + ", title=" + title + ", contents=" + contents
				+ ", regdate=" + regdate + ", hitcount=" + hitcount + ", matchingId=" + matchingId + ", originalfile="
				+ originalfile + ", savedfile=" + savedfile + "]";
	}
	
}
