package com.final2.petopia.service;

import java.util.HashMap;
import java.util.List;

import com.final2.petopia.model.PetVO;

public interface InterCareService {

	//===== 반려동물 리스트 =====
	List<HashMap<String,String>> getPet_infoList(int fk_idx);
	
	//===== 반려동물 등록 =====
	int insertPet_info(PetVO pvo);



}
