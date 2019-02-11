package com.final2.petopia.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ConsultDAO implements InterConsultDAO {

	//===== 의존객체 주입(DI:Dependency Injection)  =====
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	// ------------------------------------------------------------------------------------------------------------
	
	// 1:1상담 글쓰기 // consult:insert
	@Override
	public int insertConsultByCvo(ConsultVO consultvo) {
		int n = sqlsession.insert("consult.insertConsultByCvo", consultvo);
		return n;
	}

	// [페이징처리 O, 검색조건 O] 전체글 갯수 totalCount
	@Override
	public int selectTotalCountWithSearch(HashMap<String, String> paraMap) {
		int n = sqlsession.selectOne("consult.selectTotalCountWithSearch", paraMap);
		return n;
	}

	// [페이징처리 O, 검색조건 X] 내가쓴글 갯수 totalCount
	@Override
	public int selectMyConsultCountNoSearch(String idx) {
		int n = sqlsession.selectOne("consult.selectMyConsultCountNoSearch", idx);
		return n;
	}
	
	// [페이징처리 O, 검색조건 X] 전체글 갯수 totalCount
	@Override
	public int selectTotalCountNoSearch() {
		int n = sqlsession.selectOne("consult.selectTotalCountNoSearch");
		return n;
	}

	// [페이징처리 O, 검색조건 O] 한 페이지 범위마다 보여지는 글목록 // consult:select
	@Override
	public List<ConsultVO> selectConsultListPaging(HashMap<String, String> paraMap) {
		List<ConsultVO> consultList = sqlsession.selectList("consult.selectConsultListPaging", paraMap);
		return consultList;
	}

	// [조회수 증가 X] 글 상세보기
	@Override
	public ConsultVO selectConsultDetailNoCount(String consult_UID) {
		ConsultVO consultvo = sqlsession.selectOne("consult.selectConsultDetailNoCount", consult_UID);
		return consultvo;
	}

	// [조회수 증가 O] 글 상세보기
	@Override
	public void updateConsultDetailAddCount(String consult_UID) {
		sqlsession.update("consult.updateConsultDetailAddCount",consult_UID);
	}

	// 원글상세 수정하기 delete
	@Override
	public int updateConsultDetail(HashMap<String, String> paraMap) {
		int n = sqlsession.update("consult.updateConsultDetail", paraMap);
		return n;
	}
	
	// 원글상세 삭제하기 delete
	@Override
	public int deleteConsult(String consult_UID) {
		int n = sqlsession.delete("consult.deleteConsult", consult_UID);
		return n;
	}

	// 원글에 달린 댓글갯수 select
	@Override
	public int selectCommentWithConsult(String consult_UID) {
		int n = sqlsession.selectOne("consult.selectCommentWithConsult", consult_UID);
		return n;
	}

	// 원글에 달린 댓글삭제 delete
	@Override
	public int deleteComment(String consult_UID) {
		int n = sqlsession.delete("consult.deleteComment", consult_UID);
		return n;
	}

	// [consult_comment]commentvo 댓글쓰기 insert
	@Override
	public int insertComment(ConsultCommentVO commentvo) {
		int n = sqlsession.insert("consult.insertComment", commentvo);
		return n;
	}
	// 대댓글쓰기 
	@Override
	public int insertCommentByComment(ConsultCommentVO commentvo) {
		int n = sqlsession.insert("consult.insertCommentByComment", commentvo);
		return n;
	}
	
	// [consult]commentCount 원글의 댓글갯수 1 update
	@Override
	public int updateConsultCommentCount(String fk_consult_UID) {
		int n = sqlsession.update("consult.updateConsultCommentCount", fk_consult_UID);
		return n;
	}

	// - [notification] 댓글작성 알림 insert
	@Override
	public int insertCommentNotification(ConsultCommentVO commentvo) {
		int n = sqlsession.insert("consult.insertCommentNotification", commentvo);
		return n;
	}
	
	// 댓글리스트 select
	@Override
	public List<ConsultCommentVO> selectCommentList(HashMap<String, String> paraMap) {
		List<ConsultCommentVO> commentList = sqlsession.selectList("consult.selectCommentList", paraMap);
		return commentList;
	}

	// 댓글 총 갯수 select
	@Override
	public int selectCommentTotalCount(HashMap<String, String> paraMap) {
		int totalCount = sqlsession.selectOne("consult.selectCommentTotalCount", paraMap);
		return totalCount;
	}

	// 댓글그룹순서 최대값
	@Override
	public int getGroupOdrMax1(ConsultCommentVO commentvo) {
		int n = sqlsession.selectOne("consult.getGroupOdrMax1", commentvo);
		return n;
	}
	@Override
	public int getGroupOdrMax2(ConsultCommentVO commentvo) {
		int n = sqlsession.selectOne("consult.getGroupOdrMax2", commentvo);
		return n;
	}

	// cscmt_g_odr그룹순서 update
	@Override
	public int updateCommentCscmtgOdr(ConsultCommentVO commentvo) {
		int n = sqlsession.update("consult.updateCommentCscmtgOdr", commentvo);
		return n;
	}

	// fk_cmt_idCount 그룹순서 
	@Override
	public int getFk_cmt_idCount(ConsultCommentVO commentvo) {
		int n = sqlsession.selectOne("consult.getFk_cmt_idCount", commentvo);
		return n;
	}

	
	
	// 관리자 -------------------------------------------------------------------------------------
	
	// - [페이징처리 O, 검색조건 O] 한 페이지 범위마다 보여지는 글목록 // consult:select
	@Override
	public List<ConsultVO> selectAdminConsultListPaging(HashMap<String, String> paraMap) {
		List<ConsultVO> AdminConsultList = sqlsession.selectList("consult.selectAdminConsultListPaging", paraMap);
		return AdminConsultList;
	}

	// - 기업회원 idx 목록 member:select
	@Override
	public List<String> selectBizMemberList() {
		List<String> bizMemberList = sqlsession.selectList("consult.selectBizMemberList");
		return bizMemberList;
	}

	// - 알림 테이블에 board로 notification:insert
	@Override
	public int insertConsultNotification(String idx) {
		int n = sqlsession.insert("consult.insertConsultNotification", idx);
		return n;
	}
	
	
	
	

	
}
