package com.final2.petopia.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.final2.petopia.model.MemberVO;
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
		
		List<PetVO> pvoList = null;
		
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if(loginuser != null && loginuser.getMembertype().equals("1")) {
			
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("IDX", String.valueOf(loginuser.getIdx())); 
			
			pvoList = service.getPet_infoList(map);
			
			req.setAttribute("pvoList", pvoList);

		}
		
		return "care/index.tiles2";
	}
	
	
	//===== 반려동물 등록페이지 요청 =====
	@RequestMapping(value="/petRegister.pet", method={RequestMethod.GET})
	public String register(HttpServletRequest req) {
		
		return "care/petRegister.tiles2";
	}
	
	//===== 반려동물 등록페이지 요청완료 =====
	@RequestMapping(value="/petRegisterEnd.pet", method={RequestMethod.POST})
	public String registerEnd(PetVO pvo, HttpServletRequest req) {
	
		int n = service.insertPet_info(pvo);

		String msg ="";
		if(n == 1) {
			msg = "반려동물 등록 성공!!";
		}
		else {
			msg = "반려동물 등록 실패!!";
		}
		
		req.setAttribute("msg", msg);

		return "care/index.tiles2";
	}
	
	
	//===== 특정 반려동물관리 상세페이지 요청 =====
	@RequestMapping(value="/petView.pet", method={RequestMethod.GET})
	public String view(HttpServletRequest req) {
		
		String pet_UID = req.getParameter("pet_UID");
/*		
		if(pet_UID != null) {
			
			HashMap<String, String> map = new HashMap<String, String>();
			map.put(key, );
			
		}
			*/
		
		
		return "care/petView.tiles2";
	}
	
	
	//===== 케어관리페이지 요청 =====
	@RequestMapping(value="/careCalendar.pet", method={RequestMethod.GET})
	public String calendar(HttpServletRequest req) {
		
		return "care/calendar.tiles2";
	}
	
	
	//===== 케어관리 등록페이지 요청 =====
	@RequestMapping(value="/careRegister.pet", method={RequestMethod.GET})
	public String careRegister(HttpServletRequest req) {
		
		
		
		

		
		
		return "care/careRegister.tiles2";
	}

	
} // end of class CareController
