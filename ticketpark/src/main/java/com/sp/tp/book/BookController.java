package com.sp.tp.book;



import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.tp.member.Member;
import com.sp.tp.member.SessionInfo;

@Controller("book.bookController")
@RequestMapping("/book/*")
public class BookController {
	@Autowired
	private BookService service;
	
	@RequestMapping(value = "seatchoice", method = RequestMethod.GET)
	public String seatChoice(
			Model model) {
		int tNum = 7;
		Book dto = service.listTheater2(tNum);

		dto.setArrSeat(dto.getSeats().split(","));
		String []seats = dto.getArrSeat();
		int rows = dto.getRows();
		int cols = dto.getCols();
		int generalSeat = dto.getGeneralSeat();
		int vipSeat = dto.getVipSeat();
		
		int width = cols * 25 + cols * 2 + 25;
		int height = rows * 25 + rows * 2;
		
		String []reservedSeat = {};
		
		model.addAttribute("cinemaCode", tNum);
		
		model.addAttribute("rows", rows);
		model.addAttribute("cols", cols);
		
		model.addAttribute("width", width);
		model.addAttribute("height", height);
		
		model.addAttribute("generalSeat", generalSeat);
		model.addAttribute("vipSeat", vipSeat);
		
		model.addAttribute("seats", seats);
		model.addAttribute("reservedSeat", reservedSeat);
		
		return ".book.seatchoice";
	}
	
	@RequestMapping(value = "seatchoice", method = RequestMethod.POST)
	public String seatChoiceOk(	
			Book dto,
			HttpSession session) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
	
		int sdNum = 49;
		int seat_price = 30000;
		
		dto.setUserId(info.getUserId());
		dto.setSdNum(sdNum);
		dto.setSeat_price(seat_price);
		try {
			service.insertBook(dto);			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/book/identification";
	}
	
	@RequestMapping(value = "complete")
	public String complete(@ModelAttribute("message") String message) {
		
		if(message == null || message.length() == 0)
			return "redirect:/";
		
		return ".book.complete";
	}
	
	@RequestMapping(value = "identification", method = RequestMethod.GET)
	public String identification(
			HttpSession session,
			Model model) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		Member dto = new Member();
		try {
			dto = service.readMember(info.getUserId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("userName", dto.getUserName());
		model.addAttribute("tel", dto.getTel());
		model.addAttribute("email", dto.getEmail());
		model.addAttribute("birth", dto.getBirth());
		
		return ".book.identification";
	}
	
	@RequestMapping(value = "identification", method = RequestMethod.POST)
	public String identificationOk() {
		return "redirect:/book/payment";
	}
	
	@RequestMapping(value = "bookCancel")
	public String bookCancel(
			HttpSession session
			) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		Book dto = new Book();
		try {
			dto = service.readBook(info.getUserId());
			service.deleteBook2(dto.getbNum());
			service.deleteBook(dto.getbNum());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/";
	}
	
	@RequestMapping(value = "payment", method = RequestMethod.GET)
	public String payment(
			HttpSession session,
			Model model) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		Member dto = new Member();
		Book vo = new Book();
		try {
			dto = service.readMember(info.getUserId());
			vo = service.readBook(info.getUserId());
			vo = service.readPay(vo.getbNum());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("userName", dto.getUserName());
		model.addAttribute("tel", dto.getTel());
		model.addAttribute("email", dto.getEmail());
		model.addAttribute("addr", dto.getAddr1()+dto.getAddr2());
		model.addAttribute("amount", vo.getAmount());
		model.addAttribute("name", vo.getSubject());
		return ".book.payment";
	}
	
	@RequestMapping(value = "payment", method = RequestMethod.POST)
	public String paymentOk(
			final RedirectAttributes reAttr,
			HttpSession session,
			Model model) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		try {
			
		} catch (Exception e) {
			try {
				Book dto = new Book();
				dto = service.readBook(info.getUserId());
				service.deleteBook2(dto.getbNum());
				service.deleteBook(dto.getbNum());
				reAttr.addFlashAttribute("message", "결제에 실패하였습니다.");
				return "redirect:/book/complete";				
			} catch (Exception e2) {				
			}
		}
		/*
		String ss = "";
		int n;
		for(String s : arrSeat) {
			n = Integer.parseInt(s.substring(4));	
			ss += s.substring(0, 3) +"("+(n==1?"일반석":"vip석")+") ";
		}
		StringBuilder sb = new StringBuilder();
		sb.append("예매가 성공적으로 처리되었습니다.<br>");
		sb.append("예매하신 상영관 정보는 ");
		sb.append(hName + tName);
		sb.append(" 입니다.<br>");
		sb.append("선택하신 좌석 번호는");
		sb.append(ss);
		sb.append("입니다.<br>");
		
		reAttr.addFlashAttribute("message", sb.toString());
		reAttr.addFlashAttribute("title", "예매 정보");
		*/
		return "redirect:/book/complete";
	}
	
}
