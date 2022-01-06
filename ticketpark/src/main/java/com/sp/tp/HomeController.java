package com.sp.tp;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.tp.article.Article;
import com.sp.tp.article.ArticleService;
import com.sp.tp.performance.Performance;
import com.sp.tp.performance.PerformanceService;
import com.sp.tp.rank.Rank;
import com.sp.tp.rank.RankService;
import com.sp.tp.review.Review;
import com.sp.tp.review.ReviewService;
import com.sp.tp.video.Video;
import com.sp.tp.video.VideoService;

@Controller
public class HomeController {
	@Autowired
	private PerformanceService performanceService;
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private ArticleService articleService;
	
	@Autowired
	private VideoService videoService;
	
	@Autowired
	private RankService rankService;
	
	@RequestMapping(value = "/")
	public String home(Locale locale, Model model) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("start", 1);
		map.put("end", 10);
		
		List<Performance> listPerformance = performanceService.listPerformance(map);
		
		List<Review> listReview = reviewService.bestReview(); 
		
		Map<String, Object> mop = new HashMap<String, Object>();
		mop.put("start", 1);
		mop.put("end", 4);
		
		List<Article> listArticle = articleService.listArticle(mop);
		
		Map<String, Object> mip = new HashMap<String, Object>();
		mip.put("start", 1);
		mip.put("end", 1);
		
		List<Video> listVideo = videoService.listVideo(mip);
		
		List<Rank> bookRank = rankService.bookRank();
		List<Rank> ratingRank = rankService.ratingRank();
		
		model.addAttribute("bookRank", bookRank);
		model.addAttribute("ratingRank", ratingRank);
		model.addAttribute("listVideo", listVideo);
		model.addAttribute("listArticle", listArticle);
		model.addAttribute("listReview", listReview);
		model.addAttribute("listPerformance", listPerformance);
	
		return ".home";
	}
	
	// 장르리스트 : AJAX-JSON 전송
	@RequestMapping(value = "listGenreMain")
	@ResponseBody
	public Map<String, Object> listGenreMain() throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<Performance> listGenreMain = performanceService.listGenreMain(map);
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("listGenreMain", listGenreMain);

		return model;
	}
	
}
