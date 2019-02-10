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

import com.final2.petopia.common.MyUtil;
import com.final2.petopia.model.ChartVO;
import com.final2.petopia.model.MemberVO;


import com.final2.petopia.service.InterChartService;

@Controller
@Component
public class ChartController {
	// 0202 requireLogin

	// ===== #35. 의존 객체 주입하기 (DIL Dependency Injection) =====
	@Autowired
	private InterChartService service;

	@RequestMapping(value = "/SelectMyPrescription.pet", method = { RequestMethod.GET })
	public String requireLogin_SelectMyChart(HttpServletRequest req, HttpServletResponse res) {

		return "chart/SelectMyPrescription.tiles2"; // 안나옴

	} // 차트 디테일 불러오기 (마이페이지에서 )

	//0209  마이페이지 진료관리 클릭시 바로 보여지는 화면 (펫정보와 진료 기록은 puid가 가장 작은 펫의 정보 )
	@RequestMapping(value = "/InsertMyPrescription.pet", method = { RequestMethod.GET })
	public String InsertMyChart(HttpServletRequest req) {

		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

		int idx = loginuser.getIdx();

		// 0202 회원이 보유한 반려동물 수 가져오기
		int pnum = service.getPetmaribyidx(idx);

		String puid = req.getParameter("fk_pet_uid");
		// 0202 반려동물이 한 마리도 없을때 반려동물페이지로 이동 / 있을때 진료기록 관리페이지로 이동
		if (pnum == 0) {
			String loc = req.getContextPath() + "/petRegister.pet";
			String msg = "등록된 반려동물이 존재하지 않습니다. ";

			req.setAttribute("loc", loc);
			req.setAttribute("msg", msg);

			return msg;
		} else {

			// 0202 반려동물의 이미지와 이름을 리스트로 보여주기
			List<HashMap<String, String>> pmaplist = new ArrayList<HashMap<String, String>>();
			pmaplist = service.getPmapListbyidx(idx);
		
			// 0202회원이 보유한 동물중 pet_UID가 가장 작은 동물의 puid 알아오기
			int minpuid = service.getMinpuidbyidx(idx);

			// 0202 pet_uid가 가장 작은 동물의 정보 불러오기
			HashMap<String, Object> minpinfo = new HashMap<String, Object>();
			minpinfo = service.getPinfobyminpuid(minpuid);
             
			//0210 마이페이지에서 진료 관리 클릭시 가장 먼저 보여지는 처방전의 날짜 리스트 (minpuid 기준 )
			HashMap<String,Object> paramap= new HashMap<String,Object>();
			paramap.put("idx", idx);
			paramap.put("minpuid", minpuid);
			
			List<HashMap<String,String>> myreservedaylist = new ArrayList<HashMap<String,String>>();
			myreservedaylist =service.getmyreservedaylist(paramap);
			
			//0210  마이페이지에서 진료 관리 클릭시 가장 먼저 보여지는 처방전의 정보(결제 정보포함) minpuid기준으로 가져오기 
			String minruid=service.getminRuid(paramap); //가장 작은 예약번호 알아오기 
			
			HashMap<String,Object> paramap2= new HashMap<String,Object>();
			paramap2.put("minruid",minruid);
			paramap2.put("idx",idx);
			paramap2.put("minpuid",minpuid);
			
			HashMap<String,Object> mypreinfo =new HashMap<String,Object>();
			mypreinfo = service.getmyPreinfo(paramap2);//마이페이지 처방전에서 보여지는 정보 
			
			
			req.setAttribute("mypreinfo", mypreinfo);
			req.setAttribute("myreservedaylist", myreservedaylist);
			req.setAttribute("minpinfo", minpinfo);
			req.setAttribute("minpuid", minpuid);
			req.setAttribute("pmaplist", pmaplist);
			
		}
		return "chart/InsertMyPrescription.tiles2";
	} // 진료 내역 인서트 (마이 페이지에서)

