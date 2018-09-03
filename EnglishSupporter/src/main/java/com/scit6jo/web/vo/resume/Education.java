package com.scit6jo.web.vo.resume;

public class Education {
	private String school_name;
	private String degree_level;
	private String major;
	private String enter_date;
	private String graduate_date;
	private String resume_no;
	
	public String getSchool_name() {
		return school_name;
	}
	public void setSchool_name(String school_name) {
		this.school_name = school_name;
	}
	public String getDegree_level() {
		return degree_level;
	}
	public void setDegree_level(String degree_level) {
		this.degree_level = degree_level;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getEnter_date() {
		return enter_date;
	}
	public void setEnter_date(String enter_date) {
		this.enter_date = enter_date;
	}
	public String getGraduate_date() {
		return graduate_date;
	}
	public void setGraduate_date(String graduate_date) {
		this.graduate_date = graduate_date;
	}
	public String getResume_no() {
		return resume_no;
	}
	public void setResume_no(String resume_no) {
		this.resume_no = resume_no;
	}
	@Override
	public String toString() {
		return "Education [school_name=" + school_name + ", degree_level=" + degree_level + ", major=" + major
				+ ", enter_date=" + enter_date + ", graduate_date=" + graduate_date + ", resume_no=" + resume_no + "]";
	}
	
	
	
	

}
