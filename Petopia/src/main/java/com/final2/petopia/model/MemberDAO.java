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
		System.out.println("????");
		for(HashMap<String, String> selectTag : selectTagList) {// 여기에 안들어옴!!!!!!!
			System.out.println("FK_TAG_UID: "+selectTag.get("FK_TAG_UID"));
			System.out.println("FK_TAG_NAME: "+selectTag.get("FK_TAG_NAME"));
			System.out.println("FK_IDX: "+selectTag.get("FK_IDX"));
			
			int n = sqlsession.insert("member.insertHave_tagByTagList", selectTag);
			
			if(n == 0) {
				System.out.println("FK_TAG_UID: "+selectTag.get("FK_TAG_UID"));
				System.out.println("FK_TAG_NAME: "+selectTag.get("FK_TAG_NAME"));
				System.out.println("FK_IDX: "+selectTag.get("FK_IDX"));
				return 0;
			} else {
				result = 1;
			} // end of if
		} // end of for
		
		return result;
	} // end of public int insertHave_tagByTagList(List<HashMap<String, String>> selectTagList)

}
