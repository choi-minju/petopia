package com.final2.petopia.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class Biz_MemberDAO implements InterBiz_MemberDAO {
	
	@Autowired
	private SqlSessionTemplate sqlsession;

	@Override
	public int idDuplicateCheck(String userid) {
		int n = sqlsession.selectOne("biz_member.idDuplicateCheck",userid);
		return n;
	}

}
