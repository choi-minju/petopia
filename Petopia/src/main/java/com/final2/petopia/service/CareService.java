package com.final2.petopia.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.final2.petopia.model.InterCareDAO;
import com.final2.petopia.model.PetVO;

@Service
public class CareService implements InterCareService {

	@Autowired
	private InterCareDAO dao;

	@Override
	public int insertPet_info(PetVO petvo) {
		int n = dao.insertPet_info(petvo);
		return n;
	}
	

}
