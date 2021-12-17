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
	
	public void insertPoster(Performance dto) throws Exception;
	public List<Performance> listPoster(int perfNum);
	public Performance readPoster(int postNum);
	public void deleteFile(Map<String, Object> map) throws Exception;
}
