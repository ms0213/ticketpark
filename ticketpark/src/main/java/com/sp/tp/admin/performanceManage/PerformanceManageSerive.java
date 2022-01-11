package com.sp.tp.admin.performanceManage;

import java.util.List;
import java.util.Map;


public interface PerformanceManageSerive {
	public void insertPerformance(PerformanceManage dto, String path) throws Exception;
	public int dataCount(Map<String, Object> map);
	public List<PerformanceManage> listPerformance(Map<String, Object> map);
	public PerformanceManage readPerformance(int perfNum);
	
	public List<PerformanceManage> listSchedule(int perfNum);
	public List<PerformanceManage> listTheater(Map<String, Object> map);
	public List<PerformanceManage> listActor(int perfNum);
	public List<PerformanceManage> listDate(int perfNum);
	public List<PerformanceManage> listCast(int ptNum);
	public List<PerformanceManage> listRole(int perfNum);
	public List<PerformanceManage> listTime(Map<String, Object> map);
	public List<PerformanceManage> listGenre(Map<String, Object> map);
	public List<PerformanceManage> listCast(Map<String, Object> map);
	public List<PerformanceManage> listRate();
	public List<PerformanceManage> listCategory();
	public List<PerformanceManage> listHall();
	
	public void insertPoster(PerformanceManage dto) throws Exception;
	public void insertActor(PerformanceManage dto) throws Exception;
	public void insertPerfDate(PerformanceManage dto) throws Exception;
	public void insertPerfTime(PerformanceManage dto) throws Exception;
	public void insertCast(PerformanceManage dto) throws Exception;
	
	public void updatePerformance(PerformanceManage dto, String path) throws Exception;
	public void updatePoster(PerformanceManage dto, String path) throws Exception;
	public void updateSchedule(PerformanceManage dto) throws Exception;
	public void updateTime(PerformanceManage dto) throws Exception;
	public void updateCast(PerformanceManage dto) throws Exception;
	
	public void deleteActor(Map<String, Object> map) throws Exception;
	public void deleteTime(Map<String, Object> map) throws Exception;
	public void deleteDate(Map<String, Object> map) throws Exception;
	public void deletePerformance(int perfNum) throws Exception;
	
}
