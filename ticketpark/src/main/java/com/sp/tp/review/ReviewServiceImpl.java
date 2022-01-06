package com.sp.tp.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.tp.common.dao.CommonDAO;

@Service("review.reviewService")
public class ReviewServiceImpl implements ReviewService {
	@Autowired
	private CommonDAO dao;

	@Override
	public void insertReview(Review dto) throws Exception {
		try {
			dao.insertData("review.insertReview", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Review> listReview(Map<String, Object> map) {
		List<Review> list = null;
		try {
			list = dao.selectList("review.listReview", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(int perfNum) {
		int result = 0;
		try {
			result = dao.selectOne("review.dataCount", perfNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void updateReview(Review dto) throws Exception {
		try {
			dao.updateData("review.updateReview", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteReview(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("review.deleteReview", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public int sumRate(int perfNum) {
		int result = 0;
		try {
			result = dao.selectOne("review.sumRate", perfNum);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public void updateRate(int sum, int count, int perfNum) throws Exception {
		double rating = 0;
		try {
			rating = (double)sum/count;
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("rate", rating);
			map.put("perfNum", perfNum);
			dao.updateData("review.updateRate", map);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Review> bestReview() {
		List<Review> list = null;
		try {
			list = dao.selectList("review.bestReview");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
}
