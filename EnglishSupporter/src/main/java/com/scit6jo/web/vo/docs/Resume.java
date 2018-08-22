package com.scit6jo.web.vo.docs;

import java.util.List;

public class Resume {
	private String resume_no;
	private String userid;
	private String title;
	private String regdate;
	private String deadline;
	private String company;
	private List<Education> education;
	private List<Experience> Experience;
	private List<Additional_info> Additional_info;
	
	
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
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public List<Education> getEducation() {
		return education;
	}
	public void setEducation(List<Education> education) {
		this.education = education;
	}
	public List<Experience> getExperience() {
		return Experience;
	}
	public void setExperience(List<Experience> experience) {
		Experience = experience;
	}
	public List<Additional_info> getAdditional_info() {
		return Additional_info;
	}
	public void setAdditional_info(List<Additional_info> additional_info) {
		Additional_info = additional_info;
	}
	@Override
	public String toString() {
		return "Resume [resume_no=" + resume_no + ", userid=" + userid + ", title=" + title + ", regdate=" + regdate
				+ ", deadline=" + deadline + ", company=" + company + ", education=" + education + ", Experience="
				+ Experience + ", Additional_info=" + Additional_info + "]";
	}

	
}
