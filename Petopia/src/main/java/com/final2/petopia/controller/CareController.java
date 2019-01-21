package com.final2.petopia.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.final2.petopia.model.PetVO;
import com.final2.petopia.service.InterCareService;

@Controller
@Component
public class CareController {

	@Autowired
	private InterCareService service;
	
	//===== 반려동물관리 메인페이지 요청 =====
	@RequestMapping(value="/careIndex.pet", method={RequestMethod.GET})
	public String index(HttpServletRequest req) {
		
		return "care/index.tiles2";
	}
	
	
	//===== 특정 반려동물관리 상세페이지 요청 =====
	@RequestMapping(value="/careView.pet", method={RequestMethod.GET})
	public String view(HttpServletRequest req) {
		
		return "care/view.tiles2";
	}
	
	
	//===== 반려동물 등록페이지 요청 =====
	@RequestMapping(value="/careRegister.pet", method={RequestMethod.GET})
	public String register(HttpServletRequest req) {
		
		return "care/register.tiles2";
	}
	
	
	//===== 반려동물 등록페이지 요청 =====
	@RequestMapping(value="/careRegisterEnd.pet", method={RequestMethod.GET})
	public String registerEnd(PetVO petvo, HttpServletRequest req) {
		
		System.out.println("ddd"); 
	/*	
		int n = service.insertPet_info(petvo);

		String msg ="";
		if(n == 1) {
			msg = "데이터 입력성공!!";
		}
		else {
			msg = "데이터 입력실패11";
		}
		
		req.setAttribute("msg", msg);
	*/	
		return "care/registerEnd.tiles2";
	}
	
	//===== 케어관리페이지 요청 =====
	@RequestMapping(value="/careCalendar.pet", method={RequestMethod.GET})
	public String calendar(HttpServletRequest req) {
		
		return "care/calendar.tiles2";
	}
	
	
} // end of class CareController
