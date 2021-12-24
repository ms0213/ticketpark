package com.sp.tp.test;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.tp.common.dao.CommonDAO;

@Service("test.testServiceImpl")
public class TestServiceImpl implements TestService {
	
	@Autowired
	private CommonDAO dao;

	@Override
	public void insertPerformance(Test dto, String pathname) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;

		try {
			result = dao.selectOne("test.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Test> listPerformance(Map<String, Object> map) {
		List<Test> list = null;
		
		try {
			list = dao.selectList("test.listPerformance", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public Test readPerformance(int perfNum) {
		Test dto = null;
		
		try {
			dto = dao.selectOne("test.readPerformance", perfNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updatePerformance(Test dto, String pathname) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deletePerformance(int perfNum, String pathname) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Test> listRate() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Test> listCategory() {
		List<Test> listCategory = null;
		
		try {
			listCategory = dao.selectList("test.listCategory");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listCategory;
	}

	@Override
	public List<Test> listGenre(Map<String, Object> map) {
		List<Test> listGenre = null;
		
		try {
			listGenre = dao.selectList("test.listGenre", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listGenre;
	}

	@Override
	public List<Test> listHall() {
		List<Test> listHall = null;
		
		try {
			listHall = dao.selectList("test.listHall");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listHall;
	}

	@Override
	public List<Test> listTheater(Map<String, Object> map) {
		List<Test> listTheater = null;
		
		try {
			listTheater = dao.selectList("test.listTheater", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listTheater;
	}

	@Override
	public List<Test> listFile(int perfNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertPoster(Test dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertCast(Test dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertSchedule(Test dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Test> listPoster(int perfNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Test readPoster(int postNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deletePoster(int postNum, String pathname) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteCast(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}
	
	

}
