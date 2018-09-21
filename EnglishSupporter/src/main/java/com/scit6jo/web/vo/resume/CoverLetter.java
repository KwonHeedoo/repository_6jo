package com.scit6jo.web.vo.resume;

public class CoverLetter {
	private String title;
	private String maintext;
	private String regdate;
	private String address;
	private String phone;
	private String email;
	private String userid;
	private String username;
	
	
	public CoverLetter() {
		super();
	}

	public CoverLetter(String title, String userid) {
		super();
		this.title = title;
		this.userid = userid;
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getMaintext() {
		return maintext;
	}
	public void setMaintext(String maintext) {
		this.maintext = maintext;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Override
	public String toString() {
		return "CoverLetter [title=" + title + ", maintext=" + maintext + ", regdate=" + regdate + ", address="
				+ address + ", phone=" + phone + ", email=" + email + ", userid=" + userid + ", username=" + username
				+ "]";
	}
	
	
	
}
