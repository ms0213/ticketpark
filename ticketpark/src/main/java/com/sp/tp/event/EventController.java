package com.sp.tp.event;

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

@Controller("event.eventController")
@RequestMapping("/event/*")
public class EventController {

	@Autowired
	private EventService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value = "list")
	public String list(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {

		String cp = req.getContextPath();

		int rows = 9;
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

		List<Event> list = service.listEvent(map);

		String query = "";
		String listUrl = cp + "/event/list";
		String articleUrl = cp + "/event/article?page=" + current_page;
		if (keyword.length() != 0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
		}

		if (query.length() != 0) {
			listUrl = cp + "/event/list?" + query;
			articleUrl = cp + "/event/article?page=" + current_page + "&" + query;
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

		return ".event.list";
	}
	
	@RequestMapping(value = "write", method = RequestMethod.GET)
	public String writeForm(Model model, HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if (info.getMembership() < 51) {
			return "redirect:/event/list";
		}

		model.addAttribute("mode", "write");

		return ".event.write";
	}

	@RequestMapping(value = "write", method = RequestMethod.POST)
	public String writeSubmit(Event dto, HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String path = root + "uploads" + File.separator + "event";

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if (info.getMembership() < 51) {
			return "redirect:/event/list";
		}

		try {
			service.insertEvent(dto, path);
		} catch (Exception e) {
		}

		return "redirect:/event/list";
	}
	
	@RequestMapping(value = "article", method = RequestMethod.GET)
	public String article(@RequestParam int eventNum,
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			Model model) throws Exception {		

		keyword = URLDecoder.decode(keyword, "utf-8");

		String query = "page=" + page;
		if (keyword.length() != 0) {
			query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
		}

		Event dto = service.readEvent(eventNum);
		if (dto == null) {
			return "redirect:/event/list?" + query;
		}

		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));

		// 이전 글, 다음 글
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("eventNum", eventNum);
		
		List<Event> listFile = service.listFile(eventNum);

		model.addAttribute("dto", dto);
		model.addAttribute("listFile", listFile);
		model.addAttribute("page", page);
		model.addAttribute("query", query);

		return ".event.article";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String updateForm(@RequestParam int eventNum,
			@RequestParam String page,
			Model model) throws Exception {

		Event dto = service.readEvent(eventNum);
		if (dto == null) {
			return "redirect:/evnet/list?page=" + page;
		}
	
		List<Event> listFile = service.listFile(eventNum);

		model.addAttribute("dto", dto);
		model.addAttribute("listFile", listFile);

		model.addAttribute("page", page);
		model.addAttribute("mode", "update");

		return ".event.write";
	}

	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String updateSubmit(Event dto,
			@RequestParam String page,
			HttpSession session) throws Exception {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "event";

		try {
			service.updateEvent(dto, pathname);
		} catch (Exception e) {
		}

		return "redirect:/event/article?eventNum=" + dto.getEventNum() + "&page=" + page;
	}
	
	@RequestMapping(value = "delete", method = RequestMethod.GET)
	public String delete(@RequestParam int eventNum,
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpSession session) throws Exception {

		keyword = URLDecoder.decode(keyword, "utf-8");
		String query = "page=" + page;
		if (keyword.length() != 0) {
			query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
		}

		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "event";

		Event dto = service.readEvent(eventNum);
		if (dto == null) {
			return "redirect:/event/list?page=" + page;
		}

		try {
			service.deleteEvent(eventNum, pathname);
		} catch (Exception e) {
		}

		return "redirect:/event/list?" + query;
	}
	
	@RequestMapping(value = "deleteFile", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFile(@RequestParam int fileNum, HttpSession session) throws Exception {

		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "event";

		Event dto = service.readFile(fileNum);
		if (dto != null) {
			// FileManager.doFileDelete(dto.getSaveFilename(), pathname);
			fileManager.doFileDelete(dto.getSaveFilename(), pathname);
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("field", "fileNum");
		map.put("eventNum", fileNum);
		service.deleteFile(map);

		// 작업 결과를 json으로 전송
		Map<String, Object> model = new HashMap<>();
		model.put("state", "true");
		return model;
	}
	
	@RequestMapping(value = "listModal", method = RequestMethod.GET)
	public String listModal(Model model) throws Exception{
		List<Coupon> couponList = service.listCoupon();
		model.addAttribute("couponList", couponList);
		return "event/listModal";
	}
}
