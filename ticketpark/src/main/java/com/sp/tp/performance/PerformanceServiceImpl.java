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
			int performanceSeq = dao.selectOne("performance.performanceSeq");
			dto.setPerfNum(performanceSeq);
			
			int scheduleSeq = dao.selectOne("performance.scheduleSeq");
			
			dao.insertData("performance.insertPerformance", dto);
			
			// 포스트 업로드
			String postFileName = fileManager.doFileUpload(dto.getPostFile(), pathname);
			
			// 포스트 insert
			if (postFileName != null) {
				dto.setPostFileName(postFileName);
				dao.insertData("performance.insertPoster", dto);
			}
			
			// 공연일정 insert
			for(int i = 0; i < dto.getPerfsDate().size(); i++) {
				
				dto.setPerfDate(dto.getPerfsDate().get(i));
				dto.setPerfTime(dto.getPerfsTime().get(i));
				
				insertSchedule(dto);
			}
			
			// 출연진 insert
			for(int i = 0; i < dto.getCastsName().size(); i++) {
				dto.setCastName(dto.getCastsName().get(i));
				dto.setRoleName(dto.getRolesName().get(i));
				dto.setSdNum(scheduleSeq);
				
				MultipartFile mf = dto.getCastsFile().get(i);
				String castFileName = fileManager.doFileUpload(mf, pathname);
				if(castFileName == null) {
					continue;
				}
				dto.setCastFileName(castFileName);
				
				insertCast(dto);
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
		Performance dto = null;
		
		try {
			dto = dao.selectOne("performance.readPerformance", perfNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
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
	public List<Performance> listRate() {
		List<Performance> listRate = null;
		
		try {
			listRate = dao.selectList("performance.listRate");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return listRate;
	}

	@Override
	public void insertCast(Performance dto) throws Exception {
		
		try {
			dao.insertData("performance.insertCast", dto);
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
			
			dao.insertData("performance.insertSchedule", dto);
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	@Override
	public List<Performance> listHall() {
		List<Performance> listHall = null;
		
		try {
			listHall = dao.selectList("performance.listHall");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listHall;
	}
	
	@Override
	public List<Performance> listTheater(Map<String, Object> map) {
		List<Performance> listTheater = null;
		
		try {
			listTheater = dao.selectList("performance.listTheater", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listTheater;
	}

	@Override
	public List<Performance> listFile(int perfNum) {
		List<Performance> listFile = null;
		
		try {
			listFile = dao.selectList("performance.listFile", perfNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listFile;
	}
}
