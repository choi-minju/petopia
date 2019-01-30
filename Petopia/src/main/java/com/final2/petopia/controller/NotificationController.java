package com.final2.petopia.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.final2.petopia.service.InterNotificationService;

@Controller
public class NotificationController {

	//===== 의존객체 주입(DI:Dependency Injection)  =====
	@Autowired
	private InterNotificationService service;
	
	//===== 양방향 암호화 알고리즘인 AES256을 사용하여 암호화/복호화하기 위한 클래스 의존객체 주입(DI:Dependency Injection) =====
	//@Autowired
	//private AES256 aes;
	
	//===== 파일업로드 및 파일다운로드를 해주는 FileManager 클래스 의존객체 주입(DI:Dependency Injection) =====
	//@Autowired
	//private FileManager fileManager;
	
	// ------------------------------------------------------------------------------------------------------------
	
	// 알림 페이지 요청 -------------------------------------------------------------------------------------------
	@RequestMapping(value="/notificationList.pet", method= {RequestMethod.GET})
	public String requireLogin_notificationList(HttpServletRequest req, HttpServletResponse res) {
		return "notification/notificationList.tiles2";
	}
	
	
	
	
}
