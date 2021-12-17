package com.sp.tp.admin.theaterManage;

import java.util.List;
import java.util.Map;

public interface TheaterService {
	public void insertTheater(Theater dto) throws Exception;
	public List<Theater> listTheater(Map<String, Object> map);
	public Theater readTheater(int tNum);
	public int dataCount();
	public void updateTheater(Theater dto) throws Exception;
	public void deleteTheater(int tNum) throws Exception;
	public void insertTheaterFile(Map<String, Object> map) throws Exception;
	public List<Theater> listHallNo();
}
