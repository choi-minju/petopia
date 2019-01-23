package com.final2.petopia.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReservationDAO implements InterReservationDAO {
	

//	===== #DI(의존객체) 주입하기
	@Autowired
	private SqlSessionTemplate sqlsession;	
	
	String ns ="reservation.";
//	#병원에 등록되어있는 예약스케줄 목록 가져오기(2주)
	@Override
	public List<ScheduleVO> selectScheduleListByIdx_biz(String idx_biz) {
		List<ScheduleVO> scheduleList = sqlsession.selectList(ns+"selectScheduleListByIdx_biz", idx_biz);
		return scheduleList;
	}

//	#병원 회원 정보 가져오기
	@Override
	public Biz_MemberVO selectBizMemberVOByIdx_biz(String idx_biz) {
		Biz_MemberVO bizmvo = sqlsession.selectOne(ns+"selectBizMemberVOByIdx_biz", idx_biz);
		return bizmvo;
	}
	
//	[190119]-------------------------------------------------------------------------------
//	#로그인 회원 idx로 펫 리스트 select하기
	@Override
	public List<PetVO> selectPetListByIdx(int idx) {
		List<PetVO> petList = sqlsession.selectList(ns+"selectPetListByIdx", idx);
		return petList;
	}
	
//	#반려동물 드롭박스에서 선택시 1마리 동물정보 가져오기
	@Override
	public PetVO selectPetOneByPet_UID(String pet_UID) {
		PetVO petvo = sqlsession.selectOne(ns+"selectPetOneByPet_UID", pet_UID);
		return petvo;
	}
//	[190120]
//	#예약VO로 예약테이블에 insert하기; 결제X
	@Override
	public int insertReservationByRvo(ReservationVO rvo) {
		int result = sqlsession.insert(ns+"insertReservationByRvo", rvo);
		return result;
	}

//	#예약일정 인서트 성공시 스케줄테이블의 스케줄 상태 변경 트랜잭션 처리
	@Override
	public int updateScheduleStatusBySUID(String fk_schedule_UID) {
		int result = sqlsession.update(ns+"updateScheduleStatusBySUID", fk_schedule_UID);
		return result;
	}
	
//	#예약테이블 시퀀스 채번
	@Override
	public String selectReservation_Seq() {
		String seq = sqlsession.selectOne(ns+"selectReservation_Seq");
		return seq;
	}
	
//	#예약VO로 예약테이블에 insert하기; 결제O
	@Override
	public int insertReservationSurgeryByRvo(ReservationVO rvo) {
		int result = sqlsession.insert(ns+"insertReservationSurgeryByRvo", rvo);
		return result;
	}
//	#회원번호로 예치금 잔액 가져오기
	@Override
	public int selectSumDepositByIdx(String idx) {
		int depositAmount = sqlsession.selectOne(ns+"selectSumDepositByIdx", idx);
		return depositAmount;
	}
//	#회원번호로 포인트 가져오기
	@Override
	public int selectPointByIdx(String idx) {
		int point = sqlsession.selectOne(ns+"selectPointByIdx", idx);
		return point;
	}	
//	#예약번호로 예약VO 가져오기
	@Override
	public HashMap<String, String> selectUserReservationOneByFkRUID(String fk_reservation_UID) {
		HashMap<String, String> returnMap = sqlsession.selectOne(ns+"selectUserReservationOneByFkRUID", fk_reservation_UID);
		return returnMap;
	}
	
	
//	#수술예약 시 예치금결제 후 결제테이블에 insert
	@Override
	public int insertPaymentByPvo(PaymentVO pvo) {
		int result = sqlsession.update(ns+"insertPaymentByPvo", pvo);
		return result;
	}
//	#예치금 잔액에서 결제금액만큼 감한 내용을 예치금 테이블에 insert
	@Override
	public int insertDepositMinus(HashMap<String, Integer> paraMap) {
		int result = sqlsession.update(ns+"insertDepositMinus", paraMap);
		return result;
	}
	
//	#예치금결제 완료시 예약테이블의 예약상태 변경 트랜잭션 처리
	@Override
	public int updateReservationStatusByFkRUID(String fk_reservation_UID) {
		int result = sqlsession.update(ns+"updateReservationStatusByFkRUID", fk_reservation_UID);
		return result;
	}


	
	
//	#검색타입/검색어가 없는 예약 목록 개수 가져오기
	@Override
	public int getTotalCountNoSearch(int idx) {
		int totalCount = sqlsession.selectOne(ns+"getTotalCountNoSearch", idx);
		return totalCount;
	}

//	#검색타입/검색어가 있는 예약목록 가져오기
	@Override
	public List<HashMap<String, String>> selectUserReservationList(HashMap<String, String> paraMap) {
		List<HashMap<String, String>> reservationList = sqlsession.selectList(ns+"selectUserReservationList",paraMap);
		return reservationList;
	}
}
