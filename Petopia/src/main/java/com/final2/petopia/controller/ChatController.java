package com.final2.petopia.controller;

import java.util.HashMap;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.final2.petopia.model.ChatVO;
import com.final2.petopia.model.MemberVO;
import com.final2.petopia.service.InterChatService;


@Controller
@Component
public class ChatController {
	
	@Autowired
	private InterChatService service;
	
	//화상진료인트로
	@RequestMapping(value="/chat.pet", method= {RequestMethod.GET})
	public String requireLogin_chatview(HttpServletRequest req, HttpServletResponse res) {
		
		return "chat/chatview.tiles2";
	}
	
	//화상진료페이지
	@RequestMapping(value="/videochat.pet", method= {RequestMethod.GET})
	public String videochat(HttpServletRequest req, HttpServletResponse res) {
		
		ChatVO chatvo = new ChatVO();
		
		String chatcode = chatvo.getChatcode();
		
		req.setAttribute("chatcode", chatcode);
	
		return "chat/videochat.tiles2";
	}
	
	//랜덤코드 생성
	@RequestMapping(value="/createcode.pet", method= {RequestMethod.GET})
	@ResponseBody
	public HashMap<String, String> createcode(HttpServletRequest req, HttpServletResponse res) throws Throwable {
		
		HashMap<String, String> map = new HashMap<String, String>();
		
		ChatVO chatvo = new ChatVO();
		
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		int idx = loginuser.getIdx();
		
		Random rnd = new Random();
		String randomStr = String.valueOf(rnd.nextInt(100000));
		
		session.setAttribute("chatcode", randomStr);
		chatvo.setChatcode(randomStr);
		
		map.put("idx", String.valueOf(idx));
		map.put("code", chatvo.getChatcode());
		
		int code = service.createcode(map);
		
		if(code == 1) {
			return map;
		}
		return map;
	}
	
	// code에 따라 접속 
	@RequestMapping(value="/viewcode.pet", method= {RequestMethod.GET})
	@ResponseBody
	public HashMap<String, String> viewcode(HttpServletRequest req, HttpServletResponse res) throws Throwable {
		
		String usercode = req.getParameter("code");
		
		String code = service.viewcode(usercode);
		
		HashMap<String, String> returnMap = new HashMap<String, String>();
		
		returnMap.put("code", code);
		
		return returnMap;
		
	}
	
	//코드 입력
	@RequestMapping(value="/videocode.pet", method= {RequestMethod.GET})
	public String videocode(HttpServletRequest req, HttpServletResponse res) {
		
		HttpSession session = req.getSession();
		String chatcode = (String)session.getAttribute("chatcode");
		
		req.setAttribute("chatcode", chatcode);
		
		return "chat/videocode.notiles";
	}
	
	//채팅 종료
	/*@RequestMapping(value="/chatend.pet", method= {RequestMethod.GET})
	@ResponseBody
	public HashMap<String, String> chatend(HttpServletRequest req, HttpServletResponse res) throws Throwable {
	
		HashMap<String, String> map = new HashMap<String, String>();
		
		
		
		return map;
	}*/
	
	
	
}
