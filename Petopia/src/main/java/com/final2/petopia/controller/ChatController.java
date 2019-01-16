package com.final2.petopia.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class ChatController {
	
	// 화상진료 페이지 보이기
	@RequestMapping(value="/chat.pet", method= {RequestMethod.GET})
	public String chatview(HttpServletRequest req) {
		
		return "chat/chatview.tiles2";
	}
	
	@RequestMapping(value="/videochat.pet", method= {RequestMethod.GET})
	public String videochat(HttpServletRequest req, HttpServletResponse res) {
		
		return "chat/videochat.tiles2";
	}
	
	@RequestMapping(value="/videocode.pet", method= {RequestMethod.GET})
	public String videocode(HttpServletRequest req) {
		
		return "chat/videocode.notiles";
	}
	
	@RequestMapping(value="/abc.pet", method= {RequestMethod.GET})
	public String abc(HttpServletRequest req) {
		
		return "chat/abc.notiles";
	}
	
}
