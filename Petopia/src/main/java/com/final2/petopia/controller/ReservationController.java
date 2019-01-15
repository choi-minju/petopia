package com.final2.petopia.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.forwardedUrl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.final2.petopia.model.ScheduleVO;
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
	
	@RequestMapping(value="/selectScheduleList.pet", method= {RequestMethod.GET})
	@ResponseBody
	public List<HashMap<String, String>> selectScheduleList(HttpServletRequest req) {
//		***JSONObject를 대체할 HashMap객체 생성
		List<HashMap<String, String>> returnMapList = new ArrayList<HashMap<String, String>>();
		
//		1) 뷰에서 보낸 파라미터값 가져오기
		String idx_biz = req.getParameter("idx_biz");
		
//		3) 부모글번호에 해당하는 댓글 갯수 가져오기 
		List<ScheduleVO> scheduleList = service.selectScheduleListByIdx_biz(idx_biz);
		
		for(ScheduleVO svo : scheduleList) {
			HashMap<String, String> returnMap = new HashMap<String, String>();
			
//			returnMap.put("title", svo.getSchedule_DATE().substring(svo.getSchedule_DATE().indexOf(" "))+"("+svo.getShowSchedule_status()+")");
			returnMap.put("title", svo.getShowSchedule_status());
			returnMap.put("start", svo.getSchedule_DATE());
			returnMap.put("end", svo.getEndtime());
			returnMap.put("schedule_status", Integer.toString(svo.getSchedule_status()));
			
			returnMapList.add(returnMap);
		}
		
		return returnMapList;
	}
}
