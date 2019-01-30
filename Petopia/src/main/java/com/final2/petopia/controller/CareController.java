package com.final2.petopia.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.final2.petopia.model.CareVO;
import com.final2.petopia.model.MemberVO;
import com.final2.petopia.model.PetVO;
import com.final2.petopia.service.InterCareService;

@Controller
@Component
public class CareController {

	@Autowired
	private InterCareService service;
	
	
	// [19-01-24. 수정 시작_hyunjae]
	// ===== 반려동물 리스트페이지 요청 =====
	@RequestMapping(value="/petList.pet", method={RequestMethod.GET})
	public String requireLogin_petList(HttpServletRequest req, HttpServletResponse res) {
		
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if(loginuser != null && loginuser.getMembertype().equals("1")) {
		
			String fk_idx = String.valueOf(loginuser.getIdx());
			req.setAttribute("fk_idx", fk_idx);
			 
		}
		
		return "care/petList.tiles2";
	}
	
	
	// ===== 반려동물 리스트 가져오기(Ajax) =====
	@RequestMapping(value="/getPet.pet", method={RequestMethod.GET})
	@ResponseBody
	public List<HashMap<String, Object>> getPet(HttpServletRequest req) {
	
		List<HashMap<String, Object>> returnmapList = new ArrayList<HashMap<String, Object>>(); 

		String fk_idx = req.getParameter("fk_idx");
		
		List<HashMap<String,String>> list = service.getPet_infoList(Integer.parseInt(fk_idx));
		
		if(list != null) {
			for(HashMap<String,String> datamap : list) {
				HashMap<String, Object> submap = new HashMap<String, Object>(); 
				submap.put("PET_UID", datamap.get("PET_UID"));
				submap.put("FK_IDX", datamap.get("FK_IDX"));
				submap.put("PET_NAME", datamap.get("PET_NAME"));
				submap.put("PET_TYPE", datamap.get("PET_TYPE"));
				submap.put("PET_BIRTHDAY", datamap.get("PET_BIRTHDAY"));
				submap.put("PET_SIZE", datamap.get("PET_SIZE"));
				submap.put("PET_WEIGHT", datamap.get("PET_WEIGHT"));
				submap.put("PET_GENDER", datamap.get("PET_GENDER"));
				submap.put("PET_NEUTRAL", datamap.get("PET_NEUTRAL"));
				submap.put("MEDICAL_HISTORY", datamap.get("MEDICAL_HISTORY"));
				submap.put("ALLERGY", datamap.get("ALLERGY"));
				submap.put("PET_PROFILEIMG", datamap.get("PET_PROFILEIMG"));
				
				returnmapList.add(submap);
			}
		}
		
		return returnmapList;
	}
	// [19-01-24. 수정 끝_hyunjae]

	
	//===== 반려동물 등록페이지 요청 =====
	@RequestMapping(value="/petRegister.pet", method={RequestMethod.GET})
	public String register(HttpServletRequest req) {
		
		return "care/petRegister.tiles2";
	}
	
	
	// [19-01-24. 수정 시작_hyunjae]
	//===== 반려동물 등록 요청완료 =====
	@RequestMapping(value="/petRegisterEnd.pet", method={RequestMethod.POST})
	public String registerEnd(PetVO pvo, HttpServletRequest req) {
	
		int n = service.insertPet_info(pvo);

		String msg = "";
		String loc = "";
		
		if(n == 1) {
			msg = "반려동물 등록 성공!!";
			loc = "/petopia/petList.pet";
		}
		else {
			msg = "반려동물 등록 실패!!";
			loc = "javascript:history.back();";
		}
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);

