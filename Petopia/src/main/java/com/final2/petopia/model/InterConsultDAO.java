package com.final2.petopia.model;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface InterConsultDAO {

	// 1:1상담 글쓰기 // consult:insert
	int insertConsultByCvo(ConsultVO consultvo);
	
	// [페이징처리 O, 검색조건 O] 전체글 갯수 totalCount
	int selectTotalCountWithSearch(HashMap<String, String> paraMap);

	// [페이징처리 O, 검색조건 X] 전체글 갯수 totalCount
	int selectTotalCountNoSearch();

	// [페이징처리 O, 검색조건 O] 한 페이지 범위마다 보여지는 글목록 // consult:select
	List<ConsultVO> selectConsultListPaging(HashMap<String, String> paraMap);

	// [조회수 증가 X] 글 상세보기
	ConsultVO selectConsultDetailNoCount(String consult_UID);

	// [조회수 증가 O] 글 상세보기
	void updateConsultDetailAddCount(String consult_UID);

	// 원글상세 수정하기 update
	int updateConsultDetail(HashMap<String, String> paraMap);

	// 원글상세 삭제하기 delete
	int deleteConsult(String consult_UID);

	// 원글에 달린 댓글갯수 select
	int selectCommentWithConsult(String consult_UID);

	// 원글에 달린 댓글삭제 delete
	int deleteComment(String consult_UID);

	// [consult_comment]commentvo 댓글쓰기 insert
	int insertComment(ConsultCommentVO commentvo);

	// [consult]commentCount 원글의 댓글갯수 1 update
	int updateConsultCommentCount(String fk_consult_UID);

	// 댓글리스트 select
	List<ConsultCommentVO> selectCommentList(HashMap<String, String> paraMap);

	// 댓글 총 갯수 select
	int selectCommentTotalCount(HashMap<String, String> paraMap);

	// 댓글그룹순서 최대값
	int getGroupOdrMax();

}
