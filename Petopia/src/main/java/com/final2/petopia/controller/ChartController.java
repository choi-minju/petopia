<<<<<<< HEAD
package com.final2.petopia.controller;

import java.util.HashMap;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.final2.petopia.model.ChartVO;
import com.final2.petopia.model.MemberVO;
import com.final2.petopia.model.PetVO;
import com.final2.petopia.model.ReservationVO;
import com.final2.petopia.service.ChartService;
import com.final2.petopia.service.InterChartService;


@Controller
@Component
public class ChartController {
	
	// ===== #35. 의존 객체 주입하기 (DIL Dependency Injection) =====
		@Autowired
		private InterChartService service;
		

		@RequestMapping(value = "/InsertMyChart.pet", method = { RequestMethod.GET })
		public String InsertMyChart(HttpServletRequest req) {
			
			HttpSession session = req.getSession();
			MemberVO loginuser= (MemberVO) session.getAttribute("loginuser");
			
			
			String idx = Integer.toString(loginuser.getIdx());
			
			String pet_uid=Integer.toString(service.selectpetuid(idx)); //idx 값을 가지고 서비스단으로 
			
			
			PetVO pvo=new PetVO();
			pvo = service.selectpetinfo(pet_uid); //펫 uid로 펫정보 가져오기 
			
			req.setAttribute("pvo", pvo);

			String nickname= service.selectnickname(idx); //병원 이름 가져오기 
			System.out.println("nickname C: " +nickname);
			req.setAttribute("nickname", nickname);
		
			ReservationVO rvo =new ReservationVO();
		    rvo = service.selectreservedate(idx);
			
		    req.setAttribute("rvo", rvo);
			
		    return "chart/InsertMyChart.tiles2"; 
		
		} //진료 내역 인서트 (마이 페이지에서)
		


		@RequestMapping(value = "/InsertMyChartEnd.pet", method = { RequestMethod.GET })
		public int InsertMyChartEnd(ChartVO cvo, HttpServletRequest req) {

			HttpSession session = req.getSession();
			MemberVO loginuser= (MemberVO) session.getAttribute("loginuser");
			
			String idx = Integer.toString(loginuser.getIdx());
			String pet_uid=Integer.toString(service.selectpetuid(idx));

			
		
			
			//처방전 인서트 
			String docname= req.getParameter("docname"); //의사명
			String dname = req.getParameter("dname"); //질병이름
			String mname =req.getParameter("mname"); // 약이름
			String caution=req.getParameter("caution"); //주의사항
			String memo=req.getParameter("memo"); //내용
			String charttype=cvo.getChart_type();// 차트 타입 
			HashMap<String, String> mychartmap = new HashMap<String, String>();
			
			mychartmap.put("DOCNAME", docname);
			mychartmap.put("DNAME", dname);
			mychartmap.put("MNAME", mname);
			mychartmap.put("CAUTION", caution);
			mychartmap.put("MEMO", memo);
			mychartmap.put("idx",idx);
			mychartmap.put("PET_UID",pet_uid);
			mychartmap.put("CHARTTYPE",charttype);
			
			int n = service.insertmychart(mychartmap);
			
			
			return n; 
			
		} //진료 내역 인서트 (마이 페이지에서)
		
		@RequestMapping(value = "/InsertChart.pet", method = { RequestMethod.GET })
		public String InsertChart(ChartVO chartvo, HttpServletRequest req) {
			
			return "chart/InsertChart.tiles2"; 
			
		} //진료 내역 인서트 창띄우기 (기업회원페이지에서)
		
		@RequestMapping(value = "/InsertChartEnd.pet", method = { RequestMethod.POST })
		public String InsertChartEnd(ReservationVO rvo, HttpServletRequest req) {
			
			
			
			HashMap<String,String> map = new HashMap<String,String>();
			
			
			return "chart/InsertChart.tiles2"; 
			
		} //진료 내역 인서트 완료  (기업회원페이지에서)
		
		
		
		
		@RequestMapping(value = "/InsertPrescription.pet", method = { RequestMethod.GET })
		public String InsertPrescription(HttpServletRequest req) {
			
			

			return "chart/InsertPrescription.tiles2"; 
			
		} //처방전 인서트 (기업회원페이지에서)
		
		
	@RequestMapping(value = "/SelectMyChart.pet", method = { RequestMethod.GET })
	public String SelectMyChart(HttpServletRequest req) {
		

		return "chart/SelectMyChart.tiles2";  //안나옴
		
	} //차트 디테일 불러오기 (마이페이지에서 )
	
	
		@RequestMapping(value = "/SelectReserveChart.pet", method = { RequestMethod.GET })
		public String SelectReserveChart(HttpServletRequest req) {
			

			return "chart/SelectReserveChart.tiles2"; 
			
		} //예약 진료 관리 (기업회원페이지에서 달력으로 )
		
