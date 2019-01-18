package com.final2.petopia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.final2.petopia.model.Biz_MemberVO;
import com.final2.petopia.model.InterReservationDAO;
import com.final2.petopia.model.ScheduleVO;

@Service
public class ReservationService implements InterReservationService{

	@Autowired
	private InterReservationDAO dao;
	
//	#병원에 등록되어있는 예약스케줄 목록 가져오기(2주)	
	@Override
	public List<ScheduleVO> selectScheduleListByIdx_biz(String idx_biz) {
		List<ScheduleVO> scheduleList = dao.selectScheduleListByIdx_biz(idx_biz);
		return scheduleList;
	}

//	#병원 회원 정보 가져오기
	@Override
	public Biz_MemberVO selectBizMemberVOByIdx_biz(String idx_biz) {
		Biz_MemberVO bizmvo = dao.selectBizMemberVOByIdx_biz(idx_biz);
		return bizmvo;
	}

}
