package com.scit6jo.web.vo.resume;

public class Additional_info {
	private String resume_no;
	private String info_title;
	private String detail;
	private String remarks;
	private String info_date;
	
	
	public String getResume_no() {
		return resume_no;
	}
	public void setResume_no(String resume_no) {
		this.resume_no = resume_no;
	}
	public String getInfo_title() {
		return info_title;
	}
	public void setInfo_title(String info_title) {
		this.info_title = info_title;
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
	public String getInfo_date() {
		return info_date;
	}
	public void setInfo_date(String info_date) {
		this.info_date = info_date;
	}
	@Override
	public String toString() {
		return "Additional_info [info_title=" + info_title + ", detail=" + detail + ", remarks=" + remarks
				+ ", info_date=" + info_date + "]";
	}
	
	

	
	
	
}
