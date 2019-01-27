package com.final2.petopia.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.final2.petopia.common.MyUtil;
import com.final2.petopia.model.Biz_MemberVO;
import com.final2.petopia.model.DepositVO;
import com.final2.petopia.model.MemberVO;
import com.final2.petopia.model.PaymentVO;
import com.final2.petopia.model.PetVO;
import com.final2.petopia.model.ReservationVO;
import com.final2.petopia.model.ScheduleVO;
import com.final2.petopia.service.InterReservationService;

@Controller
public class ReservationController {
	
	@Autowired
	private InterReservationService service;
	
	public String chageDateFormat(String date) {
//		"Tue  Jan  22   2019       09:    00:    00 GMT+0000" -> "yyyy-mm-dd hh24:mi"
//		 0123 4567 8910 1112131415 161718 192021
//		String[] weekend = {"Sun", "Mon", "Tue", "Wed", "Thr", "Fri", "Sat"};
		String[] Months = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
		String result = "";
		result += date.substring(11, 15);
		for(int i=0; i<Months.length; i++) {
			if(date.substring(4,7).equals(Months[i])) {
				if(i+1<10) {
					result += "-0"+(i+1);
				}
				else {
					result += "-"+(i+1);
				}
			}
		}
		result += "-"+date.substring(8, 10) + " "+date.substring(16, 21);
		
//		System.out.println("날짜 포맷 변환 결과: "+result);
		return result;
	}
	
	
	@RequestMapping(value="/reservation.pet", method= {RequestMethod.GET})
	public String requireLogin_goReservationPage(HttpServletRequest req, HttpServletResponse res) {
		
//		String idx_biz = req.getParameter("idx_biz");
		String idx_biz="5";
//		[190119]---------------------------------------------------------
//		#로그인한 유저 정보로 펫 정보 가져오기
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		int idx = loginuser.getIdx();
		
		List<PetVO> petList = service.selectPetListByIdx(idx);
//		-----------------------------------------------------------------
		
		Biz_MemberVO bizmvo = service.selectBizMemberVOByIdx_biz(idx_biz);
		
		req.setAttribute("bizmvo", bizmvo);
		req.setAttribute("petList", petList);
		return "reservation/reservation.tiles2";
	}
	
	@RequestMapping(value="/selectScheduleList.pet", method= {RequestMethod.GET})
	@ResponseBody
	public List<HashMap<String, String>> selectScheduleList(HttpServletRequest req) {
		List<HashMap<String, String>> returnMapList = new ArrayList<HashMap<String, String>>();
		
		String idx_biz = req.getParameter("idx_biz");
		
		List<ScheduleVO> scheduleList = service.selectScheduleListByIdx_biz(idx_biz);
		
		for(ScheduleVO svo : scheduleList) {
			HashMap<String, String> returnMap = new HashMap<String, String>();
			
//			returnMap.put("title", svo.getSchedule_DATE().substring(svo.getSchedule_DATE().indexOf(" "))+"("+svo.getShowSchedule_status()+")");
			returnMap.put("title", svo.getShowSchedule_status());
			returnMap.put("start", svo.getSchedule_DATE());
			returnMap.put("end", svo.getEndtime());
			returnMap.put("schedule_status", Integer.toString(svo.getSchedule_status()));
			returnMap.put("schedule_UID", Integer.toString(svo.getSchedule_UID()));
			returnMapList.add(returnMap);
		}
		
		return returnMapList;
	}
	
