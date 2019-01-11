package com.final2.petopia.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.final2.petopia.service.InterReservationService;

@Controller
public class ReservationController {
	
	@Autowired
	private InterReservationService service;
	
	@RequestMapping(value="/reservation.pet", method= {RequestMethod.GET})
	public String index(HttpServletRequest req) {
		
		String idx = req.getParameter("idx");
		
		
/*		String biz_idx = req.getParameter("biz_idx");
		List<HashMap<String, String>> bizScheduleList = service.selectBizScheduleByBiz_idx(biz_idx);
		
		req.setAttribute("bizScheduleList", bizScheduleList);
*/
		return "reservation/reservation.tiles2";
	}
}
