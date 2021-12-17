package com.sp.tp.performance;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Performance {
	private int perfNum;
	private String subject;
	private String content;
	private String startDate;
	private String endDate;
	private Double rating;
	private int price;
	private int time;
	
	private String perfDate;
	private String perfTime;
	
	private int genreNum;
	private String genre;
	
	private int categoryNum;
	private String category;
	
	private int theaterNum;
	private String theater;
	
	private int hallNum;
	private String hallName;
	
	private int rateNum;
	private String rate;
	
	private String castNum;
	private String castName;
	private String roleName;
	
	private String postNum;
	private String saveFilename;
	private List<MultipartFile> selectFile;
	
	public String getPerfDate() {
		return perfDate;
	}
	public void setPerfDate(String perfDate) {
		this.perfDate = perfDate;
	}
	public String getPerfTime() {
		return perfTime;
	}
	public void setPerfTime(String perfTime) {
		this.perfTime = perfTime;
	}
	public int getPerfNum() {
		return perfNum;
	}
	public void setPerfNum(int perfNum) {
		this.perfNum = perfNum;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public Double getRating() {
		return rating;
	}
	public void setRating(Double rating) {
		this.rating = rating;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getTime() {
		return time;
	}
	public void setTime(int time) {
		this.time = time;
	}
	public int getGenreNum() {
		return genreNum;
	}
	public void setGenreNum(int genreNum) {
		this.genreNum = genreNum;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public int getCategoryNum() {
		return categoryNum;
	}
	public void setCategoryNum(int categoryNum) {
		this.categoryNum = categoryNum;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getTheaterNum() {
		return theaterNum;
	}
	public void setTheaterNum(int theaterNum) {
		this.theaterNum = theaterNum;
	}
	public String getTheater() {
		return theater;
	}
	public void setTheater(String theater) {
		this.theater = theater;
	}
	public int getHallNum() {
		return hallNum;
	}
	public void setHallNum(int hallNum) {
		this.hallNum = hallNum;
	}
	public String getHallName() {
		return hallName;
	}
	public void setHallName(String hallName) {
		this.hallName = hallName;
	}
	public int getRateNum() {
		return rateNum;
	}
	public void setRateNum(int rateNum) {
		this.rateNum = rateNum;
	}
	public String getRate() {
		return rate;
	}
	public void setRate(String rate) {
		this.rate = rate;
	}
	public String getCastNum() {
		return castNum;
	}
	public void setCastNum(String castNum) {
		this.castNum = castNum;
	}
	public String getCastName() {
		return castName;
	}
	public void setCastName(String castName) {
		this.castName = castName;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	public String getPostNum() {
		return postNum;
	}
	public void setPostNum(String postNum) {
		this.postNum = postNum;
	}
	public String getSaveFilename() {
		return saveFilename;
	}
	public void setSaveFilename(String saveFilename) {
		this.saveFilename = saveFilename;
	}
	public List<MultipartFile> getSelectFile() {
		return selectFile;
	}
	public void setSelectFile(List<MultipartFile> selectFile) {
		this.selectFile = selectFile;
	}
}
