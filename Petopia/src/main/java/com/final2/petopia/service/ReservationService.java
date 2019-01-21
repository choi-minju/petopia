package com.final2.petopia.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.final2.petopia.common.AES256;
import com.final2.petopia.model.Biz_MemberVO;
import com.final2.petopia.model.InterReservationDAO;
import com.final2.petopia.model.PaymentVO;
import com.final2.petopia.model.PetVO;
import com.final2.petopia.model.ReservationVO;
import com.final2.petopia.model.ScheduleVO;

@Service
public class ReservationService implements InterReservationService{

	@Autowired
	private InterReservationDAO dao;
	
	// [190120] AES256 의존객체 삽입
	@Autowired
	private AES256 aes;
	
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
		try {  // [190120] aes256객체를 이용해 기업회원 연락처 복호화
			bizmvo.setPhone(aes.decrypt(bizmvo.getPhone()));
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		return bizmvo;
	}

//	[190119]
//	#로그인 회원 idx로 펫 리스트 select하기
	@Override
	public List<PetVO> selectPetListByIdx(int idx) {
		List<PetVO> petList = dao.selectPetListByIdx(idx);
		return petList;
	}
	
//	#반려동물 드롭박스에서 선택시 1마리 동물정보 가져오기
	@Override
	public PetVO selectPetOneByPet_UID(String pet_UID) {
		PetVO petvo = dao.selectPetOneByPet_UID(pet_UID);
		return petvo;
	}
	
//	[190120]
//	#예약VO로 예약테이블에 insert하기; 결제X; 트랜잭션 처리 -> 예약테이블에 인서트가 성공했을 때 스케줄 테이블 예약상태 변경
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int insertReservationByRvo(ReservationVO rvo) throws Throwable {
		int result = dao.insertReservationByRvo(rvo);
		
		if(result==1) {
			result = dao.updateScheduleStatusBySUID(rvo.getFk_schedule_UID());
		}
		
		return result;
	}
	
//	#예약VO로 예약테이블에 insert하기; 결제O; 트랜잭션 처리 -> 예약테이블에 인서트가 성공했을 때 스케줄 테이블 예약상태 변경
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public HashMap<String, String> insertReservationSurgeryByRvo(ReservationVO rvo) throws Throwable {
		HashMap<String, String> returnMap = new HashMap<String, String>();
		
		String seq = dao.selectReservation_Seq();
		rvo.setReservation_UID(seq);
		
		int result = dao.insertReservationSurgeryByRvo(rvo);
		
		if(result==1) {
			result = dao.updateScheduleStatusBySUID(rvo.getFk_schedule_UID());
		}
		
		returnMap.put("seq", seq);
		returnMap.put("result", String.valueOf(result));
		return returnMap;
	}

//	#회원번호로 예치금잔액 가져오기
	@Override
	public int selectSumDepositByIdx(String idx) {
		int depositAmount = dao.selectSumDepositByIdx(idx);
		return depositAmount;
	}
//	#회원번호로 포인트 가져오기
	@Override
	public int selectPointByIdx(String idx) {
		int point = dao.selectPointByIdx(idx);
		return point;
	}
//	#예약번호로 예약 내역 가져오기
	@Override
	public HashMap<String, String> selectUserReservationOneByFkRUID(String fk_reservation_UID) {
		HashMap<String, String>  returnMap = dao.selectUserReservationOneByFkRUID(fk_reservation_UID);
		try {
			returnMap.put("phone", aes.decrypt(returnMap.get("phone")));			
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		return returnMap;
	}
//	#예치금 결제 완료; 트랜잭션: payment테이블 insert -> deposit테이블 마이너스값 insert -> reservation테이블 status update
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int goPayReservationDeposit(PaymentVO pvo) {
		int result = 0;
		HashMap<String, Integer> paraMap = new HashMap<String, Integer>();
		paraMap.put("depositcoin", pvo.getPayment_pay());
		paraMap.put("fk_idx", pvo.getFk_idx());
		
		int n1 = dao.insertPaymentByPvo(pvo);
		int n2 = 0;
		int n3 = 0;
		if(n1==1) {
			n2 = dao.insertDepositMinus(paraMap);
		}
		if(n1==1 && n2==1) {
			n3 = dao.updateReservationStatusByFkRUID(pvo.getFk_reservation_UID());
		}
		
		if(n1*n2*n3 == 1) {
			result = 1;
		}
		return result;
	}
	
//	#검색타입/검색어에 만족하는 예약 목록 개수 가져오기
	@Override
	public int getTotalCountWithSearch(HashMap<String, String> paraMap) {
		int totalCount = dao.getTotalCountWithSearch(paraMap);
		return totalCount;
	}
//	#검색타입/검색어가 없는 예약 목록 개수 가져오기
	@Override
	public int getTotalCountNoSearch() {
		int totalCount = dao.getTotalCountNoSearch();
		return totalCount;
	}

//	#검색타입/검색어가 있는 예약목록 가져오기
	@Override
	public List<ReservationVO> selectUserReservationList(HashMap<String, String> paraMap) {
		List<ReservationVO> reservationList = dao.selectUserReservationList(paraMap);
		return reservationList;
	}


}
