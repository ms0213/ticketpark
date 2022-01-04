package com.sp.tp.review;

import java.util.List;
import java.util.Map;

public interface ReviewService {
	public void insertReview(Review dto) throws Exception;
	public List<Review> listReview(Map<String, Object> map);
	public int dataCount(int perfNum);
	public void updateReview(Review dto) throws Exception;
	public void deleteReview(Map<String, Object> map) throws Exception;
	
	public int sumRate(int perfNum);
	public void updateRate(int sum, int count, int perfNum) throws Exception;
}
