package com.sp.tp.admin.performanceManage;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.tp.common.FileManager;
import com.sp.tp.common.dao.CommonDAO;

@Service("performanceManage.performanceManageServiceImpl")
public class PerformanceManageServiceImpl implements PerformanceManageSerive {
	
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;

		try {
			result = dao.selectOne("performanceManage.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<PerformanceManage> listPerformance(Map<String, Object> map) {
		List<PerformanceManage> list = null;
		
		try {
			list = dao.selectList("performanceManage.listPerformance", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public void insertPerformance(PerformanceManage dto, String pathname) throws Exception {
		int seq = dao.selectOne("performanceManage.seq");
		dto.setPerfNum(seq);
		
		dao.insertData("performanceManage.insertPerformance", dto);
		
		// 포스트 업로드
		String postFileName = fileManager.doFileUpload(dto.getPostFile(), pathname);
		
		// 포스트 insert
		if (postFileName != null) {
			dto.setPostFileName(postFileName);
			dao.insertData("performanceManage.insertPoster", dto);
		}
		
		// 출연진 insert
		for(int i = 0; i < dto.getActorsName().size(); i++) {
			dto.setActorName(dto.getActorsName().get(i));
			dto.setRoleName(dto.getRolesName().get(i));
			dto.setPerfNum(seq);
			dto.setActorNum(dao.selectOne("performanceManage.actorSeq"));
			
			MultipartFile mf = dto.getActorsFile().get(i);
			String actorFileName = fileManager.doFileUpload(mf, pathname);
			if(actorFileName == null) {
				continue;
			}
			dto.setActorFileName(actorFileName);
			
			insertActor(dto);
		}
	}
	
	@Override
	public void insertPoster(PerformanceManage dto) throws Exception {
		try {
			dao.insertData("perfomanceManage.insertPoster", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<PerformanceManage> listRate() {
		List<PerformanceManage> listRate = null;
		
		try {
			listRate = dao.selectList("performanceManage.listRate");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return listRate;
	}

	@Override
	public List<PerformanceManage> listCategory() {
		List<PerformanceManage> listCategory = null;
		
		try {
			listCategory = dao.selectList("performanceManage.listCategory");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listCategory;
	}

	@Override
	public List<PerformanceManage> listGenre(Map<String, Object> map) {
		List<PerformanceManage> listGenre = null;
		
		try {
			listGenre = dao.selectList("performanceManage.listGenre", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listGenre;
	}

	@Override
	public List<PerformanceManage> listHall() {
		List<PerformanceManage> listHall = null;
		
		try {
			listHall = dao.selectList("performanceManage.listHall");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listHall;
	}

	@Override
	public List<PerformanceManage> listTheater(Map<String, Object> map) {
		List<PerformanceManage> listTheater = null;
		
		try {
			listTheater = dao.selectList("performanceManage.listTheater", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listTheater;
	}

	@Override
	public PerformanceManage readPerformance(int perfNum) {
		PerformanceManage dto = null;
		
		try {
			dto = dao.selectOne("performanceManage.readPerformance", perfNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@Override
	public void insertActor(PerformanceManage dto) throws Exception {
		try {
			dao.insertData("performanceManage.insertActor", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
