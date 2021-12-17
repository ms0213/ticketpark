package com.sp.tp;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sp.tp.performance.Performance;
import com.sp.tp.performance.PerformanceService;

@Controller
public class HomeController {
	@Autowired
	private PerformanceService performanceService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", 1);
		map.put("end", 10);
		List<Performance> listPerformance = performanceService.listPerformance(map);
		
		model.addAttribute("listPerformance", listPerformance);
		return ".home";
	}
	
}
