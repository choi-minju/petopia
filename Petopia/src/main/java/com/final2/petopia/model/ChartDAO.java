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
			//병원페이지에서 차트 입력하기 0126
			@Override
			public int insertChart(ChartVO cvo) {
				
				int n = sqlsession.insert("chart.insertChart",cvo);
				return n;
			}
			//병원페이지에서 처방전 입력하기 0128 0130
			@Override
			public int insertPre(List<HashMap<String, String>> mlist) {
				int result = 0;
				for(HashMap<String, String> map:mlist) {
					int n =sqlsession.insert("chart.insertPre",map);
					if(n==0) {
						result=0;
						return result;
					}else {
						result=1;
					}
				}
				return result;
			}
            //처방전 인서트 완료후 예약스테이터스 변경하기 
			@Override
			public void updaterstatus(String ruid) {
				sqlsession.update("chart.updaterstatus",ruid);
				
			}
			//병원페이지에서 차트 내역불러오기 
			@Override
			public HashMap<String, String> selectChart(HashMap<String,String> map) {
				HashMap<String, String> cmap = sqlsession.selectOne("chart.selectChart",map);
				
				return cmap;
			}
			//차트번호 가져오기 
			@Override
			public String getChartuid() {
				String cuid=sqlsession.selectOne("chart.getChartuid");
				return cuid;
			}
			//처방전 번호 알아오기 
			@Override
			public String getPuid(HashMap<String,String> map) {
				String puid = sqlsession.selectOne("chart.getPuid",map);
				return puid;
			}
			//0129
			//예약자번호로 처방전 인서트 내용 가져오기
			@Override
			public HashMap<String, String> selectpreinfobyruid(String ruid) {
				HashMap<String, String> preinfo = sqlsession.selectOne("chart.selectpreinfobyruid",ruid);
				return preinfo;
			}
			//셀렉트창에서 처방전 내용가져오기 
			@Override
			public HashMap<String, String> selectPreinfo(HashMap<String, String> map2) {
				HashMap<String, String> pmap = sqlsession.selectOne("chart.selectPreinfo",map2);
				return pmap;
			}

			//0131 예약번호로 차트번호 알아오기 
			@Override
			public String getChartuidbyruid(String ruid) {
				String cuid= sqlsession.selectOne("chart.getChartuidbyruid",ruid);
				return cuid;
			}
			//0131병원페이지에서 차트 수정하기
			@Override
			public int Updatechart(HashMap<String, String> map) {
				int n =sqlsession.update("chart.Updatechart",map);
				return n;
			}
			//0131병원페이지에서 차트 수정시 처방전 수정
			@Override
			public int Updatepre(HashMap<String, String> map) {
				int n =sqlsession.update("chart.Updatepre",map);
				return n;
			}
			//병원 차트페이지에서 처방전 부분 
			@Override
			public List<HashMap<String, String>> selectPre(HashMap<String, String> map) {
				List<HashMap<String, String>> pmap2list = sqlsession.selectList("chart.selectPre",map);
				return pmap2list;
			}
			
			
	}
