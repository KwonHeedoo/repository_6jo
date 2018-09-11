package com.scit6jo.web.vo;

public class Schedule {
	private String userid;
	private String title;
	private String allDay;
	private String startDate;
	private String endDate;
	private String s_id;
	
	public Schedule() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Schedule(String userid, String title) {
		super();
		this.userid = userid;
		this.title = title;
	}

	public Schedule(String userid, String title, String allDay, String startDate) {
		super();
		this.userid = userid;
		this.title = title;
		this.allDay = allDay;
		this.startDate = startDate;
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

	public String getAllDay() {
		return allDay;
	}

	public void setAllDay(String allDay) {
		this.allDay = allDay;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getS_id() {
		return s_id;
	}

	public void setS_id(String s_id) {
		this.s_id = s_id;
	}

	@Override
	public String toString() {
		return "Schedule [userid=" + userid + ", title=" + title + ", allDay=" + allDay + ", startDate=" + startDate
				+ ", endDate=" + endDate + ", s_id=" + s_id + "]";
	}
	
	

}
