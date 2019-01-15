package com.final2.petopia.model;

import java.util.List;

public interface InterReservationDAO {

//	#병원에 등록되어있는 예약스케줄 목록 가져오기(2주)
	List<ScheduleVO> selectScheduleListByIdx_biz(String idx_biz);

}
