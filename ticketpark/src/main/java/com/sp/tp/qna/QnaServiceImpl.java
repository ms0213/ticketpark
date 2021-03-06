package com.sp.tp.qna;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.tp.common.dao.CommonDAO;

@Service("qna.qnaService")
public class QnaServiceImpl implements QnaService {
	@Autowired
	private CommonDAO dao;

	@Override
	public void insertReply(Reply dto) throws Exception {
		try {
			dao.insertData("qna.insertReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list = null;

		try {
			list = dao.selectList("qna.listReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		int result = 0;

		try {
			result = dao.selectOne("qna.replyCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("qna.deleteReply", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Reply> listReplyAnswer(int answer) {
		List<Reply> list = null;

		try {
			list = dao.selectList("qna.listReplyAnswer", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public int replyAnswerCount(int answer) {
		int result = 0;

		try {
			result = dao.selectOne("qna.replyAnswerCount", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public int dataCount(int perfNum) {
		int result = 0;

		try {
			result = dao.selectOne("qna.dataCount", perfNum);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public void insertReplyLike(Map<String, Object> map) throws Exception {

		try {

			Map<String, Object> countMap = dao.selectOne("qna.checkReplyLike", map);

			
			if (((BigDecimal) countMap.get("COUNT")).intValue() > 0) {
				dao.deleteData("qna.deleteReplyLike", map);
			} else {
				dao.insertData("qna.insertReplyLike", map);
			}

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Map<String, Object> replyLikeCount(Map<String, Object> map) {
		Map<String, Object> countMap = null;

		try {
			countMap = dao.selectOne("qna.replyLikeCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return countMap;

	}

	@Override
	public void deleteBoardLike(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("qna.deleteBoardLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
