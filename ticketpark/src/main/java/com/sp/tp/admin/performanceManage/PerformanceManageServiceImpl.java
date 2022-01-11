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
	public List<PerformanceManage> listSchedule(int perfNum) {
		List<PerformanceManage> listSchedule = null;
		
		try {
			listSchedule = dao.selectList("performanceManage.listSchedule", perfNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return listSchedule;
	}
	
	@Override
	public List<PerformanceManage> listTime(Map<String, Object> map) {
		List<PerformanceManage> listTime = null;
		
		try {
			listTime = dao.selectList("performanceManage.listTime", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listTime;
	}
	
	@Override
	public List<PerformanceManage> listCast(Map<String, Object> map) {
		List<PerformanceManage> listCast = null;
		try {
			listCast = dao.selectList("performanceManage.listCast", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listCast;
	}
	
	@Override
	public List<PerformanceManage> listRole(int perfNum) {
		List<PerformanceManage> listRole = null;
		
		try {
			listRole = dao.selectList("performanceManage.listRole", perfNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listRole;
	}
	
	@Override
	public List<PerformanceManage> listActor(int perfNum) {
		List<PerformanceManage> listActor = null;
		
		try {
			listActor = dao.selectList("performanceManage.listActor", perfNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return listActor;
	}
	
	@Override
	public List<PerformanceManage> listDate(int perfNum) {
		List<PerformanceManage> listDate = null;
		
		try {
			listDate = dao.selectList("performanceManage.listDate", perfNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listDate;
	}
	
	@Override
	public List<PerformanceManage> listCast(int ptNum) {
		List<PerformanceManage> listCast = null;
		
		try {
			listCast = dao.selectList("performanceManage.listCast", ptNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listCast;
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
	
	@Override
	public void insertPerfDate(PerformanceManage dto) throws Exception {
		
		try {
			for(int i=0; i < dto.getPerfsDate().size(); i++) {
				dto.setPerfDate(dto.getPerfsDate().get(i));
				dao.insertData("performanceManage.insertperfDate", dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void insertPerfTime(PerformanceManage dto) throws Exception {
		int seq = dao.selectOne("performanceManage.ptSeq");
		dto.setPtNum(seq);
		try {
			for(int i = 0; i < dto.getPerfsTime().size(); i++) {
				dto.setPerfTime(dto.getPerfsTime().get(i));
				dao.insertData("performanceManage.insertperfTime", dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		for(int i = 0; i < dto.getActorsNum().size(); i++) {
			dto.setActorNum(dto.getActorsNum().get(i));
			
			insertCast(dto);
		}
	}
	
	@Override
	public void insertCast(PerformanceManage dto) throws Exception {
		try {
			dao.insertData("performanceManage.insertCast", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void deleteActor(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("performanceManage.deleteActor", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void deleteTime(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("performanceManage.deleteTime", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void deleteDate(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("performanceManage.deleteDate", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void deletePerformance(int perfNum) throws Exception {
		try {
			dao.updateData("performanceManage.deletePerformance", perfNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void updatePerformance(PerformanceManage dto, String path) throws Exception {
		try {
			dao.updateData("performanceManage.updatePerformance", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		// 출연진 insert
		for(int i = 0; i < dto.getActorsName().size(); i++) {
			dto.setActorName(dto.getActorsName().get(i));
			dto.setRoleName(dto.getRolesName().get(i));
			dto.setActorNum(dao.selectOne("performanceManage.actorSeq"));
			
			MultipartFile mf = dto.getActorsFile().get(i);
			String actorFileName = fileManager.doFileUpload(mf, path);
			if(actorFileName == null) {
				continue;
			}
			dto.setActorFileName(actorFileName);
			
			insertActor(dto);
		}
	}
	
	@Override
	public void updatePoster(PerformanceManage dto, String path) throws Exception {
		try {
			String saveFilename = fileManager.doFileUpload(dto.getPostFile(), path);
			
			if (saveFilename != null) {
				// 이전 파일 지우기
				if (dto.getPostFileName().length() != 0) {
					fileManager.doFileDelete(dto.getPostFileName(), path);
				}
				dto.setPostFileName(saveFilename);
			}
			
			dao.updateData("performanceManage.updatePoster", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void updateSchedule(PerformanceManage dto) throws Exception {
		try {
			dao.updateData("performanceManage.updateSchedule", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void updateTime(PerformanceManage dto) throws Exception {
		try {
			dao.updateData("performanceManage.updateTime", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void updateCast(PerformanceManage dto) throws Exception {
		try {
			for(int i=0; i < dto.getActorsNum().size(); i++) {
				dto.setActorNum(dto.getActorsNum().get(i));
				dao.updateData("performanceManage.updateCast", dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
}