		@RequestMapping(value = "/SelectChartSearch.pet", method = { RequestMethod.GET })
		public String SelectChartSearch(HttpServletRequest req) {
			

			return "chart/SelectChartSearch.tiles2"; 
			
		} //예약 진료 관리 (기업회원페이지에서)
		
		
		
}// end of controller
=======
package com.final2.petopia.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.final2.petopia.model.ChartVO;
import com.final2.petopia.model.ReservationVO;
import com.final2.petopia.service.ChartService;


@Controller
@Component
public class ChartController {
	
	// ===== #35. 의존 객체 주입하기 (DIL Dependency Injection) =====
		@Autowired
		private ChartService service;
		
		@RequestMapping(value = "/InsertChart.pet", method = { RequestMethod.GET })
		public String InsertChart(ChartVO chartvo, HttpServletRequest req) {
			
			return "chart/InsertChart.tiles2"; 
			
		} //진료 내역 인서트 창띄우기 (기업회원페이지에서)
		
		@RequestMapping(value = "/InsertChartEnd.pet", method = { RequestMethod.POST })
		public String InsertChartEnd(ReservationVO rvo, HttpServletRequest req) {
			
			
			String date = rvo.getReservation_DATE();//방문 일자 
			int idx= rvo.getFk_idx(); // 회원번호 
			String name1= req.getParameter("name1"); //병명
			String caution = req.getParameter("caution");
			String note = req.getParameter("note");
			
			HashMap<String,String> map = new HashMap<String,String>();
			
			int n= service.insertchartinfo(rvo);
                
			if(n==1) {
				map.put("NAME1", name1);
				map.put("CAUTION",caution);
				map.put("NOTE", note);
			}
			return "chart/InsertChart.tiles2"; 
			
		} //진료 내역 인서트 완료  (기업회원페이지에서)
		
		@RequestMapping(value = "/InsertMyChart.pet", method = { RequestMethod.GET })
		public String InsertMyChart(HttpServletRequest req) {
			
			/*HashMap<String,String> map = new HashMap<String,String>();
			
			int n= service.insertchartinfo(chartvo);
                
			if(n==1) {
				map.put(key, value);
			}*/
			return "chart/InsertMyChart.tiles2"; 
			
		} //진료 내역 인서트 (마이 페이지에서)
		
		@RequestMapping(value = "/InsertPrescription.pet", method = { RequestMethod.GET })
		public String InsertPrescription(HttpServletRequest req) {
			

			return "chart/InsertPrescription.tiles2"; 
			
		} //처방전 인서트 (기업회원페이지에서)
		
		
	@RequestMapping(value = "/SelectMyChart.pet", method = { RequestMethod.GET })
	public String SelectMyChart(HttpServletRequest req) {
		

		return "chart/SelectMyChart.tiles2";  //안나옴
		
	} //차트 디테일 불러오기 (마이페이지에서 )
	
	
		@RequestMapping(value = "/SelectReserveChart.pet", method = { RequestMethod.GET })
		public String SelectReserveChart(HttpServletRequest req) {
			

			return "chart/SelectReserveChart.tiles2"; 
			
		} //예약 진료 관리 (기업회원페이지에서 달력으로 )
		
		@RequestMapping(value = "/SelectChartSearch.pet", method = { RequestMethod.GET })
		public String SelectChartSearch(HttpServletRequest req) {
			

			return "chart/SelectChartSearch.tiles2"; 
			
		} //예약 진료 관리 (기업회원페이지에서)
		
		
		
}// end of controller
>>>>>>> refs/remotes/origin/hyunjae
