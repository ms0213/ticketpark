package com.sp.tp.video;

public class Video {
	private int vNum;
	private String link;
	private String subject;
	private String content;
	
	public int getvNum() {
		return vNum;
	}
	public void setvNum(int vNum) {
		this.vNum = vNum;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
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
}