    //0209 해당회원이 보유한 동물의 정보  펫이미지 버튼 클릭시 보여질 정보 
	@RequestMapping(value = "/getPinfobyminpuid.pet", method = { RequestMethod.GET })
	@ResponseBody
	public HashMap<String,Object> getPinfobyminpuid(HttpServletRequest req) {

		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

		int idx = loginuser.getIdx();

		String puid = req.getParameter("fk_pet_uid");
		
		HashMap<String,Object> pinfo = service.getPinfo(puid);
		
		return pinfo;
	
	} // 진료 내역 인서트 (마이 페이지에서)
	
	// 0201 캘린더에 넣을 정보 리스트 불러오기
	@RequestMapping(value = "/selectMyPrescription.pet", method = { RequestMethod.GET })
	@ResponseBody
	public List<HashMap<String, String>> selectMyPrescription(HttpServletRequest req) {

		String fk_pet_uid = req.getParameter("fk_pet_uid");
		List<HashMap<String, String>> callist = new ArrayList<HashMap<String, String>>();
		callist = service.selectMyPrescription(fk_pet_uid);

		// System.out.println("callist: "+callist.get(0).get("reservation_date"));

		return callist;
	} //
	
	//0210 마이페이지 - 진료관리에서 일반회원이 처방전 입력하기 
	@RequestMapping(value = "/InsertMyChartEnd.pet", method = { RequestMethod.POST })
	public String InsertMyChartEnd(HttpServletRequest req) {

		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		int idx = loginuser.getIdx();
		int minpuid = service.getMinpuidbyidx(idx);

		HashMap<String,Object> paramap= new HashMap<String,Object>();
		paramap.put("idx", idx);
		paramap.put("minpuid", minpuid);
		
		String minruid=service.getminRuid(paramap);
		
		String cuid=service.getcuid(minruid);
		String rx_name= req.getParameter("rx_name");
		String dose_number= req.getParameter("dose_number");
		String dosage= req.getParameter("dosage");
		String rx_cautions=req.getParameter("rx_cautions");
		String rx_notice=req.getParameter("rx_notice");
		String rx_regname=req.getParameter("rx_regname");
		
		HashMap<String,String> map= new HashMap<String,String>();
		map.put("idx",String.valueOf(idx));
		map.put("cuid",cuid);
		map.put("rx_name",rx_name);
		map.put("dose_number",dose_number);
		map.put("dosage",dosage);
		map.put("rx_cautions",rx_cautions);
		map.put("rx_notice",rx_notice);
		map.put("rx_regname",rx_regname);
		
		
	    System.out.println("rx_name: "+rx_name);
	    
	    System.out.println("dosage: "+dosage);
	    System.out.println("cuid : "+cuid);
	    System.out.println("idx : "+idx);
		int n = service.insertmychart(map); //개인사용자가 마이페이지에서 처방전 입력하기
		
		String msg = "";
		String loc = "";
		
		if(n==1) {
			msg="처방전 등록 성공";
			loc="javascript:history.back();";
		}else {
			msg="처방전 등록 실패";
			loc="javascript:history.back();";
		}
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		return "msg";

	} // 진료 내역 인서트 (마이 페이지에서)
	