	@RequestMapping(value="/selectPetOne.pet", method= {RequestMethod.GET})
	@ResponseBody
	public HashMap<String, String> selectPetOne(HttpServletRequest req){
		HashMap<String, String> returnMap = new HashMap<String, String>();
		
		String pet_UID = req.getParameter("pet_UID");
		PetVO petvo = service.selectPetOneByPet_UID(pet_UID);
		
		returnMap.put("pet_UID", String.valueOf(petvo.getPet_UID()));
		returnMap.put("pet_name", petvo.getPet_name());
		
		String pet_type=petvo.getPet_type();
		if(pet_type.equals("cat")) {
			pet_type="고양이";
		}
		else if(pet_type.equals("dog")) {
			pet_type="강아지";
		}
		else if(pet_type.equals("smallani")) {
			pet_type="소동물";
		}
		else if(pet_type.equals("etc")) {
			pet_type="기타분류";
		}
		returnMap.put("pet_type",pet_type);
		returnMap.put("pet_gender", petvo.getPet_gender());
		returnMap.put("pet_size", petvo.getPet_size());
		returnMap.put("pet_weight", String.valueOf(petvo.getPet_weight()));
		return returnMap;
	}
	
//	[190120] 예약하기 메소드
	@RequestMapping(value="/goReservation.pet", method= {RequestMethod.POST})
	public String goReservation(ReservationVO rvo, HttpServletRequest req) throws Throwable {
		String str_date = rvo.getReservation_DATE();
		String reservation_DATE = chageDateFormat(str_date);
		
		rvo.setReservation_DATE(reservation_DATE);
		
		if(rvo.getReservation_status() == null || rvo.getReservation_status() == "") {
			rvo.setReservation_status("1");
		}
		int result = service.insertReservationByRvo(rvo);
		
		String loc="";
		String msg = "";
		
		if(result ==1) {
			msg = "예약 성공";
			loc = req.getContextPath()+"/reservationList.pet";
		}
		else {
			msg = "예약 실패";
			loc="javascript:history.back();";
		}
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		return "msg";
	}
	
//	[190120] 예약하기 메소드; 수술 예약시
	@RequestMapping(value="/goReservationSurgery.pet", method= {RequestMethod.POST})
	public String goReservationSurgery(ReservationVO rvo, HttpServletRequest req) throws Throwable {
		
		String str_date = rvo.getReservation_DATE();
		String reservation_DATE = chageDateFormat(str_date);
		
		rvo.setReservation_DATE(reservation_DATE);
		HashMap<String, String> resultMap = service.insertReservationSurgeryByRvo(rvo);
		
		String loc="";
		String msg = "";
		String result = resultMap.get("result");
		System.out.println(result);
		if(result.equals("1")) {
			msg = "선예약 성공! 예치금 결제 페이지로 이동합니다.";
			loc = req.getContextPath()+"/goPayDeposit.pet?fk_reservation_UID="+resultMap.get("seq")+"&fk_idx="+rvo.getFk_idx();
		}
		else {
			msg = "예약 실패";
			loc="javascript:history.back();";
		}
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		return "msg";
	}

//	#수술 예약하기; 예치금 결제페이지로 이동
	@RequestMapping(value="/goPayDeposit.pet", method= {RequestMethod.GET})
	public String goPayDeposit(HttpServletRequest req, HttpServletResponse res) throws Throwable {
		String fk_reservation_UID = req.getParameter("fk_reservation_UID");
		String idx = req.getParameter("fk_idx");

		int depositAmount = service.selectSumDepositByIdx(idx);

		int point = service.selectPointByIdx(idx);
		HashMap<String, String> returnMap = service.selectUserReservationOneByFkRUID(fk_reservation_UID);

		if(depositAmount<100000) {
			req.setAttribute("msg", "예치금 잔액이 부족합니다. 예치금 충전 후 예약목록에서 예치금 결제를 진행하세요.");
			req.setAttribute("loc", req.getContextPath()+"/chargeDepositCoin.pet?idx="+idx+"&depositAmount="+depositAmount);
			return "msg";
		}
		else {
			req.setAttribute("idx", idx);
			req.setAttribute("depositAmount", depositAmount);
			req.setAttribute("point", point);
			req.setAttribute("fk_reservation_UID", fk_reservation_UID);
			req.setAttribute("returnMap", returnMap);
			return "reservation/payDeposit.tiles2";
		}
	}
	
//	#예치금 코인 결제 완료페이지; 트랜잭션 처리
	@RequestMapping(value="/goPayDepositEnd.pet", method= {RequestMethod.POST})
	public String goPayDepositEnd(PaymentVO pvo, HttpServletRequest req) throws Throwable {
		
		int result = service.goPayReservationDeposit(pvo);
		String loc="";
		String msg = "";
		
		if(result ==1) {
			msg = "결제 성공";
			loc = req.getContextPath()+"/reservationList.pet";
		}
		else {
			msg = "결제 실패";
			loc="javascript:history.back();";
		}
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		return "msg";
	}
	
	
//	#예약목록
	@RequestMapping(value="/reservationList.pet", method={RequestMethod.GET})
	public String requireLogin_reservationList(HttpServletRequest req, HttpServletResponse res) {
		List<HashMap<String, String>> reservationList = null;
		String str_currentShowPageNo = req.getParameter("currentShowPageNo");
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		int idx = loginuser.getIdx();
		
		HashMap<String, String> paraMap = new HashMap<String ,String>();
		paraMap.put("idx", String.valueOf(idx));
		
//		2) 페이지 구분을 위한 변수 선언하기
		int totalCount = 0;			// 조건에 맞는 총게시물의 개수
		int sizePerPage = 10;		// 한 페이지당 보여줄 게시물 개수
		int currentShowPageNo = 0;	// 현재 보여줄 페이지번호(초기치 1)
		int totalPage = 0;			// 총 페이지 수(웹브라우저 상에서 보여줄 총 페이지의 개수)
		
		int startRno = 0;			// 시작행 번호
		int endRno = 0;				// 마지막행 번호
		
		int blockSize = 3;			// 페이지바의 블럭(토막) 개수
		
		totalCount = service.getTotalCountNoSearch(idx);

		totalPage=(int)Math.ceil((double)totalCount/sizePerPage);
		
//		4) 현재 페이지 번호 셋팅하기
		if(str_currentShowPageNo == null) {
//			게시판 초기 화면의 경우
			currentShowPageNo=1;
		}
		else {
//			특정 페이지를 조회한 경우
			try {
			currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
			if(currentShowPageNo<1 || currentShowPageNo>totalPage) {
				currentShowPageNo = 1;
			}
			} catch(NumberFormatException e) {
				currentShowPageNo = 1;
			}
		}
		
//		5) 가져올 게시글의 범위 구하기(기존 공식과 다른 버전)
		startRno = ((currentShowPageNo-1) * sizePerPage)+1;
		endRno = startRno+sizePerPage -1; 
		
//		6) DB에서 조회할 조건들을 paraMap에 넣기
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		
//		7) 게시글 목록 가져오기
		reservationList = service.selectUserReservationList(paraMap);

//		#120. 페이지바 만들기(MyUtil에 있는 static메소드 사용)
		String pageBar = "<ul>";
		pageBar += MyUtil.getPageBar(sizePerPage, blockSize, totalPage, currentShowPageNo, "reservationList.pet");
		pageBar += "</ul>";
		
		session.setAttribute("readCountPermission", "yes");

		req.setAttribute("reservationList", reservationList);
		
//		#페이지바 넘겨주기
		req.setAttribute("pageBar", pageBar);
		
//		#currentURL 뷰로 보내기
		String currentURL = MyUtil.getCurrentURL(req);
		System.out.println(currentURL);
		if(currentURL.substring(currentURL.length()-5).equals("?null")) {
			currentURL = currentURL.substring(0 , currentURL.length()-5);
		}
		req.setAttribute("currentURL", currentURL);
		return "reservation/reservationList.tiles2";
	}

	
	@RequestMapping(value="/deposit.pet", method={RequestMethod.GET})
	public String requireLogin_depositList(HttpServletRequest req, HttpServletResponse res) {
		
		return "reservation/depositList.tiles2";
	}
	
//	[190126] 예치금 히스토리 목록
	@RequestMapping(value="/depositHistory.pet", method={RequestMethod.GET})
	@ResponseBody
	public List<HashMap<String, Object>> depositHistory(HttpServletRequest req, HttpServletResponse res) {
		List<HashMap<String, Object>> mapList = new ArrayList<HashMap<String, Object>>();
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		int idx = loginuser.getIdx();
		
		String currentShowPageNo = req.getParameter("currentShowPageNo");
		if(currentShowPageNo == null || "".equals(currentShowPageNo)) {
			currentShowPageNo = "1";
		}
		String type = req.getParameter("type");
		if(type == null || "".equals(type)) {
			type = "-1";
		}
		
		int sizePerPage = 10;	// 한 페이지 당 보여줄 댓글의 갯수
		int rno1 = Integer.parseInt(currentShowPageNo) * sizePerPage - (sizePerPage-1);
		int rno2 = Integer.parseInt(currentShowPageNo) * sizePerPage;
		
		HashMap<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("idx", String.valueOf(idx));
		paraMap.put("rno1", String.valueOf(rno1));
		paraMap.put("rno2", String.valueOf(rno2));
		paraMap.put("type", type);
		List<DepositVO> depositList = service.selectDepositListByIdx(paraMap);
		
		for(DepositVO dvo : depositList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("deposit_UID", dvo.getDeposit_UID());
			map.put("depositcoin", dvo.getDepositcoin());
			map.put("deposit_date", dvo.getDeposit_date());
			map.put("showDepositStatus", dvo.getShowDepositStatus());
			map.put("deposit_status", dvo.getDeposit_status());
			
			mapList.add(map);
		}
		
		return mapList;
	}
	
