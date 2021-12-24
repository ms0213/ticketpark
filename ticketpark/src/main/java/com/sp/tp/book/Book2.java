package com.sp.tp.book;

import java.util.List;

public class Book2 {
	private int bNum;
	private String userId;
	private String bookDate;
	private int price;
	private int amount;
	
	private int b2Num;
	private int sdNum;
	private int seat_price;
	private List<String> seats;
	private String seat_num;
	
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
	public List<String> getSeats() {
		return seats;
	}
	public void setSeats(List<String> seats) {
		this.seats = seats;
	}
}
