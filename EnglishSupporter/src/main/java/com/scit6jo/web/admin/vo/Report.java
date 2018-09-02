package com.scit6jo.web.admin.vo;

public class Report {
	private int reportNum;
	private String reporter;
	private String reportee;
	private String report;
	private String reason;
	private String regdate;
	private String reportURL;
	
	public Report() {
		super();
	}

	public Report(int reportNum, String reporter, String reportee, String report, String reason, String regdate,
			String reportURL) {
		super();
		this.reportNum = reportNum;
		this.reporter = reporter;
		this.reportee = reportee;
		this.report = report;
		this.reason = reason;
		this.regdate = regdate;
		this.reportURL = reportURL;
	}

	public int getReportNum() {
		return reportNum;
	}

	public void setReportNum(int reportNum) {
		this.reportNum = reportNum;
	}

	public String getReporter() {
		return reporter;
	}

	public void setReporter(String reporter) {
		this.reporter = reporter;
	}

	public String getReportee() {
		return reportee;
	}

	public void setReportee(String reportee) {
		this.reportee = reportee;
	}

	public String getReport() {
		return report;
	}

	public void setReport(String report) {
		this.report = report;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getReportURL() {
		return reportURL;
	}

	public void setReportURL(String reportURL) {
		this.reportURL = reportURL;
	}

	@Override
	public String toString() {
		return "Report [reportNum=" + reportNum + ", reporter=" + reporter + ", reportee=" + reportee + ", report="
				+ report + ", reason=" + reason + ", regdate=" + regdate + ", reportURL=" + reportURL + "]";
	}
	
}
