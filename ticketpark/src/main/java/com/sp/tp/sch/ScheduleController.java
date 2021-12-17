package com.sp.tp.sch;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sp.tp.member.SessionInfo;

@Controller("sch.scheduleController")
@RequestMapping("/schedule/*")
public class ScheduleController {
	@Autowired
	private ScheduleService service;
	
	@RequestMapping(value = "main")
	public ModelAndView main(
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", info.getUserId());
		List<Schedule> listCategory = service.listCategory(map);
		
		ModelAndView mav = new ModelAndView(".sch.main");
		mav.addObject("listCategory", listCategory);
		return mav;
	}
	
	@RequestMapping(value = "write", method = RequestMethod.GET)
	public String writeForm(@ModelAttribute(value = "dto") Schedule dto,
			HttpSession session,
			Model model) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", info.getUserId());
		List<Schedule> listCategory = service.listCategory(map);
		
		model.addAttribute("mode", "write");
		model.addAttribute("listCategory", listCategory);
		
		return ".sch.write";
	}
	
	@RequestMapping(value = "write", method = RequestMethod.POST)
	public String writeSubmit(Schedule dto,
			HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			if(dto.getCategoryNum() == 0) {
				dto.setCategoryNum(null);
			}
			
			dto.setUserId(info.getUserId());
			service.insertSchedule(dto);
		} catch (Exception e) {
		}
		
		return "redirect:/schedule/main";
	}
	
	
	@RequestMapping(value="month")
	@ResponseBody
	public Map<String, Object> month (
			@RequestParam String start,
			@RequestParam String end,
			@RequestParam(required = false) List<Integer> categorys,
			HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("categoryList", categorys);
		map.put("start", start);
		map.put("end", end);
		map.put("userId", info.getUserId());
		
		List<Schedule> list=service.listMonth(map);
		for(Schedule dto:list) {
	    	if(dto.getStime()==null) {
	    		dto.setAllDay(true);
	    	} else {
	    		dto.setAllDay(false);
	    	}
	    	
	    	if(dto.getStime()!=null && dto.getStime().length()!=0) {
	    		
	    		dto.setStart(dto.getSday()+"T" + dto.getStime());
	    	} else {
	    		dto.setStart(dto.getSday());
	    	}
	    	
	    	if(dto.getEtime()!=null && dto.getEtime().length()!=0) {
	    		dto.setEnd(dto.getEday()+"T" + dto.getEtime());
	    	} else {
	    		dto.setEnd(dto.getEday());
	    	}
	    	
	    	if(dto.getRepeat()!=0) { 
	    		if( dto.getStart().substring(0,4).compareTo(start.substring(0,4)) != 0 ) {
	    			dto.setStart(start.substring(0,4)+dto.getStart().substring(5));
	    		}
	    	}	    	
		}
		
		Map<String, Object> model=new HashMap<>();
		model.put("list", list);
		return model;
	}
	
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String updateForm(@RequestParam int num,
			HttpSession session,
			Model model) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		Schedule dto = service.readSchedule(num);
		if(dto == null) {
			return "redirect:/schedule/main";
		}
		
		if(dto.getStime() == null) {
			dto.setAll_day("1");
			try {
				String s = dto.getEday().replaceAll("\\-|\\.|/", "");

				int y = Integer.parseInt(s.substring(0, 4));
				int m = Integer.parseInt(s.substring(4, 6));
				int d = Integer.parseInt(s.substring(6));

				Calendar cal = Calendar.getInstance();
				cal.set(y, m - 1, d);

				cal.add(Calendar.DATE, -1);

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				dto.setEday( sdf.format(cal.getTime()) );
			} catch (Exception e) {
			}
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", info.getUserId());
		List<Schedule> listCategory = service.listCategory(map);
		
		model.addAttribute("mode", "update");
		model.addAttribute("dto", dto);
		model.addAttribute("listCategory", listCategory);
		
		return ".sch.write";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String updateSubmit(Schedule dto,
			HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			if(dto.getCategoryNum() == 0) {
				dto.setCategoryNum(null);
			}
			
			dto.setUserId(info.getUserId());
			service.updateSchedule(dto);
		} catch (Exception e) {
		}
		
		return "redirect:/schedule/main";
	}


	@RequestMapping(value = "updateDrag", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateDragSubmit(Schedule dto, HttpSession session) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String state = "true";
		try {
			dto.setUserId(info.getUserId());
			if(dto.getCategoryNum() == 0) {
				dto.setCategoryNum(null);
			}
			
			
			if(dto.getRepeat() == 1 && dto.getRepeat_cycle() != 0) {
				dto.setEday("");
				dto.setStime("");
				dto.setEtime("");
			}
			
			service.updateSchedule(dto);
		} catch (Exception e) {
			state = "false";
		}

		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	

	@RequestMapping(value = "delete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(
			@RequestParam int num,
			HttpSession session
			) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");

		String state = "true";
		try {
			Map<String, Object> map=new HashMap<>();
			map.put("userId", info.getUserId());
			map.put("num", num);
			service.deleteSchedule(map);
		}catch (Exception e) {
			state = "false";
		}
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state", state);
		
		return model;
	}
	

	@RequestMapping(value = "categoryAdd", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> categoryAdd(@RequestParam Map<String, Object> paramMap,
				HttpSession session) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String state = "true";
		List<Schedule> listCategory = null;
		try {
			paramMap.put("userId", info.getUserId());
			service.insertCategory(paramMap);
			
			listCategory = service.listCategory(paramMap);
			
		} catch (Exception e) {
			state = "false";
		}

		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		model.put("listCategory", listCategory);
		return model;
	}
	

	@RequestMapping(value = "categorydelete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> categorydelete(@RequestParam Map<String, Object> paramMap,
				HttpSession session) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String state = "true";
		try {
			paramMap.put("userId", info.getUserId());
			service.deleteCategory(paramMap);
		} catch (Exception e) {
			state = "false";
		}

		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
}
