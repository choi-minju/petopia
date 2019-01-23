package com.final2.petopia.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.final2.petopia.model.InterCareDAO;
import com.final2.petopia.model.PetVO;

@Service
public class CareService implements InterCareService {

	@Autowired
	private InterCareDAO dao;

	
	//===== 반려동물 리스트 =====
	@Override
	public List<PetVO> getPet_infoList(HashMap<String, String> map) {
		List<PetVO> pvoList = dao.getPet_infoList(map);
		return pvoList;
	}
	
	
	//===== 반려동물 등록 =====
	@Override
	public int insertPet_info(PetVO pvo) {
		int n = dao.insertPet_info(pvo);
		return n;
	}


	

}
