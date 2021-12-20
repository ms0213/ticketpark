package com.sp.tp.admin.theaterManage;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.tp.common.dao.CommonDAO;

@Service("admin.theaterManage.theaterService")
public class TheaterManageServiceImpl implements TheaterService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertTheater(Theater dto) throws Exception {
		try {
			dto.setsCount(dto.getGeneralSeat() + dto.getVipSeat());
			dao.insertData("theaterManage.insertTheater", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}		
	}

	@Override
	public List<Theater> listTheater(Map<String, Object> map) {
		List<Theater> list = null;
		try {
			list = dao.selectList("theaterManage.listTheater", map);
		} catch (Exception e) {
		}
		return list;
	}

	@Override
	public Theater readTheater(int tNum) {
		Theater dto = null;
		try {
			dao.selectOne("theaterManage.readTheater", tNum);
		} catch (Exception e) {
		}
		return dto;
	}

	@Override
	public int dataCount() {
		int result = 0;
		try {
			result = dao.selectOne("theaterManage.dataCount");
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public void updateTheater(Theater dto) throws Exception {
		try {
			dao.updateData("theaterManage.updateTheater", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteTheater(int tNum) throws Exception {
		try {
			dao.deleteData("theaterManage.deleteTheater", tNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void insertTheaterFile(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("theaterManage.insertTheaterFile", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Theater> listHallNo() {
		List<Theater> listHallNo = null;
		
		try {
			listHallNo = dao.selectList("theaterManage.listHallNo");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return listHallNo;
	}

	@Override
	public List<Theater> readHallFile(Map<String, Object> map) {
		List<Theater> list = null;
		try {
			list = dao.selectList("theaterManage.readHallFile", map);
		} catch (Exception e) {
		}
		return list;
	}

}
