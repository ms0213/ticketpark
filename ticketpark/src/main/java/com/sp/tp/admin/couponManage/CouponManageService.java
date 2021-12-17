package com.sp.tp.admin.couponManage;

import java.util.List;

public interface CouponManageService {
	public void insertCoupon(Coupon dto) throws Exception;
	public List<Coupon> listCoupon();
	public Coupon readCoupon(String couponNum);
	public void updateCoupon(Coupon dto) throws Exception;
	public void deleteCoupon(String couponNum) throws Exception;
}
