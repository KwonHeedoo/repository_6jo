package com.scit6jo.web.vo.docs;

public class Education {
	private String school_name;
	private String degree;
	private String major;
	private String start_date;
	private String end_date;
	
	
	public String getSchool_name() {
		return school_name;
	}
	public void setSchool_name(String school_name) {
		this.school_name = school_name;
	}
	public String getDegree() {
		return degree;
	}
	public void setDegree(String degree) {
		this.degree = degree;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	
	@Override
	public String toString() {
		return "Education [school_name=" + school_name + ", degree=" + degree + ", major=" + major + ", start_date="
				+ start_date + ", end_date=" + end_date + "]";
	}
	
	

}
