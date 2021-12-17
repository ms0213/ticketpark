package com.sp.tp.video;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.tp.common.dao.CommonDAO;

@Service("video.videoServiceImpl")
public class VideoServiceImpl implements VideoService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertVideo(Video dto) throws Exception {
		try {
			int seq = dao.selectOne("video.seq");
			dto.setvNum(seq);
			
			dao.insertData("video.insertVideo", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("video.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Video> listVideo(Map<String, Object> map) {
		List<Video> list = null;
		try {
			list = dao.selectList("video.listVideo", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void updateVideo(Video dto) throws Exception {
		try {
			dao.deleteData("video.updateVideo", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteVideo(int num) throws Exception {
		try {
			dao.deleteData("video.deleteVideo", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Video readVideo(int num) {
		Video dto = null;
		try {
			dto = dao.selectOne("video.readVideo", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

}
