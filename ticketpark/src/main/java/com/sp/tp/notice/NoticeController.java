package com.sp.tp.notice;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

@Controller("notice.noticeController")
@RequestMapping("/notice/*")
public class NoticeController {
	@Autowired
	private NoticeService service;
	@Autowired
	private MyUtil myUtil;
	@Autowired
	private FileManager fileManager;

	@RequestMapping(value = "main")
	public String main() throws Exception {
		return ".notice.main";
	}

	// AJAX - HTML
	@RequestMapping(value = "list")
	public String list(@RequestParam(value = "pageNo", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {

		int rows = 10; 
		int total_page = 0;
		int dataCount = 0;

		if (req.getMethod().equalsIgnoreCase("GET")) { 
			keyword = URLDecoder.decode(keyword, "utf-8");
		}

		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);

		dataCount = service.dataCount(map);
		if (dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}

		
		if (total_page < current_page) {
			current_page = total_page;
		}

		
		List<Notice> noticeList = null;
		if (current_page == 1) {
			noticeList = service.listNoticeTop();
		}

		
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);

		
		List<Notice> list = service.listNotice(map);

	
		Date endDate = new Date();
		long gap;
		int listNum, n = 0;
		for (Notice dto : list) {
			listNum = dataCount - (start + n - 1);
			dto.setListNum(listNum);

			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date beginDate = formatter.parse(dto.getReg_date());
		
			gap = (endDate.getTime() - beginDate.getTime()) / (60 * 60 * 1000);
			dto.setGap(gap);

			dto.setReg_date(dto.getReg_date().substring(0, 10));

			n++;
		}

		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");

		model.addAttribute("noticeList", noticeList);
		model.addAttribute("list", list);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);

		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);

		return "notice/list";
	}


	@RequestMapping(value = "write", method = RequestMethod.GET)
	public String writeForm(Model model, 
			HttpServletResponse resp,
			HttpSession session) throws Exception {

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info.getMembership() < 51) {
			resp.sendError(402);
			return "redirect:/notice/main";
		}

		model.addAttribute("mode", "write");
		model.addAttribute("pageNo", "1");

		return "notice/write";
	}

	
	@RequestMapping(value = "write", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> writeSubmit(Notice dto, 
			HttpSession session) throws Exception {

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String state = "false";
		
		try {
			if (info.getMembership() > 50) {
				String root = session.getServletContext().getRealPath("/");
				String pathname = root + "uploads" + File.separator + "notice";
	
				dto.setUserId(info.getUserId());
				service.insertNotice(dto, pathname);
				state = "true";
			}
		} catch (Exception e) {
		}

		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}

	
	@RequestMapping(value = "article")
	public String article(@RequestParam int num,
			@RequestParam String pageNo,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletResponse resp,
			Model model) throws Exception {

		keyword = URLDecoder.decode(keyword, "utf-8");

		service.updateHitCount(num);

		Notice dto = service.readNotice(num);
		if (dto == null) {
			resp.sendError(410);
			return "redirect:/notice/main";
		}

		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));

		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("num", num);

		Notice preReadDto = service.preReadNotice(map);
		Notice nextReadDto = service.nextReadNotice(map);

		
		List<Notice> listFile = service.listFile(num);

		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		model.addAttribute("listFile", listFile);
		model.addAttribute("pageNo", pageNo);

		return "notice/article";
	}

	
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String updateForm(@RequestParam int num,
			@RequestParam String pageNo,
			HttpSession session,
			HttpServletResponse resp,
			Model model) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		Notice dto = service.readNotice(num);
		if (dto == null || ! info.getUserId().equals(dto.getUserId())) {
			resp.sendError(402);
			return "redirect:/notice/main";
		}

		List<Notice> listFile = service.listFile(num);

		model.addAttribute("mode", "update");
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("dto", dto);
		model.addAttribute("listFile", listFile);

		return "notice/write";
	}

	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateSubmit(Notice dto,
			HttpSession session) throws Exception {

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String state = "false";
		
		try {
			if (info.getMembership() > 50) {
				String root = session.getServletContext().getRealPath("/");
				String pathname = root + File.separator + "uploads" + File.separator + "notice";
	
				dto.setUserId(info.getUserId());
				service.updateNotice(dto, pathname);
				
				state = "true";
			}
		} catch (Exception e) {
		}

		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}

	
	@RequestMapping(value = "delete")
	@ResponseBody
	public Map<String, Object> delete(@RequestParam int num,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String state = "false";
		try {
			if(info.getMembership() > 50) {
				String root = session.getServletContext().getRealPath("/");
				String pathname = root + "uploads" + File.separator + "notice";
				service.deleteNotice(num, pathname);
				
				state = "true";
			}
		} catch (Exception e) {
		}

		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}

	@RequestMapping(value = "download")
	public void download(@RequestParam int fileNum,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "notice";

		boolean b = false;

		Notice dto = service.readFile(fileNum);
		if (dto != null) {
			String saveFilename = dto.getSaveFilename();
			String originalFilename = dto.getOriginalFilename();

			b = fileManager.doFileDownload(saveFilename, originalFilename, pathname, resp);
		}

		if (! b) {
			try {
				resp.setContentType("text/html; charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('파일 다운로드가 불가능 합니다 !!!');history.back();</script>");
			} catch (Exception e) {
			}
		}
	}

	@RequestMapping(value = "zipdownload")
	public void zipdownload(@RequestParam int num,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "notice";

		boolean b = false;

		List<Notice> listFile = service.listFile(num);
		if (listFile.size() > 0) {
			String[] sources = new String[listFile.size()];
			String[] originals = new String[listFile.size()];
			String zipFilename = num + ".zip";

			for (int idx = 0; idx < listFile.size(); idx++) {
				sources[idx] = pathname + File.separator + listFile.get(idx).getSaveFilename();
				originals[idx] = File.separator + listFile.get(idx).getOriginalFilename();
			}

			b = fileManager.doZipFileDownload(sources, originals, zipFilename, resp);
		}

		if (! b) {
			try {
				resp.setContentType("text/html; charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('파일 다운로드가 불가능 합니다 !!!');history.back();</script>");
			} catch (Exception e) {
			}
		}
	}

	
	@RequestMapping(value = "deleteFile", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFile(@RequestParam int fileNum, HttpSession session) throws Exception {

		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "notice";

		Notice dto = service.readFile(fileNum);
		if (dto != null) {
			fileManager.doFileDelete(dto.getSaveFilename(), pathname);
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("field", "fileNum");
		map.put("num", fileNum);
		service.deleteFile(map);

		// 작업 결과를 json으로 전송
		Map<String, Object> model = new HashMap<>();
		model.put("state", "true");
		return model;
	}
}
