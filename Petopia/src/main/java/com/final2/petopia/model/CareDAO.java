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
	public List<HashMap<String,String>> getPet_infoList(int fk_idx) {
		List<HashMap<String,String>> list = sqlsession.selectList("care.getPet_infoList", fk_idx); 
		return list;
	}
	
	
	//===== 반려동물 등록 =====
	@Override
	public int insertPet_info(PetVO pvo) {
		int n = sqlsession.insert("care.insertPet_info", pvo);
		return n;
	}


	//===== 케어 등록 caretype 가져오기 =====
	@Override
	public List<HashMap<String, String>> getCaretypeList() {
		List<HashMap<String,String>> caretypeList = sqlsession.selectList("care.getCaretypeList");
		return caretypeList;
	}


	//===== 케어 등록 caretype 가져오기 =====
	@Override
	public List<HashMap<String, String>> getCaretype_infoList(String caertype) {
		List<HashMap<String,String>> list = sqlsession.selectList("care.getCaretype_infoList", caertype); 
		return list;
	}





}
