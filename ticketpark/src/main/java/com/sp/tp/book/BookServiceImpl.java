package com.sp.tp.book;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.tp.common.dao.CommonDAO;
import com.sp.tp.member.Member;

@Service("book.bookService")
public class BookServiceImpl implements BookService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public Book listTheater2(int tNum) {
		Book dto = null;
		try {
			dto = dao.selectOne("theaterManage.listTheater2", tNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void insertBook(Book dto) throws Exception {
		try {
			int seq = dao.selectOne("book.seq");
			dto.setbNum(seq);
			dao.insertData("book.insertBook", dto);
			List<String> items = Arrays.asList(dto.getSeats().split("\\s*,\\s*"));
			// 좌석 저장
			for(String seat : items) {
				dto.setSeat_num(seat);
				dao.insertData("book.insertBook2", dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Member readMember(String userId) {
		Member dto = null;
		
		try {
			dto = dao.selectOne("member.readMember", userId);
			
			if (dto != null) {
				if (dto.getEmail() != null) {
					String[] s = dto.getEmail().split("@");
					dto.setEmail1(s[0]);
					dto.setEmail2(s[1]);
				}

				if (dto.getTel() != null) {
					String[] s = dto.getTel().split("-");
					dto.setTel1(s[0]);
					dto.setTel2(s[1]);
					dto.setTel3(s[2]);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Book readBook(String userId) {
		Book dto = null;
		try {
			dto = dao.selectOne("book.readBook", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void deleteBook(int bNum) throws Exception {
		try {
			dao.deleteData("book.deleteBook", bNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteBook2(int bNum) throws Exception {
		try {
			dao.deleteData("book.deleteBook2", bNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public Book readPay(int bNum) throws Exception {
		Book dto = null;
		try {
			dto = dao.selectOne("book.readPay", bNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}



}
