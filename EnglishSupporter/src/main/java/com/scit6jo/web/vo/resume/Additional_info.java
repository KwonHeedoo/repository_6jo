package com.scit6jo.web.vo.resume;

public class Additional_info {
	private String resume_no;
	private String title;
	private String detail;
	private String remarks;
	private String date;
	
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getResume_no() {
		return resume_no;
	}
	public void setResume_no(String resume_no) {
		this.resume_no = resume_no;
	}
	@Override
	public String toString() {
		return "Additional_info [resume_no=" + resume_no + ", title=" + title + ", detail=" + detail + ", remarks="
				+ remarks + ", date=" + date + "]";
	}
	

	
}
