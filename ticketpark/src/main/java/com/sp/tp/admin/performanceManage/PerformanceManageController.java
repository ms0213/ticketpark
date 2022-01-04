package com.sp.tp.admin.performanceManage;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.tp.common.MyUtil;
import com.sp.tp.member.SessionInfo;

@Controller("performanceManage.performanceManageController")
@RequestMapping("/admin/performanceManage/*")
public class PerformanceManageController {

	@Autowired
	private PerformanceManageSerive service;

	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value = "perfList")
	public String list(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			@RequestParam(defaultValue = "") String category,
			HttpServletRequest req,
			Model model) throws Exception {
		
		String cp = req.getContextPath();

		int rows = 8;
		int total_page = 0;
		int dataCount = 0;

		if (req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}

		// 전체 페이지 수
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("category", category);

		dataCount = service.dataCount(map);
		if(dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}

		if (total_page < current_page) {
			current_page = total_page;
		}

		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);

		List<PerformanceManage> list = service.listPerformance(map);
		
		// 글번호
		int listNum, n = 0;
		for(PerformanceManage dto : list) {
			listNum = dataCount - (start + n - 1);
			dto.setListNum(listNum);
			n++;
		}

		String query = "";
		String listUrl = cp + "/admin/performanceManage/perfList";
		
		if(keyword.length() != 0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
		}
		
		if(category.length() != 0 ) {
			if(query.length() != 0)
				query = query + "&category=" + category;
			else
				query = "category=" + category;
		}
		
		if(query.length() != 0) {
			listUrl = listUrl + "?" + query;
		}
		
		if (keyword.length() != 0) {
			query = "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8"); 
		}

		if (query.length() != 0) {
			listUrl = cp + "/admin/performanceManage/perfList?" + query;
		}

		String paging = myUtil.paging(current_page, total_page, listUrl);

		model.addAttribute("list", list);
		model.addAttribute("category", category);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);

		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".admin.performanceManage.perfList";
	}
	
	@RequestMapping(value = "perfAdd", method = RequestMethod.GET)
	public String writeForm(Model model, 
			@RequestParam String page,
			HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		List<PerformanceManage> categoryList = service.listCategory();
		List<PerformanceManage> rateList = service.listRate();
		List<PerformanceManage> hallList = service.listHall();
		
		if (info.getMembership() < 51) {
			return "redirect:/";
		}

		model.addAttribute("mode", "perfAdd");
		model.addAttribute("page", page);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("rateList", rateList);
		model.addAttribute("hallList", hallList);
		
		return ".admin.performanceManage.perfAdd";
	}
	
	@RequestMapping(value = "perfAdd", method = RequestMethod.POST)
	public String writeSubmit(PerformanceManage dto, HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String path = root + "uploads" + File.separator + "performance";

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if (info.getMembership() < 51) {
			return "redirect:/admin/performanceManage/perfList";
		}

		try {
			service.insertPerformance(dto, path);
		} catch (Exception e) {
		}

		return "redirect:/admin/performanceManage/perfList";
	}
	
	@RequestMapping(value = "genre", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> genreList(
			@RequestParam int categoryNum) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("categoryNum", categoryNum);
		
		List<PerformanceManage> genreList = service.listGenre(map);
		
		Map<String, Object> model = new HashMap<>();
		model.put("genreList", genreList);
		
		return model;
		
	}
	
	@RequestMapping(value = "theater", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> theaterList(
			@RequestParam String perfDate,
			@RequestParam int perfNum) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("perfNum", perfNum);
		map.put("perfDate", perfDate);
		List<PerformanceManage> theaterList = service.listTheater(map);
		
		Map<String, Object> model = new HashMap<>();
		model.put("theaterList", theaterList);
		
		return model;
		
	}
	
	@RequestMapping(value="detail")
	public String detailePerformance(
			@RequestParam int perfNum,
			Model model) throws Exception {
		
		PerformanceManage dto=service.readPerformance(perfNum);
		
		List<PerformanceManage> list = service.listSchedule(perfNum);
		
		model.addAttribute("list", list);
		model.addAttribute("dto", dto);
		
		return "/admin/performanceManage/perfDetail";
	}
	
	@GetMapping(value = "time")
	@ResponseBody
	public Map<String, Object> timeList(
			@RequestParam String perfDate,
			@RequestParam int perfNum) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("perfDate", perfDate);
		map.put("perfNum", perfNum);
		
		List<PerformanceManage> timeList = service.listTime(map);
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("timeList", timeList);
		
		return model;
	}
	

	@RequestMapping(value = "addDate", method = RequestMethod.GET)
	public String addForm(Model model, 
			HttpSession session,
			@RequestParam String page,
			@RequestParam int perfNum) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		List<PerformanceManage> hallList = service.listHall();
		
		if (info.getMembership() < 51) {
			return "redirect:/";
		}
		
		model.addAttribute("page", page);
		model.addAttribute("mode", "addDate");
		model.addAttribute("perfNum", perfNum);
		model.addAttribute("hallList", hallList);
		
		return ".admin.performanceManage.perfAddDate";

	}
	
	@RequestMapping(value = "addDate", method = RequestMethod.POST)
	public String addDateSubmit(PerformanceManage dto, HttpSession session,@RequestParam String page) throws Exception {

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if (info.getMembership() < 51) {
			return "redirect:/";
		}

		try {
			service.insertPerfDate(dto);
			
		} catch (Exception e) {
		}

		return "redirect:/admin/performanceManage/perfList?page=" + page;
	}
	
	
	@RequestMapping(value = "addTime", method = RequestMethod.GET)
	public String addTimeForm(Model model, 
			HttpSession session,
			@RequestParam String page,
			@RequestParam int perfNum) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		List<PerformanceManage> dateList = service.listDate(perfNum);
		List<PerformanceManage> actorList = service.listActor(perfNum);
		
		if (info.getMembership() < 51) {
			return "redirect:/";
		}
		
		model.addAttribute("page", page);
		model.addAttribute("mode", "addTime");
		model.addAttribute("dateList", dateList);
		model.addAttribute("actorList", actorList);
		model.addAttribute("perfNum", perfNum);
		
		return ".admin.performanceManage.perfAddTime";

	}
	
	@RequestMapping(value = "addTime", method = RequestMethod.POST)
	public String addTimeSubmit(PerformanceManage dto, HttpSession session) throws Exception {

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if (info.getMembership() < 51) {
			return "redirect:/";
		}

		try {
			service.insertPerfTime(dto);
			
		} catch (Exception e) {
		}
		
		return "redirect:/admin/performanceManage/addTime";
	}

	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String updateForm(@RequestParam int perfNum,
			@RequestParam String page,
			HttpSession session,
			Model model) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		PerformanceManage dto = service.readPerformance(perfNum);
		
		if(dto == null) {
			return "redirect:/admin/performanceManage/perfList";
		}
		
		List<PerformanceManage> categoryList = service.listCategory();
		List<PerformanceManage> rateList = service.listRate();
		List<PerformanceManage> actorList = service.listActor(perfNum);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("categoryNum", dto.getCategoryNum());
		List<PerformanceManage> genreList = service.listGenre(map);
		if (info.getMembership() < 51) {
			return "redirect:/admin/performanceManage/perfList";
		}

		model.addAttribute("mode", "update");
		model.addAttribute("dto", dto);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("rateList", rateList);
		model.addAttribute("actorList", actorList);
		model.addAttribute("genreList", genreList);
		
		return ".admin.performanceManage.perfAdd";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String updateSubmit(PerformanceManage dto, HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String path = root + "uploads" + File.separator + "performance";

		try {
			service.updatePerformance(dto,path);
		} catch (Exception e) {

		}
		return "redirect:/admin/performanceManage/perfList";
	}
	
	@PostMapping(value="deleteActor")
	@ResponseBody
	public Map<String, Object> deleteActor(
			@RequestParam int actorNum,
			HttpSession session) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("actorNum", actorNum);
		service.deleteActor(map);
		
		return null;
	}
	
}
