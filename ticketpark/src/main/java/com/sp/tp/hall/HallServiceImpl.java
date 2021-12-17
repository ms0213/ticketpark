package com.sp.tp.hall;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.tp.common.FileManager;
import com.sp.tp.common.dao.CommonDAO;

@Service("hall.hallServiceImpl")
public class HallServiceImpl implements HallService {
	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertHall(Hall dto, String pathname) throws Exception {
		try {
			int seq = dao.selectOne("hall.seq");
			dto.sethNum(seq);
			
			dao.insertData("hall.insertHall", dto);
			
			if(! dto.getSelectFile().isEmpty()) {
				for(MultipartFile mf : dto.getSelectFile()) {
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
	public int dataCount() {
		int result = 0;
		
		try {
			result = dao.selectOne("hall.dataCount");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	@Override
	public List<Hall> listHall(Map<String, Object> map) {
		List<Hall> list = null; 
		try {
			list = dao.selectList("hall.listHall", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public Hall readHall(int hNum) {
		Hall dto = null;
		
		try {
			dto = dao.selectOne("hall.readHall", hNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	@Override
	public void updateHall(Hall dto, String pathname) throws Exception {
		try {
			dao.updateData("hall.updateHall", dto);
			
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
	public void deletHall(int hNum, String pathname) throws Exception {
		try {
			List<Hall> listFile = listFile(hNum);
			if(listFile != null) {
				for(Hall dto : listFile) {
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				}
			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("field", "hNum");
			map.put("hNum", hNum);
			deleteFile(map);
			dao.deleteData("hall.deleteHall", hNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	@Override
	public void insertFile(Hall dto) throws Exception {
		try {
			dao.insertData("hall.insertFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	@Override
	public List<Hall> listFile(int hNum) {
		List<Hall> listFile = null;
		try {
			listFile = dao.selectList("hall.listFile", hNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listFile;
	}
	@Override
	public Hall readFile(int fileNum) {
		Hall dto = null;
		try {
			dto = dao.selectOne("hall.readFile", fileNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	@Override
	public void deleteFile(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("hall.deleteFile", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	
}
