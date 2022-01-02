package com.sp.tp.admin.performanceManage;

import java.util.List;
import java.util.Map;


public interface PerformanceManageSerive {
	public void insertPerformance(PerformanceManage dto, String pathname) throws Exception;
	public int dataCount(Map<String, Object> map);
	public List<PerformanceManage> listPerformance(Map<String, Object> map);
	public PerformanceManage readPerformance(int perfNum);
	
	public List<PerformanceManage> listSchedule(int perfNum);
	public List<PerformanceManage> listTime(Map<String, Object> map);
	public List<PerformanceManage> listRate();
	public List<PerformanceManage> listCategory();
	public List<PerformanceManage> listGenre(Map<String, Object> map);
	public List<PerformanceManage> listHall();
	public List<PerformanceManage> listTheater(Map<String, Object> map);
	public List<PerformanceManage> listActor(int perfNum);
	public void insertPoster(PerformanceManage dto) throws Exception;
	public void insertActor(PerformanceManage dto) throws Exception;
	public void insertPerfDate(PerformanceManage dto) throws Exception;
	public void insertPerfTime(PerformanceManage dto) throws Exception;
	public void insertCast(PerformanceManage dto) throws Exception;
	public void updatePerformance(PerformanceManage dto) throws Exception;
	public void updateActor(PerformanceManage dto) throws Exception;
}