	@RequestMapping(value="/depositHistoryPageBar.pet", method={RequestMethod.GET})
	@ResponseBody
	public  HashMap<String, Integer> depositHistoryPageBar(HttpServletRequest req) {
		HashMap<String, Integer> returnMap = new HashMap<String, Integer>();
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String idx = String.valueOf(loginuser.getIdx());
		String sizePerPage = req.getParameter("sizePerPage");
		String type = req.getParameter("type");
		if(type == null || "".equals(type)) {
			type = "-1";
		}
		if(sizePerPage == null || "".equals(sizePerPage)) {
			sizePerPage = "5";
		}
		
		HashMap<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("idx", idx);
		paraMap.put("type", type);
		paraMap.put("sizePerPage", sizePerPage);
		int totalCount = service.selectDepositListTotalCount(paraMap);
		
//		총 페이지 수 구하기
//		ex) 57.0(행 개수)/10(sizePerPage) => 5.7 => 6.0 => 6
//		ex2) 57.0(행 개수)/5(sizePerPage) => 11.4 => 12.0 => 12
		int totalPage = (int)Math.ceil((double)totalCount/Integer.parseInt(sizePerPage));
		
		returnMap.put("totalPage", totalPage);
		returnMap.put("type", Integer.parseInt(type));
		return returnMap;

	}
	@RequestMapping(value="/SelectChartSearch.pet", method={RequestMethod.GET})
	public String requireLogin_selectChartSearch(HttpServletRequest req, HttpServletResponse res) {
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String membertype = loginuser.getMembertype();
		String idx_biz = String.valueOf(loginuser.getIdx());
		if(!"2".equals(membertype)) {
			session.invalidate(); // 강제 로그아웃(세션에서 지움)
			
			String msg = "접근이 불가합니다.";
			String loc = "javascript:history.back();";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "msg";

		}
		else {
			int scheduleCount = service.selectScheduleCountByIdx_biz(idx_biz);
			req.setAttribute("idx_biz", idx_biz);
			req.setAttribute("scheduleCount", scheduleCount);
			return "reservation/biz_rvCalendar.tiles2";
		}
	}
	
	@RequestMapping(value="/insertScheduleFirst.pet", method= {RequestMethod.GET})
	public String insertScheduleFirst(HttpServletRequest req) {
		String idx_biz = req.getParameter("idx_biz");

		String msg = "";
		String loc = "";
		
		try {
			service.insertScheduleFirst(idx_biz);
			msg = "스케줄 생성 성공!";
			loc = "javascript:loctaion.href='"+req.getContextPath()+"/SelectChartSearch.pet'";
		} catch (Exception e) {
			msg = "스케줄 생성 실패";
			loc="javascript:history.back();";
		}
	
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		return "msg";
	}
//	------------- 190126 끝
	
}
