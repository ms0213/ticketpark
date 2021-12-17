package com.sp.tp.admin.theaterManage;

public class Theater {
	private int tNum;
	private int hallNo; // 공연장 번호
	private int sCount;
	private String name;
	private String location;
	private String saveFilename;
	
	private int generalSeat; // 일반좌석수
	private int vipSeat; // 휠체어 좌석수

	private int rows;
	private int cols;
	private String seats; // 좌석배치도
	private String []arrSeat;
	
	private String hallName;
	
	private String hallFile;
	
	public String getHallName() {
		return hallName;
	}
	public void setHallName(String hallName) {
		this.hallName = hallName;
	}
	
	public int gettNum() {
		return tNum;
	}
	public void settNum(int tNum) {
		this.tNum = tNum;
	}
	public int getHallNo() {
		return hallNo;
	}
	public void setHallNo(int hallNo) {
		this.hallNo = hallNo;
	}
	public int getsCount() {
		return sCount;
	}
	public void setsCount(int sCount) {
		this.sCount = sCount;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getSaveFilename() {
		return saveFilename;
	}
	public void setSaveFilename(String saveFilename) {
		this.saveFilename = saveFilename;
	}
	public int getGeneralSeat() {
		return generalSeat;
	}
	public void setGeneralSeat(int generalSeat) {
		this.generalSeat = generalSeat;
	}
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
	public int getCols() {
		return cols;
	}
	public void setCols(int cols) {
		this.cols = cols;
	}
	public String getSeats() {
		return seats;
	}
	public void setSeats(String seats) {
		this.seats = seats;
	}
	public String[] getArrSeat() {
		return arrSeat;
	}
	public void setArrSeat(String[] arrSeat) {
		this.arrSeat = arrSeat;
	}
	public int getVipSeat() {
		return vipSeat;
	}
	public void setVipSeat(int vipSeat) {
		this.vipSeat = vipSeat;
	}
	public String getHallFile() {
		return hallFile;
	}
	public void setHallFile(String hallFile) {
		this.hallFile = hallFile;
	}
	
}
