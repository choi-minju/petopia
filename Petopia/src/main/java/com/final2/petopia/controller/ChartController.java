package com.final2.petopia.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.final2.petopia.model.ChartVO;
import com.final2.petopia.model.MemberVO;
import com.final2.petopia.model.PetVO;
import com.final2.petopia.model.ReservationVO;

import com.final2.petopia.service.InterChartService;


@Controller
@Component
public class ChartController {
	
	// ===== #35. 의존 객체 주입하기 (DIL Dependency Injection) =====
		@Autowired
		private InterChartService service;
		
		@RequestMapping(value = "/SelectMyPrescription.pet", method = { RequestMethod.GET })
		public String SelectMyChart(HttpServletRequest req) {
			
		
		    
			return "chart/SelectMyPrescription.tiles2";  //안나옴
			
		} //차트 디테일 불러오기 (마이페이지에서 )

		@RequestMapping(value = "/InsertMyPrescription.pet", method = { RequestMethod.GET })
		public String InsertMyChart(HttpServletRequest req) {
			
			
			HttpSession session = req.getSession();
			MemberVO loginuser= (MemberVO) session.getAttribute("loginuser");
			
			int idx = loginuser.getIdx();
			System.out.println("idx: "+idx);
		
			List<PetVO> petlist = service.selectpetlist(idx); //펫 uid로 펫정보 가져오기 
			req.setAttribute("petlist", petlist);
/*
		    HashMap<String,Object> paramap =new HashMap<String,Object>();
		    String rdate = req.getParameter("rdate");
		    paramap.put("idx", idx);
		    paramap.put("rdate",rdate);
		     int ruid=  service.selecttabuid(paramap); //탭에 넣을 예약 번호 알아오기 
*/		   
			
		    return "chart/InsertMyPrescription.tiles2"; 
		
		} //진료 내역 인서트 (마이 페이지에서)
		


		@RequestMapping(value = "/InsertMyChartEnd.pet", method = { RequestMethod.GET })
		public int InsertMyChartEnd(ChartVO cvo, HttpServletRequest req) {

			HttpSession session = req.getSession();
			MemberVO loginuser= (MemberVO) session.getAttribute("loginuser");
			
			int idx = loginuser.getIdx();
		
		
			
			List<PetVO>petlist = service.selectpetlist(idx); //펫 uid로 펫정보 가져오기 
			req.setAttribute("petlist", petlist);

		
		    
			//처방전 테이블에 인서트 !!!!!1
			
			String mname =req.getParameter("mname"); // 약이름
			String caution=req.getParameter("caution"); //주의사항
			String memo=req.getParameter("memo"); //내용
			String name = req.getParameter("name");//등록자 이름 
			String mtimes=req.getParameter("mtimes");// 복용횟수 
			String ms=req.getParameter("ms");// 복용량 
			HashMap<String, String> mychartmap = new HashMap<String, String>();
			
		
			mychartmap.put("MNAME", mname);
			mychartmap.put("CAUTION", caution);
			mychartmap.put("MEMO", memo);
			mychartmap.put("NAME", name);
			mychartmap.put("MTIMES",mtimes);
			mychartmap.put("MS",ms);
			int n = service.insertmychart(mychartmap);
			
			
			return n; 
			
		} //진료 내역 인서트 (마이 페이지에서)
		
		@RequestMapping(value = "/InsertChart.pet", method = { RequestMethod.GET })
		public String InsertChart(ChartVO chartvo, HttpServletRequest req) {
			
			return "chart/InsertChart.tiles2"; 
			
		} //진료 내역 인서트 창띄우기 (기업회원페이지에서)
		
		@RequestMapping(value = "/InsertChartEnd.pet", method = { RequestMethod.GET })
		public String InsertChartEnd(ReservationVO rvo, HttpServletRequest req) {
			
			
			
			
			
			return "chart/InsertChart.tiles2"; 
			
		} //진료 내역 인서트 완료  (기업회원페이지에서)
		
		
		
		
		@RequestMapping(value = "/InsertPrescription.pet", method = { RequestMethod.GET })
		public String InsertPrescription(HttpServletRequest req) {
			
			

			return "chart/InsertPrescription.tiles2"; 
			
		} //처방전 인서트 (기업회원페이지에서)
		
		
	
	
	
		@RequestMapping(value = "/SelectReserveChart.pet", method = { RequestMethod.GET })

		public String SelectReserveChart(HttpServletRequest req) {
			
			return "chart/SelectReserveChart.tiles2"; 
			
		} //예약 진료 관리 (기업회원페이지에서 달력으로 )
		
		//ajax로 캘린더에 스케줄 넣기 
		@RequestMapping(value = "/selectReserveinfo.pet", method = { RequestMethod.GET })
		@ResponseBody
		public List<HashMap<String,String>> selectReserveinfo(HttpServletRequest req) {
			 List<HashMap<String,String>> rlist =new ArrayList<HashMap<String,String>>();
			HttpSession session = req.getSession();
			MemberVO loginuser= (MemberVO) session.getAttribute("loginuser");
			
			int idx = loginuser.getIdx();
		     int bidx =5;
		     req.setAttribute("bidx", 5);
			
		    List<HashMap<String,String>> rMapList =new ArrayList<HashMap<String,String>>();//펫타입, 에약 날짜
		    rMapList = service.selectreserveinfo(idx); //해시맵으로 받아와서 리스트에 넣어준다. 
		    
		   for(HashMap<String,String> map:rMapList){
			   HashMap<String,String> rmap =new HashMap<String,String>();
			   rmap.put("ptype", map.get("pet_type"));
			   rmap.put("rdate", map.get("reservation_DATE"));
			   rmap.put("bidx",map.get("fk_idx_bizs"));
			   rlist.add(rmap);
		   } 
		   
		    return rlist;
		}
		
		@RequestMapping(value = "/SelectChartSearch.pet", method = { RequestMethod.GET })
		public String SelectChartSearch(HttpServletRequest req) {
			

			return "chart/SelectChartSearch.tiles2"; 
			
		} //예약 진료 관리 (기업회원페이지에서)
		
		
		
}// end of controller
