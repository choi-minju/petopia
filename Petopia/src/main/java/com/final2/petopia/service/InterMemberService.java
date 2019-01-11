package com.final2.petopia.service;

import java.util.HashMap;
import java.util.List;

import com.final2.petopia.model.MemberVO;

public interface InterMemberService {

	List<HashMap<String, String>> selectRecommendTagList(); // 태그 리스트 보여주기

	// *** 회원가입 *** //
	int insertMemberByMvoTagList(MemberVO mvo, String[] tagNoArr, String[] tagNameArr); // 태그가 있는 경우 회원가입
	int insertMemberByMvo(MemberVO mvo); // 태그가 없는 경우 회원가입

}