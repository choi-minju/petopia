package com.final2.petopia.service;

import java.util.List;

import com.final2.petopia.model.Biz_MemberVO;
import com.final2.petopia.model.ScheduleVO;

public interface InterReservationService {

//	#병원에 등록되어있는 예약스케줄 목록 가져오기(2주)
	List<ScheduleVO> selectScheduleListByIdx_biz(String idx_biz);

//	#예약 페이지 갈 때 병원정보 조회하기
	Biz_MemberVO selectBizMemberVOByIdx_biz(String idx_biz);

}
