package com.sp.tp.contactUs;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.tp.common.dao.CommonDAO;

@Service("contactUs.contactUsService")
public class ContactUsServiceImpl implements ContactUsService {
	@Autowired
	private CommonDAO dao;

	@Override
	public void insertContact(ContactUs dto) throws Exception {
		try {
			dto.setChecked("n");
			dao.insertData("contactUs.insertContact", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteContact(int cNum) throws Exception {
		try {
			dao.deleteData("contactUs.deleteContact", cNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<ContactUs> listContact(Map<String, Object> map) {
		List<ContactUs> list = null;
		try {
			list = dao.selectList("contactUs.listContact", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public ContactUs readContact(int cNum) {
		ContactUs dto = null;
		try {
			dto = dao.selectOne("contactUs.readContact", cNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("contactUs.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void updateChecked(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("contactUs.updateChecked", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
}
