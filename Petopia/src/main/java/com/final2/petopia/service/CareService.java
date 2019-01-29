package com.final2.petopia.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.final2.petopia.model.CareVO;
import com.final2.petopia.model.InterCareDAO;
import com.final2.petopia.model.PetVO;

@Service
public class CareService implements InterCareService {

	@Autowired
	private InterCareDAO dao;

	
	//===== 반려동물 리스트 =====
	@Override
	public List<HashMap<String,String>> getPet_infoList(int fk_idx) {
		List<HashMap<String,String>> list = dao.getPet_infoList(fk_idx);
		return list;
	}
	
	
	//===== 반려동물 등록 =====
	@Override
	public int insertPet_info(PetVO pvo) {
		int n = dao.insertPet_info(pvo);
		return n;
	}


	//===== 케어 등록 caretype 가져오기 =====
	@Override
	public List<HashMap<String, String>> getCaretypeList() {
		List<HashMap<String,String>> caretypeList = dao.getCaretypeList();
		return caretypeList;
	}

	
	//===== 케어 등록 caretype 가져오기 =====
	@Override
	public List<HashMap<String, String>> getCaretype_infoList(String caertype) {
		List<HashMap<String,String>> list = dao.getCaretype_infoList(caertype);
		return list;
	}


	//===== 케어 등록 ===== 
	@Override
	public int insertPetcare(CareVO cvo) {
		int n = dao.insertPetcare(cvo);
		return n;
	}


	//===== 특정 반려동물 리스트 =====
	@Override
	public HashMap<String, Object> getPet_info(int pet_UID) {
		HashMap<String, Object> petInfo = dao.getPet_info(pet_UID);
		return petInfo;
	}


	

}
