package com.sp.tp.member;

import java.util.List;
import java.util.Map;

public interface MemberService {
	public Member loginMember(String userId);
	
	public void insertMember(Member dto) throws Exception;
	
	public void updateMembership(Map<String, Object> map) throws Exception;
	public void updateMember(Member dto) throws Exception;
	
	public Member readMember(String userId);
	
	public void deleteMember(Map<String, Object> map) throws Exception;
	
	public void generatePwd(Member dto) throws Exception;
	
	public List<myCoupon> listMyCoupon(String userId);
	
	public List<myChoice> listMyChoice(String userId);
	public boolean userChoiced(Map<String, Object> map);
	public void insertChoice(Map<String, Object> map) throws Exception;
	public void deleteChoice(Map<String, Object> map) throws Exception;
	
	public List<MyBookList> listMyBook(String userId);
	public MyBookList openModal(Map<String, Object> map);
}
