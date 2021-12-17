package com.sp.tp.hall;

import java.util.List;
import java.util.Map;

public interface HallService {

	public void insertHall(Hall dto, String pathname) throws Exception;
	public int dataCount();
	public List<Hall> listHall(Map<String, Object> map);
	public Hall readHall(int hNum);
	public void updateHall(Hall dto, String pathname) throws Exception;
	public void deletHall(int hNum, String pathname) throws Exception;
	
	public void insertFile(Hall dto)throws Exception;
	public List<Hall> listFile(int hNum);
	public Hall readFile(int fileNum);
	public void deleteFile(Map<String, Object> map) throws Exception;
}
