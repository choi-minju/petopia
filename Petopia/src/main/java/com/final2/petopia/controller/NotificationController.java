package com.final2.petopia.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.final2.petopia.model.MemberVO;
import com.final2.petopia.service.InterNotificationService;

@Controller
public class NotificationController {

	//===== 의존객체 주입(DI:Dependency Injection)  =====
	@Autowired
	private InterNotificationService service;
	
	// ----------------------------------------------------------------------------------------------------------
	
	// 안읽은 알림 배지 생성(AJAX) ------------------------------------------------------------------------------------
	@RequestMapping(value="/unreadNotificationCount.pet", method= {RequestMethod.GET})
	@ResponseBody
	public HashMap<String, Integer> unreadNotificationCount(HttpServletRequest req) throws Throwable {
		
		HashMap<String, Integer> returnMap = new HashMap<String, Integer>();
		
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		int idx = loginuser.getIdx();
		
		// 회원의 고유번호를 이용한 안읽은 알림 갯수 나타내기
		int unreadNotificationCount = service.selectUnreadNotificationCount(idx);
		
		returnMap.put("UNREADNOTIFICATIONCOUNT", unreadNotificationCount);
		
		return returnMap;
	}
	
	
	// 알림 페이지 요청 ----------------------------------------------------------------------------------------------
	@RequestMapping(value="/notificationList.pet", method= {RequestMethod.GET})
	public String requireLogin_notificationList(HttpServletRequest req, HttpServletResponse res) {
		return "notification/notificationList.tiles2";
	}
	
	
	
	
}
