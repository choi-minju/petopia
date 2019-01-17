package com.final2.petopia.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAO implements InterMemberDAO {

	@Autowired
	private SqlSessionTemplate sqlsession;
	
	// 태그 리스트 보여주기
	@Override
	public List<HashMap<String, String>> selectRecommendTagList() {
		List<HashMap<String, String>> tagList = sqlsession.selectList("member.selectRecommendTagList");
		
		return tagList;
	} // end of public List<HashMap<String, String>> selectRecommendTagList()

	// *** 회원가입 *** //
	// 회원가입할 회원번호 받아오기
	@Override
	public int selectMemberNoSeq() {
		int idx = sqlsession.selectOne("member.selectMemberSeq");
		
		return idx;
	} // end of public int selectMemberNoSeq()

	// member 테이블 insert
	@Override
	public int insertMemberByMvo(MemberVO mvo) {
		int result = sqlsession.insert("member.insertMemberByMvo", mvo);
		
		return result;
	} // end of public int insertMemberByMvo(MemberVO mvo)

	// login_log 테이블 insert
	@Override
	public int insertLogin_logByMvo(MemberVO mvo) {
		int result = sqlsession.insert("member.insertLogin_logByMvo", mvo);
		
		return result;
	} // end of public int insertLogin_logByMvo(MemberVO mvo)
	
	// have_tag 테이블 insert
	@Override
	public int insertHave_tagByTagList(List<HashMap<String, String>> selectTagList) {
		int result = 0;
		for(HashMap<String, String> selectTag : selectTagList) {
			int n = sqlsession.insert("member.insertHave_tagByTagList", selectTag);
			
			if(n == 0) {
				return 0;
			} else {
				result = 1;
			} // end of if
		} // end of for
		
		return result;
	} // end of public int insertHave_tagByTagList(List<HashMap<String, String>> selectTagList)

	// *** 아이디 중복 체크 *** //
	@Override
	public int selectMemberIdIsUsed(String userid) {
		int cnt = sqlsession.selectOne("member.selectMemberIdIsUsed", userid);
		
		return cnt;
	} // end of public int selectMemberIdIsUsed(String userid)

	// *** 로그인 *** //
	// 로그인
	@Override
	public MemberVO loginSelectByUseridPwd(HashMap<String, String> loginMap) {
		MemberVO loginuser = sqlsession.selectOne("member.loginSelectByUseridPwd", loginMap);
		
		return loginuser;
	} // end of public MemberVO loginSelectByUseridPwd(HashMap<String, String> loginMap)

	// 마지막 로그인 날짜 기록하기
	@Override
	public void updateLoginDateByUserid(HashMap<String, String> loginMap) {
		sqlsession.update("member.updateLoginDateByUserid", loginMap);
	} // end of public void updateLoginDateByUserid(HashMap<String, String> loginMap)

	// *** 아이디로 회원정보 조회 *** //
	// 회원정보 조회
	@Override
	public MemberVO selectMemberByIdx(int idx) {
		MemberVO mvo = sqlsession.selectOne("member.selectMemberByIdx", idx);
		
		return mvo;
	} // end of public MemberVO selectMemberByUserid(String userid)

	// 저장된 사용자 태그 조회
	@Override
	public List<HashMap<String, String>> selectHave_tagByIdx(int idx) {
		List<HashMap<String, String>> haveTagList = sqlsession.selectList("member.selectHave_tagByIdx", idx);
		
		return haveTagList;
	} // end of public List<HashMap<String, String>> selectHave_tagByIdx(int idx)

	// *** 회원수정 *** //
	// member 테이블의 정보수정
	@Override
	public int updateMemberByMvo(MemberVO mvo) {
		int result = sqlsession.update("member.updateMemberByMvo", mvo);
		
		return result;
	} // end of public int updateMemberByMvo(MemberVO mvo)

	// login_log 테이블의 정보수정
	@Override
	public int updateLogin_logByMvo(MemberVO mvo) {
		int result = sqlsession.update("member.updateLogin_logByMvo", mvo);
		
		return result;
	} // end of public int updateLogin_logByMvo(MemberVO mvo)

	// 해당 사용자의 태그 모두 지우기
	@Override
	public int deleteHave_tagByIdx(int idx) {
		int result = sqlsession.delete("member.deleteHave_tagByIdx", idx);
		return result;
	} // end of public int deleteHave_tagByIdx(int idx)

	// 파일 수정이 없는 회원 정보 수정 
	// member 테이블의 정보수정(프로필 사진 변경 X)
	@Override
	public int updateMemberByMvoNoProfile(MemberVO mvo) {
		int result = sqlsession.update("member.updateMemberByMvoNoProfile", mvo);
		
		return result;
	} // end of public int updateMemberByMvoNoProfile(MemberVO mvo)

	// *** 회원 탈퇴 *** //
	@Override
	public int deleteMemberByIdx(int idx) {
		int result = sqlsession.update("member.deleteMemberByIdx", idx);
		
		return result;
	} // end of public int deleteMemberByIdx(int idx)

}
