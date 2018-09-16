package com.scit6jo.web.vo;

public class Comment {
	private int commentNum;
	private String userid;
	private String nickname;
	private String imgFilePath;
	private int boardNum;
	private String comments;
	private String regdate;
	private String parentId;
	private String parentNick;
	private int groupNum;
	private String matchingId;
	private float pronunciation;
	private float contents;
	private float posture;
	
	public Comment() {
		super();
	}

	public Comment(int commentNum, String userid, String nickname, String imgFilePath, int boardNum, String comments, 
			String regdate, String parentId, String parentNick, int groupNum, String matchingId) {
		super();
		this.commentNum = commentNum;
		this.userid = userid;
		this.nickname = nickname;
		this.boardNum = boardNum;
		this.comments = comments;
		this.regdate = regdate;
		this.parentId = parentId;
		this.parentNick = parentNick;
		this.groupNum = groupNum;
		this.matchingId = matchingId;
	}

	public Comment(int commentNum, String userid, String nickname, int boardNum, String comments, String regdate,
			String parentId, String parentNick, int groupNum, float pronunciation, float contents, float posture) {
		super();
		this.commentNum = commentNum;
		this.userid = userid;
		this.nickname = nickname;
		this.boardNum = boardNum;
		this.comments = comments;
		this.regdate = regdate;
		this.parentId = parentId;
		this.parentNick = parentNick;
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

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	public String getImgFilePath() {
		return imgFilePath;
	}

	public void setImgFilePath(String imgFilePath) {
		this.imgFilePath = imgFilePath;
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

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getParentNick() {
		return parentNick;
	}

	public void setParentNick(String parentNick) {
		this.parentNick = parentNick;
	}

	public int getGroupNum() {
		return groupNum;
	}

	public void setGroupNum(int groupNum) {
		this.groupNum = groupNum;
	}

	public String getMatchingId() {
		return matchingId;
	}

	public void setMatchingId(String matchingId) {
		this.matchingId = matchingId;
	}

	public float getPronunciation() {
		return pronunciation;
	}

	public void setPronunciation(float pronunciation) {
		this.pronunciation = pronunciation;
	}

	public float getContents() {
		return contents;
	}

	public void setContents(float contents) {
		this.contents = contents;
	}

	public float getPosture() {
		return posture;
	}

	public void setPosture(float posture) {
		this.posture = posture;
	}
	

	@Override
	public String toString() {
		return "Comment [commentNum=" + commentNum + ", userid=" + userid + ", nickname=" + nickname + ", imgFilePath="
				+ imgFilePath + ", boardNum=" + boardNum + ", comments=" + comments + ", regdate=" + regdate
				+ ", parentId=" + parentId + ", parentNick=" + parentNick + ", groupNum=" + groupNum + ", matchingId="
				+ matchingId + ", pronunciation=" + pronunciation + ", contents=" + contents + ", posture=" + posture
				+ "]";
	}

}
