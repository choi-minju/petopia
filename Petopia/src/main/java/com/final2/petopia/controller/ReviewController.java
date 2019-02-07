package com.final2.petopia.controller;

import java.io.File;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.final2.petopia.common.FileManager;
import com.final2.petopia.model.MemberVO;
import com.final2.petopia.service.InterReviewService;

@Controller
public class ReviewController {

	// === 2019.01.28 ==== //
	@Autowired
	private InterReviewService service;
	
	// === 2019.02.03 === 파일 업로드를 위한 autowired //
	@Autowired
	private FileManager fileManager;
	// === 2019.02.03 === 파일 업로드를 위한 autowired //
	
	@RequestMapping(value="/myReviewList.pet", method={RequestMethod.GET})
	public String requireLogin_myReviewList(HttpServletRequest req, HttpServletResponse res) {
		return "review/myReviewList.tiles2";
	} // end of public String requireLogin_myReviewList(HttpServletRequest req, HttpServletRequest res)
	
	
	@RequestMapping(value="/selectMyReviewList.pet", method={RequestMethod.GET})
	@ResponseBody
	public List<HashMap<String, String>> requireLogin_selectMyReviewList(HttpServletRequest req, HttpServletResponse res) {
		
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
	} // end of public List<HashMap<String, String>> requireLogin_selectMyReviewList(HttpServletRequest req, HttpServletResponse res)
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
	@RequestMapping(value="/updateMyReviewStatus.pet", method={RequestMethod.POST}) // === 2019.02.04 === value 수정 //
	public String requireLogin_updateMyReviewStatusByReviewUID(HttpServletRequest req, HttpServletResponse res) { // === 2019.02.04 === 이름 수정 //
		
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
	} // end of public String requireLogin_updateMyReviewStatusByReviewUID(HttpServletRequest req, HttpServletResponse res)
	
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
	
	// === 2019.02.03 === 시작 //
	@RequestMapping(value="/reviewDetail.pet", method={RequestMethod.GET})
	public String reviewDetail(HttpServletRequest req) {
		String str_review_UID = req.getParameter("review_UID");
		
		int review_UID = 0;
		
		if(str_review_UID == null || "".equals(str_review_UID)) {
			str_review_UID = "0";
		}
		
		try {
			review_UID = Integer.parseInt(str_review_UID);
		} catch (NumberFormatException e) {
			review_UID = 0;
		} // end of try~catch
		
		HashMap<String, String> reviewMap = service.selectReviewByReview_UID(review_UID);
		
		req.setAttribute("reviewMap", reviewMap);
		
		// === 2019.02.06 ==== //
		HashMap<String, Integer> paraMap = new HashMap<String, Integer>();
		paraMap.put("REVIEW_UID", review_UID);
		
		// 전체 갯수 알아오기 -> 페이징 처리를 위한
		int totalCnt = service.selectReviewCommentsTotalCount(paraMap);
		
		req.setAttribute("totalCnt", totalCnt);
		// === 2019.02.06 ==== //
		
		return "review/reviewDetail.tiles2";
	} // end of public String reviewDetail(HttpServletRequest req)
	// === 2019.02.03 === 끝 //
	// === 2019.01.31 ==== //
	
	// === 2019.02.03 ==== summerNote의 이미지 업로드 //
	@RequestMapping(value="/summernoteImgUpload.pet", method={RequestMethod.POST})
	@ResponseBody
	public String summernoteImgUpload(MultipartHttpServletRequest req) {
		
		MultipartFile uploadFile = req.getFile("uploadFile");
		
		String newFileName = "";
		if(!uploadFile.isEmpty()) {
			// 파일 경로
			HttpSession session = req.getSession();
			String root = session.getServletContext().getRealPath("/");
			String path = root+"resources"+File.separator+"img"+File.separator+"review";
			
			byte[] bytes = null; // 첨부파일을 WAS(톰캣)에 저장할때 사용되는 용도
			
			try {
				bytes = uploadFile.getBytes(); // 첨부된 파일을 바이트 단위로 파일을 다 읽어오는 것
				
				newFileName = fileManager.doFileUpload(bytes, uploadFile.getOriginalFilename(), path);
				// 첨부된 파일을 WAS(톰캣)의 디스크로 파일올리기를 하는 것
				
				//System.out.println(">>> 확인용 newFileName ==> "+newFileName);
			} catch (Exception e) {
				e.printStackTrace();
			} // end of try~catch
		} // end of if
		
		return newFileName;
	} // end of public String summernoteImgUpload(MultipartHttpServletRequest req)
	// === 2019.02.03 ==== summerNote의 이미지 업로드 //
	
