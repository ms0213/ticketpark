package com.sp.tp.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

@Controller("review.reviewController")
@RequestMapping("/performance/review/*")
public class ReviewController {
	@Autowired
	private ReviewService service;
	
	@Autowired
	private MyUtil myUtil;

	@RequestMapping(value = "review")
	public String reviewList(int perfNum, Model model) throws Exception{
		model.addAttribute("perfNum", perfNum);
		
		return "performance/review/review";
	}
	
	@RequestMapping(value = "list")
	@ResponseBody
	public Map<String, Object> list(
			@RequestParam(value = "pageNo", defaultValue = "1")int current_page
			, int perfNum
			) throws Exception{
		int rows = 10;
		int dataCount = service.dataCount(perfNum);
		int total_page = myUtil.pageCount(rows, dataCount);
		if (current_page > total_page) {
			current_page = total_page;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
		map.put("perfNum", perfNum);
		
		List<Review> list = service.listReview(map);
		for(Review dto:list) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		Map<String, Object> model = new HashMap<>();
		
		model.put("dataCount", dataCount);
		model.put("total_page", total_page);
		model.put("pageNo", current_page);
		model.put("list", list);
		
		return model;
	}
	
	@RequestMapping(value = "insertReview", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> writeSubmit(Review dto, HttpSession session) throws Exception{
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String state = "true";
		
		try {
			dto.setUserId(info.getUserId());
			service.insertReview(dto);
			
			int sum = 0;
			sum = service.sumRate(dto.getPerfNum());
			int count = 0;
			count = service.dataCount(dto.getPerfNum());
			service.updateRate(sum, count, dto.getPerfNum());
		} catch (Exception e) {
			state = "false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value = "updateReview", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> reviewUpdate(Review dto, HttpSession session) throws Exception{
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String state = "true";
		
		try {
			dto.setUserId(info.getUserId());
			service.updateReview(dto);
		} catch (Exception e) {
			state = "false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value = "deleteReview", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> reviewDelete(@RequestParam int num, 
			int perfNum
			,HttpSession session) throws Exception{
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String state = "true";
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("num", num);
			map.put("membership", info.getMembership());
			map.put("userId", info.getUserId());
			service.deleteReview(map);
			
			int sum = 0;
			sum = service.sumRate(perfNum);
			int count = 0;
			count = service.dataCount(perfNum);
			service.updateRate(sum, count, perfNum);
		} catch (Exception e) {
			state = "false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	
	
}
