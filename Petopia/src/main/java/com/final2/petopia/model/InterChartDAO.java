package com.final2.petopia.model;

import java.util.HashMap;

import org.springframework.stereotype.Repository;


@Repository
public interface InterChartDAO {

	
int insertmychart(HashMap<String, String> mychartmap);

int selectpetuid(String idx); //회원번호로 펫 uid가져오기 

PetVO selectpetinfo(String pet_uid); //펫 uid로 펫정보 가져오기 

String selectnickname(String idx); //회원번호로 병원 이름 가져오기 

ReservationVO selectreservedate(String idx); //회원번호로 예약 날짜 알아오기

	

}
