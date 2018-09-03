package com.scit6jo.web.admin.vo;

public class GraphData {
	private String day;
	private int countOne;
	private int countTwo;
	
	public GraphData() {
		super();
	}

	public GraphData(String day, int countOne, int countTwo) {
		super();
		this.day = day;
		this.countOne = countOne;
		this.countTwo = countTwo;
	}

	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}

	public int getCountOne() {
		return countOne;
	}

	public void setCountOne(int countOne) {
		this.countOne = countOne;
	}

	public int getCountTwo() {
		return countTwo;
	}

	public void setCountTwo(int countTwo) {
		this.countTwo = countTwo;
	}

	@Override
	public String toString() {
		return "GraphData [day=" + day + ", countOne=" + countOne + ", countTwo=" + countTwo + "]";
	}
	
}
