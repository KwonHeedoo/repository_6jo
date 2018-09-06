package com.scit6jo.web.vo;

public class Schedule {
	private String userid;
	private String title;
	private String allDay;
	private String start;
	private String end;
	private String id;
	
	public Schedule() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Schedule(String userid, String title, String allDay, String start, String end, String id) {
		super();
		this.userid = userid;
		this.title = title;
		this.allDay = allDay;
		this.start = start;
		this.end = end;
		this.id = id;
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

	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Override
	public String toString() {
		return "Schedule [userid=" + userid + ", title=" + title + ", allDay=" + allDay + ", start=" + start + ", end="
				+ end + ", id=" + id + "]";
	}
	

}
