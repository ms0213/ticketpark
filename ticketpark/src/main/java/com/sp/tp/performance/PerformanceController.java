package com.sp.tp.performance;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.tp.common.MyUtil;
import com.sp.tp.member.SessionInfo;

@Controller("performance.performanceController")
@RequestMapping("/performance/*")
public class PerformanceController {
	
	@Autowired
	private PerformanceService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value = "list")
	public String list(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "") String condiDate,
			@RequestParam(defaultValue = "") String condiAddr,
			@RequestParam(defaultValue = "") String condiGenre,
			@RequestParam(defaultValue = "") String keyDate,
			@RequestParam(defaultValue = "") String keyAddr,
			@RequestParam(defaultValue = "") String keyGenre,
			@RequestParam(defaultValue = "all") String category,
			@RequestParam(value = "categoryNum") Integer categoryNum,
			HttpServletRequest req,
			Model model) throws Exception {
		
		String cp = req.getContextPath();

		int rows = 12;
		// int rows = 4;
		int total_page;
		int dataCount;

		if (req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyGenre = URLDecoder.decode(keyGenre, "utf-8");
			keyAddr = URLDecoder.decode(keyAddr, "utf-8");
		}

		// 전체 페이지 수
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condiDate", condiDate);
		map.put("condiAddr", condiAddr);
		map.put("condiGenre", condiGenre);
		map.put("keyDate", keyDate);
		map.put("keyAddr", keyAddr);
		map.put("keyGenre", keyGenre);
		map.put("category", category);

		dataCount = service.dataCount(map);
		total_page = myUtil.pageCount(rows, dataCount);

		if (total_page < current_page) {
			current_page = total_page;
		}

		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
		map.put("category", category);

		List<Performance> list = service.listPerformance(map);

		Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("categoryNum", categoryNum);
		List<Performance> listGenre = service.listGenre(map2);

		String query = "category=" + category+"&categoryNum=" + categoryNum;
		
		if(keyGenre.length()!=0) {
			query+="&keyGenre="+keyGenre;
		}
		
		if(keyAddr.length()!=0) {
			query += "&keyAddr=" + URLEncoder.encode(keyAddr, "utf-8");
		}
		
		if(keyDate.length()!=0) {
			query += "&keyDate=" + keyDate;
		}
		
		String listUrl = cp + "/performance/list"; 
		String articleUrl = cp + "/performance/article?page=" + current_page;
		
		query = "condiDate=" + condiDate + "&condiAddr=" + condiAddr + 
				"&condiGenre=" + condiGenre;
		
		if (query.length() != 0) {
			listUrl = cp + "/performance/list?" + query;
			articleUrl = cp + "/performance/article?page=" + current_page + "&" + query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);

		model.addAttribute("listGenre", listGenre);
		
		model.addAttribute("list", list);
		model.addAttribute("categoryNum", categoryNum);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);
		model.addAttribute("category", category);

		model.addAttribute("condiDate", condiDate);
		model.addAttribute("condiAddr", condiAddr);
		model.addAttribute("condiGenre", condiGenre);
		model.addAttribute("keyDate", keyDate);
		model.addAttribute("keyAddr", keyAddr);
		model.addAttribute("keyGenre", keyGenre);
		
		return ".performance.list";
	}
	
	@RequestMapping(value = "add", method = RequestMethod.GET)
	public String writeForm(Model model, HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		List<Performance> groupList = service.listCategory();
		List<Performance> rateList = service.listRate();
		List<Performance> hallList = service.listHall();
		
		if (info.getMembership() < 51) {
			return "redirect:/";
		}

		model.addAttribute("mode", "add");
		model.addAttribute("groupList", groupList);
		model.addAttribute("rateList", rateList);
		model.addAttribute("hallList", hallList);
		
		return ".performance.perfAdd";
	}
	
	@RequestMapping(value = "add", method = RequestMethod.POST)
	public String writeSubmit(Performance dto, HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String path = root + "uploads" + File.separator + "performance";

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if (info.getMembership() < 51) {
			return "redirect:/";
		}

		try {
			service.insertPerformance(dto, path);
		} catch (Exception e) {
		}

		return "redirect:/";
	}
	
	@RequestMapping(value = "genre", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> genreList(
			@RequestParam int categoryNum) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("categoryNum", categoryNum);
		
		List<Performance> genreList = service.listGenre(map);
		
		Map<String, Object> model = new HashMap<>();
		model.put("genreList", genreList);
		
		return model;
		
	}
	
	@RequestMapping(value = "theater", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> theaterList(
			@RequestParam int hallNum) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("hallNum", hallNum);
		
		List<Performance> theaterList = service.listTheater(map);
		
		Map<String, Object> model = new HashMap<>();
		model.put("theaterList", theaterList);
		
		return model;
		
	}
	
	@RequestMapping(value = "article", method = RequestMethod.GET)
	public String article(@RequestParam int perfNum,
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			@RequestParam String category,
			Model model) throws Exception {		

		keyword = URLDecoder.decode(keyword, "utf-8");

		String query = "page=" + page;
		query += "&category=" + category;
		
		if (keyword.length() != 0) {
			query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
		}

		Performance dto = service.readPerformance(perfNum);
		if (dto == null) {
			return "redirect:/performance/list?" + query;
		}
		
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));

		List<Performance> listFile = service.listFile(perfNum);

		model.addAttribute("dto", dto);
		model.addAttribute("listFile", listFile);
		model.addAttribute("page", page);
		model.addAttribute("query", query);

		return ".performance.article";
	}
}