	//0210 마이페이지 진료관리에서 처방전 셀렉트 하기 
	@RequestMapping(value = "/insertMyPrescription.pet", method = { RequestMethod.GET })
	@ResponseBody
	public List<HashMap<String, String>> selectmychart(HttpServletRequest req) {
	
		List<HashMap<String, String>> selectmychartlist= new ArrayList<HashMap<String,String>>();
		
		
		return selectmychartlist;
	
	}
	
	
	// 01.24 0130 0131 병원 회원 페이지에서 인서트 창띄우기
	@RequestMapping(value = "/InsertChart.pet", method = { RequestMethod.GET })
	public String requireLoginBiz_InsertChart(HttpServletRequest req, HttpServletResponse res) {

		String ruid = req.getParameter("reservation_UID");
		String cuid = service.getChartuid(); // 차트번호 채번
		
		HashMap<String, String> chartmap = new HashMap<String, String>();

		int reservation_type =service.selectrtype(ruid);
		
		chartmap = service.selectReserverInfo(ruid); // 예약번호를 이용하여 차트에 예약자 정보 불러오기

		chartmap.put("fk_reservation_UID", ruid);
		chartmap.put("chart_UID", cuid);
		// 0125
		List<HashMap<String, String>> doclist = new ArrayList<HashMap<String, String>>();
		doclist = service.selectDocList(ruid); // 의사 리스트

		req.setAttribute("chartmap", chartmap);
		req.setAttribute("doclist", doclist);
        req.setAttribute("rtype", reservation_type);
		return "chart/InsertChart.tiles2";

	} // 진료 내역 인서트 창띄우기 (기업회원페이지에서)
		// 0125~0126
		// 0130 인서트문 수정
       //0207 인서트 수정중 
	@RequestMapping(value = "/InsertChartEnd.pet", method = { RequestMethod.POST })
	public String requireLoginBiz_InsertChartEnd(ChartVO cvo, HttpServletRequest req) throws Throwable {
		
		String ruid = req.getParameter("fk_reservation_UID");

		/// 0 약국/1 진료 / 2 예방접종 / 3 수술 / 4 호텔링
		String ctype = cvo.getChart_type();

		String rx_regName = req.getParameter("rx_regName");

		String result = "";

		int n = 0; 
		if (ctype.equals("약국")) {
			result = "0";
		} else if (ctype.equals("외래진료")) {
			result = "1";
		} else if (ctype.equals("예방접종")) {
			result = "2";
		} else if (ctype.equals("수술상담")) {
			result = "3";
		} else if (ctype.equals("호텔링")) {
			result = "4";
		}

	   cvo.setChart_type(result);
	
		String cuid = req.getParameter("chart_UID"); // 뷰에서 차트번호 알아오기

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("chart_UID", cuid);// 맵에 넣어준다.
		map.put("rx_regName", rx_regName);
		map.put("ruid", ruid);
		
		List<HashMap<String, String>> mlist = new ArrayList<HashMap<String, String>>();

		String[] rx_name = req.getParameterValues("rx_name");
		String[] dosage = req.getParameterValues("dosage");
		String[] dose_number = req.getParameterValues("dose_number");

		for (int i = 0; i < rx_name.length; i++) {
			HashMap<String, String> map2 = new HashMap<String, String>();
			map2.put("chart_UID", cuid);
			map2.put("rx_regName", rx_regName);
			map2.put("rx_name", rx_name[i]);
			
			map2.put("dosage", dosage[i]);
			map2.put("dose_number", dose_number[i]);

			mlist.add(map2);
		}
		
		n = service.insertChart(cvo,mlist,map);// 차트테이블에 인서트
		
		
		String msg = "";
		String loc = "";
		if(n==1) {
			msg="차트등록 성공";
			loc="javascript:location.href='"+req.getContextPath()+"/bizReservationList.pet'";
		}else {
			msg="차트 등록 실패";
			loc="javascript:history.back();";
		}
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		return "msg";
		

	} // 진료 차트 인서트 완료 (기업회원페이지에서)

