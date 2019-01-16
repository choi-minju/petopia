package com.final2.petopia.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.final2.petopia.model.ChartDAO;
import com.final2.petopia.model.ReservationVO;

@Service
public class ChartService {
	// ===== #34. 의존 객체 주입하기 (DIL Dependency Injection) =====
		@Autowired
		private ChartDAO dao;

        //기업회원 페이지에서 차트 인서트하기 
		public int insertchartinfo(ReservationVO rvo) {
			
			int n=dao.insertchartinfo(rvo);
			
			return n;
		}

		
}
