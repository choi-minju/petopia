package com.final2.petopia.service;

import java.util.HashMap;
import java.util.List;

import com.final2.petopia.model.CareVO;
import com.final2.petopia.model.PetVO;

public interface InterCareService {

	//===== 반려동물 리스트 =====
	List<HashMap<String,String>> getPet_infoList(int fk_idx);
	
	//===== 반려동물 등록 =====
	int insertPet_info(PetVO pvo);

	//===== 케어 등록 caretype 가져오기 =====
	List<HashMap<String, String>> getCaretypeList();

	//===== 케어타입 코드 =====
	List<HashMap<String, String>> getCaretype_infoList(String caertype);

	//===== 케어 등록 =====
	int insertPetcare(CareVO cvo);



}
