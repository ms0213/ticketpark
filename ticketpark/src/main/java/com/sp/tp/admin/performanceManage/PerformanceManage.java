package com.sp.tp.admin.performanceManage;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class PerformanceManage {
	private int listNum;
	private int perfNum;
	private String subject;
	private String content;
	private String startDate;
	private String endDate;
	private Double rating;
	private int price;
	private int showTime;
	
	private int sdNum;
	private String perfDate;
	private String perfDateDay;
	private String perfTime;
	private List<String> perfsDate;
	private List<String> perfsTime;
	
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
	
	private int actorNum;
	private int castNum;
	private String actorName;
	private String roleName;
	private String actorFileName;
	private MultipartFile actorFile;
	private List<String> actorsName;
	private List<String> rolesName;
	private List<Integer> actorsNum;
	private List<MultipartFile> actorsFile;
	
	private int postNum;
	private String postFileName;
	private MultipartFile postFile;
	
	private String selectDate;
	private String selectTime;
	private int ptNum;
	
	
	public String getSelectTime() {
		return selectTime;
	}
	public void setSelectTime(String selectTime) {
		this.selectTime = selectTime;
	}
	public String getSelectDate() {
		return selectDate;
	}
	public void setSelectDate(String selectDate) {
		this.selectDate = selectDate;
	}
	public String getPerfDateDay() {
		return perfDateDay;
	}
	public void setPerfDateDay(String perfDateDay) {
		this.perfDateDay = perfDateDay;
	}
	public List<Integer> getActorsNum() {
		return actorsNum;
	}
	public void setActorsNum(List<Integer> actorsNum) {
		this.actorsNum = actorsNum;
	}
	public int getPtNum() {
		return ptNum;
	}
	public void setPtNum(int ptNum) {
		this.ptNum = ptNum;
	}
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
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
	public int getShowTime() {
		return showTime;
	}
	public void setShowTime(int showTime) {
		this.showTime = showTime;
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
	public int getPostNum() {
		return postNum;
	}
	public void setPostNum(int postNum) {
		this.postNum = postNum;
	}
	public String getPostFileName() {
		return postFileName;
	}
	public void setPostFileName(String postFileName) {
		this.postFileName = postFileName;
	}
	public int getSdNum() {
		return sdNum;
	}
	public void setSdNum(int seq) {
		this.sdNum = seq;
	}
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
	public List<String> getPerfsDate() {
		return perfsDate;
	}
	public void setPerfsDate(List<String> perfsDate) {
		this.perfsDate = perfsDate;
	}
	public List<String> getPerfsTime() {
		return perfsTime;
	}
	public void setPerfsTime(List<String> perfsTime) {
		this.perfsTime = perfsTime;
	}
	public int getCastNum() {
		return castNum;
	}
	public void setCastNum(int castNum) {
		this.castNum = castNum;
	}
	public int getActorNum() {
		return actorNum;
	}
	public void setActorNum(int actorNum) {
		this.actorNum = actorNum;
	}
	public String getActorName() {
		return actorName;
	}
	public void setActorName(String actorName) {
		this.actorName = actorName;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	public String getActorFileName() {
		return actorFileName;
	}
	public void setActorFileName(String actorFileName) {
		this.actorFileName = actorFileName;
	}
	public MultipartFile getActorFile() {
		return actorFile;
	}
	public void setActorFile(MultipartFile actorFile) {
		this.actorFile = actorFile;
	}
	public List<String> getActorsName() {
		return actorsName;
	}
	public void setActorsName(List<String> actorsName) {
		this.actorsName = actorsName;
	}
	public List<String> getRolesName() {
		return rolesName;
	}
	public void setRolesName(List<String> rolesName) {
		this.rolesName = rolesName;
	}
	public List<MultipartFile> getActorsFile() {
		return actorsFile;
	}
	public void setActorsFile(List<MultipartFile> actorsFile) {
		this.actorsFile = actorsFile;
	}
	public MultipartFile getPostFile() {
		return postFile;
	}
	public void setPostFile(MultipartFile postFile) {
		this.postFile = postFile;
	}
}
