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
}
