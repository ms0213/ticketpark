package com.sp.tp.expect;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.tp.common.dao.CommonDAO;

@Service("expect.expectService")
public class ExpectServiceImpl implements ExpectService {
	@Autowired
	private CommonDAO dao;

	@Override
	public void insertExpect(Expect dto) throws Exception {
		try {
			dao.insertData("expect.insertExpect", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Expect> listExpect(Map<String, Object> map) {
		List<Expect> list = null;

		try {
			list = dao.selectList("expect.listExpect", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public int dataCount() {
		int result = 0;

		try {
			result = dao.selectOne("expect.dataCount");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public void deleteExpect(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("expect.deleteExpect", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void updateExpect(Expect dto) throws Exception {
		try {
			dao.updateData("expect.updateExpect", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
