package com.sp.tp.event;

import java.util.List;
import java.util.Map;

public interface EventService {
	public void insertEvent(Event dto, String pathname) throws Exception;
	public int dataCount(Map<String, Object> map);
	public List<Event> listEvent(Map<String, Object> map);
	public Event readEvent(int eventNum);
	public void updateEvent(Event dto, String pathname) throws Exception;
	public void deleteEvent(int eventNum, String pathname) throws Exception;
	
	public void insertFile(Event dto) throws Exception;
	public List<Event> listFile(int eventNum);
	public Event readFile(int fileNum);
	public void deleteFile(Map<String, Object> map) throws Exception;
	
	public List<Coupon> listCoupon();
	public Coupon readCoupon(String couponNum);
	public void insertMyCoupon(Map<String, Object> map) throws Exception;
	public int couponExist(Map<String, Object> map);
}
