package com.scit6jo.web.vo;

public class User {
	private String userid;
	private String userpwd;
	private String nickname;
	private String email;
	private String birthdate;
	private String username;
	private String usertype;
	private String regdate;
	private String lastdate;
	private int attendNum;
	
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public User(String userid, String userpwd, String nickname, String email, String birthdate, String username,
			String usertype, String regdate, String lastdate, int attendNum) {
		super();
		this.userid = userid;
		this.userpwd = userpwd;
		this.nickname = nickname;
		this.email = email;
		this.birthdate = birthdate;
		this.username = username;
		this.usertype = usertype;
		this.regdate = regdate;
		this.lastdate = lastdate;
		this.attendNum = attendNum;
	}

	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUserpwd() {
		return userpwd;
	}
	public void setUserpwd(String userpwd) {
		this.userpwd = userpwd;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getBirthdate() {
		return birthdate;
	}
	public void setBirthdate(String birthdate) {
		this.birthdate = birthdate;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUsertype() {
		return usertype;
	}
	public void setUsertype(String usertype) {
		this.usertype = usertype;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getLastdate() {
		return lastdate;
	}
	public void setLastdate(String lastdate) {
		this.lastdate = lastdate;
	}
	public int getAttendNum() {
		return attendNum;
	}
	public void setAttendNum(int attendNum) {
		this.attendNum = attendNum;
	}

	@Override
	public String toString() {
		return "User [userid=" + userid + ", userpwd=" + userpwd + ", nickname=" + nickname + ", email=" + email
				+ ", birthdate=" + birthdate + ", username=" + username + ", usertype=" + usertype + ", regdate="
				+ regdate + ", lastdate=" + lastdate + ", attendNum=" + attendNum + "]";
	}
	
}
