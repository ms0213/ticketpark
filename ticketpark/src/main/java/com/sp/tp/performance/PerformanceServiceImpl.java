package com.sp.tp.performance;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.tp.common.FileManager;
import com.sp.tp.common.dao.CommonDAO;

@Service("performance.performanceServiceImpl")
public class PerformanceServiceImpl implements PerformanceService {
	
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;


	@Override
	public void insertPerformance(Performance dto, String pathname) throws Exception {
		try {
			int seq = dao.selectOne("performance.seq");
			dto.setPerfNum(seq);
			
			dao.insertData("performance.insertPerformance", dto);
			
			if(!dto.getSelectFile().isEmpty()) {
				for(MultipartFile mf : dto.getSelectFile()) {
					String saveFilename = fileManager.doFileUpload(mf, pathname);
					if(saveFilename == null) {
						continue;
					}
					dto.setSaveFilename(saveFilename);
					
					insertPoster(dto);
					
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
			result = dao.selectOne("performance.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public List<Performance> listPerformance(Map<String, Object> map) {
		List<Performance> list = null;
		
		try {
			list = dao.selectList("performance.listPerformance", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public Performance readPerformance(int perfNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updatePerformance(Performance dto, String pathname) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deletePerformance(int perfNum, String pathname) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertPoster(Performance dto) throws Exception {
		try {
			dao.insertData("perfomance.insertPoster", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Performance> listPoster(int perfNum) {
		List<Performance> listPoster = null;
		
		try {
			listPoster = dao.selectList("performance.listPoster", perfNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listPoster;
	}

	@Override
	public Performance readPoster(int postNum) {
		Performance dto = null;
		
		try {
			dto = dao.selectOne("performance.readFile", postNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void deleteFile(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

}
