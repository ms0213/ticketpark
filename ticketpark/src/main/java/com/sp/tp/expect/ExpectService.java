package com.sp.tp.expect;

import java.util.List;
import java.util.Map;

public interface ExpectService {
	public void insertExpect(Expect dto) throws Exception;
	public List<Expect> listExpect(Map<String, Object> map);
	public int dataCount(int perfNum);
	public void deleteExpect(Map<String, Object> map) throws Exception;
	public void updateExpect(Expect dto) throws Exception;
}
