package com.final2.petopia.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CareDAO implements InterCareDAO {

	@Autowired
	private SqlSessionTemplate sqlsession;

	
	//===== 반려동물 리스트 =====
	@Override
	public List<PetVO> getPet_infoList(HashMap<String, String> map) {
		List<PetVO> pvoList = sqlsession.selectList("care.getPet_infoList", map); 
		return pvoList;
	}
	
	
	//===== 반려동물 등록 =====
	@Override
	public int insertPet_info(PetVO pvo) {
		int n = sqlsession.insert("care.insertPet_info", pvo);
		return n;
	}





}
