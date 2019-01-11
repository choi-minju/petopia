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

}