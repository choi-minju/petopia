package com.final2.petopia.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.final2.petopia.model.Biz_MemberVO;
import com.final2.petopia.model.ScheduleVO;
import com.final2.petopia.service.InterReservationService;

@Controller
public class ReservationController {
	
	@Autowired
	private InterReservationService service;
	
	@RequestMapping(value="/reservation.pet", method= {RequestMethod.GET})
	public String index(HttpServletRequest req) {
		
		String idx_biz = req.getParameter("idx_biz");
		
		idx_biz="5";
		
		
		Biz_MemberVO bizmvo = service.selectBizMemberVOByIdx_biz(idx_biz);
		
		req.setAttribute("bizmvo", bizmvo);

		return "reservation/reservation.tiles2";
	}
	
	@RequestMapping(value="/selectScheduleList.pet", method= {RequestMethod.GET})
	@ResponseBody
	public List<HashMap<String, String>> selectScheduleList(HttpServletRequest req) {
		List<HashMap<String, String>> returnMapList = new ArrayList<HashMap<String, String>>();
		
		String idx_biz = req.getParameter("idx_biz");
		
		List<ScheduleVO> scheduleList = service.selectScheduleListByIdx_biz(idx_biz);
		
		for(ScheduleVO svo : scheduleList) {
			HashMap<String, String> returnMap = new HashMap<String, String>();
			
//			returnMap.put("title", svo.getSchedule_DATE().substring(svo.getSchedule_DATE().indexOf(" "))+"("+svo.getShowSchedule_status()+")");
			returnMap.put("title", svo.getShowSchedule_status());
			returnMap.put("start", svo.getSchedule_DATE());
			returnMap.put("end", svo.getEndtime());
			returnMap.put("schedule_status", Integer.toString(svo.getSchedule_status()));
			returnMap.put("schedule_UID", Integer.toString(svo.getSchedule_UID()));
			returnMapList.add(returnMap);
		}
		
		return returnMapList;
	}
}
