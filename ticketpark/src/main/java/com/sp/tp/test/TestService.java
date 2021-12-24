package com.sp.tp.test;

import java.util.List;
import java.util.Map;


public interface TestService {

	public void insertPerformance(Test dto, String pathname) throws Exception;
	public int dataCount(Map<String, Object> map);
	public List<Test> listPerformance(Map<String, Object> map);
	public Test readPerformance(int perfNum);
	public void updatePerformance(Test dto, String pathname) throws Exception;
	public void deletePerformance(int perfNum, String pathname) throws Exception;
	public List<Test> listRate();
	public List<Test> listCategory();
	public List<Test> listGenre(Map<String, Object> map);
	public List<Test> listHall();
	public List<Test> listTheater(Map<String, Object> map);
	public List<Test> listFile(int perfNum);
	
	public void insertPoster(Test dto) throws Exception;
	public void insertCast(Test dto) throws Exception;
	public void insertSchedule(Test dto) throws Exception;
	public List<Test> listPoster(int perfNum);
	public Test readPoster(int postNum);
	public void deletePoster(int postNum, String pathname) throws Exception;
	public void deleteCast(Map<String, Object> map) throws Exception;
	
}
