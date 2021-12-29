package com.sp.tp.contactUs;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.tp.common.MyUtil;

@Controller("contactUs.contactUsController")

public class ContactUsController {
	@Autowired
	private ContactUsService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value = "/admin/contactUs/list")
	public String list(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {
		
		String cp = req.getContextPath();
		
		int rows = 5;
		int total_page = 0;
		int dataCount = 0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
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
		
		List<ContactUs> list = service.listContact(map);
		int listNum, n = 0;
		for(ContactUs dto : list) {
			listNum = dataCount - (start + n - 1);
			dto.setListNum(listNum);
		}
		
		String query = "";
		String listUrl = cp + "/admin/contactUs/list";
		String articleUrl = cp + "/admin/contactUs/article?page="+ current_page;
		
		if (keyword.length() != 0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
		}

		if (query.length() != 0) {
			listUrl = cp + "/admin/contactUs/list?" + query;
			articleUrl = cp + "/admin/contactUs/article?page="+ current_page + "&" + query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);

		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".admin.contactUs.list";
	}
	
	@RequestMapping(value = "/admin/contactUs/article", method = RequestMethod.GET)
	public String article(@RequestParam int cNum,
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			Model model
			) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "utf-8");

		String query = "page=" + page;
		if (keyword.length() != 0) {
			query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
		}
		
		ContactUs dto = service.readContact(cNum);
		if (dto == null) {
			return "redirect:/admin/contactUs/list?" + query;
		}
		
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
		return ".admin.contactUs.article";
	}
	
	@RequestMapping(value = "/admin/contactUs/updateChecked")
	public String updateChecked(
			@RequestParam int cNum,
			@RequestParam String checked
			) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cNum", cNum);
		map.put("checked", checked);
		try {
			service.updateChecked(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return "redirect:/admin/contactUs/list";
	}
	
	@RequestMapping(value = "/admin/contactUs/delete")
	public String deleteContact(
			@RequestParam int cNum
			) throws Exception {
		try {
			service.deleteContact(cNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return "redirect:/admin/contactUs/list";
	}
	
	@RequestMapping(value = "/contactUs/write")
	public String write(ContactUs dto) throws Exception {
		try {
			service.insertContact(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return "redirect:/";
	}
}
