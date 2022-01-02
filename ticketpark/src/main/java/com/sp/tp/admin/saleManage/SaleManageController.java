package com.sp.tp.admin.saleManage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller("admin.saleManage.saleManageController")
@RequestMapping("/admin/saleManage/*")
public class SaleManageController {

	@Autowired
	private SaleManageService service;
	
	@RequestMapping("main")
	public String main() throws Exception {
		
		return ".admin.saleManage.main"; 
	}
	
	@RequestMapping(value = "monthSale", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> monthSale() throws Exception {
		
		int perfMonthCount = service.perfMonthCount();
		
		List<Sale> monthSale = service.monthSale(perfMonthCount);
		Map<String, Object> model = new HashMap<String, Object>();
		
		model.put("monthSale", monthSale);
				
		return model;
	}
	
	@RequestMapping(value = "performSale", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> performSale() throws Exception {
		
		int perfMonthCount = service.perfMonthCount();
		
		List<Sale> performSale = service.performSale(perfMonthCount);
		Map<String, Object> model = new HashMap<String, Object>();
		
		model.put("performSale", performSale);
				
		return model;
	}
	
	@RequestMapping(value = "categorySale", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> categorySale(@RequestParam String category) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		int categoryDataCount = service.categoryDataCount(map);
		map.put("category", category);
		map.put("categoryDataCount", categoryDataCount);
		

		List<Sale> categorySale = service.categorySale(map);
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("categorySale", categorySale);
		
		return model;
	}
	
	@RequestMapping(value = "categoryAll")
	@ResponseBody
	public Map<String, Object> categoryAll() throws Exception {
		
		int categoryAllCount = service.categoryAllCount();
		List<Sale> categoryAll = service.categoryAll(categoryAllCount);
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("categoryAll", categoryAll);
		
		return model;
	}
	
}
