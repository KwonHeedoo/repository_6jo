package com.scit6jo.web.vo;

public class Comment {
	private int commentNum;
	private String userid;
	private int boardNum;
	private String comments;
	private String regdate;
	private String parentCmtId;
	private int groupNum;
	private int pronunciation;
	private int contents;
	private int posture;
	
	public Comment() {
		super();
	}

	public Comment(int commentNum, String userid, int boardNum, String comments, String regdate, String parentCmtId,
			int groupNum) {
		super();
		this.commentNum = commentNum;
		this.userid = userid;
		this.boardNum = boardNum;
		this.comments = comments;
		this.regdate = regdate;
		this.parentCmtId = parentCmtId;
		this.groupNum = groupNum;
	}

	public Comment(int commentNum, String userid, int boardNum, String comments, String regdate, String parentCmtId,
			int groupNum, int pronunciation, int contents, int posture) {
		super();
		this.commentNum = commentNum;
		this.userid = userid;
		this.boardNum = boardNum;
		this.comments = comments;
		this.regdate = regdate;
		this.parentCmtId = parentCmtId;
		this.groupNum = groupNum;
		this.pronunciation = pronunciation;
		this.contents = contents;
		this.posture = posture;
	}

	public int getCommentNum() {
		return commentNum;
	}

	public void setCommentNum(int commentNum) {
		this.commentNum = commentNum;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public int getBoardNum() {
		return boardNum;
	}

	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getParentCmtId() {
		return parentCmtId;
	}

	public void setParentCmtId(String parentCmtId) {
		this.parentCmtId = parentCmtId;
	}

	public int getGroupNum() {
		return groupNum;
	}

	public void setGroupNum(int groupNum) {
		this.groupNum = groupNum;
	}

	public int getPronunciation() {
		return pronunciation;
	}

	public void setPronunciation(int pronunciation) {
		this.pronunciation = pronunciation;
	}

	public int getContents() {
		return contents;
	}

	public void setContents(int contents) {
		this.contents = contents;
	}

	public int getPosture() {
		return posture;
	}

	public void setPosture(int posture) {
		this.posture = posture;
	}

	@Override
	public String toString() {
		return "Comment [commentNum=" + commentNum + ", userid=" + userid + ", boardNum=" + boardNum + ", comments="
				+ comments + ", regdate=" + regdate + ", parentCmtId=" + parentCmtId + ", groupNum=" + groupNum
				+ ", pronunciation=" + pronunciation + ", contents=" + contents + ", posture=" + posture + "]";
	}
	
}
