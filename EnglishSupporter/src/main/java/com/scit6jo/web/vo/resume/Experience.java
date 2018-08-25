package com.scit6jo.web.vo.resume;

public class Experience {
	private String company_name;
	private String job_description;
	private String start_date;
	private String end_date;
	private String resume_no;
	
	public String getCompany_name() {
		return company_name;
	}
	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}
	public String getJob_description() {
		return job_description;
	}
	public void setJob_description(String job_description) {
		this.job_description = job_description;
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
	public String getResume_no() {
		return resume_no;
	}
	public void setResume_no(String resume_no) {
		this.resume_no = resume_no;
	}
	@Override
	public String toString() {
		return "Experience [company_name=" + company_name + ", job_description=" + job_description + ", start_date="
				+ start_date + ", end_date=" + end_date + ", resume_no=" + resume_no + "]";
	}


	

}
