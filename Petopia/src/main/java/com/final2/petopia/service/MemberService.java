package com.final2.petopia.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.final2.petopia.common.SHA256;
import com.final2.petopia.model.InterMemberDAO;
import com.final2.petopia.model.MemberVO;

@Service
public class MemberService implements InterMemberService {
	
	@Autowired
	private InterMemberDAO dao;

	// 태그 리스트 보여주기
	@Override
	public List<HashMap<String, String>> selectRecommendTagList() {
		List<HashMap<String, String>> tagList = dao.selectRecommendTagList();
		
		return tagList;
	} // end of public List<HashMap<String, String>> selectRecommendTagList()

	// *** 회원가입 *** //
	// 태그가 있는 경우 회원가입
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int insertMemberByMvoTagList(MemberVO mvo, String[] tagNoArr, String[] tagNameArr) {
		int result = 0;
		
		// 회원가입할 회원번호 받아오기
		int idx = dao.selectMemberNoSeq();
		
		// 회원번호 mvo에 넣기
		mvo.setIdx(idx);
		
		// member 테이블 insert
		int n1 = dao.insertMemberByMvo(mvo);

		// login_log 테이블 insert
		int n2 = dao.insertLogin_logByMvo(mvo);
		
		// have_tag 테이블 insert
		List<HashMap<String, String>> selectTagList = new ArrayList<HashMap<String, String>>();
		
		for(int i=0; i<tagNoArr.length; i++) {
			HashMap<String, String> selectTagMap = new HashMap<String, String>();
			selectTagMap.put("FK_TAG_UID", tagNoArr[i]);
			selectTagMap.put("FK_TAG_NAME", tagNameArr[i]);
			selectTagMap.put("FK_IDX", String.valueOf(idx));
			
			selectTagList.add(selectTagMap);
		} // end of for
		
		int n3 = dao.insertHave_tagByTagList(selectTagList);
		
		if(n1*n2*n3 == 0) {
			// 회원가입 실패
			result = 0;
		} else {
			// 회원가입 성공
			result = 1;
		} // end of if~else
		
		return result;
	} // end of public int insertMemberByMvoTagList(MemberVO mvo, List<HashMap<String, String>> selectTagList)
	
	// 태그가 없는 경우 회원가입
	@Override
	public int insertMemberByMvo(MemberVO mvo) {
		int result = 0;
		
		// 회원가입할 회원번호 받아오기
		int idx = dao.selectMemberNoSeq();
		
		// 회원번호 mvo에 넣기
		mvo.setIdx(idx);
		
		// member 테이블 insert
		int n1 = dao.insertMemberByMvo(mvo);

		// login_log 테이블 insert
		int n2 = dao.insertLogin_logByMvo(mvo);
		
		if(n1*n2 == 0) {
			// 회원가입 실패
			result = 0;
		} else {
			// 회원가입 성공
			result = 1;
		} // end of if~else
		
		return result;
	} // end of public int insertMemberByMvo(MemberVO mvo)

	// *** 아이디 중복 체크 *** //
	@Override
	public int selectMemberIdIsUsed(String userid) {
		int cnt  = dao.selectMemberIdIsUsed(userid);
		
		return cnt;
	} // end of public int selectMemberIdIsUsed(String userid)

	// *** 로그인 *** //
	@Override
	public MemberVO loginSelectByUseridPwd(HashMap<String, String> loginMap) {
		MemberVO loginuser = dao.loginSelectByUseridPwd(loginMap);
		
		if(loginuser == null) {
			return null;
		} else if(loginuser.getLastlogindategap() >= 12) {
			// 마지막 로그인 날짜 확인 후 12개월 이상이면 휴면으로
			loginuser.setIdleStatus(true);
			
			return loginuser;
		} else {
			// 마지막 로그인 날짜 기록하기
			dao.updateLoginDateByUserid(loginMap);
			
			return loginuser;
		} // end of if~else
		
	} // public MemberVO loginSelectByUseridPwd(HashMap<String, String> loginMap)

	// *** 아이디로 회원정보 조회 *** //
	// 회원정보 조회
	@Override
	public MemberVO selectMemberByUserid(String userid) {
		MemberVO mvo = dao.selectMemberByUserid(userid);
		
		return mvo;
	} // end of public MemberVO selectMemberByUserid(String userid)

	// 저장된 사용자 태그 조회
	@Override
	public List<HashMap<String, String>> selectHave_tagByIdx(int idx) {
		List<HashMap<String, String>> haveTagList = dao.selectHave_tagByIdx(idx);
		
		return haveTagList;
	} // end of public List<HashMap<String, String>> selectHave_tagByIdx(int idx)
	
}