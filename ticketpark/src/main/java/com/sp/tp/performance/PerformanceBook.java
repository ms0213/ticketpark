package com.sp.tp.performance;

public class PerformanceBook {
	private int ptNum;
	private String perf_date;
	private String perfTime;
	private String actorName;
	
	public String getPerf_date() {
		return perf_date;
	}
	public void setPerf_date(String perf_date) {
		this.perf_date = perf_date;
	}
	public int getPtNum() {
		return ptNum;
	}
	public void setPtNum(int ptNum) {
		this.ptNum = ptNum;
	}
	public String getPerfTime() {
		return perfTime;
	}
	public void setPerfTime(String perfTime) {
		this.perfTime = perfTime;
	}
	public String getActorName() {
		return actorName;
	}
	public void setActorName(String actorName) {
		this.actorName = actorName;
	}
}
