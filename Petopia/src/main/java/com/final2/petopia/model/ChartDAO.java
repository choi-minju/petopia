package com.final2.petopia.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

	@Repository
	public  class ChartDAO implements InterChartDAO {
		
			@Autowired
			private SqlSessionTemplate sqlsession;

			
			//펫uid로 펫정보 가져오기 
			@Override
			public List<PetVO> selectpetlist(int idx) {
				List<PetVO> petinfo = sqlsession.selectList("chart.selectpetlist",idx);
				
				return petinfo;
			}
			
			//마이페이지에서 처방전 입력하기 
			@Override
			public int insertmychart(HashMap<String, String> mychartmap) {
				int n = sqlsession.insert("chart.insertmychart",mychartmap);
				return n;
			}
			@Override
			public ChartVO selectchartinfo(int idx) {
				ChartVO chartinfo=sqlsession.selectOne("chart.selectchartinfo", idx); 
				return chartinfo;
			}

			@Override
			public int selecttabuid( HashMap<String,Object> paramap) {
				int ruid = sqlsession.selectOne("chart.selecttabuid",paramap);
				return ruid;
			}

			@Override
			public List<HashMap<String,String>> selectreserveinfo(int idx) {
				 List<HashMap<String,String>> maplist =sqlsession.selectList("chart.selectreserveinfo",idx);
				return maplist;
			}

		
			
			
			
	}
