package com.final2.petopia.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class Biz_MemberDAO implements InterBiz_MemberDAO {
	
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	@Override
	public List<HashMap<String, String>> selectHaveTagList() {
		
		List<HashMap<String, String>> tagList = sqlsession.selectList("biz_member.selectHaveTagList");
		
		return tagList;
	}

	@Override
	public int selectBizMemberIdIsUsed(String userid) {
		
		int cnt = sqlsession.selectOne("biz_member.selectBizMemberIdIsUsed", userid);
		
		return cnt;
	}

	@Override
	public int selectMemberNoSeq() {
		
		int idx = sqlsession.selectOne("biz_member.selectBizMemberSeq");
		
		return idx;
	}

	@Override
	public int insertMemberByMvo(Biz_MemberVO mvo) {
		int result = sqlsession.insert("biz_member.insertMemberByMvo", mvo);
		
		return result;
	}

	@Override
	public int insertLogin_logByMvo(Biz_MemberVO mvo) {
		int result = sqlsession.insert("biz_member.insertLogin_logByMvo", mvo);
		
		return result;
	}

	@Override
	public int insertHave_tagByTagList(List<HashMap<String, String>> selectTagList) {
		int result = 0;
		for(HashMap<String, String> selectTag : selectTagList) {
			int n = sqlsession.insert("biz_member.insertHave_tagByTagList", selectTag);
			
			if(n == 0) {
				return 0;
			} else {
				result = 1;
			} // end of if
		} // end of for
		
		return result;
	}

	@Override
	public int insertBizInfo(Biz_MemberVO bmvo) {
		
		int result = sqlsession.insert("biz_member.insertBizInfo", bmvo);
		
		return result;
	}


	

}
