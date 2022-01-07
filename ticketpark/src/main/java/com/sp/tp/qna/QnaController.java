package com.sp.tp.qna;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.tp.member.SessionInfo;
import com.sp.tp.common.MyUtil;

@Controller("qna.expectController")
@RequestMapping("/performance/qna/*")
public class QnaController {
	@Autowired
	private QnaService service;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value = "qna")
	public String replyList(int perfNum, Model model) throws Exception {
		model.addAttribute("perfNum", perfNum);
		
		return "performance/qna/qna";
	}
	
	// 댓글 리스트 : AJAX-TEXT
	@RequestMapping(value = "listReply")
	public String listReply (@RequestParam(value = "pageNo", defaultValue = "1") int current_page
			, int perfNum, Model model
			) throws Exception {

		int rows = 5;
		int total_page = 0;
		int dataCount = 0;
		
		Map<String, Object> map = new HashMap<>();
		map.put("perfNum", perfNum);
		
		dataCount = service.replyCount(map);
		total_page = myUtil.pageCount(rows, dataCount);
		
		if (current_page > total_page) {
			current_page = total_page;
		}

		
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
	
		
		List<Reply> listReply = service.listReply(map);
		
		for (Reply dto : listReply) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("listReply", listReply);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("replyCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);

		return "performance/qna/listReply";

		}
	
		// 댓글 및 댓글의 답글 등록 : AJAX-JSON
		@RequestMapping(value = "insertReply", method = RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> insertReply(Reply dto, HttpSession session) {
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
		public Map<String, Object> deleteReply(@RequestParam Map<String, Object> paramMap) {
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
		public String listReplyAnswer(@RequestParam int answer, Model model) throws Exception {
			List<Reply> listReplyAnswer = service.listReplyAnswer(answer);
			
			for (Reply dto : listReplyAnswer) {
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			}

			model.addAttribute("listReplyAnswer", listReplyAnswer);
			return "performance/qna/listReplyAnswer";
		}

		// 댓글의 답글 개수 : AJAX-JSON
		@RequestMapping(value = "countReplyAnswer")
		@ResponseBody
		public Map<String, Object> countReplyAnswer(@RequestParam(value = "answer") int answer) {
			int count = service.replyAnswerCount(answer);

			Map<String, Object> model = new HashMap<>();
			model.put("count", count);
			return model;
		}

		// 댓글의 좋아요/싫어요 추가 : AJAX-JSON
		@RequestMapping(value = "insertReplyLike", method = RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> insertReplyLike(@RequestParam Map<String, Object> paramMap, 
				
				HttpSession session) {
			String state = "true";

			SessionInfo info = (SessionInfo) session.getAttribute("member");
			Map<String, Object> model = new HashMap<>();

			try {
				paramMap.put("userId", info.getUserId());
				service.insertReplyLike(paramMap);
			} catch (DuplicateKeyException e) {
				state = "liked";
			} catch (Exception e) {
				state = "false";
			}

			Map<String, Object> countMap = service.replyLikeCount(paramMap);

		
			int likeCount = ((BigDecimal) countMap.get("LIKECOUNT")).intValue();
			int disLikeCount = ((BigDecimal)countMap.get("DISLIKECOUNT")).intValue();
			
			model.put("likeCount", likeCount);
			model.put("disLikeCount", disLikeCount);
			model.put("state", state);
			return model;
		}
		
		// 댓글의 좋아요/싫어요 개수 : AJAX-JSON
		@RequestMapping(value = "countReplyLike", method = RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> countReplyLike(@RequestParam Map<String, Object> paramMap,
				HttpSession session) {

			Map<String, Object> countMap = service.replyLikeCount(paramMap);
		
			int likeCount = ((BigDecimal) countMap.get("LIKECOUNT")).intValue();
			int disLikeCount = ((BigDecimal)countMap.get("DISLIKECOUNT")).intValue();
			
			Map<String, Object> model = new HashMap<>();
			model.put("likeCount", likeCount);
			model.put("disLikeCount", disLikeCount);

			return model;
		}
	}
