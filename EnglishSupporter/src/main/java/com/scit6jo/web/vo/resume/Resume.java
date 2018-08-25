package com.scit6jo.web.vo.resume;

import java.util.List;

public class Resume {
	private String resume_no;
	private String userid;
	private String title;
	private String regdate;
	private String deadline;
	private String phone;
	private String address;
	private List<Education> education;
	private List<Experience> experience;
	private List<Additional_info> additional_info;
	
	
	public String getResume_no() {
		return resume_no;
	}
	public void setResume_no(String resume_no) {
		this.resume_no = resume_no;
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
	public List<Education> getEducation() {
		return education;
	}
	public void setEducation(List<Education> education) {
		this.education = education;
	}
	public List<Experience> getExperience() {
		return experience;
	}
	public void setExperience(List<Experience> experience) {
		this.experience = experience;
	}
	public List<Additional_info> getAdditional_info() {
		return additional_info;
	}
	public void setAdditional_info(List<Additional_info> additional_info) {
		this.additional_info = additional_info;
	}
	@Override
	public String toString() {
		return "Resume [resume_no=" + resume_no + ", userid=" + userid + ", title=" + title + ", regdate=" + regdate
				+ ", deadline=" + deadline + ", phone=" + phone + ", address=" + address + ", education=" + education
				+ ", experience=" + experience + ", additional_info=" + additional_info + "]";
	}
	
	

	
}
