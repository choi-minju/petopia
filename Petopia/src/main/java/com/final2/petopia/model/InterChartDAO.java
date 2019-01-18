package com.final2.petopia.model;

import java.util.HashMap;

import org.springframework.stereotype.Repository;


@Repository
public interface InterChartDAO {

	
int insertmychart(HashMap<String, String> mychartmap);

int selectpetuid(String idx); //회원번호로 펫 uid가져오기 

	

}
