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
			//0124
			@Override
			public List<HashMap<String,String>> selectBizReservationList(HashMap<String, String> paraMap) {
				 List<HashMap<String,String>> maplist =sqlsession.selectList("chart.selectBizReservationList",paraMap);
				 return maplist;
			}

			@Override
			public int getTotalCountNoSearch(int idx_biz) {
				int n =sqlsession.selectOne("chart.getTotalCountNoSearch",idx_biz);
				return n;
			}
            //예약번호로 예약자 정보 불러오기 
			@Override
			public HashMap<String,String> selectReserverInfo(String ruid) {
				
				HashMap<String,String> chartmap = sqlsession.selectOne("chart.selectReserverInfo",ruid);
				
				return chartmap;
			}
			//0125  예약번호로 의사 이름 가져오기 
			@Override
			public List<HashMap<String, String>> selectDocList(String ruid) {
				 List<HashMap<String, String>> doclist =sqlsession.selectList("chart.selectDocList",ruid);
				return doclist ;
			}
			//병원페이지에서 차트 입력하기 
			@Override
			public int insertChart(ChartVO cvo) {
				int n = sqlsession.insert("chart.insertChart",cvo);
				return n;
			}
			
			
	}
