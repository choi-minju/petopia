package com.final2.petopia.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.final2.petopia.model.InterReviewDAO;

@Service
public class ReviewService implements InterReviewService {
	
	// === 2019.01.28 ==== //
	@Autowired
	private InterReviewDAO dao;

	// *** 리뷰 쓸 병원 리스트 조회 *** //
	// 병원 리스트 카운트
	@Override
	public int selectTotalCount(HashMap<String, Integer> paramap) {
		int cnt = dao.selectTotalCount(paramap);
		
		return cnt;
	} // end of public int selectTotalCount(HashMap<String, Integer> paramap)

	// 병원 리스트 카운트 - 기간이 없는
	@Override
	public int selectTotalCountByPeriod(HashMap<String, Integer> paramap) {
		int cnt = dao.selectTotalCountByPeriod(paramap);
		
		return cnt;
	} // end of public int selectTotalCountByPeriod(HashMap<String, Integer> paramap)

	// 병원 리스트 - 기간이 없는
	@Override
	public List<HashMap<String, String>> selectHosList(HashMap<String, Integer> paramap) {
		List<HashMap<String, String>> hosList = dao.selectHosList(paramap);
		
		return hosList;
	} // end of public List<HashMap<String, Object>> selectHosList(HashMap<String, Integer> paramap)

	// 병원 리스트 - 기간이 있는
	@Override
	public List<HashMap<String, String>> selectHosListByPeriod(HashMap<String, Integer> paramap) {
		List<HashMap<String, String>> hosList = dao.selectHosListByPeriod(paramap);
		
		return hosList;
	} // end of public List<HashMap<String, Object>> selectHosListByPeriod(HashMap<String, Integer> paramap)
	// === 2019.01.28 ==== //
	
	// === 2019.01.29 ==== //
	// *** 리뷰 쓰기 *** //
	@Override
	public int insertReviewByReviewMap(HashMap<String, String> reviewMap) {
		
		// 리뷰를 쓸 기업 번호 알아오기
		String fk_idx_biz = dao.selectBizIdxByReservationUID(reviewMap.get("FK_RESERVATION_UID"));
		
		reviewMap.put("FK_IDX_BIZ", fk_idx_biz);
		
		// review 테이블에 insert
		int result = dao.insertReviewByReviewMap(reviewMap);
		
		return result;
	} // end of public int insertReviewByReviewMap(HashMap<String, String> reviewMap)
	// === 2019.01.29 ==== //
	
	// === 2019.01.30 ==== //
	// *** 예약코드로 리뷰 보기 *** //
	@Override
	public HashMap<String, String> selectMyReviewByReservationUID(int fk_reservation_UID) {
		HashMap<String, String> reviewMap = dao.selectMyReviewByReservationUID(fk_reservation_UID);
		
		return reviewMap;
	} // end of public HashMap<String, String> selectMyReviewByReservationUID(int fk_reservation_UID)
	
	// *** 리뷰번호로 리뷰 수정하기 *** //
	@Override
	public int updateReviewByReviewUID(HashMap<String, String> paraMap) {
		int result = dao.updateReviewByReviewUID(paraMap);
		
		return result;
	} // end of public int updateReviewByReviewUID(HashMap<String, String> paraMap)

	// *** 리뷰번호로 리뷰 삭제하기 *** //
	@Override
	public int updateReviewStatusByReviewUID(int review_UID) {
		int result = dao.updateReviewStatusByReviewUID(review_UID);
		
		return result;
	} // end of public int updateReviewStatusByReviewUID(String review_UID)
	// === 2019.01.30 ==== //
}
