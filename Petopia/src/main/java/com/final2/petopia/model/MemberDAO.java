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

}
