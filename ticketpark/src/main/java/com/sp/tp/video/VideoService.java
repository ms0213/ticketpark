package com.sp.tp.video;

import java.util.List;
import java.util.Map;

public interface VideoService {
	public void insertVideo(Video dto) throws Exception;
	public int dataCount(Map<String, Object> map);
	public List<Video> listVideo(Map<String, Object> map);
	public Video readVideo(int num);
	public void updateVideo(Video dto) throws Exception;
	public void deleteVideo(int num) throws Exception;
}