	// === 2019.02.04 ==== //
	// *** 리뷰 수정하는 페이지 보기 *** //
	@RequestMapping(value="/editReview.pet", method={RequestMethod.GET})
	public String requireLogin_editReview(HttpServletRequest req, HttpServletResponse res) {
		
		String str_review_UID = req.getParameter("review_UID");
		
		int review_UID = 0;
		if(str_review_UID == null || "".equals(str_review_UID)) {
			str_review_UID = "0";
		}
		
		try {
			review_UID = Integer.parseInt(str_review_UID);
		} catch (NumberFormatException e) {
			review_UID = 0;
		} // end of try~catch
		
		HashMap<String, String> reviewMap = service.selectReviewByReview_UID(review_UID);
		
		req.setAttribute("reviewMap", reviewMap);
		
		return "review/reviewEdit.tiles2";
	} // end of public String requireLogin_editReview(HttpServletRequest req, HttpServletResponse res)
	
	// *** 리뷰 수정하기 *** //
	@RequestMapping(value="/updateReview.pet", method={RequestMethod.POST})
	public String requireLogin_updateReview(HttpServletRequest req, HttpServletResponse res) {
		
		String str_review_UID = req.getParameter("review_UID");
		String str_startpoint = req.getParameter("startpoint");
		String rv_contents = req.getParameter("rv_contents");
	
		// 번호
		int review_UID = 0;
		if(str_review_UID == null || "".equals(str_review_UID)) {
			str_review_UID = "0";
		}
		
		try {
			review_UID = Integer.parseInt(str_review_UID);
		} catch (NumberFormatException e) {
			review_UID = 0;
		} // end of try~catch
		
		// 별점
		int startpoint = 0;
		if(str_startpoint == null || "".equals(str_startpoint)) {
			str_startpoint = "0";
		}
		
		try {
			startpoint = Integer.parseInt(str_startpoint);
		} catch (NumberFormatException e) {
			startpoint = 0;
		} // end of try~catch
		
		HashMap<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("STARTPOINT", String.valueOf(startpoint));
		paraMap.put("REVIEW_UID", String.valueOf(review_UID));
		paraMap.put("RV_CONTENTS", rv_contents);
		
		int result = service.updateReviewByReviewUID(paraMap);
		
		String msg = "";
		String loc = "";
		if(result == 0) {
			msg = "리뷰 수정이 실패되었습니다.";
			loc = "javascript:histroy.back();";
		} else {
			msg = "리뷰 수정되었습니다.";
			loc = req.getContextPath()+"/reviewDetail.pet?review_UID="+review_UID;
		}
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		return "msg";
	} // end of public String requireLogin_updateReview(HttpServletRequest req, HttpServletResponse res)
	