	// 0131 병원 페이지에서 차트 셀렉트 하기
	@RequestMapping(value = "/SelectChart.pet", method = { RequestMethod.GET })
	public String requireLogin_SelectChart(HttpServletRequest req, HttpServletResponse res) {

		String ruid = req.getParameter("reservation_UID");//예약번호 알아오기 
		String cuid = service.getChartuidbyruid(ruid); // 차트번호 알아오기
		int reservation_type =service.selectrtype(ruid);
		
		List<HashMap<String, String>> doclist = new ArrayList<HashMap<String, String>>();
		doclist = service.selectDocList(ruid); // 의사 리스트

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("ruid", ruid);
		map.put("cuid", cuid);

		HashMap<String, String> cmap = new HashMap<String, String>();
		cmap = service.selectChart(map); // 차트 페이지에서 차트 내용 셀렉트

		String[] rx_name = req.getParameterValues("rx_name");
		String[] dosage = req.getParameterValues("dosage");
		String[] dose_number = req.getParameterValues("dose_number");

		List<HashMap<String, String>> plist = new ArrayList<HashMap<String, String>>();
		
		for (int i = 0; i < plist.size(); i++) {
			HashMap<String, String> pmap1 = new HashMap<String, String>();
			pmap1.put("rx_name", rx_name[i]);
			pmap1.put("dosage", dosage[i]);
			pmap1.put("dose_number", dose_number[i]);

			
			plist.add(pmap1);
		}
		List<HashMap<String, String>> pmap2list = new ArrayList<HashMap<String, String>>();
		pmap2list = service.selectPre(map); // 차트 페이지에서 처방전 내용 셀렉트
		
		req.setAttribute("plist", plist);
		req.setAttribute("pmap2list", pmap2list);
		req.setAttribute("cmap", cmap);
		req.setAttribute("doclist", doclist);
		req.setAttribute("rtype", reservation_type);
		
		return "chart/SelectChart.tiles2";

	} // 기업회원 페이지에서 차트불러오기

	@RequestMapping(value = "/EditChart.pet", method = { RequestMethod.POST })

	public String requireLoginBiz_EditChart(ChartVO cvo,HttpServletRequest req, HttpServletResponse res) {

		String ruid = req.getParameter("fk_reservation_UID");
		String cuid = req.getParameter("chart_UID");

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("ruid", ruid);
		map.put("cuid", cuid);

		HashMap<String, String> cmap = new HashMap<String, String>();
		cmap = service.selectChart(map); // 차트 페이지에서 차트 내용 셀렉트

		String[] rx_name = req.getParameterValues("rx_name");
		String[] dosage = req.getParameterValues("dosage");
		String[] dose_number = req.getParameterValues("dose_number");

		List<HashMap<String, String>> plist = new ArrayList<HashMap<String, String>>();
		
		for (int i = 0; i < plist.size(); i++) {
			HashMap<String, String> pmap1 = new HashMap<String, String>();
			pmap1.put("rx_name", rx_name[i]);
			pmap1.put("dosage", dosage[i]);
			pmap1.put("dose_number", dose_number[i]);

			pmap1.put("chart_UID", cuid);
			plist.add(pmap1);
		}
		
		int n = service.Updatechart(map,cvo,plist);
		
		String msg = "";
		String loc = "";
		
		if(n==1) {
			msg="차트수정 성공";
			loc="javascript:location.href='"+req.getContextPath()+"/bizReservationList.pet'";
		}else {
			msg="차트 수정 실패";
			loc="javascript:history.back();";
		}
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		return "msg";
		

	} // 기업회원 페이지에서 차트수정하기

	//0209
	@RequestMapping(value = "/SelectReserveChart.pet", method = { RequestMethod.GET })
	public String SelectReserveChart(HttpServletRequest req) {

		//고객의 예약 /및 진료 날짜  가져오기 
		 List<HashMap<String,String>> daylist =new ArrayList<HashMap<String,String>>();
		 //daylist = service.getRdays();
		 
		// 고객의 이름 및 방문 시각 가져오기 
		return "chart/SelectReserveChart.tiles2";

	} // 예약 진료 관리 (기업회원페이지에서 달력으로 )

