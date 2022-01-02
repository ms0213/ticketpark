package com.sp.tp.rank;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("rank.rankController")
@RequestMapping("/rank/*")
public class RankController {
	
	@Autowired
	private RankService service;
	
	@RequestMapping(value = "rank")
	public String rankList(Model model, HttpServletRequest req) throws Exception {
		
		String cp = req.getContextPath();
		
		List<Rank> bookRank = service.bookRank();
		List<Rank> ratingRank = service.ratingRank();
		
		String articleUrl = cp + "/performance/article?page="+ 1;
		
		
		model.addAttribute("bookRank", bookRank);
		model.addAttribute("ratingRank", ratingRank);
		model.addAttribute("articleUrl", articleUrl);
		
		return ".rank.rank";
	}
}
