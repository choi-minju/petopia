package com.final2.petopia.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.final2.petopia.model.MemberVO;
import com.final2.petopia.service.InterReviewService;

@Controller
public class ReviewController {

	// === 2019.01.28 ==== //
	@Autowired
	private InterReviewService service;
	
	@RequestMapping(value="/myReviewList.pet", method={RequestMethod.GET})
	public String requireLogin_myReviewList(HttpServletRequest req, HttpServletResponse res) {
		return "review/myReviewList.tiles2";
	} // end of public String requireLogin_myReviewList(HttpServletRequest req, HttpServletRequest res)
	
	
	@RequestMapping(value="/selectMyReviewList.pet", method={RequestMethod.GET})
	@ResponseBody
	public List<HashMap<String, String>> selectMyReviewList(HttpServletRequest req) {
		
		List<HashMap<String, String>> hosList = new ArrayList<HashMap<String, String>>();
		
		String str_start = req.getParameter("start");
		String str_len = req.getParameter("len");
		String str_period = req.getParameter("period");
		
		int period = 0;
		try {
			period = Integer.parseInt(str_period);
		} catch(NumberFormatException e) {
			period = 0;
		}
		
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		HashMap<String, Integer> paramap = new HashMap<String, Integer>();
		paramap.put("PERIOD", period);
		paramap.put("IDX", loginuser.getIdx());
		
		int start = 0;
		if(str_start == null || "".equals(str_start)) {
			str_start = "1";
		}
		
		int len = 0;
		if(str_len == null || "".equals(str_len)) {
			str_len = "4";
		}
		
		try {
			start = Integer.parseInt(str_start);
			
		} catch(NumberFormatException e) {
			start = 1;
		} // try~catch
		
		try {
			len = Integer.parseInt(str_len);
			
		} catch(NumberFormatException e) {
			len = 1;
		} // try~catch
		
		int end = start+len;
		
		paramap.put("START", start);
		paramap.put("END", end);
		
		if(period == 0) {
			// 기간이 전체인 경우
			hosList = service.selectHosList(paramap);
		} else {
			// 기간이 정해진 경우
			hosList = service.selectHosListByPeriod(paramap);
		} // end of if~else
		
		return hosList;
	} // end of 
	// === 2019.01.28 ==== //
	
	// === 2019.01.29 ==== //
	@RequestMapping(value="/addReview.pet", method={RequestMethod.POST})
	public String requireLogin_addReview(HttpServletRequest req, HttpServletResponse res) {
		
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String startpoint = req.getParameter("startpoint");
		String fk_reservation_UID = req.getParameter("fk_reservation_UID");
		String rv_contents = req.getParameter("rv_contents");
		
		if(startpoint == null || "".equals(startpoint)) {
			startpoint = "0";
		}
		
		/*System.out.println("startpoint: "+startpoint);
		System.out.println("fk_reservation_UID: "+fk_reservation_UID);
		System.out.println("rv_contents: "+rv_contents);*/
		
		HashMap<String, String> reviewMap = new HashMap<String, String>();
		reviewMap.put("FK_IDX", String.valueOf(loginuser.getIdx()));
		reviewMap.put("FK_RESERVATION_UID", fk_reservation_UID);
		reviewMap.put("STARTPOINT", startpoint);
		reviewMap.put("FK_USERID", loginuser.getUserid());
		reviewMap.put("FK_NICKNAME", loginuser.getNickname());
		reviewMap.put("RV_CONTENTS", rv_contents);
		reviewMap.put("STARTPOINT", startpoint);
		
		int result = service.insertReviewByReviewMap(reviewMap);
		
		String msg = "";
		String loc = "";
		if(result == 0) {
			msg = "리뷰 등록 실패했습니다.";
			loc = "javascript:history.back();";
		} else {
			msg = "리뷰 등록 성공했습니다.";
			loc = req.getContextPath()+"/myReviewList.pet";
		} // end of if~else
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		return "msg";
	} //  end of 
	// === 2019.01.29 ==== //
	
	
}