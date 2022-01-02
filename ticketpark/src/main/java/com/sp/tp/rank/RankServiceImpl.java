package com.sp.tp.rank;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.tp.common.dao.CommonDAO;

@Service("rank.rankServiceImpl")
public class RankServiceImpl implements RankService{
	
	@Autowired
	private CommonDAO dao;
	
	@Override
	public List<Rank> bookRank() {
		List<Rank> bookRank = null;
		
		try {
			bookRank = dao.selectList("rank.bookRank");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bookRank;
	}

	@Override
	public List<Rank> ratingRank() {
		List<Rank> ratingRank = null;
		
		try {
			ratingRank = dao.selectList("rank.ratingRank");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ratingRank;
	}

}
