package com.sp.tp.article;

import java.util.List;
import java.util.Map;



public interface ArticleService {
	public void insertArticle(Article dto, String pathname) throws Exception;
	public List<Article> listArticle(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public Article readArticle(int num);
	public void updateHitCount(int num) throws Exception;
	public Article preReadArticle(Map<String, Object> map);
	public Article nextReadArticle(Map<String, Object> map);
	public void updateArticle(Article dto, String pathname) throws Exception;
	public void deleteArticle(int num, String pathname, String userId, int membership) throws Exception;
	
	public void insertReply(ArticleReply dto) throws Exception;
	public List<ArticleReply> listReply(Map<String, Object> map);
	public int replyCount(Map<String, Object> map);
	public void deleteReply(Map<String, Object> map) throws Exception;
	
	public List<ArticleReply> listReplyAnswer(int answer);
	public int replyAnswerCount(int answer);
	
	public void insertFile(Article dto) throws Exception;
	public List<Article> listFile(int num);
	public Article readFile(int fileNum);
	public void deleteFile(Map<String, Object> map) throws Exception;	
	
}
