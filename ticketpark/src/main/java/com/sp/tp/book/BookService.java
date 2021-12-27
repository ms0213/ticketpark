package com.sp.tp.book;

import com.sp.tp.member.Member;

public interface BookService {
	public Book listTheater2(int tNum);
	public void insertBook(Book dto) throws Exception;
	public Member readMember(String userId);
	public Book readBook(String userId);
	public void deleteBook(int bNum) throws Exception;
	public void deleteBook2(int bNum) throws Exception;
	public Book readPay(int bNum) throws Exception;
}
