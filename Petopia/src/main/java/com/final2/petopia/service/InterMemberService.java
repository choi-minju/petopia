package com.final2.petopia.service;

import java.util.HashMap;
import java.util.List;

import com.final2.petopia.model.MemberVO;

public interface InterMemberService {

	List<HashMap<String, String>> selectRecommendTagList(); // 태그 리스트 보여주기

	// *** 회원가입 *** //
	int insertMemberByMvoTagList(MemberVO mvo, String[] tagNoArr, String[] tagNameArr); // 태그가 있는 경우 회원가입
	int insertMemberByMvo(MemberVO mvo); // 태그가 없는 경우 회원가입

	// *** 아이디 중복 체크 *** //
	int selectMemberIdIsUsed(String userid);

	// *** 로그인 *** //
	MemberVO loginSelectByUseridPwd(HashMap<String, String> loginMap);

	// *** 회원번호로 회원정보 조회 *** //
	MemberVO selectMemberByIdx(int idx); // 회원정보 조회
	List<HashMap<String, String>> selectHave_tagByIdx(int idx); // 저장된 사용자 태그 조회

	// *** 회원수정 *** //
	// 프로필 사진이 있는 경우
	int updateMemberByMvoTagList(MemberVO mvo, String[] tagNoArr, String[] tagNameArr); // 태그가 있는 회원수정
	int updateMemberByMvo(MemberVO mvo); // 태그가 없는 회원수정
	// 프로필 사진이 없는 경우
	int updateMemberByMvoTagListNoProfile(MemberVO mvo, String[] tagNoArr, String[] tagNameArr); // 태그가 있는 회원수정
	int updateMemberByMvoNoProfile(MemberVO mvo); // 태그가 없는 회원수정

	// *** 회원 탈퇴 *** //
	int deleteMemberByIdx(int idx);

	
	

}