	// *** 리뷰 삭제하기 *** //
	@RequestMapping(value="/updateReviewStatus.pet", method={RequestMethod.POST})
	public String requireLogin_updateReviewStatus(HttpServletRequest req, HttpServletResponse res) {
		
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
			loc = req.getContextPath()+"/allReviewList.pet";
		}
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		return "msg";
	} // end of public String requireLogin_updateReviewStatus(HttpServletRequest req, HttpServletResponse res)
	// === 2019.02.04 ==== //
	
	// === 2019.02.05 ==== //
	// 댓글 쓰기
	@RequestMapping(value="/addComments.pet", method={RequestMethod.POST})
	@ResponseBody
	public int requireLogin_addComments(HttpServletRequest req, HttpServletResponse res) {
		
		int result = 0;
		
		String str_review_uid = req.getParameter("review_uid");
		String rc_content = req.getParameter("rc_content");
		String fk_userid = req.getParameter("fk_userid");
		
		int review_UID = 0;
		try {
			review_UID = Integer.parseInt(str_review_uid);
		} catch (NumberFormatException e) {
			review_UID = 0;
		} // end of try~catch
		
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		HashMap<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("FK_REVIEW_UID", String.valueOf(review_UID));
		paraMap.put("RC_CONTENT", rc_content);
		paraMap.put("FK_IDX", String.valueOf(loginuser.getIdx()));
		paraMap.put("RC_NICKNAME", loginuser.getNickname());
		paraMap.put("RC_CONTENT", rc_content);
		
		if((loginuser.getUserid()).equals(fk_userid)) {
			// 로그인한 아이디와 작성자가 같다면 댓글 insert
			result = service.insertReviewComments(paraMap);
		} else {
			// 로그인한 아이디와 작성자가 같지 않다면 댓글 insert+알림 insert
			paraMap.put("NOT_MESSAGE", "리뷰댓글이 추가되었습니다.");
			paraMap.put("NOT_URL", req.getContextPath()+"/reviewDetail.pet?review_UID="+review_UID);
			
			result = service.insertReviewCommentsNotification(paraMap);
		} // end of if~else
		
		return result;
	} // end of public int requireLogin_addComments(HttpServletRequest req, HttpServletResponse res)
	
	// *** 댓글 목록 보기 *** //
	@RequestMapping(value="/selectReviewCommentsList.pet", method={RequestMethod.GET})
	@ResponseBody
	public List<HashMap<String, String>> selectReviewCommentsList(HttpServletRequest req) {
		
		String str_currentPageNo = req.getParameter("currentPageNo");
		String str_review_uid = req.getParameter("review_uid");
		
		int currentPageNo = 0;
		int review_uid = 0;
		int sizePerPage = 10;
		
		// review_uid
		if(str_review_uid == null || "".equals(str_review_uid)) {
			str_review_uid = "0";
		}
		
		try {
			review_uid = Integer.parseInt(str_review_uid);
		} catch (NumberFormatException e) {
			review_uid = 0;
		} // end of try~catch
		
		HashMap<String, Integer> paraMap = new HashMap<String, Integer>();
		paraMap.put("REVIEW_UID", review_uid);
		
		// 전체 갯수 알아오기 -> 페이징 처리를 위한
		int totalCnt = service.selectReviewCommentsTotalCount(paraMap);
		
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
		
		paraMap.put("STARTRNO", startRno);
		paraMap.put("ENDRNO", endRno);
		
		List<HashMap<String, String>> reviewCommentsList = service.selectReviewCommentsListByReviewUID(paraMap);
		
		return reviewCommentsList;
	} // end of public List<HashMap<String, String>> selectReviewCommentsList(HttpServletRequest req)
	// === 2019.02.05 ==== //
	
	// === 2019.02.06 ==== //
	// 페이지바를 만들기 위한 페이지 갯수 알아오기
	@RequestMapping(value="/selectReviewCommentsTotalPage.pet", method={RequestMethod.GET})
	@ResponseBody
	public int selectReviewCommentsTotalPage(HttpServletRequest req) {
		int totalPage = 0;
		
		String str_review_uid = req.getParameter("review_uid");
		
		int review_uid = 0;
		int sizePerPage = 10;
		
		// review_uid
		if(str_review_uid == null || "".equals(str_review_uid)) {
			str_review_uid = "0";
		}
		
		try {
			review_uid = Integer.parseInt(str_review_uid);
		} catch (NumberFormatException e) {
			review_uid = 0;
		} // end of try~catch
		
		HashMap<String, Integer> paraMap = new HashMap<String, Integer>();
		paraMap.put("REVIEW_UID", review_uid);
		
		// 전체 갯수 알아오기 -> 페이징 처리를 위한
		int totalCnt = service.selectReviewCommentsTotalCount(paraMap);
		
		// 총페이지
		totalPage = (int)Math.ceil((double)totalCnt/sizePerPage);
		
		return totalPage;
	} // end of public int selectReviewCommentsTotalPage(HttpServletRequest req)
	
	// === 2019.02.06 ==== //
}