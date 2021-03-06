package com.sp.tp.performance;

import java.io.File;
import java.net.URLDecoder;
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
import com.sp.tp.member.MemberService;
import com.sp.tp.member.SessionInfo;

@Controller("performance.performanceController")
@RequestMapping("/performance/*")
public class PerformanceController {
	@Autowired
	private MemberService servicem;
	
	@Autowired
	private PerformanceService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value = "list")
	public String list(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "") String condiDate,
			@RequestParam(defaultValue = "") String condiGenre,
			@RequestParam(defaultValue = "") String keyDate,
			@RequestParam(defaultValue = "") String keyGenre,
			@RequestParam(defaultValue = "") String condiAddr,
			@RequestParam(defaultValue = "") String keyAddr,
			@RequestParam(defaultValue = "all") String category,
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
		map.put("condiGenre", condiGenre);
		map.put("condiAddr", condiAddr);
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
		List<Performance> listGenre = service.listGenre(map);
		

		String query = "category=" + category;
		
		if(keyGenre.length()!=0) {
			query+="&condiGenre="+condiGenre+"&keyGenre="+keyGenre;
		}
		if(keyAddr.length()!=0) {
			query += "&condiAddr="+condiAddr+"&keyAddr="+keyAddr;
		}
		if(keyDate.length()!=0) {
			query += "&condiDate="+condiDate+"&keyDate=" + keyDate;
		}
		
		String listUrl = cp + "/performance/list?"+query;
		String articleUrl = cp + "/performance/article?page=" + current_page;
		
		
		if (query.length() != 0) {
			articleUrl = cp + "/performance/article?page=" + current_page + "&" + query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);

		model.addAttribute("listGenre", listGenre);
		
		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);
		model.addAttribute("category", category);

		model.addAttribute("condiDate", condiDate);
		model.addAttribute("condiGenre", condiGenre);
		model.addAttribute("condiAddr", condiAddr);
		model.addAttribute("keyAddr", keyAddr);
		model.addAttribute("keyDate", keyDate);
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
			@RequestParam(defaultValue = "") String condiDate,
			@RequestParam(defaultValue = "") String condiGenre,
			@RequestParam(defaultValue = "") String keyDate,
			@RequestParam(defaultValue = "") String keyGenre,
			@RequestParam(defaultValue = "") String condiAddr,
			@RequestParam(defaultValue = "") String keyAddr,
			@RequestParam String category,
			HttpSession session,
			Model model) throws Exception {

		
		keyGenre = URLDecoder.decode(keyGenre, "utf-8");
		keyAddr = URLDecoder.decode(keyAddr, "utf-8");

		String query = "page=" + page;
		query += "&category=" + category;
		
		if(keyGenre.length()!=0) {
			query+="&condiGenre="+condiGenre+"&keyGenre="+keyGenre;
		}
		if(keyAddr.length()!=0) {
			query+="&condiAddr="+condiAddr+"&keyAddr="+keyAddr;
		}
		if(keyDate.length()!=0) {
			query += "&condiDate="+condiDate+"&keyDate=" + keyDate;
		}
		
		Performance dto = service.readPerformance(perfNum);
		if (dto == null) {
			return "redirect:/performance/list?" + query;
		}
		
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));

		List<Performance> listFile = service.listFile(perfNum);
		
		List<PerformanceBook> listSchedule = service.listSchedule(perfNum);

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		Map<String , Object> map = new HashMap<String, Object>();
		map.put("userId", info.getUserId());
		map.put("perfNum", perfNum);
		boolean userChoiced = servicem.userChoiced(map);
		
		model.addAttribute("dto", dto);
		model.addAttribute("listFile", listFile);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		model.addAttribute("userChoiced", userChoiced);
		model.addAttribute("listSchedule", listSchedule);

		return ".performance.article";
	}
	
	@RequestMapping("listTime")
	@ResponseBody
	public Map<String, Object> listTime(@RequestParam String perf_date, @RequestParam int perfNum) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("perf_date", perf_date);
		map.put("perfNum", perfNum);
		List<PerformanceBook> listTime = service.listTime(map);
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("listTime", listTime);
		return model;
	}
	
	
}
