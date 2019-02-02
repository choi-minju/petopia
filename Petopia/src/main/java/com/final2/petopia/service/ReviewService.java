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

	// === 2019.02.01 === //
	// *** 전체 리뷰 갯수 *** //
	// 기간X검색X
	@Override
	public int selectAllTotalCount(HashMap<String, String> paraMap) {
		int totalCnt = dao.selectAllTotalCount(paraMap);
		
		return totalCnt;
	} // end of public int selectAllTotalCount(HashMap<String, String> paraMap)
	
	// 기간X검색O
	@Override
	public int selectAllTotalCountBySearch(HashMap<String, String> paraMap) {
		int totalCnt = dao.selectAllTotalCountBySearch(paraMap);
		
		return totalCnt;
	} // end of public int selectAllTotalCountBySearch(HashMap<String, String> paraMap)

	// 기간O검색X
	@Override
	public int selectAllTotalCountByPeriod(HashMap<String, String> paraMap) {
		int totalCnt = dao.selectAllTotalCountByPeriod(paraMap);
		
		return totalCnt;
	} // end of public int selectAllTotalCountByPeriod(HashMap<String, String> paraMap)

	// 기간O검색O
	@Override
	public int selectAllTotalCountByPeriodSearch(HashMap<String, String> paraMap) {
		int totalCnt = dao.selectAllTotalCountByPeriodSearch(paraMap);
		
		return totalCnt;
	} // end of public int selectAllTotalCountByPeriodSearch(HashMap<String, String> paraMap)
	
	// === 2019.01.31 ==== //
	// *** 전체 리뷰 목록 보기 *** //
	// 기간X검색X
	@Override
	public List<HashMap<String, String>> selectReviewList(HashMap<String, String> paraMap) {
		List<HashMap<String, String>> reviewList = dao.selectReviewList(paraMap);
		
		return reviewList;
	} // end of public List<HashMap<String, String>> selectReviewList(HashMap<String, String> paraMap)
	// === 2019.01.31 ==== //

	// === 2019.02.01 === //
	// 기간X검색O
	@Override
	public List<HashMap<String, String>> selectReviewListBySearch(HashMap<String, String> paraMap) {
		List<HashMap<String, String>> reviewList = dao.selectReviewListBySearch(paraMap);
		
		return reviewList;
	} // end of public List<HashMap<String, String>> selectReviewListBySearch(HashMap<String, String> paraMap)

	// 기간O검색X
	@Override
	public List<HashMap<String, String>> selectReviewListByPeriod(HashMap<String, String> paraMap) {
		List<HashMap<String, String>> reviewList = dao.selectReviewListByPeriod(paraMap);
		
		return reviewList;
	} // end of public List<HashMap<String, String>> selectReviewListByPeriod(HashMap<String, String> paraMap)

	// 기간O검색O
	@Override
	public List<HashMap<String, String>> selectReviewListByPeriodSearch(HashMap<String, String> paraMap) {
		List<HashMap<String, String>> reviewList = dao.selectReviewListByPeriodSearch(paraMap);
		
		return reviewList;
	} // end of public List<HashMap<String, String>> selectReviewListByPeriodSearch(HashMap<String, String> paraMap)
	// === 2019.02.01 === //
	
	
}
