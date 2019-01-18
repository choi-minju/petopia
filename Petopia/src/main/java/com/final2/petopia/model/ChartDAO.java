package com.final2.petopia.model;

import java.util.HashMap;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

	@Repository
	public  class ChartDAO implements InterChartDAO {
		// ===== #33. 의존 객체 주입하기 (DIL Dependency Injection) =====
			@Autowired
			private SqlSessionTemplate sqlsession;

			@Override
			public int insertmychart(HashMap<String, String> mychartmap) {
				int n =sqlsession.insert("chart.insertmychart",mychartmap);
				return n;
			}

			@Override
			public int selectpetuid(String idx) {
				int n = sqlsession.selectOne("chart.selectpetuid", idx);
				return n;
			}


			
	}

