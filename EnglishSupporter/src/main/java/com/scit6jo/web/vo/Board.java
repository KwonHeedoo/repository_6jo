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
	private String appointedTime;
	private String roomNum;
	private String originalfile;
	private String savedfile;
	
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
			String matchingId, String appointedTime, String roomNum) {
		super();
		this.boardNum = boardNum;
		this.userid = userid;
		this.title = title;
		this.contents = contents;
		this.hitcount = hitcount;
		this.regdate = regdate;
		this.status = status;
		this.matchingId = matchingId;
		this.appointedTime = appointedTime;
		this.roomNum = roomNum;
	}

	public Board(int boardNum, String userid, String title, String contents, int hitcount, String regdate, int status,
			String originalfile, String savedfile) {
		super();
		this.boardNum = boardNum;
		this.userid = userid;
		this.title = title;
		this.contents = contents;
		this.hitcount = hitcount;
		this.regdate = regdate;
		this.status = status;
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

	public String getAppointedTime() {
		return appointedTime;
	}

	public void setAppointedTime(String appointedTime) {
		this.appointedTime = appointedTime;
	}

	public String getRoomNum() {
		return roomNum;
	}

	public void setRoomNum(String roomNum) {
		this.roomNum = roomNum;
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
				+ ", hitcount=" + hitcount + ", regdate=" + regdate + ", status=" + status + ", matchingId="
				+ matchingId + ", appointedTime=" + appointedTime + ", roomNum=" + roomNum + ", originalfile="
				+ originalfile + ", savedfile=" + savedfile + "]";
	}

}
