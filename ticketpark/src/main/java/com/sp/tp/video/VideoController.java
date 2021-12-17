package com.sp.tp.video;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.tp.common.MyUtil;
import com.sp.tp.member.SessionInfo;

@Controller("video.videoController")
@RequestMapping(value = "/video/*")
public class VideoController {
	@Autowired
	private VideoService service;
	@Autowired
	private MyUtil myUtil;

	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String videoList(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			HttpServletRequest req,
			Model model) throws Exception {
		
		String cp = req.getContextPath();
		
		int rows = 8;
		int total_page=0;
		int dataCount=0;
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		dataCount = service.dataCount(map);
		if(dataCount!= 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}

		if (total_page < current_page) {
			current_page = total_page;
		}

		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
		
		List<Video> list = service.listVideo(map);
		
		String listUrl = cp+"/video/list";
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);

		return ".video.list";
	}
	
	@RequestMapping(value = "write", method = RequestMethod.GET)
	public String writeForm(Model model, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(info.getMembership()<51) {
			return "redirect:/video/list";
		}
		
		model.addAttribute("mode", "write");
		
		return ".video.write";
	}
	
	@RequestMapping(value = "write", method = RequestMethod.POST)
	public String submitForm(Video dto, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(info.getMembership()<51) {
			return "redirect:/video/list";
		}
		
		try {
			service.insertVideo(dto);
		} catch (Exception e) {
		}
		
		return "redirect:/video/list";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String updateForm(@RequestParam int vNum,
			@RequestParam String page,
			HttpSession session,
			Model model
			) throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(info.getMembership()<51) {
			return "redirect:/video/list";
		}
		
		Video dto = service.readVideo(vNum);
		
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		model.addAttribute("dto", dto);
		
		return ".video.write";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String updateSubmit(Video dto,
			@RequestParam String page,
			HttpSession session) throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(info.getMembership()<51) {
			return "redirect:/video/list";
		}
		try {
			service.updateVideo(dto);
		} catch (Exception e) {
		}
		
		return "redirect:/video/list?page=" + page;
	}
	
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteVideo(
			@RequestParam int vNum
			) throws Exception {
		String state = "false";
		try {
			service.deleteVideo(vNum);
			state = "true";
		} catch (Exception e) {
		}
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value = "listModal", method = RequestMethod.GET)
	public String listModal(Model model) throws Exception {
		Map<String, Object> map = new HashMap<>();
		int dataCount = 0;
		dataCount = service.dataCount(map);
		map.put("start",1);
		map.put("end",dataCount);
		
		List<Video> list = service.listVideo(map);
		model.addAttribute("list", list);
		return "video/listModal";
	}
}
