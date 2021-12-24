package com.sp.tp.test;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.tp.common.MyUtil;


@Controller("test.testController")
@RequestMapping("/test/*")
public class TestController {
	
	@Autowired
	private TestService service;
	
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

		List<Test> list = service.listPerformance(map);
		
		Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("categoryNum", categoryNum);
		List<Test> listGenre = service.listGenre(map2);

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
		
		String listUrl = cp + "/test/list"; 
		String articleUrl = cp + "/test/article?page=" + current_page;
		
		query = "condiDate=" + condiDate + "&condiAddr=" + condiAddr + 
				"&condiGenre=" + condiGenre;
					
					
					
		
		
		if (query.length() != 0) {
			listUrl = cp + "/test/list?" + query;
			articleUrl = cp + "/test/article?page=" + current_page + "&" + query;
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
		
		return ".test.list";
	}
	
}
