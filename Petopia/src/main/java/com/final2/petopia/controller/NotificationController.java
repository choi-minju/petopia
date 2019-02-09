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
import com.final2.petopia.model.NotificationVO;
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
		
		// 접속한 페이지주소가 notificationList.pet 라면 카운트를 비교해서 알림리스트를 가져오는 ajax를 실행
		
		return returnMap;
	}
	
	// 알림 아이콘 클릭 시 심플알림창 생성(AJAX) -------------------------------------------------------------------------
	// (안읽은 알림만 생성)
	@RequestMapping(value="/notificationSimpleList.pet", method= {RequestMethod.GET})
	@ResponseBody
	public List<HashMap<String, String>> notificationSimpleList(HttpServletRequest req) throws Throwable {
		
		List<HashMap<String, String>> notificationSimpleList = new ArrayList<HashMap<String, String>>();
		
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		int idx = loginuser.getIdx();
		
		// 회원의 고유번호를 이용한 심플 알림정보 가져오기(알림타입과 그 갯수)
		List<HashMap<String, String>> n_List = service.selectNotificatioSimplenList(idx);
		
		// HashMap에 nvoList안의 nvo.not_type에 따라 문구 넣기
		for(int i=0; i<n_List.size(); i++) {
			
			HashMap<String, String> map = new HashMap<String, String>();
			
			String simpleMsg = "";
			 
			switch (n_List.get(i).get("NOT_TYPE")) {
			case "0":
				simpleMsg = "댓글이 없는 상담글이 있습니다.";
				break;
			case "1":
				simpleMsg = "케어 알림이 도착했습니다.";
				break;
			case "2":
				simpleMsg = "예약 알림이 있습니다.";
				break;
			case "3":
				simpleMsg = "결제대기 중인 예약이 있습니다.";
				break;
			case "4":
				simpleMsg = "게시글에 새 댓글이 있습니다.";
				break;
			case "5":
				simpleMsg = "화상상담 코드가 도착했습니다.";
				break;
			} // end of switch
			
			map.put("SIMPLEMSG", simpleMsg);
			map.put("COUNT", n_List.get(i).get("COUNT"));
			
			
			notificationSimpleList.add(map);
		} // end of for
		
		return notificationSimpleList;
	}
	
	// 알림 페이지 요청 -----------------------------------------------------------------------------------------------
	@RequestMapping(value="/notificationList.pet", method= {RequestMethod.GET})
	public String requireLogin_notificationList(HttpServletRequest req, HttpServletResponse res) {
		return "notification/notificationList.tiles2";
	}
	
	/*
	// 알림 페이지 내용 요청(AJAX) -------------------------------------------------------------------------------------
	@RequestMapping(value="/notificationListAJAX.pet", method= {RequestMethod.GET})
	@ResponseBody
	public List<HashMap<String, String>> notificationListAJAX(HttpServletRequest req) throws Throwable {
	
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		int idx = loginuser.getIdx();
		
		List<NotificationVO> notificationList = service.selectNotificationList(idx);
		
		
		
		return notificationList;
	}
	*/
}
