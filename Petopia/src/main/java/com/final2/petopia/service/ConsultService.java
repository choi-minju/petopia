package com.final2.petopia.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.final2.petopia.model.ConsultCommentVO;
import com.final2.petopia.model.ConsultVO;
import com.final2.petopia.model.InterConsultDAO;

@Service
public class ConsultService implements InterConsultService {

	//===== 의존객체 주입(DI:Dependency Injection)  =====
	@Autowired
	private InterConsultDAO dao;

	//===== 양방향 암호화 알고리즘인 AES256을 사용하여 암호화/복호화하기 위한 클래스 의존객체 주입(DI:Dependency Injection) =====
	// @Autowired
	// private AES256 aes;
	
	// ------------------------------------------------------------------------------------------------------------
	
	// 1:1상담 글쓰기 // consult:insert
	@Override
	public int insertConsultByCvo(ConsultVO consultvo) {
		int n = dao.insertConsultByCvo(consultvo);
		return n;
	}

	// [페이징처리 O, 검색조건 O] 전체글 갯수 totalCount
	@Override
	public int selectTotalCountWithSearch(HashMap<String, String> paraMap) {
		int n = dao.selectTotalCountWithSearch(paraMap);
		return n;
	}

	// [페이징처리 O, 검색조건 X] 전체글 갯수 totalCount
	@Override
	public int selectTotalCountNoSearch() {
		int n = dao.selectTotalCountNoSearch();
		return n;
	}

	// [페이징처리 O, 검색조건 O] 한 페이지 범위마다 보여지는 글목록 // consult:select
	@Override
	public List<ConsultVO> selectConsultListPaging(HashMap<String, String> paraMap) {
		List<ConsultVO> consultList = dao.selectConsultListPaging(paraMap);
		return consultList;
	}

	// [조회수 증가 O] 글 상세보기
	@Override
	public ConsultVO selectConsultDetailWithCount(String consult_UID, String userid) {
		
		ConsultVO consultvo = dao.selectConsultDetailNoCount(consult_UID);
		
		if( userid!=null && !consultvo.getUserid().equals(userid) ) {
			// 조회수 증가는 로그인되어져 있는 상태에서
			// 다른 사람이 작성한 글을 읽었을때만 조회수 증가하도록한다.
			dao.updateConsultDetailAddCount(consult_UID); // 조회수증가
			consultvo = dao.selectConsultDetailNoCount(consult_UID); // 글상세보기
		}
		return consultvo;
	}

	// [조회수 증가 X] 글 상세보기
	@Override
	public ConsultVO selectConsultDetailNoCount(String consult_UID) {
		ConsultVO consultvo = dao.selectConsultDetailNoCount(consult_UID);
		return consultvo;
	}

	// [조회수 증가 X] 수정하기 위한 글 가져오기
	@Override
	public ConsultVO selectConsultEditNoCount(String consult_UID) {
		ConsultVO consultvo = dao.selectConsultDetailNoCount(consult_UID);
		return consultvo;
	}

	// 글상세 수정하기 
	@Override
	public int updateConsultDetail(HashMap<String, String> paraMap) {
		int n = dao.updateConsultDetail(paraMap);
		return n;
	}

	// 글상세 삭제하기
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int deleteConsult(String consult_UID) throws Throwable {
		
		int count = 0;
		int result1 = 0;
		int result2 = 0; 
		int n = 0;
		
		count = dao.selectCommentWithConsult(consult_UID); // - 원글에 달린 댓글갯수
		result1 = dao.deleteConsult(consult_UID); // - 원글삭제 delete
		
		if(count>0) { // 원글에 달린 댓글이 있을경우
			result2 = dao.deleteComment(consult_UID); // - 원글에 달린 댓글삭제 delete
		}
		
		if( (result1>0 && (count>0 && result2>0)) || // (원글 삭제 && 댓글이 있는 경우, 댓글도 삭제)
				(result1>0 && count==0) ) { // 원글 삭제 && 댓글이 없는 경우
				n = 1;
		}
		
		return n;
	}

	// [consult_comment]commentvo 댓글쓰기 insert + [consult]commentCount 원글의 댓글갯수 1 update
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int insertComment(ConsultCommentVO commentvo) throws Throwable {
		
		int result1 = 0;
		int result2 = 0;
		
		result1 = dao.insertComment(commentvo); // - [consult_comment]commentvo 댓글쓰기 insert
		
		if(result1==1) {
			result2 = dao.updateConsultCommentCount(commentvo.getFk_consult_UID()); // - [consult]commentCount 원글의 댓글갯수 1 update
		}
		
		return result2;
	}

	// 댓글리스트 select
	@Override
	public List<ConsultCommentVO> selectCommentList(HashMap<String, String> paraMap) {
		List<ConsultCommentVO> commentList = dao.selectCommentList(paraMap);
		return commentList;
	}

	
	
}
