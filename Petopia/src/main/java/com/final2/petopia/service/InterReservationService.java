package com.final2.petopia.service;

import java.util.HashMap;
import java.util.List;

import com.final2.petopia.model.Biz_MemberVO;
import com.final2.petopia.model.PaymentVO;
import com.final2.petopia.model.PetVO;
import com.final2.petopia.model.ReservationVO;
import com.final2.petopia.model.ScheduleVO;

public interface InterReservationService {

//	#병원에 등록되어있는 예약스케줄 목록 가져오기(2주)
	List<ScheduleVO> selectScheduleListByIdx_biz(String idx_biz);

//	#예약 페이지 갈 때 병원정보 조회하기
	Biz_MemberVO selectBizMemberVOByIdx_biz(String idx_biz);

//	[190119]
//	#로그인된 회원 idx를 받아와 펫 리스트 select하기
	List<PetVO> selectPetListByIdx(int idx);

//	#반려동물 드롭박스에서 선택시 1마리 동물정보 가져오기
	PetVO selectPetOneByPet_UID(String pet_UID);

//	[190120]
//	#예약VO로 예약테이블에 insert하기; 결제X
	int insertReservationByRvo(ReservationVO rvo) throws Throwable;
	
//	#예약VO로 예약테이블에 insert하기; 결제O
	HashMap<String, String> insertReservationSurgeryByRvo(ReservationVO rvo) throws Throwable;

//	#회원번호로 예치금잔액 가져오기
	int selectSumDepositByIdx(String idx);
//	#회원번호로 포인트 가져오기
	int selectPointByIdx(String idx);
//	#예약번호로 예약VO 가져오기
	HashMap<String, String> selectUserReservationOneByFkRUID(String fk_reservation_UID);
	
//	#예치금 결제 완료; 트랜잭션
	int goPayReservationDeposit(PaymentVO pvo);
	
	
//	#예약목록
	int getTotalCountNoSearch(int idx);
	List<HashMap<String, String>> selectUserReservationList(HashMap<String, String> paraMap);
}
