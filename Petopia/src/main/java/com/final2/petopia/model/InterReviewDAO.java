package com.final2.petopia.model;

import java.util.HashMap;
import java.util.List;

public interface InterReviewDAO {

	// === 2019.01.28 ==== //
	// *** 리뷰 쓸 병원 리스트 조회 *** //
	int selectTotalCount(HashMap<String, Integer> paramap); // 병원 리스트 카운트 - 기간이 없는
	int selectTotalCountByPeriod(HashMap<String, Integer> paramap); // 병원 리스트 카운트 - 기간이 있는
	
	List<HashMap<String, String>> selectHosList(HashMap<String, Integer> paramap); // 병원 리스트 - 기간이 없는
	List<HashMap<String, String>> selectHosListByPeriod(HashMap<String, Integer> paramap);// 병원 리스트 - 기간이 있는
	// === 2019.01.28 ==== //

	// === 2019.01.29 ==== //
	// *** 리뷰 쓰기 *** //
	String selectBizIdxByReservationUID(String reservationUID); // 리뷰를 쓸 기업 번호 알아오기
	int insertReviewByReviewMap(HashMap<String, String> reviewMap); // review 테이블에 insert
	// === 2019.01.29 ==== //
	
	// === 2019.01.30 ==== //
	// *** 예약코드로 리뷰 보기 *** //
	HashMap<String, String> selectMyReviewByReservationUID(int fk_reservation_UID);
	
	// *** 리뷰번호로 리뷰 수정하기 *** //
	int updateReviewByReviewUID(HashMap<String, String> paraMap);
	
	// *** 리뷰번호로 리뷰 삭제하기 *** //
	int updateReviewStatusByReviewUID(int review_UID);
	// === 2019.01.30 ==== //
	
	// *** 전체 리뷰 갯수 *** //
	// === 2019.02.01 === //
	int selectAllTotalCount(HashMap<String, String> paraMap); // 기간X검색X
	int selectAllTotalCountBySearch(HashMap<String, String> paraMap); // 기간X검색O
	int selectAllTotalCountByPeriod(HashMap<String, String> paraMap); // 기간O검색X
	int selectAllTotalCountByPeriodSearch(HashMap<String, String> paraMap); // 기간O검색O
	// === 2019.02.01 === //
	
	// === 2019.01.31 ==== //
	// *** 전체 리뷰 목록 보기 *** //
	List<HashMap<String, String>> selectReviewList(HashMap<String, String> paraMap); // 기간X검색X
	// === 2019.01.31 ==== //
	// === 2019.02.01 === //
	List<HashMap<String, String>> selectReviewListBySearch(HashMap<String, String> paraMap); // 기간X검색O
	List<HashMap<String, String>> selectReviewListByPeriod(HashMap<String, String> paraMap); // 기간O검색X
	List<HashMap<String, String>> selectReviewListByPeriodSearch(HashMap<String, String> paraMap); // 기간O검색O
	// === 2019.02.01 === //
	
	// === 2019.02.03 === //
	// *** 리뷰 디테일 *** //
	HashMap<String, String> selectReviewByReview_UID(int review_UID);
	// === 2019.02.03 === //
	
	// === 2019.02.05 === //
	// *** 댓글 쓰기 *** //
	int insertReviewComments(HashMap<String, String> paraMap); // 댓글 insert
	int insertReviewNotification(HashMap<String, String> paraMap); // 알림 insert
	
	// *** 댓글 목록 *** //
	int selectReviewCommentsTotalCount(HashMap<String, Integer> paraMap); // 댓글 전체 갯수
	List<HashMap<String, String>> selectReviewCommentsListByReviewUID(HashMap<String, Integer> paraMap); // 댓글 전체 리스트
	// === 2019.02.05 === //
}