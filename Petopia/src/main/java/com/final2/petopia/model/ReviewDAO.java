package com.final2.petopia.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReviewDAO implements InterReviewDAO {

	// === 2019.01.28 ==== //
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	// *** 리뷰 쓸 병원 리스트 조회 *** //
	// 병원 리스트 카운트 - 기간이 없는
	@Override
	public int selectTotalCount(HashMap<String, Integer> paramap) {
		int cnt = sqlsession.selectOne("review.selectTotalCount", paramap);
		
		return cnt;
	} // end of public int selectTotalCount()

	// 병원 리스트 카운트 - 기간이 있는
	@Override
	public int selectTotalCountByPeriod(HashMap<String, Integer> paramap) {
		int cnt = sqlsession.selectOne("review.selectTotalCountByPeriod", paramap);
		
		return cnt;
	} // end of public int selectTotalCountByPeriod(HashMap<String, Integer> paramap)

	// 병원 리스트 - 기간이 없는
	@Override
	public List<HashMap<String, String>> selectHosList(HashMap<String, Integer> paramap) {
		List<HashMap<String, String>> hosList = sqlsession.selectList("review.selectHosList", paramap);
		
		return hosList;
	} // end of public List<HashMap<String, Object>> selectHosList(HashMap<String, Integer> paramap)

	// 병원 리스트 - 기간이 있는
	@Override
	public List<HashMap<String, String>> selectHosListByPeriod(HashMap<String, Integer> paramap) {
		List<HashMap<String, String>> hosList = sqlsession.selectList("review.selectHosListByPeriod", paramap);

		return hosList;
	} // end of public List<HashMap<String, Object>> selectHosListByPeriod(HashMap<String, Integer> paramap)
	// === 2019.01.28 ==== //
	
	// === 2019.01.29 ==== //
	// *** 리뷰 쓰기 *** //
	// 리뷰를 쓸 기업 번호 알아오기
	@Override
	public String selectBizIdxByReservationUID(String reservationUID) {
		String bizIdx = sqlsession.selectOne("review.selectBizIdxByReservationUID", reservationUID);
		
		return bizIdx;
	} // end of public String selectBizIdxByReservationUID(String string)

	// review 테이블에 insert
	@Override
	public int insertReviewByReviewMap(HashMap<String, String> reviewMap) {
		int result = sqlsession.insert("review.insertReviewByReviewMap", reviewMap);
		
		return result;
	} // end of public int insertReviewByReviewMap(HashMap<String, String> reviewMap)
	// === 2019.01.29 ==== //

	// === 2019.01.30 ==== //
	// *** 예약코드로 리뷰 보기 *** //
	@Override
	public HashMap<String, String> selectMyReviewByReservationUID(int fk_reservation_UID) {
		HashMap<String, String> reviewMap = sqlsession.selectOne("review.selectMyReviewByReservationUID", fk_reservation_UID);
		
		return reviewMap;
	} // end of public HashMap<String, String> selectMyReviewByReservationUID(int fk_reservation_UID)

	// *** 리뷰번호로 리뷰 수정하기 *** //
	@Override
	public int updateReviewByReviewUID(HashMap<String, String> paraMap) {
		int result = sqlsession.update("review.updateReviewByReviewUID", paraMap);
		
		return result;
	} // end of public int updateReviewByReviewUID(HashMap<String, String> paraMap)

	// *** 리뷰번호로 리뷰 삭제하기 *** //
	@Override
	public int updateReviewStatusByReviewUID(int review_UID) {
		int result = sqlsession.update("review.updateReviewStatusByReviewUID", review_UID);
		
		return result;
	} // end of public int updateReviewStatusByReviewUID(int review_UID)
	// === 2019.01.30 ==== //

	// === 2019.02.01 === //
	// *** 전체 리뷰 갯수 *** //
	// 기간X검색X
	@Override
	public int selectAllTotalCount(HashMap<String, String> paraMap) {
		int totalCnt = sqlsession.selectOne("review.selectAllTotalCount", paraMap);
		
		return totalCnt;
	} // end of public int selectAllTotalCount(HashMap<String, String> paraMap)

	// 기간X검색o
	@Override
	public int selectAllTotalCountBySearch(HashMap<String, String> paraMap) {
		int totalCnt = sqlsession.selectOne("review.selectAllTotalCountBySearch", paraMap);
		
		return totalCnt;
	} // end of public int selectAllTotalCountBySearch(HashMap<String, String> paraMap)

	// 기간O검색X
	@Override
	public int selectAllTotalCountByPeriod(HashMap<String, String> paraMap) {
		int totalCnt = sqlsession.selectOne("review.selectAllTotalCountByPeriod", paraMap);
		
		return totalCnt;
	} // end of public int selectAllTotalCountByPeriod(HashMap<String, String> paraMap)

	// 기간O검색O
	@Override
	public int selectAllTotalCountByPeriodSearch(HashMap<String, String> paraMap) {
		int totalCnt = sqlsession.selectOne("review.selectAllTotalCountByPeriodSearch", paraMap);
		
		return totalCnt;
	} // end of public int selectAllTotalCountByPeriodSearch(HashMap<String, String> paraMap)
	
	// === 2019.01.31 ==== //
	// *** 전체 리뷰 목록 보기 *** //
	// 기간X검색X
	@Override
	public List<HashMap<String, String>> selectReviewList(HashMap<String, String> paraMap) {
		List<HashMap<String, String>> reviewList = sqlsession.selectList("review.selectReviewList", paraMap);
		
		return reviewList;
	} // end of public List<HashMap<String, String>> selectReviewList(HashMap<String, String> paraMap)
	// === 2019.01.31 ==== //

	// === 2019.02.01 === //
	// 기간X검색O
	@Override
	public List<HashMap<String, String>> selectReviewListBySearch(HashMap<String, String> paraMap) {
		List<HashMap<String, String>> reviewList = sqlsession.selectList("review.selectReviewListBySearch", paraMap);
		
		return reviewList;
	} // end of public List<HashMap<String, String>> selectReviewListBySearch(HashMap<String, String> paraMap)

	// 기간O검색X
	@Override
	public List<HashMap<String, String>> selectReviewListByPeriod(HashMap<String, String> paraMap) {
		List<HashMap<String, String>> reviewList = sqlsession.selectList("review.selectReviewListByPeriod", paraMap);
		
		return reviewList;
	} // end of public List<HashMap<String, String>> selectReviewListByPeriod(HashMap<String, String> paraMap)

	// 기간O검색O
	@Override
	public List<HashMap<String, String>> selectReviewListByPeriodSearch(HashMap<String, String> paraMap) {
		List<HashMap<String, String>> reviewList = sqlsession.selectList("review.selectReviewListByPeriodSearch", paraMap);
		
		return reviewList;
	} // end of public List<HashMap<String, String>> selectReviewListByPeriodSearch(HashMap<String, String> paraMap)
	// === 2019.02.01 === //
	
	// === 2019.02.03 === //
	// *** 리뷰 디테일 *** //
	@Override
	public HashMap<String, String> selectReviewByReview_UID(int review_UID) {
		HashMap<String, String> reviewMap = sqlsession.selectOne("review.selectReviewByReview_UID", review_UID);
		
		return reviewMap;
	} // end of public HashMap<String, String> selectReviewByReview_UID(int review_UID)
	// === 2019.02.03 === //

	// === 2019.02.05 === //
	// *** 댓글 쓰기 *** //
	// 댓글 insert
	@Override
	public int insertReviewComments(HashMap<String, String> paraMap) {
		int result = sqlsession.insert("review.insertReviewComments", paraMap);
		
		return result;
	} // end of public int insertReviewComments(HashMap<String, String> paraMap)

	// 알림 insert
	@Override
	public int insertReviewNotification(HashMap<String, String> paraMap) {
		int result = sqlsession.insert("review.insertReviewNotification", paraMap);;
		
		return result;
	} // end of public int insertReviewNotification(HashMap<String, String> paraMap)
	
	// *** 댓글 목록 *** //
	// 댓글 전체 갯수
	@Override
	public int selectReviewCommentsTotalCount(HashMap<String, Integer> paraMap) {
		int totalCnt = sqlsession.selectOne("review.selectReviewCommentsTotalCount", paraMap);
		
		return totalCnt;
	} // end of public int selectReviewCommentsTotalCount(HashMap<String, Integer> paraMap)

	// 댓글 전체 리스트
	@Override
	public List<HashMap<String, String>> selectReviewCommentsListByReviewUID(HashMap<String, Integer> paraMap) {
		List<HashMap<String, String>> reviewCommentsList = sqlsession.selectList("review.selectReviewCommentsListByReviewUID", paraMap);
		
		return reviewCommentsList;
	} // end of public List<HashMap<String, String>> selectReviewCommentsListByReviewUID(HashMap<String, Integer> paraMap)
	// === 2019.02.05 === //

}

