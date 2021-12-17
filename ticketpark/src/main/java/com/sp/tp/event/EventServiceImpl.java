package com.sp.tp.event;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.tp.common.FileManager;
import com.sp.tp.common.dao.CommonDAO;


@Service("event.eventServiceImpl")
public class EventServiceImpl implements EventService{
	
	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;

	@Override
	public void insertEvent(Event dto, String pathname) throws Exception {
		try {
			int seq = dao.selectOne("event.seq");
			dto.setEventNum(seq);
			
			dao.insertData("event.insertEvent", dto);
						
			if (!dto.getSelectFile().isEmpty()) {
				for (MultipartFile mf : dto.getSelectFile()) {
					String saveFilename = fileManager.doFileUpload(mf, pathname);
					if (saveFilename == null) {
						continue;
					}

					dto.setSaveFilename(saveFilename);
					
					insertFile(dto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;

		try {
			result = dao.selectOne("event.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public List<Event> listEvent(Map<String, Object> map) {
		List<Event> list = null;
		
		try {
			list = dao.selectList("event.listEvent", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Event readEvent(int eventNum) {
		Event dto = null;
		
		try {
			dto = dao.selectOne("event.readEvent", eventNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updateEvent(Event dto, String pathname) throws Exception {
		try {
			dao.updateData("event.updateEvent", dto);

			if (!dto.getSelectFile().isEmpty()) {
				for (MultipartFile mf : dto.getSelectFile()) {
					String saveFilename = fileManager.doFileUpload(mf, pathname);
					if (saveFilename == null) {
						continue;
					}

					dto.setSaveFilename(saveFilename);

					insertFile(dto);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteEvent(int eventNum, String pathname) throws Exception {		
		try {
			// 파일 지우기
			List<Event> listFile = listFile(eventNum);
			if (listFile != null) {
				for (Event dto : listFile) {
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				}
			}

			// 파일 테이블 내용 지우기
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("field", "eventNum");
			map.put("eventNum", eventNum);
			deleteFile(map);

			dao.deleteData("event.deleteEvent", eventNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void insertFile(Event dto) throws Exception {
		try {
			dao.insertData("event.insertFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Event> listFile(int eventNum) {
		List<Event> listFile = null;
		
		try {
			listFile = dao.selectList("event.listFile", eventNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listFile;
	}

	@Override
	public Event readFile(int fileNum) {
		Event dto = null;

		try {
			dto = dao.selectOne("event.readFile", fileNum);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public void deleteFile(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("event.deleteFile", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Coupon> listCoupon() {
		List<Coupon> listCoupon = null;
		
		try {
			listCoupon = dao.selectList("coupon.listCoupon");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listCoupon;
	}

	@Override
	public void insertMyCoupon(Coupon dto) throws Exception {
		try {
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


}
