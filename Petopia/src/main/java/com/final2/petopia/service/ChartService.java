package com.final2.petopia.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.final2.petopia.model.InterChartDAO;

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
	
   

}
