package com.final2.petopia.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.final2.petopia.common.MyUtil;
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
	   
		//01.24  기업회원 페이지에서 인서트 창띄우고 인서트 하기  
		@RequestMapping(value = "/InsertChart.pet", method = { RequestMethod.GET })
		public String InsertChart(HttpServletRequest req) {
			
			String ruid=req.getParameter("reservation_UID");
			
			HashMap<String,String> chartmap =new HashMap<String,String>();
			chartmap = service.selectReserverInfo(ruid); //예약번호를 이용하여 차트에 예약자 정보 불러오기 
			
			req.setAttribute("chartmap", chartmap);
			//0125
			List<HashMap<String,String>> doclist=new ArrayList<HashMap<String,String>>();
			doclist=service.selectDocList(ruid);
			
		
			
			
			req.setAttribute("doclist", doclist);
			return "chart/InsertChart.tiles2"; 
			
		} //진료 내역 인서트 창띄우기 (기업회원페이지에서)
		//0125~0126
		@RequestMapping(value = "/InsertChartEnd.pet", method = { RequestMethod.POST })
		public String InsertChartEnd(ChartVO cvo, HttpServletRequest req) {
		 
		/*	0 약국/1 진료 / 2 예방접종 / 3 수술 / 4 호텔링
			 * 
			String ctype =cvo.getChart_type();
			if (ctype.equals("약국")) {
				
				return n;
			}*/
			int n =service.insertChart(cvo);
			
			
			String loc = "";
			if(n==1) {
				String msg="차트등록에 실패하였습니다.";
			req.setAttribute("msg", msg);
			}else {
				loc=req.getContextPath()+"/bizReservationList.pet";
			}
			req.setAttribute("loc", loc);
			return "chart/InsertChart.tiles2"; 
			
		} //진료 차트  인서트 완료  (기업회원페이지에서)
		//0126
		
		
		
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
		
		
/*	0126 주석처리	 
 * @RequestMapping(value = "/SelectChartSearch.pet", method = { RequestMethod.GET })
		public String SelectChartSearch(HttpServletRequest req) {
			

			return "chart/SelectChartSearch.tiles2"; 
			
		} //예약 진료 관리 (기업회원페이지에서)
*/		
	//   #예약목록
		   @RequestMapping(value="/bizReservationList.pet", method={RequestMethod.GET})
		   public String requireLogin_biz_rvchartList(HttpServletRequest req, HttpServletResponse res) {
		      List<HashMap<String, String>> rvchartList = null;
		      String str_currentShowPageNo = req.getParameter("currentShowPageNo");
		      HttpSession session = req.getSession();
		      MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		      int idx_biz = loginuser.getIdx();
		     
		      HashMap<String, String> paraMap = new HashMap<String ,String>();
		      paraMap.put("idx_biz", String.valueOf(idx_biz));
		      
//		      2) 페이지 구분을 위한 변수 선언하기
		      int totalCount = 0;         // 조건에 맞는 총게시물의 개수
		      int sizePerPage = 10;      // 한 페이지당 보여줄 게시물 개수
		      int currentShowPageNo = 0;   // 현재 보여줄 페이지번호(초기치 1)
		      int totalPage = 0;         // 총 페이지 수(웹브라우저 상에서 보여줄 총 페이지의 개수)
		      
		      int startRno = 0;         // 시작행 번호
		      int endRno = 0;            // 마지막행 번호
		      
		      int blockSize = 3;         // 페이지바의 블럭(토막) 개수
		      
		      totalCount = service.getTotalCountNoSearch(idx_biz);

		      totalPage=(int)Math.ceil((double)totalCount/sizePerPage);
		      
//		      4) 현재 페이지 번호 셋팅하기
		      if(str_currentShowPageNo == null) {
//		         게시판 초기 화면의 경우
		         currentShowPageNo=1;
		      }
		      else {
//		         특정 페이지를 조회한 경우
		         try {
		         currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
		         if(currentShowPageNo<1 || currentShowPageNo>totalPage) {
		            currentShowPageNo = 1;
		         }
		         } catch(NumberFormatException e) {
		            currentShowPageNo = 1;
		         }
		      }
		      
//		      5) 가져올 게시글의 범위 구하기(기존 공식과 다른 버전)
		      startRno = ((currentShowPageNo-1) * sizePerPage)+1;
		      endRno = startRno+sizePerPage -1; 
		      
//		      6) DB에서 조회할 조건들을 paraMap에 넣기
		      paraMap.put("startRno", String.valueOf(startRno));
		      paraMap.put("endRno", String.valueOf(endRno));
		      
//		      7) 게시글 목록 가져오기
		      rvchartList = service.selectBizReservationList(paraMap);

//		      #120. 페이지바 만들기(MyUtil에 있는 static메소드 사용)
		      String pageBar = "<ul>";
		      pageBar += MyUtil.getPageBar(sizePerPage, blockSize, totalPage, currentShowPageNo, "reservationList.pet");
		      pageBar += "</ul>";
		      
		      session.setAttribute("readCountPermission", "yes");

		      req.setAttribute("rvchartList", rvchartList);
		      
//		      #페이지바 넘겨주기
		      req.setAttribute("pageBar", pageBar);
		      
//		      #currentURL 뷰로 보내기
		      String currentURL = MyUtil.getCurrentURL(req);
		      //System.out.println(currentURL);
		      if(currentURL.substring(currentURL.length()-5).equals("?null")) {
		         currentURL = currentURL.substring(0 , currentURL.length()-5);
		      }
		      req.setAttribute("currentURL", currentURL);
		      return "chart/biz_rvchartList.tiles2";
		   }
		

}// end of controller
