package com.final2.petopia.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.final2.petopia.model.InterChartDAO;
import com.final2.petopia.model.PetVO;
import com.final2.petopia.model.ReservationVO;

@Service
public class ChartService implements InterChartService {
   @Autowired
   private InterChartDAO dao;

@Override
public int insertmychart(HashMap<String, String> mychartmap) {
	int n = dao.insertmychart(mychartmap);
	return n;
}

@Override
public int selectpetuid(String idx) {
	int n = dao.selectpetuid(idx);
	
	return n;
} //회원 번호로 펫uid가져오기 

//펫uid로 펫정보 가져오기 
@Override
public PetVO selectpetinfo(String pet_uid) {
	PetVO petinfo =dao.selectpetinfo(pet_uid);
	return petinfo;
}


//회원번호로 병원 이름 가져오기 
@Override
public String selectnickname(String idx) {
	String nickname = dao.selectnickname(idx);
	System.out.println("nickname S: " +nickname);
	return nickname;
}
//회원번호로 예약 날짜 알아오기 
@Override
public ReservationVO selectreservedate(String idx) {
	ReservationVO reservedate =dao.selectreservedate(idx);
	return reservedate;
}


	
   

}
