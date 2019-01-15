package com.final2.petopia.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReservationDAO implements InterReservationDAO {
	

//	===== #DI(의존객체) 주입하기
	@Autowired
	private SqlSessionTemplate sqlsession;	
	
	
//	#병원에 등록되어있는 예약스케줄 목록 가져오기(2주)
	@Override
	public List<ScheduleVO> selectScheduleListByIdx_biz(String idx_biz) {
		List<ScheduleVO> scheduleList = sqlsession.selectList("reservation.selectScheduleListByIdx_biz", idx_biz);
		return scheduleList;
	}

}
