package com.sp.tp.book;



public class Book {
	private int bNum;
	private String userId;
	private String bookDate;
	private int price;
	private int amount;
	private String state;
	
	private int b2Num;
	private int sdNum;
	private String seat_num;
	private int seat_price;
	
	private int tNum;
	private int rows;
	private int cols;
	private String seats;
	private String hallName;
	
	
	private int generalSeat;
	private int vipSeat;
	private String []arrSeat;
	private String []reservedSeat;
	
	private String subject;
	
	
	

	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
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
	
	public int gettNum() {
		return tNum;
	}
	public void settNum(int tNum) {
		this.tNum = tNum;
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

	public String getHallName() {
		return hallName;
	}
	public void setHallName(String hallName) {
		this.hallName = hallName;
	}
	public int getGeneralSeat() {
		return generalSeat;
	}
	public void setGeneralSeat(int generalSeat) {
		this.generalSeat = generalSeat;
	}
	public int getVipSeat() {
		return vipSeat;
	}
	public void setVipSeat(int vipSeat) {
		this.vipSeat = vipSeat;
	}
	public String[] getReservedSeat() {
		return reservedSeat;
	}
	public void setReservedSeat(String[] reservedSeat) {
		this.reservedSeat = reservedSeat;
	}
	public int getbNum() {
		return bNum;
	}
	public void setbNum(int bNum) {
		this.bNum = bNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getBookDate() {
		return bookDate;
	}
	public void setBookDate(String bookDate) {
		this.bookDate = bookDate;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public int getB2Num() {
		return b2Num;
	}
	public void setB2Num(int b2Num) {
		this.b2Num = b2Num;
	}
	public int getSdNum() {
		return sdNum;
	}
	public void setSdNum(int sdNum) {
		this.sdNum = sdNum;
	}
	public String getSeat_num() {
		return seat_num;
	}
	public void setSeat_num(String seat_num) {
		this.seat_num = seat_num;
	}
	public int getSeat_price() {
		return seat_price;
	}
	public void setSeat_price(int seat_price) {
		this.seat_price = seat_price;
	}

}
