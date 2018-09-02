package com.scit6jo.web.admin.vo;

public class GraphData {
	private String date;
	private int count;
	
	public GraphData() {
		super();
	}

	public GraphData(String date, int count) {
		super();
		this.date = date;
		this.count = count;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	@Override
	public String toString() {
		return "GraphData [date=" + date + ", count=" + count + "]";
	}
	
}
