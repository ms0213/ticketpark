package com.sp.tp.expect;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.sp.tp.common.MyUtil;
import com.sp.tp.member.SessionInfo;


@RestController("expect.expectController")
@RequestMapping("/expect/*")
public class ExpectController {
	@Autowired
	private ExpectService service;

	@Autowired
	private MyUtil myUtil;

	
	@RequestMapping(value = "main")
	public ModelAndView expect(Model model) {
		ModelAndView mav = new ModelAndView(".expect.expect");

		return mav;
	}

	// AJAX - Map을 JSON으로 변환 반환
	@RequestMapping(value = "list")
	public Map<String, Object> list(@RequestParam(value = "pageNo", defaultValue = "1") int current_page)
			throws Exception {
		int rows = 10;
		int dataCount = service.dataCount();
		int total_page = myUtil.pageCount(rows, dataCount);
		if (current_page > total_page) {
			current_page = total_page;
		}

		Map<String, Object> map = new HashMap<String, Object>();
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);

		List<Expect> list = service.listExpect(map);
		for (Expect dto : list) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}

		Map<String, Object> model = new HashMap<>();

		model.put("dataCount", dataCount);
		model.put("total_page", total_page);
		model.put("pageNo", current_page);
		

		model.put("list", list);

		return model;
	}

	// AJAX - Map을 JSON으로 변환 반환
	@RequestMapping(value = "insert", method = RequestMethod.POST)
	public Map<String, Object> writeSubmit(Expect dto, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String state = "true";
		try {
			dto.setUserId(info.getUserId());
			service.insertExpect(dto);
		} catch (Exception e) {
			state = "false";
		}

		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}

	// AJAX - Map을 JSON으로 변환 반환
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	public Map<String, Object> expectDelete(@RequestParam int num, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String state = "true";
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("num", num);
			map.put("membership", info.getMembership());
			map.put("userId", info.getUserId());
			service.deleteExpect(map);
		} catch (Exception e) {
			state = "false";
		}

		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public Map<String, Object> expectUpdate(Expect dto, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String state = "true";
		
		try {
			dto.setUserId(info.getUserId());
			service.updateExpect(dto);
		} catch (Exception e) {
			state = "false";
		}
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state", state);
		return model;
	}
	
	
}
