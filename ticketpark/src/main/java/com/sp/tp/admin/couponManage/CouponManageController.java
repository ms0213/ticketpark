package com.sp.tp.admin.couponManage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;





@Controller("admin.couponManage.couponManageController")
@RequestMapping("/admin/couponManage/*")
public class CouponManageController {
	@Autowired
	private CouponManageService service;
	
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String couponList(
			Model model) throws Exception {
		
		List<Coupon> list = service.listCoupon();		
		
		model.addAttribute("list", list);
		
		return ".admin.couponManage.list";
	}
	
	@RequestMapping(value="detaile")
	public String detaileMember(
			Model model) throws Exception {
		
		List<Coupon> list = service.listCoupon();
		
		model.addAttribute("list", list);
		return "admin/couponManage/detaile";
	}
	
	@RequestMapping(value = "write", method = RequestMethod.GET)
	public String writeForm(Model model) throws Exception {
		
		model.addAttribute("mode", "write");
		
		return ".admin.couponManage.write";
	}
	
	@RequestMapping(value = "write", method = RequestMethod.POST)
	public String submitForm(Coupon dto) throws Exception {
	
		try {
			service.insertCoupon(dto);
		} catch (Exception e) {
		}
		
		return "redirect:/admin/couponManage/list";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String updateForm(@RequestParam String couponNum,
			Model model
			) throws Exception{
		Coupon dto = service.readCoupon(couponNum);
		
		model.addAttribute("mode", "update");
		model.addAttribute("dto", dto);
		
		return ".admin.couponManage.write";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String updateSubmit(Coupon dto) throws Exception{

		try {
			service.updateCoupon(dto);
		} catch (Exception e) {
		}
		
		return "redirect:/admin/couponManage/list?";
	}
	
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteVideo(
			@RequestParam String couponNum
			) throws Exception {
		String state = "false";
		try {
			service.deleteCoupon(couponNum);
			state = "true";
		} catch (Exception e) {
		}
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value = "listModal", method = RequestMethod.GET)
	public String listModal(Model model) throws Exception {
		
		List<Coupon> list = service.listCoupon();
		model.addAttribute("list", list);
		return "video/listModal";
	}
	
}
