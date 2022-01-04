package com.sp.tp.article;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Article {
	private int listNum;
	
	private int artiNum;
	private String admin;
	private String subject;
	private String content;
	private int hitCount;
	private String reg_date;
	private String userName;
	private int atNum;	// 컬럼 유형 번호
	private String atName;	// 컬럼 유형 이름
	
	private int fileNum;
	private int fileCount;
	private String saveFilename;
	private List<MultipartFile> selectFile;
	
	private int replyCount;
	private int articleLikeCount; 
	
	
	public int getFileCount() {
		return fileCount;
	}

	public void setFileCount(int fileCount) {
		this.fileCount = fileCount;
	}

	public int getArticleLikeCount() {
		return articleLikeCount;
	}

	public void setArticleLikeCount(int articleLikeCount) {
		this.articleLikeCount = articleLikeCount;
	}

	public int getListNum() {
		return listNum;
	}

	public void setListNum(int listNum) {
		this.listNum = listNum;
	}

	public int getArtiNum() {
		return artiNum;
	}

	public void setArtiNum(int artiNum) {
		this.artiNum = artiNum;
	}

	public String getAdmin() {
		return admin;
	}

	public void setAdmin(String admin) {
		this.admin = admin;
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

	public int getHitCount() {
		return hitCount;
	}

	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}

	public String getReg_date() {
		return reg_date;
	}

	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

	public int getAtNum() {
		return atNum;
	}

	public void setAtNum(int atNum) {
		this.atNum = atNum;
	}

	public String getAtName() {
		return atName;
	}

	public void setAtName(String atName) {
		this.atName = atName;
	}

	public int getFileNum() {
		return fileNum;
	}

	public void setFileNum(int fileNum) {
		this.fileNum = fileNum;
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

	public int getReplyCount() {
		return replyCount;
	}

	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	
}
