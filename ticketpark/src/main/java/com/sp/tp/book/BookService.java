package com.sp.tp.book;

import java.util.List;
import java.util.Map;

import com.sp.tp.member.Member;

public interface BookService {
	public Book listTheater2(int tNum);
	public void insertBook(Book dto) throws Exception;
	public Member readMember(String userId);
	public Book readBook(String userId);
	public void deleteBook(int bNum) throws Exception;
	public void deleteBook2(int bNum) throws Exception;
	public Book readPay(int bNum) throws Exception;
	public List<Book> readComplete(Map<String, Object> map);
	public void updateBook(Map<String, Object> map);
	
	public List<Book> readCoupon(String userId);
	
}
