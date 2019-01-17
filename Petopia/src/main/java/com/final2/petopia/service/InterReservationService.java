package com.final2.petopia.service;

import java.util.List;

import com.final2.petopia.model.ScheduleVO;

public interface InterReservationService {

//	#병원에 등록되어있는 예약스케줄 목록 가져오기(2주)
	List<ScheduleVO> selectScheduleListByIdx_biz(String idx_biz);

}
