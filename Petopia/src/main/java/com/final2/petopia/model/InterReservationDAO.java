package com.final2.petopia.model;

import java.util.HashMap;
import java.util.List;

public interface InterReservationDAO {

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
	int insertReservationByRvo(ReservationVO rvo);
	
//	#예약일정 인서트 성공시 스케줄테이블의 스케줄 상태 변경 트랜잭션 처리
	int updateScheduleStatusBySUID(String fk_schedule_UID);
	
//	#예약테이블 시퀀스 채번
	String selectReservation_Seq();
	
//	#예약VO로 예약테이블에 insert하기; 결제O
	int insertReservationSurgeryByRvo(ReservationVO rvo);
	
//	#회원번호로 예치금잔액 가져오기
	int selectSumDepositByIdx(String idx);	
//	#회원번호로 포인트 가져오기
	int selectPointByIdx(String idx);
//	#예약번호로 예약 내역 가져오기
	HashMap<String, String> selectUserReservationOneByFkRUID(String fk_reservation_UID);

// [190124]	
//	#결제테이블 시퀀스 채번
	int selectPayment_Seq();
//	#결제시 사용 포인트를 감하고 실결제금액의 10% point 적립하기
	int updatePointMember(HashMap<String, Integer> paraMap);
// ----------------------------------------------
//	#수술예약 시 예치금결제 후 결제테이블에 insert
	int insertPaymentByPvo(PaymentVO pvo);
//	#예치금 잔액에서 결제금액만큼 감한 내용을 예치금 테이블에 insert
	int insertDepositMinus(HashMap<String, Integer> paraMap);	
//	#결제 완료시 예약테이블 상태 변경 트랜잭션 처리 
	int updateReservationStatusByFkRUID(String fk_reservation_UID);


//	#예약목록(페이징처리)
	int getTotalCountNoSearch(int idx);
	List<HashMap<String, String>> selectUserReservationList(HashMap<String, String> paraMap);

//	[190125] 예치금 히스토리 목록 중 모두보기인 경우 
	List<DepositVO> selectDepositListByIdx(HashMap<String, String> paraMap);

}
