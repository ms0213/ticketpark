package com.sp.tp.article;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.tp.common.FileManager;
import com.sp.tp.common.MyUtil;
import com.sp.tp.member.SessionInfo;

@Controller("article.articleController")
@RequestMapping("/article/*")
public class ArticleController {
	@Autowired
	private ArticleService service;
	@Autowired
	private MyUtil myUtil;
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value = "list")
	public String list(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			HttpSession session,
			Model model
			) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String cp = req.getContextPath();
		
		int rows = 10;
		int total_page;
		int dataCount;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("admin", info.getUserId());
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount = service.dataCount(map);
		total_page = myUtil.pageCount(rows, dataCount);
		
		if(total_page < current_page) {
			current_page = total_page;
		}
		
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
		
		List<Article> list = service.listArticle(map);
		
		String query = "";
		String listUrl = cp + "/article/list";
		String articleUrl = cp + "/article/article?page=" + current_page;
		if(keyword.length() != 0) {
			query = "condition="+condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
		}
		
		if(query.length() != 0) {
			listUrl = cp + "/article/list?"+query;
			articleUrl = cp + "/article/article?page=" + current_page + "&" +query;
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
		
		return ".article.list";
	}
	
	@RequestMapping(value = "write", method = RequestMethod.GET)
	public String writeForm(Model model, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if(info.getMembership()<51) {
	         return "redirect:/article/list";
	      }
		
		model.addAttribute("mode", "write");
		
		return ".article.write";
	}
	
	@RequestMapping(value = "write", method = RequestMethod.POST)
	public String writeSubmit(Article dto, HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String path = root + "uploads" + File.separator + "article";
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		try {
			dto.setAdmin(info.getUserId());
			service.insertArticle(dto, path);
		} catch (Exception e) {
		}
		
		return "redirect:/article/list";
	}
	
	@RequestMapping(value = "article")
	public String article(
			@RequestParam int num,
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
		service.updateHitCount(num);

		Article dto = service.readArticle(num);
		if(dto == null) {
			return "redirect:/article/list?" + query;
		}

		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		
		List<Article> listFile = service.listFile(num);
		
		model.addAttribute("dto", dto);
		model.addAttribute("listFile", listFile);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
		return ".article.article";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String updateForm(
			@RequestParam int num,
			@RequestParam String page,
			HttpSession session,
			Model model
			) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		Article dto = service.readArticle(num);
		if(dto == null) {
			return "redirect:/article/list?page=" + page;
		}
		if( ! dto.getAdmin().equals(info.getUserId())) {
			return "redirect:/";
		}
		if(info.getMembership()<51) {
	         return "redirect:/article/list";
	      }
		
		List<Article> listFile = service.listFile(num);
		
		model.addAttribute("dto", dto);
		model.addAttribute("listFile", listFile);
		model.addAttribute("page", page);
		model.addAttribute("mode", "update");
		
		return ".article.write";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String updateSubmit(Article dto,
			@RequestParam String page,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "article";

		try {
			service.updateArticle(dto, pathname);
		} catch (Exception e) {
		}

		return "redirect:/article/article?num=" + dto.getArtiNum() + "&page=" + page;
	}

	@RequestMapping(value = "delete", method = RequestMethod.GET)
	public String delete(@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		keyword = URLDecoder.decode(keyword, "utf-8");
		String query = "page=" + page;
		if (keyword.length() != 0) {
			query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
		}
		
		Article dto = service.readArticle(num);
		if (dto == null) {
			return "redirect:/article/list?page=" + page;
		}

		if (!dto.getAdmin().equals(info.getUserId())) {
			return "redirect:/";
		}
		
		

		try {
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + "uploads" + File.separator + "article";
			service.deleteArticle(num, pathname, info.getUserId(), info.getMembership());
		} catch (Exception e) {
		}

		return "redirect:/article/list?" + query;
	}

	@RequestMapping(value = "deleteFile", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFile(@RequestParam int fileNum, HttpSession session) throws Exception {

		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "article";

		Article dto = service.readFile(fileNum);
		if (dto != null) {
			fileManager.doFileDelete(dto.getSaveFilename(), pathname);
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("field", "fileNum");
		map.put("fileNum", fileNum);
		service.deleteFile(map);

		// 작업 결과를 json으로 전송
		Map<String, Object> model = new HashMap<>();
		model.put("state", "true");
		return model;
	}
	
	// 댓글 리스트 : AJAX-TEXT
		@RequestMapping(value = "listReply", method = RequestMethod.GET)
		public String listReply(
				@RequestParam int num, 
				@RequestParam(value = "pageNo", defaultValue = "1") int current_page,
				Model model
				) throws Exception {

			int rows = 5;
			int total_page;
			int dataCount;

			Map<String, Object> map = new HashMap<>();
			map.put("artiNum", num);

			dataCount = service.replyCount(map);
			total_page = myUtil.pageCount(rows, dataCount);
			if (current_page > total_page) {
				current_page = total_page;
			}

			int start = (current_page - 1) * rows + 1;
			int end = current_page * rows;
			map.put("start", start);
			map.put("end", end);
			
			List<ArticleReply> listReply = service.listReply(map);

			for (ArticleReply dto : listReply) {
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			}

			// AJAX 용 페이징
			String paging = myUtil.pagingMethod(current_page, total_page, "listPage");

			// 포워딩할 jsp로 넘길 데이터
			model.addAttribute("listReply", listReply);
			model.addAttribute("pageNo", current_page);
			model.addAttribute("replyCount", dataCount);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);

			return "article/listReply";
		}

		// 댓글 및 댓글의 답글 등록 : AJAX-JSON
		@RequestMapping(value = "insertReply", method = RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> insertReply(
				ArticleReply dto, 
				HttpSession session) {
			
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			String state = "true";

			try {
				dto.setUserId(info.getUserId());
				service.insertReply(dto);
			} catch (Exception e) {
				state = "false";
			}

			Map<String, Object> model = new HashMap<>();
			model.put("state", state);
			return model;
		}

		// 댓글 및 댓글의 답글 삭제 : AJAX-JSON
		@RequestMapping(value = "deleteReply", method = RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> deleteReply(
				@RequestParam Map<String, Object> paramMap) {
			
			String state = "true";
			
			try {
				service.deleteReply(paramMap);
			} catch (Exception e) {
				state = "false";
			}

			Map<String, Object> map = new HashMap<>();
			map.put("state", state);
			return map;
		}

		// 댓글의 답글 리스트 : AJAX-TEXT
		@RequestMapping(value = "listReplyAnswer")
		public String listReplyAnswer(
				@RequestParam int answer, 
				Model model
				) throws Exception {
			
			List<ArticleReply> listReplyAnswer = service.listReplyAnswer(answer);
			
			for (ArticleReply dto : listReplyAnswer) {
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			}

			model.addAttribute("listReplyAnswer", listReplyAnswer);
			return "article/listReplyAnswer";
		}

		// 댓글의 답글 개수 : AJAX-JSON
		@RequestMapping(value = "countReplyAnswer")
		@ResponseBody
		public Map<String, Object> countReplyAnswer(
				@RequestParam(value = "answer") int answer
				) {
			
			int count = service.replyAnswerCount(answer);

			Map<String, Object> model = new HashMap<>();
			model.put("count", count);
			return model;
		}
	
		// 게시글 좋아요 추가/삭제 : AJAX-JSON
		@RequestMapping(value = "insertArticleLike", method = RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> insertArticleLike(@RequestParam int artiNum, 
				@RequestParam boolean userLiked,
				HttpSession session) {
			String state = "true";
			int articleLikeCount = 0;
			SessionInfo info = (SessionInfo) session.getAttribute("member");

			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("artiNum", artiNum);
			paramMap.put("userId", info.getUserId());

			try {
				if(userLiked) {
					service.deleteArticleLike(paramMap);
				} else {
					service.insertArticleLike(paramMap);
				}
			} catch (DuplicateKeyException e) {
				state = "liked";
			} catch (Exception e) {
				state = "false";
			}

			articleLikeCount = service.articleLikeCount(artiNum);

			Map<String, Object> model = new HashMap<>();
			model.put("state", state);
			model.put("articleLikeCount", articleLikeCount);

			return model;
		}
}
