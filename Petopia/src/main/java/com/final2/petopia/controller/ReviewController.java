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

import com.final2.petopia.model.MemberVO;
import com.final2.petopia.service.InterReviewService;

@Controller
public class ReviewController {

	// === 2019.01.28 ==== //
	@Autowired
	private InterReviewService service;
	
	@RequestMapping(value="/myReviewList.pet", method={RequestMethod.GET})
	public String requireLogin_myReviewList(HttpServletRequest req, HttpServletResponse res) {
		return "review/myReviewList.tiles2";
	} // end of public String requireLogin_myReviewList(HttpServletRequest req, HttpServletRequest res)
	
	
	@RequestMapping(value="/selectMyReviewList.pet", method={RequestMethod.GET})
	@ResponseBody
	public List<HashMap<String, String>> selectMyReviewList(HttpServletRequest req) {
		
		List<HashMap<String, String>> hosList = new ArrayList<HashMap<String, String>>();
		
		String str_start = req.getParameter("start");
		String str_len = req.getParameter("len");
		String str_period = req.getParameter("period");
		
		int period = 0;
		try {
			period = Integer.parseInt(str_period);
		} catch(NumberFormatException e) {
			period = 0;
		}
		
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		HashMap<String, Integer> paramap = new HashMap<String, Integer>();
		paramap.put("PERIOD", period);
		paramap.put("IDX", loginuser.getIdx());
		
		int start = 0;
		if(str_start == null || "".equals(str_start)) {
			str_start = "1";
		}
		
		int len = 0;
		if(str_len == null || "".equals(str_len)) {
			str_len = "4";
		}
		
		try {
			start = Integer.parseInt(str_start);
			
		} catch(NumberFormatException e) {
			start = 1;
		} // try~catch
		
		try {
			len = Integer.parseInt(str_len);
			
		} catch(NumberFormatException e) {
			len = 1;
		} // try~catch
		
		int end = start+len;
		
		paramap.put("START", start);
		paramap.put("END", end);
		
		if(period == 0) {
			// 기간이 전체인 경우
			hosList = service.selectHosList(paramap);
		} else {
			// 기간이 정해진 경우
			hosList = service.selectHosListByPeriod(paramap);
		} // end of if~else
		
		return hosList;
	} // end of 
	// === 2019.01.28 ==== //
	
	// === 2019.01.29 ==== //
	@RequestMapping(value="/addReview.pet", method={RequestMethod.POST})
	public String requireLogin_addReview(HttpServletRequest req, HttpServletResponse res) {
		
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String startpoint = req.getParameter("startpoint");
		String fk_reservation_UID = req.getParameter("fk_reservation_UID");
		String rv_contents = req.getParameter("rv_contents");
		
		if(startpoint == null || "".equals(startpoint)) {
			startpoint = "0";
		}
		
		/*System.out.println("startpoint: "+startpoint);
		System.out.println("fk_reservation_UID: "+fk_reservation_UID);
		System.out.println("rv_contents: "+rv_contents);*/
		
		HashMap<String, String> reviewMap = new HashMap<String, String>();
		reviewMap.put("FK_IDX", String.valueOf(loginuser.getIdx()));
		reviewMap.put("FK_RESERVATION_UID", fk_reservation_UID);
		reviewMap.put("STARTPOINT", startpoint);
		reviewMap.put("FK_USERID", loginuser.getUserid());
		reviewMap.put("FK_NICKNAME", loginuser.getNickname());
		reviewMap.put("RV_CONTENTS", rv_contents);
		reviewMap.put("STARTPOINT", startpoint);
		
		int result = service.insertReviewByReviewMap(reviewMap);
		
		String msg = "";
		String loc = "";
		if(result == 0) {
			msg = "리뷰 등록 실패했습니다.";
			loc = "javascript:history.back();";
		} else {
			msg = "리뷰 등록 성공했습니다.";
			loc = req.getContextPath()+"/myReviewList.pet";
		} // end of if~else
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		return "msg";
	} //  end of public String requireLogin_addReview(HttpServletRequest req, HttpServletResponse res)
	// === 2019.01.29 ==== //
	
	// === 2019.01.30 ==== //
	// *** 나의 병원리뷰에서 예약코드로 리뷰 보기 *** //
	@RequestMapping(value="/selectMyReview.pet", method={RequestMethod.GET})
	@ResponseBody
	public HashMap<String, String> requireLogin_selectMyReview(HttpServletRequest req, HttpServletResponse res) {
		
		String str_fk_reservation_UID = req.getParameter("fk_reservation_UID");
		int fk_reservation_UID = 0;
		
		try {
			fk_reservation_UID = Integer.parseInt(str_fk_reservation_UID);
		} catch (NumberFormatException e) {
			fk_reservation_UID = 0;
		} // end of try~catch
		
		HashMap<String, String> reviewMap = service.selectMyReviewByReservationUID(fk_reservation_UID);
		
		return reviewMap;
	} // end of public String requireLogin_selectMyReview(HttpServletRequest req, HttpServletResponse res)
	