		return "msg";
	}
	// [19-01-24. 수정 끝_hyunjae]
	
	
	//===== 특정 반려동물관리 상세페이지 요청 =====
	@RequestMapping(value="/petView.pet", method={RequestMethod.GET})
	public String view(HttpServletRequest req) {
	
		String str_pet_UID = "";
		
		try {
		
			str_pet_UID = req.getParameter("pet_UID");			
			int pet_UID = Integer.parseInt(str_pet_UID); 

			HashMap<String, Object> petInfo = service.getPet_info(pet_UID); 
			
			req.setAttribute("petInfo", petInfo);
			req.setAttribute("pet_UID", pet_UID);
			
			return "care/petView.tiles2";
			
		} catch (NumberFormatException e) {
			req.setAttribute("str_pet_UID", str_pet_UID);
			return "care/petRegister.tiles2";			
		}
		
	}
	
	
	// [19-01-30. 수정 시작_hyunjae]
	//===== 특정 반려동물관리 몸무게(Ajax) =====
	@RequestMapping(value="/getWeight.pet", method={RequestMethod.GET})
	@ResponseBody
	public List<HashMap<String, Object>> getWeight(HttpServletRequest req) {
		
		List<HashMap<String, Object>> returnmapList = new ArrayList<HashMap<String, Object>>(); 

		String pet_UID = req.getParameter("pet_UID");
		
		List<HashMap<String,String>> list = service.getWeight(pet_UID);
		
		if(list != null) {
			for(HashMap<String,String> datamap : list) {
				HashMap<String, Object> submap = new HashMap<String, Object>(); 
				submap.put("PETWEIGHT_UID", datamap.get("PETWEIGHT_UID"));
				submap.put("FK_PET_UID", datamap.get("FK_PET_UID"));
				submap.put("PETWEIGHT_PAST", datamap.get("PETWEIGHT_PAST"));
				submap.put("PETWEIGHT_DATE", datamap.get("PETWEIGHT_DATE"));
				
				returnmapList.add(submap);
			}
		}

		return returnmapList;
	}

	
	//===== 특정 반려동물관리 체중 추가 =====
	@RequestMapping(value="/addWeight.pet", method={RequestMethod.GET})
	public String addWeight(HttpServletRequest req) {
		
		return "care/addWeight.notiles";
	}

	
	//===== 특정 반려동물관리 진료기록(Ajax) =====
	@RequestMapping(value="/getChart.pet", method={RequestMethod.GET})
	@ResponseBody
	public List<HashMap<String, Object>> getChart(HttpServletRequest req) {
		
		List<HashMap<String, Object>> returnmapList = new ArrayList<HashMap<String, Object>>(); 

		String pet_UID = req.getParameter("pet_UID");
		
		List<HashMap<String,String>> list = service.getChart(pet_UID);
		
		if(list != null) {
			for(HashMap<String,String> datamap : list) {
				HashMap<String, Object> submap = new HashMap<String, Object>(); 
				submap.put("CHART_UID", datamap.get("CHART_UID"));
				submap.put("BIZ_NAME", datamap.get("BIZ_NAME"));
				submap.put("RESERVATION_DATE", datamap.get("RESERVATION_DATE"));
				
				returnmapList.add(submap);
			}
		}

		return returnmapList;
	}
	// [19-01-30. 수정 끝_hyunjae]
	
	
	// [19-01-25. 수정 시작_hyunjae]
	//===== 케어관리페이지 요청 =====
	@RequestMapping(value="/careCalendar.pet", method={RequestMethod.GET})
	public String calendar(HttpServletRequest req) {
		
		return "care/careCalendar.tiles2";
	}
	
	
	// [19-01-24. 수정 시작_hyunjae]
	//===== 케어관리 등록페이지 요청 =====
	@RequestMapping(value="/careRegister.pet", method={RequestMethod.GET})
	public String careRegister(HttpServletRequest req) {
		
		//String fk_pet_UID = req.getParameter("fk_pet_UID");
		String fk_caretype_UID = req.getParameter("fk_caretype_UID");
		
		List<HashMap<String,String>> caretypeList = service.getCaretypeList();
		
		req.setAttribute("caretypeList", caretypeList);
		req.setAttribute("fk_caretype_UID", fk_caretype_UID);
		
		return "care/careRegister.tiles2";
	}
	
	
	//===== 케어타입 코드 =====
	@RequestMapping(value="/getCaretype_info.pet", method={RequestMethod.GET})
	@ResponseBody
	public List<HashMap<String, Object>> getCaretype_info(HttpServletRequest req) {
		
		List<HashMap<String, Object>> returnmapList = new ArrayList<HashMap<String, Object>>(); 
		
		String caretype = req.getParameter("caertype");
		List<HashMap<String,String>> list = service.getCaretype_infoList(caretype);
		
		if(list != null) {
			for(HashMap<String,String> datamap : list) {
				HashMap<String, Object> submap = new HashMap<String, Object>(); 
				submap.put("CARETYPE_INFO", datamap.get("CARETYPE_INFO"));
				
				returnmapList.add(submap);
			}
		}
	
		return returnmapList;
	}
	
	
	//===== 케어 등록페이지 요청완료 =====
	@RequestMapping(value="/careRegisterEnd.pet", method={RequestMethod.POST})
	public String careRegisterEnd(CareVO cvo, HttpServletRequest req) {
	
		int n = service.insertPetcare(cvo);
		
		String msg = "";
		String loc = "";
		 
		if(n == 1) {
			msg = "케어 등록 성공!!";
			loc = "/petopia/careCalendar.pet";
		}
		else {
			msg = "케어 등록 실패!!";
			loc = "javascript:history.back();";
		}
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);

		return "msg";		
	}
	// [19-01-24. 수정 끝_hyunjae]
	// [19-01-25. 수정 끝_hyunjae]
	
	
} // end of class CareController
