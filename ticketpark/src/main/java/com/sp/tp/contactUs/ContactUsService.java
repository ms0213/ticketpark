package com.sp.tp.contactUs;

import java.util.List;
import java.util.Map;

public interface ContactUsService {
	public void insertContact(ContactUs dto) throws Exception;
	public void deleteContact(int cNum) throws Exception;
	public List<ContactUs> listContact(Map<String, Object> map);
	public ContactUs readContact(int cNum);
	public int dataCount(Map<String, Object> map);
	public void updateChecked(Map<String, Object> map) throws Exception;
}
