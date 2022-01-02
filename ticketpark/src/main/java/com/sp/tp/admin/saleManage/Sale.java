package com.sp.tp.admin.saleManage;

public class Sale {
	private String bookDate;
	private int price;
	private int total;
	private String subject;
	private String category;
	private String month;
	private int cateCount;
	private int monthCount;
	private int perfCount;
	private int cateAllCount;
	
	
	public int getCateAllCount() {
		return cateAllCount;
	}
	public void setCateAllCount(int cateAllCount) {
		this.cateAllCount = cateAllCount;
	}
	public int getCateCount() {
		return cateCount;
	}
	public void setCateCount(int cateCount) {
		this.cateCount = cateCount;
	}
	public int getMonthCount() {
		return monthCount;
	}
	public void setMonthCount(int monthCount) {
		this.monthCount = monthCount;
	}
	public int getPerfCount() {
		return perfCount;
	}
	public void setPerfCount(int perfCount) {
		this.perfCount = perfCount;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
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
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
}
