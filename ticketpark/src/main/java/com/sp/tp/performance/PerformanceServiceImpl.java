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
			int seq = dao.selectOne("performance.performanceSeq");
			dto.setPerfNum(seq);
			
			dao.insertData("performance.insertPerformance", dto);
			
			// 포스트 업로드
			String postFileName = fileManager.doFileUpload(dto.getPostFile(), pathname);
			
			if (postFileName != null) {
				dto.setPostFileName(postFileName);
				dao.insertData("performance.insertPost", dto);
			}
			
			if(!dto.getCastsFileName().isEmpty()) {
				for(MultipartFile mf : dto.getCastsFileName()) {
					String castFileName = fileManager.doFileUpload(mf, pathname);
					if(castFileName == null) {
						continue;
					}
					
					dto.setCastFileName(castFileName);
					
					insertCast(dto);
				}
			}
			
			System.out.println(dto.getPerfsDate());
			for(int i=0; i < dto.getPerfsDate().size(); i++) {
				List<String> perfDate = dto.getPerfsDate();
				
				insertSchedule(dto);
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
	public List<Performance> listCategory() {
		List<Performance> listCategory = null;
		
		try {
			listCategory = dao.selectList("performance.listCategory");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listCategory;
	}
	
	@Override
	public List<Performance> listGenre(Map<String, Object> map) {
		List<Performance> listGenre = null;
		
		try {
			listGenre = dao.selectList("performance.listGenre", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listGenre;
	}

	@Override
	public void insertCast(Performance dto) throws Exception {
		try {
			dao.insertData("performance.inserCast", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deletePoster(int postNum, String pathname) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteCast(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("performance.deleteCast", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void insertSchedule(Performance dto) throws Exception {
		try {
			int seq = dao.insertData("performance.scheduleSeq");
			dto.setSdNum(seq);
			
			dao.insertData("performance.insertSchedule", dto);
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
}
