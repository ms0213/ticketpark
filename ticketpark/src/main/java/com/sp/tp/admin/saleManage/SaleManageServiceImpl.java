package com.sp.tp.admin.saleManage;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.tp.common.dao.CommonDAO;

@Service("admin.saleManage.saleManageService")
public class SaleManageServiceImpl implements SaleManageService {

	@Autowired
	private CommonDAO dao;
	
	@Override
	public int perfMonthCount() {
		int result = 0;
		try {
			result = dao.selectOne("saleManage.perfMonthCount");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Sale> monthSale(int perfMonthCount) {
		List<Sale> monthSale = null;
		
		try {
			monthSale = dao.selectList("saleManage.monthSale", perfMonthCount);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return monthSale;
	}

	@Override
	public List<Sale> performSale(int perfMonthCount) {
		List<Sale> performSale = null;
		
		try {
			performSale = dao.selectList("saleManage.performSale", perfMonthCount);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return performSale;
	}

	@Override
	public int categoryDataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("saleManage.categoryDataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Sale> categorySale(Map<String, Object> map) {
		List<Sale> categorySale = null;
		
		try {
			categorySale = dao.selectList("saleManage.categorySale", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return categorySale;
	}

	@Override
	public int categoryAllCount() {
		int result = 0;
		try {
			result = dao.selectOne("saleManage.categoryAllCount");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Sale> categoryAll(int categoryAllCount) {
		List<Sale> categoryAll = null;
		
		try {
			categoryAll = dao.selectList("saleManage.categoryAll", categoryAllCount);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return categoryAll;
	}
	
}
