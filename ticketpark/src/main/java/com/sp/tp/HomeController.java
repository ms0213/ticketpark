package com.sp.tp;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.tp.performance.Performance;
import com.sp.tp.performance.PerformanceService;

@Controller
public class HomeController {
	@Autowired
	private PerformanceService performanceService;
	
	@RequestMapping(value = "/")
	public String home(Locale locale, Model model) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", 1);
		map.put("end", 10);
		
		List<Performance> listPerformance = performanceService.listPerformance(map);
		
		model.addAttribute("listPerformance", listPerformance);
	
		return ".home";
	}
	
	// 장르리스트 : AJAX-JSON 전송
	@RequestMapping(value = "listGenreMain")
	@ResponseBody
	public Map<String, Object> listGenreMain() throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<Performance> listGenreMain = performanceService.listGenreMain(map);
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("listGenreMain", listGenreMain);

		return model;
	}
	
}
