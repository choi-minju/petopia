<<<<<<< HEAD
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
			String idx= rvo.getFk_idx(); // 회원번호 // reservationVO 변수 String 타입으로 변경
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
>>>>>>> refs/remotes/origin/hohywan
