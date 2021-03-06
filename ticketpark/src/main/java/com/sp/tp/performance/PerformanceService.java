package com.sp.tp.performance;

import java.util.List;
import java.util.Map;

public interface PerformanceService {
	public void insertPerformance(Performance dto, String pathname) throws Exception;
	public int dataCount(Map<String, Object> map);
	public List<Performance> listPerformance(Map<String, Object> map);
	public Performance readPerformance(int perfNum);
	public void updatePerformance(Performance dto, String pathname) throws Exception;
	public void deletePerformance(int perfNum, String pathname) throws Exception;
	public List<Performance> listRate();
	public List<Performance> listCategory();
	public List<Performance> listGenre(Map<String, Object> map);
	public List<Performance> listGenreMain(Map<String, Object> map);
	public List<Performance> listHall();
	public List<Performance> listTheater(Map<String, Object> map);
	public List<Performance> listFile(int perfNum);
	
	public void insertPoster(Performance dto) throws Exception;
	public void insertCast(Performance dto) throws Exception;
	public void insertSchedule(Performance dto) throws Exception;
	public List<Performance> listPoster(int perfNum);
	public Performance readPoster(int postNum);
	public void deletePoster(int postNum, String pathname) throws Exception;
	public void deleteCast(Map<String, Object> map) throws Exception;
	
	public List<PerformanceBook> listSchedule(int perfNum);
	public List<PerformanceBook> listTime(Map<String, Object> map);
	
}

