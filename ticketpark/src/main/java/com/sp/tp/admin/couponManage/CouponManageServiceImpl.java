package com.sp.tp.admin.couponManage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.tp.common.dao.CommonDAO;

@Service("admin.couponManage.couponManageService")
public class CouponManageServiceImpl implements CouponManageService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertCoupon(Coupon dto) throws Exception {
		try {
			String seq = dao.selectOne("couponManage.seq");
			dto.setCouponNum(seq);
			
			dao.insertData("couponManage.insertCoupon", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Coupon> listCoupon() {
		List<Coupon> list = null;
		try {
			list = dao.selectList("couponManage.listCoupon");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Coupon readCoupon(String couponNum) {
		Coupon dto = null;
		try {
			dto = dao.selectOne("couponManage.readCoupon", couponNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateCoupon(Coupon dto) throws Exception {
		try {
			dao.updateData("couponManage.updateCoupon", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteCoupon(String couponNum) throws Exception {
		try {
			dao.deleteData("couponManage.deleteCoupon", couponNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
}
