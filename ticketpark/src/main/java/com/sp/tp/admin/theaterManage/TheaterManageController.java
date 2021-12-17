package com.sp.tp.admin.theaterManage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller("admin.theaterManage.theaterManageController")
@RequestMapping("/admin/theaterManage/*")
public class TheaterManageController {
	@Autowired
	private TheaterService service;
	
	@RequestMapping(value = "main")
	public String main(Model model) throws Exception {
		List<Theater> listHallNo = service.listHallNo();
		
		model.addAttribute("listHallNo", listHallNo);
		
		return ".admin.theaterManage.main";
	}
	
	@RequestMapping(value = "list")
	public String list(
			HttpServletRequest req,
			@RequestParam int hallNo,
			Model model) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("hallNo", hallNo);
		List<Theater> list = service.listTheater(map);
		
		model.addAttribute("list", list);
		
		return "admin/theaterManage/list";
	}
	
	@RequestMapping(value = "write", method = RequestMethod.GET)
	public String writeForm(
			@RequestParam int hallNo,
			Model model) throws Exception {
		int rows = 15;
		int cols = 29;
		
		int generalSeat = rows * cols; // 일반석
		int vipSeat = 0; // vip석
		
		int width = cols * 30;
		int height = rows * 30;
		
		model.addAttribute("hallNo", hallNo);

		model.addAttribute("rows", rows);
		model.addAttribute("cols", cols);
		
		model.addAttribute("generalSeat", generalSeat);
		model.addAttribute("vipSeat", vipSeat);
		
		model.addAttribute("width", width);
		model.addAttribute("height", height);
		
		model.addAttribute("mode", "write");
		return ".admin.theaterManage.write";
	}
	
	@RequestMapping(value = "write", method = RequestMethod.POST)
	public String writeSubmit(
			Theater dto,
			final RedirectAttributes reAttr,
			Model model
			) throws Exception {
		try {
			service.insertTheater(dto);
		} catch (DataIntegrityViolationException e) {
			// 데이터형식 오류, 참조키, NOT NULL 등의 제약조건 위반
			model.addAttribute("mode", "write");
			model.addAttribute("message", "제약 조건 위반으로 상영관 좌석 등록이 실패했습니다.");
			return ".admin.theaterManage.write";
		} catch (Exception e) {
			model.addAttribute("mode", "write");
			model.addAttribute("message", "상영관 좌석 등록이 실패했습니다.");
			return ".admin.theaterManage.write";
		}

		StringBuilder sb = new StringBuilder();
		sb.append("상영관 좌석이 성공적으로 등록되었습니다.<br>");
		sb.append("상영관 관리 메뉴에서 확인해보시기 바랍니다.<br>");

		// 리다이렉트된 페이지에 값 넘기기
		reAttr.addFlashAttribute("message", sb.toString());
		reAttr.addFlashAttribute("title", "상영관 등록");
		
		return "redirect:/admin/theaterManage/complete";
	}
	
	@RequestMapping(value = "complete")
	public String complete(@ModelAttribute("message") String message) throws Exception {
		// 컴플릿 페이지(complete.jsp)의 출력되는 message와 title는 RedirectAttributes 값이다.
		// F5를 눌러 새로 고침을 하면 null이 된다.

		if (message == null || message.length() == 0) // F5를 누른 경우
			return "redirect:/";

		return ".admin.theaterManage.complete";
	}
	
	@RequestMapping(value = "article")
	public String article() throws Exception {
		
		return ".admin.theaterManage.article";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String updateForm() throws Exception {
		
		return ".admin.theaterManage.write";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String updateSubmit() throws Exception {
		
		return "redirect:/admin/theaterManage/list";
	}
	
	@RequestMapping(value = "delete")
	public String delete(
			@RequestParam int tNum
			) throws Exception {
		try {
			service.deleteTheater(tNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/admin/theaterManage/list";
	}
	
	@RequestMapping(value = "insertFile")
	public String insertTheaterFile(
			@RequestParam int hallNo,
			@RequestParam String saveFilename,
			final RedirectAttributes reAttr,
			Model model) throws Exception {
			
			Map<String, Object> map = new HashMap<String, Object>();
		try {
			map.put("saveFilename", saveFilename);
			map.put("hallNo", hallNo);
			service.insertTheaterFile(map);
		} catch (Exception e) {
			model.addAttribute("message", "상영관 사진파일 등록에 실패했습니다.");
			return ".admin.theaterManage.main";
		}
		
		StringBuilder sb = new StringBuilder();
		sb.append("상영관 사진이 성공적으로 등록되었습니다.<br>");
		sb.append("상영관 관리 메뉴에서 확인해보시기 바랍니다.<br>");

		// 리다이렉트된 페이지에 값 넘기기
		reAttr.addFlashAttribute("message", sb.toString());
		reAttr.addFlashAttribute("title", "상영관 사진 등록");
		
		return "redirect:/admin/theaterManage/complete";
	}
}