	// ajax로 캘린더에 스케줄 넣기
	@RequestMapping(value = "/selectReserveinfo.pet", method = { RequestMethod.GET })
	@ResponseBody
	public List<HashMap<String, String>> requireLogin_selectReserveinfo(HttpServletRequest req,
			HttpServletResponse res) {
		List<HashMap<String, String>> rlist = new ArrayList<HashMap<String, String>>();
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

		int idx = loginuser.getIdx();
		int bidx = 5;
		req.setAttribute("bidx", 5);

		List<HashMap<String, String>> rMapList = new ArrayList<HashMap<String, String>>();// 펫타입, 에약 날짜
		rMapList = service.selectreserveinfo(idx); // 해시맵으로 받아와서 리스트에 넣어준다.

		for (HashMap<String, String> map : rMapList) {
			HashMap<String, String> rmap = new HashMap<String, String>();
			rmap.put("ptype", map.get("pet_type"));
			rmap.put("rdate", map.get("reservation_DATE"));
			rmap.put("bidx", map.get("fk_idx_bizs"));
			rlist.add(rmap);
		}

		return rlist;
	}

	/*
	 * 0126 주석처리
	 * 
	 * @RequestMapping(value = "/SelectChartSearch.pet", method = {
	 * RequestMethod.GET }) public String SelectChartSearch(HttpServletRequest req)
	 * {
	 * 
	 * 
	 * return "chart/SelectChartSearch.tiles2";
	 * 
	 * } //예약 진료 관리 (기업회원페이지에서)
	 */
//   #예약목록
	@RequestMapping(value = "/bizReservationList.pet", method = { RequestMethod.GET })
	public String requireLogin_biz_rvchartList(HttpServletRequest req, HttpServletResponse res) {
		List<HashMap<String, String>> rvchartList = null;
		String str_currentShowPageNo = req.getParameter("currentShowPageNo");
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		int idx_biz = loginuser.getIdx();

		HashMap<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("idx_biz", String.valueOf(idx_biz));

//		      2) 페이지 구분을 위한 변수 선언하기
		int totalCount = 0; // 조건에 맞는 총게시물의 개수
		int sizePerPage = 10; // 한 페이지당 보여줄 게시물 개수
		int currentShowPageNo = 0; // 현재 보여줄 페이지번호(초기치 1)
		int totalPage = 0; // 총 페이지 수(웹브라우저 상에서 보여줄 총 페이지의 개수)

		int startRno = 0; // 시작행 번호
		int endRno = 0; // 마지막행 번호

		int blockSize = 3; // 페이지바의 블럭(토막) 개수

		totalCount = service.getTotalCountNoSearch(idx_biz);

		totalPage = (int) Math.ceil((double) totalCount / sizePerPage);

//		      4) 현재 페이지 번호 셋팅하기
		if (str_currentShowPageNo == null) {
//		         게시판 초기 화면의 경우
			currentShowPageNo = 1;
		} else {
//		         특정 페이지를 조회한 경우
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				if (currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					currentShowPageNo = 1;
				}
			} catch (NumberFormatException e) {
				currentShowPageNo = 1;
			}
		}

//		      5) 가져올 게시글의 범위 구하기(기존 공식과 다른 버전)
		startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
		endRno = startRno + sizePerPage - 1;

//		      6) DB에서 조회할 조건들을 paraMap에 넣기
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));

//		      7) 게시글 목록 가져오기
		rvchartList = service.selectBizReservationList(paraMap);

//		      #120. 페이지바 만들기(MyUtil에 있는 static메소드 사용)
		String pageBar = "<ul class='pagination'>";
		pageBar += MyUtil.getPageBar(sizePerPage, blockSize, totalPage, currentShowPageNo, "reservationList.pet");
		pageBar += "</ul>";

		session.setAttribute("readCountPermission", "yes");

		req.setAttribute("rvchartList", rvchartList);

//		      #페이지바 넘겨주기
		req.setAttribute("pageBar", pageBar);

//		      #currentURL 뷰로 보내기
		String currentURL = MyUtil.getCurrentURL(req);
		// System.out.println(currentURL);
		if (currentURL.substring(currentURL.length() - 5).equals("?null")) {
			currentURL = currentURL.substring(0, currentURL.length() - 5);
		}
		req.setAttribute("currentURL", currentURL);
		return "chart/biz_rvchartList.tiles2";
	}

}// end of controller
