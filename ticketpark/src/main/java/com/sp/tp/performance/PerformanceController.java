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

import com.sp.tp.common.FileManager;
import com.sp.tp.common.MyUtil;
import com.sp.tp.member.SessionInfo;

@Controller("performance.performanceController")
@RequestMapping("/performance/*")
public class PerformanceController {
	
	@Autowired
	private PerformanceService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value = "list")
	public String list(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			@RequestParam String category,
			HttpServletRequest req,
			Model model) throws Exception {
		
		String cp = req.getContextPath();

		int rows = 12;
		int total_page;
		int dataCount;

		if (req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}

		// 전체 페이지 수
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);

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

		String query = "";
		String listUrl = cp + "/performance/list";
		String articleUrl = cp + "/performance/article?page=" + current_page;
		if (keyword.length() != 0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
		}

		if (query.length() != 0) {
			listUrl = cp + "/performance/list?" + query;
			articleUrl = cp + "/performance/article?page=" + current_page + "&" + query;
		}

		String paging = myUtil.paging(current_page, total_page, listUrl);

		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);
		model.addAttribute("category", category);

		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".performance.list";
	}
	
	@RequestMapping(value = "add", method = RequestMethod.GET)
	public String writeForm(Model model, HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		List<Performance> groupList = service.listCategory();
		
		if (info.getMembership() < 51) {
			return "redirect:/performance/list";
		}

		model.addAttribute("mode", "add");
		model.addAttribute("groupList", groupList);

		return ".performance.perfAdd";
	}
	
	@RequestMapping(value = "add", method = RequestMethod.POST)
	public String writeSubmit(Performance dto, HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String path = root + "uploads" + File.separator + "performance";

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if (info.getMembership() < 51) {
			return "redirect:/performance/list";
		}

		try {
			service.insertPerformance(dto, path);
		} catch (Exception e) {
		}

		return "redirect:/performance/list";
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
}
