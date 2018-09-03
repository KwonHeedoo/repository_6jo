package com.scit6jo.web.admin.vo;

public class GraphData {
	private String day;
	private int countOne;
	private int countTwo;
	private int countThree;
	private int countFour;
	
	public GraphData() {
		super();
	}

	public GraphData(String day, int countOne, int countTwo) {
		super();
		this.day = day;
		this.countOne = countOne;
		this.countTwo = countTwo;
	}
	
	public GraphData(int countOne, int countTwo, int countThree, int countFour) {
		super();
		this.countOne = countOne;
		this.countTwo = countTwo;
		this.countThree = countThree;
		this.countFour = countFour;
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

	public int getCountThree() {
		return countThree;
	}

	public void setCountThree(int countThree) {
		this.countThree = countThree;
	}

	public int getCountFour() {
		return countFour;
	}

	public void setCountFour(int countFour) {
		this.countFour = countFour;
	}

	@Override
	public String toString() {
		return "GraphData [day=" + day + ", countOne=" + countOne + ", countTwo=" + countTwo + ", countThree="
				+ countThree + ", countFour=" + countFour + "]";
	}

}
