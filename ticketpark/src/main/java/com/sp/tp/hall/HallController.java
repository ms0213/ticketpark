package com.sp.tp.hall;

import java.io.File;
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

import com.sp.tp.common.FileManager;
import com.sp.tp.common.MyUtil;
import com.sp.tp.member.SessionInfo;

@Controller("hall.hallController")
@RequestMapping(value = "/hall/*")
public class HallController {
	@Autowired
	private HallService service;
	@Autowired
	private MyUtil myUtil;
	@Autowired
	private FileManager fileManager;

	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String List(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			HttpServletRequest req,
			Model model
			) throws Exception {
		String cp = req.getContextPath();
		
		int rows = 9;
		int total_page;
		int dataCount;
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		dataCount = service.dataCount();
		total_page = myUtil.pageCount(rows, dataCount);
		
		if (total_page < current_page) {
			current_page = total_page;
		}

		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
		
		List<Hall> list = service.listHall(map);
		
		String listUrl = cp +"/hall/list";
		String articleUrl = cp+"/hall/article?page="+current_page;
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);
		
		return ".hall.list";
	}
	
	@RequestMapping(value = "write", method = RequestMethod.GET)
	public String writeForm(Model model, HttpSession session) throws Exception{
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if (info.getMembership() < 51) {
			return "redirect:/hall/list";
		}

		model.addAttribute("mode", "write");

		return ".hall.write";
	}
	
	@RequestMapping(value = "write", method = RequestMethod.POST)
	public String writeSubmit(Hall dto, HttpSession session) throws Exception{
		String root = session.getServletContext().getRealPath("/");
		String path = root + "uploads" + File.separator + "hall";

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if (info.getMembership() < 51) {
			return "redirect:/hall/list";
		}
		try {
			service.insertHall(dto, path);
			
		} catch (Exception e) {
		}

		return "redirect:/hall/list";
	}
	
	@RequestMapping(value = "article", method = RequestMethod.GET)
	public String article(
			@RequestParam int hNum,
			@RequestParam String page,
			Model model
			) throws Exception {
		String query = "page=" + page;
		Hall dto = service.readHall(hNum);
		if(dto == null) {
			return "redirect:/hall/list"+query;
		}
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("hNum", hNum);
		
		List<Hall> listFile = service.listFile(hNum);
		
		model.addAttribute("dto", dto);
		model.addAttribute("listFile", listFile);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
		return ".hall.article";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String updateForm(
			@RequestParam int hNum,
			@RequestParam String page,
			Model model
			) throws Exception{
		
		Hall dto = service.readHall(hNum);
		if(dto == null) {
			return "redirect:/hall/list?page="+page;
		}
		
		List<Hall> listFile = service.listFile(hNum);
		
		model.addAttribute("dto", dto);
		model.addAttribute("listFile", listFile);
		
		model.addAttribute("page", page);
		model.addAttribute("mode", "update");
		
		return ".hall.write";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String updateSubmit(
			Hall dto,
			@RequestParam String page,
			HttpSession session
			) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"hall";
		
		try {
			service.updateHall(dto, pathname);
		} catch (Exception e) {
		}
		return "redirect:/hall/article?hNum="+dto.gethNum()+"&page="+page;
	}
	
	@RequestMapping(value = "delete", method = RequestMethod.GET)
	public String deleteHall(
			@RequestParam int hNum,
			@RequestParam String page,
			HttpSession session
			) throws Exception {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"hall";
		
		Hall dto = service.readHall(hNum);
		if(dto == null) {
			return "redirect:/hall/list?page="+page;
		}
		
		try {
			service.deletHall(hNum, pathname);
		} catch (Exception e) {
		}
		
		return "redirect:/hall/list?page="+page;
	}
	
	@RequestMapping(value = "deleteFile", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFile(
			@RequestParam int fileNum,
			HttpSession session
			) throws Exception{
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"hall";
		
		Hall dto = service.readFile(fileNum);
		if(dto != null) {
			fileManager.doFileDelete(dto.getSaveFilename(), pathname);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("field", "fileNum");
		map.put("hNum", fileNum);
		service.deleteFile(map);
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state", "true");
		
		return model;
	}
	
	
	
}
