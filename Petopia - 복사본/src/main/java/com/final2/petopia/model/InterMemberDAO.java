package com.final2.petopia.model;

import java.util.HashMap;
import java.util.List;

public interface InterMemberDAO {

	List<HashMap<String, String>> selectRecommendTagList();	// 태그 리스트 보여주기

	// *** 회원가입 *** //
	int selectMemberNoSeq(); // 회원가입할 회원번호 받아오기
	int insertMemberByMvo(MemberVO mvo); // member 테이블 insert
	int insertLogin_logByMvo(MemberVO mvo); // login_log 테이블 insert
	int insertHave_tagByTagList(List<HashMap<String, String>> selectTagList); // have_tag 테이블 insert

	// *** 아이디 중복 체크 *** //
	int selectMemberIdIsUsed(String userid);

	// *** 로그인 *** //
	MemberVO loginSelectByUseridPwd(HashMap<String, String> loginMap); // 로그인
	void updateLoginDateByUserid(HashMap<String, String> loginMap); // 마지막 로그인 날짜 기록하기

	// *** 아이디로 회원정보 조회 *** //
	MemberVO selectMemberByUserid(String userid); // 회원정보 조회
	List<HashMap<String, String>> selectHave_tagByIdx(int idx); // 저장된 사용자 태그 조회

	// *** 회원수정 *** //
	int updateMemberByMvo(MemberVO mvo); // member 테이블의 정보수정
	int updateLogin_logByMvo(MemberVO mvo); // login_log 테이블의 정보수정
	int deleteHave_tagByIdx(int idx); // 해당 사용자의 태그 모두 지우기

}