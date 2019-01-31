package com.final2.petopia.service;

import java.util.HashMap;
import java.util.List;

public interface InterReviewService {

	// === 2019.01.28 ==== //
	// *** 리뷰 쓸 병원 리스트 조회 *** //
	int selectTotalCount(HashMap<String, Integer> paramap); // 병원 리스트 카운트 - 기간이 없는
	int selectTotalCountByPeriod(HashMap<String, Integer> paramap); // 병원 리스트 카운트 - 기간이 있는
	
	List<HashMap<String, String>> selectHosList(HashMap<String, Integer> paramap); // 병원 리스트 - 기간이 없는
	List<HashMap<String, String>> selectHosListByPeriod(HashMap<String, Integer> paramap); // 병원 리스트 - 기간이 있는
	// === 2019.01.28 ==== //
	
	// === 2019.01.29 ==== //
	// *** 리뷰 쓰기 *** //
	int insertReviewByReviewMap(HashMap<String, String> reviewMap);
	// === 2019.01.29 ==== //
	
	// === 2019.01.30 ==== //
	// *** 예약코드로 리뷰 보기 *** //
	HashMap<String, String> selectMyReviewByReservationUID(int fk_reservation_UID);
	
	// *** 리뷰번호로 리뷰 수정하기 *** //
	int updateReviewByReviewUID(HashMap<String, String> paraMap);
	
	// *** 리뷰번호로 리뷰 삭제하기 *** //
	int updateReviewStatusByReviewUID(int review_UID);
	// === 2019.01.30 ==== //
	
}
