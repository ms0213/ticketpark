package com.sp.tp.admin.performanceManage;

import java.util.List;
import java.util.Map;

public interface PerformanceManageSerive {
	public void insertPerformance(PerformanceManage dto, String pathname) throws Exception;
	public int dataCount(Map<String, Object> map);
	public List<PerformanceManage> listPerformance(Map<String, Object> map);
	public PerformanceManage readPerformance(int perfNum);
	
	public List<PerformanceManage> listRate();
	public List<PerformanceManage> listCategory();
	public List<PerformanceManage> listGenre(Map<String, Object> map);
	public List<PerformanceManage> listHall();
	public List<PerformanceManage> listTheater(Map<String, Object> map);
	public void insertPoster(PerformanceManage dto) throws Exception;
}