	// *** 나의 병원리뷰에서 리뷰번호로 리뷰 수정하기 *** //
	@RequestMapping(value="/updateMyReview.pet", method={RequestMethod.POST})
	public String requireLogin_updateMyReview(HttpServletRequest req, HttpServletResponse res) {
		
		String startpoint = req.getParameter("startpoint");
		String review_uid = req.getParameter("review_uid");
		String rv_contents = req.getParameter("rv_contents");
		
		HashMap<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("STARTPOINT", startpoint);
		paraMap.put("REVIEW_UID", review_uid);
		paraMap.put("RV_CONTENTS", rv_contents);
		
		int result = service.updateReviewByReviewUID(paraMap);
		
		String msg = "";
		String loc = "";
		if(result == 0) {
			msg = "리뷰 수정이 실패되었습니다.";
			loc = "javascript:histroy.back();";
		} else {
			msg = "리뷰 수정되었습니다.";
			loc = req.getContextPath()+"/myReviewList.pet";
		}
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		return "msg";
	} // end of public String requireLogin_updateMyReview(HttpServletRequest req, HttpServletResponse res)
	
	// *** 나의 병원리뷰에서 리뷰 삭제하기 *** //
	@RequestMapping(value="/updateReviewStatus.pet", method={RequestMethod.POST})
	public String requireLogin_updateReviewStatusByReviewUID(HttpServletRequest req, HttpServletResponse res) {
		
		String str_review_UID = req.getParameter("review_UID");
		
		int review_UID = 0;
		
		try {
			review_UID = Integer.parseInt(str_review_UID);
		} catch (NumberFormatException e) {
			review_UID = 0;
		}
		
		int result = service.updateReviewStatusByReviewUID(review_UID);
		
		String msg = "";
		String loc = "";
		if(result == 0) {
			msg = "리뷰 삭제가 실패되었습니다.";
			loc = "javascript:histroy.back();";
		} else {
			msg = "리뷰 삭제되었습니다.";
			loc = req.getContextPath()+"/myReviewList.pet";
		}
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		return "msg";
	} // end of public String requireLogin_updateReviewStatusByReviewUID(HttpServletRequest req, HttpServletResponse res)
	
	// *** 나의 병원리뷰에서 더보기를 위한 전체 갯수 가져오기 *** //
	@RequestMapping(value="/selectMyReviewTotalCount.pet", method={RequestMethod.GET})
	@ResponseBody
	public int requireLogin_selectMyReviewTotalCount(HttpServletRequest req, HttpServletResponse res) {
		
		int cnt = 0;
		
		String str_period = req.getParameter("period");
		
		int period = 0;
		
		if(str_period == null || "".equals(str_period)) {
			str_period = "0";
		}
		
		try {
			period = Integer.parseInt(str_period);
			
			if(period != 0 && period != 1 && period != 3 && period != 6) { // === 2019.01.30 === ||에서 &&로 수정//
				period = 0;
			}
		} catch (NumberFormatException e) {
			period = 0;
		} // end of try~catch
		
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		HashMap<String, Integer> paraMap = new HashMap<String, Integer>();
		paraMap.put("PERIOD", period);
		paraMap.put("IDX", loginuser.getIdx());
		
		if(period == 0) {
			cnt = service.selectTotalCount(paraMap);
		} else {
			cnt = service.selectTotalCountByPeriod(paraMap);
		} // end of if~else
		
		return cnt;
	} // end of public int requireLogin_selectMyReviewTotalCount(HttpServletRequest req, HttpServletResponse res)
	
	// === 2019.01.30 ==== //
	
	// === 2019.01.31 ==== //
	// 전체리뷰를 보여주는 페이지
	@RequestMapping(value="/allReviewList.pet", method={RequestMethod.GET})
	public String allReviewList() {
		
		return "review/allReviewList.tiles2";
	} // end of public String allReviewList()
	
