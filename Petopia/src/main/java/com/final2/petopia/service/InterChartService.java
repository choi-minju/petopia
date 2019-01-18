package com.final2.petopia.service;

import java.util.HashMap;

public interface InterChartService {

	int insertmychart(HashMap<String, String> mychartmap); //차트 입력하기 

	int selectpetuid(String idx); //회원번호로 펫정보  가져오기 


    
}
