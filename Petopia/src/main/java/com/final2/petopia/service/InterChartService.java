package com.final2.petopia.service;

import java.util.HashMap;

import com.final2.petopia.model.PetVO;
import com.final2.petopia.model.ReservationVO;

public interface InterChartService {

	int insertmychart(HashMap<String, String> mychartmap); //차트 입력하기 

	int selectpetuid(String idx); //회원번호로 펫번호  가져오기 

	PetVO selectpetinfo(String pet_uid);

	String selectnickname(String idx); //회원번호로 병원 이름 가져오기 

	ReservationVO selectreservedate(String idx); //회원번호로 방문일자, 예약일자 알아오기 




    
}
