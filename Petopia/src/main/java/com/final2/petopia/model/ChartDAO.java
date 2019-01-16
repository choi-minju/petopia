package com.final2.petopia.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ChartDAO {
	// ===== #33. 의존 객체 주입하기 (DIL Dependency Injection) =====
		@Autowired
		private SqlSessionTemplate sqlsession;

		public int insertchartinfo(ReservationVO rvo) {
			// TODO Auto-generated method stub
			return 0;
		}
}
