package com.scit6jo.web.vo;

public class Resume {
	private String userid;
	private String title;
	private String username;
	private String email;
	private String phone;
	private String address;
	private String edu_date1;
	private String edu_date2;
	private String edu_school;
	private String edu_major;
	private String skill;
	private String pro_date1;
	private String pro_date2;
	private String pro_job;
	private String pro_detail;
	private String act_date1;
	private String act_date2;
	private String act_title;
	private String act_detail;
	private String lang;
	private String lang_pro;
	private String add_info;
	private String regdate;
	private String deadline;
	private String hashtag;
	private String res_cov;
	
	public Resume() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Resume(String userid, String title, String username, String email, String phone, String address,
			String edu_date1, String edu_date2, String edu_school, String edu_major, String skill, String pro_date1,
			String pro_date2, String pro_job, String pro_detail, String act_date1, String act_date2, String act_title,
			String act_detail, String lang, String lang_pro, String add_info, String regdate, String deadline,
			String hashtag, String res_cov) {
		super();
		this.userid = userid;
		this.title = title;
		this.username = username;
		this.email = email;
		this.phone = phone;
		this.address = address;
		this.edu_date1 = edu_date1;
		this.edu_date2 = edu_date2;
		this.edu_school = edu_school;
		this.edu_major = edu_major;
		this.skill = skill;
		this.pro_date1 = pro_date1;
		this.pro_date2 = pro_date2;
		this.pro_job = pro_job;
		this.pro_detail = pro_detail;
		this.act_date1 = act_date1;
		this.act_date2 = act_date2;
		this.act_title = act_title;
		this.act_detail = act_detail;
		this.lang = lang;
		this.lang_pro = lang_pro;
		this.add_info = add_info;
		this.regdate = regdate;
		this.deadline = deadline;
		this.hashtag = hashtag;
		this.res_cov = res_cov;
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
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getEdu_date1() {
		return edu_date1;
	}
	public void setEdu_date1(String edu_date1) {
		this.edu_date1 = edu_date1;
	}
	public String getEdu_date2() {
		return edu_date2;
	}
	public void setEdu_date2(String edu_date2) {
		this.edu_date2 = edu_date2;
	}
	public String getEdu_school() {
		return edu_school;
	}
	public void setEdu_school(String edu_school) {
		this.edu_school = edu_school;
	}
	public String getEdu_major() {
		return edu_major;
	}
	public void setEdu_major(String edu_major) {
		this.edu_major = edu_major;
	}
	public String getSkill() {
		return skill;
	}
	public void setSkill(String skill) {
		this.skill = skill;
	}
	public String getPro_date1() {
		return pro_date1;
	}
	public void setPro_date1(String pro_date1) {
		this.pro_date1 = pro_date1;
	}
	public String getPro_date2() {
		return pro_date2;
	}
	public void setPro_date2(String pro_date2) {
		this.pro_date2 = pro_date2;
	}
	public String getPro_job() {
		return pro_job;
	}
	public void setPro_job(String pro_job) {
		this.pro_job = pro_job;
	}
	public String getPro_detail() {
		return pro_detail;
	}
	public void setPro_detail(String pro_detail) {
		this.pro_detail = pro_detail;
	}
	public String getAct_date1() {
		return act_date1;
	}
	public void setAct_date1(String act_date1) {
		this.act_date1 = act_date1;
	}
	public String getAct_date2() {
		return act_date2;
	}
	public void setAct_date2(String act_date2) {
		this.act_date2 = act_date2;
	}
	public String getAct_title() {
		return act_title;
	}
	public void setAct_title(String act_title) {
		this.act_title = act_title;
	}
	public String getAct_detail() {
		return act_detail;
	}
	public void setAct_detail(String act_detail) {
		this.act_detail = act_detail;
	}
	public String getLang() {
		return lang;
	}
	public void setLang(String lang) {
		this.lang = lang;
	}
	public String getLang_pro() {
		return lang_pro;
	}
	public void setLang_pro(String lang_pro) {
		this.lang_pro = lang_pro;
	}
	public String getAdd_info() {
		return add_info;
	}
	public void setAdd_info(String add_info) {
		this.add_info = add_info;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getDeadline() {
		return deadline;
	}
	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}
	public String getHashtag() {
		return hashtag;
	}
	public void setHashtag(String hashtag) {
		this.hashtag = hashtag;
	}
	public String getRes_cov() {
		return res_cov;
	}
	public void setRes_cov(String res_cov) {
		this.res_cov = res_cov;
	}

	@Override
	public String toString() {
		return "Resume [userid=" + userid + ", title=" + title + ", username=" + username + ", email=" + email
				+ ", phone=" + phone + ", address=" + address + ", edu_date1=" + edu_date1 + ", edu_date2=" + edu_date2
				+ ", edu_school=" + edu_school + ", edu_major=" + edu_major + ", skill=" + skill + ", pro_date1="
				+ pro_date1 + ", pro_date2=" + pro_date2 + ", pro_job=" + pro_job + ", pro_detail=" + pro_detail
				+ ", act_date1=" + act_date1 + ", act_date2=" + act_date2 + ", act_title=" + act_title + ", act_detail="
				+ act_detail + ", lang=" + lang + ", lang_pro=" + lang_pro + ", add_info=" + add_info + ", regdate="
				+ regdate + ", deadline=" + deadline + ", hashtag=" + hashtag + ", res_cov=" + res_cov + "]";
	}
	
}
