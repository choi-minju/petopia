package com.final2.petopia.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CareDAO implements InterCareDAO {

	@Autowired
	private SqlSessionTemplate sqlsession;
	
	@Override
	public int insertPet_info(PetVO petvo) {
		int n = sqlsession.insert("care.insertPet_info");
		return n;
	}

}
