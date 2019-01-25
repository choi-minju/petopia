package com.final2.petopia.service;

import java.util.HashMap;
import java.util.List;

import com.final2.petopia.model.Biz_MemberVO;
import com.final2.petopia.model.MemberVO;

public interface InterBiz_MemberService {

	// 태그 리스트 보여주기
	List<HashMap<String, String>> selectHaveTagList();
	
	// 아이디 중복체크
	int selectBizMemberIdIsUsed(String userid);
	
	// 태그가 있는 경우 회원가입
	int insertMemberByMvoTagList(Biz_MemberVO mvo, String[] tagNoArr, String[] tagNameArr);

	// 태그가 없는 경우 회원가입
	int insertMemberByMvo(Biz_MemberVO mvo);




}