	// 전체리뷰 목록 가져오는 ajax
	@RequestMapping(value="/selectReviewList.pet", method={RequestMethod.GET})
	@ResponseBody
	public List<HashMap<String, String>> selectReviewList(HttpServletRequest req) {
		
		List<HashMap<String, String>> reviewList = new ArrayList<HashMap<String, String>>();
		
		String str_currentPageNo = req.getParameter("currentPageNo");
		String str_period = req.getParameter("period");
		String searchWhat = req.getParameter("searchWhat");
		String search = req.getParameter("search");
		
		int sizePerPage = 10; // 한 페이지당 갯수
		int totalCnt = 0;
		
		int currentPageNo = 0;
		int period = 0;
		
		// 기간
		if(str_period == null || "".equals(str_period)) {
			str_period = "0";
		}
		
		try {
			period = Integer.parseInt(str_period);
			
			if(period != 0 && period != 1 && period != 3 && period != 6) { 
				period = 0;
			}
		} catch (NumberFormatException e) {
			period = 0;
		} // end of try~catch
		
		HashMap<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("PERIOD", String.valueOf(period));
		paraMap.put("SEARCHWHAT", searchWhat);
		paraMap.put("SEARCH", search);
		
		// 전체 갯수 알아오기 -> 페이징 처리를 위한
		if(period == 0) {
			// 기간이 없는 경우
			if(searchWhat == null || "".equals(searchWhat) || search == null || "".equals(search)) {
				// 검색이 없는 경우
				totalCnt = service.selectAllTotalCount(paraMap);
			} else {
				// 검색이 있는 경우
				totalCnt = service.selectAllTotalCountBySearch(paraMap);
			}// end of if~else
		} else {
			// 기간이 있는 경우
			if(searchWhat == null || "".equals(searchWhat) || search == null || "".equals(search)) {
				// 검색이 없는 경우
				totalCnt = service.selectAllTotalCountByPeriod(paraMap);
			} else {
				// 검색이 있는 경우
				totalCnt = service.selectAllTotalCountByPeriodSearch(paraMap);
			}// end of if~else
		} // end of if~else
		
		// 총페이지
		int totalPage = (int)Math.ceil((double)totalCnt/sizePerPage);
		
		// 페이지번호 
		if(str_currentPageNo == null || "".equals(str_currentPageNo)) {
			str_currentPageNo = "1";
		}
		
		try {
			currentPageNo = Integer.parseInt(str_currentPageNo);
			
			if(currentPageNo < 1 || currentPageNo > totalPage) {
				currentPageNo = 1;
			}
		} catch (NumberFormatException e) {
			currentPageNo = 1;
		}
		
		int startRno = ((currentPageNo-1) * sizePerPage) + 1;
		int endRno = (currentPageNo * sizePerPage);
		
		paraMap.put("STARTRNO", String.valueOf(startRno));
		paraMap.put("ENDRNO", String.valueOf(endRno));
		
		if(period == 0) {
			// 기간이 없는 경우
			if(searchWhat == null || "".equals(searchWhat) || search == null || "".equals(search)) {
				// 검색이 없는 경우
				reviewList = service.selectReviewList(paraMap);
			} else {
				// 검색이 있는 경우
				reviewList = service.selectReviewListBySearch(paraMap);
			}// end of if~else
		} else {
			// 기간이 있는 경우
			if(searchWhat == null || "".equals(searchWhat) || search == null || "".equals(search)) {
				// 검색이 없는 경우
				reviewList = service.selectReviewListByPeriod(paraMap);
			} else {
				// 검색이 있는 경우
				reviewList = service.selectReviewListByPeriodSearch(paraMap);
			}// end of if~else
		} // end of if~else
		
		return reviewList;
	} // end of public List<HashMap<String, String>> selectReviewList(HttpServletRequest req)
	
	@RequestMapping(value="/selectReviewListTotalPage.pet", method={RequestMethod.GET})
	@ResponseBody
	public int selectReviewListTotalPage(HttpServletRequest req) {
		int totalPage = 0;
		
		String str_period = req.getParameter("period");
		String searchWhat = req.getParameter("searchWhat");
		String search = req.getParameter("search");
		
		int sizePerPage = 10; // 한 페이지당 갯수
		int totalCnt = 0;
		
		int period = 0;
		
		// 기간
		if(str_period == null || "".equals(str_period)) {
			str_period = "0";
		}
		
		try {
			period = Integer.parseInt(str_period);
			
			if(period != 0 && period != 1 && period != 3 && period != 6) { 
				period = 0;
			}
		} catch (NumberFormatException e) {
			period = 0;
		} // end of try~catch
		
		HashMap<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("PERIOD", String.valueOf(period));
		paraMap.put("SEARCHWHAT", searchWhat);
		paraMap.put("SEARCH", search);
		
		// 전체 갯수 알아오기 -> 페이징 처리를 위한
		if(period == 0) {
			// 기간이 없는 경우
			if(searchWhat == null || "".equals(searchWhat) || search == null || "".equals(search)) {
				// 검색이 없는 경우
				totalCnt = service.selectAllTotalCount(paraMap);
			} else {
				// 검색이 있는 경우
				totalCnt = service.selectAllTotalCountBySearch(paraMap);
			}// end of if~else
		} else {
			// 기간이 있는 경우
			if(searchWhat == null || "".equals(searchWhat) || search == null || "".equals(search)) {
				// 검색이 없는 경우
				totalCnt = service.selectAllTotalCountByPeriod(paraMap);
			} else {
				// 검색이 있는 경우
				totalCnt = service.selectAllTotalCountByPeriodSearch(paraMap);
			}// end of if~else
		} // end of if~else
		
		// 총페이지
		totalPage = (int)Math.ceil((double)totalCnt/sizePerPage);
		
		return totalPage;
	} // end of public int selectReviewListTotalPage(HttpServletRequest req)
	
	
	@RequestMapping(value="/reviewDetail.pet", method={RequestMethod.GET})
	public String reviewDetail(HttpServletRequest req) {
		
		return "";
	}
	
	// === 2019.01.31 ==== //
	
}