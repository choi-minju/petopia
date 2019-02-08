package com.final2.petopia.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.final2.petopia.model.ChartVO;
import com.final2.petopia.model.InterChartDAO;


@Service
public class ChartService implements InterChartService {

	@Autowired
	private InterChartDAO dao;

	// 마이페이지에서 처방전 입력하기
	@Override
	public int insertmychart(HashMap<String, String> mychartmap) {
		int n = dao.insertmychart(mychartmap);
		return n;
	}

	// 차트 정보 불러오기
	@Override
	public ChartVO selectchartinfo(int idx) {
		ChartVO chartinfo = dao.selectchartinfo(idx);
		return chartinfo;
	}

	// 예약 정보 가져오기
	@Override
	public List<HashMap<String, String>> selectreserveinfo(int idx) {
		List<HashMap<String, String>> maplist = dao.selectreserveinfo(idx);
		return maplist;
	}

	// 탭에 넣을 예약번호 알아오기
	@Override
	public int selecttabuid(HashMap<String, Object> paramap) {
		int ruid = dao.selecttabuid(paramap);
		return ruid;
	}

	// 0124
	@Override
	public List<HashMap<String, String>> selectBizReservationList(HashMap<String, String> paraMap) {
		List<HashMap<String, String>> maplist = dao.selectBizReservationList(paraMap);
		return maplist;
	}

	@Override
	public int getTotalCountNoSearch(int idx_biz) {
		int totalCount = dao.getTotalCountNoSearch(idx_biz);
		return totalCount;
	}

	// 예약번호로 예약자 정보 얻어오기  0207
	@Override
	public HashMap<String, String> selectReserverInfo(String ruid) {
		HashMap<String, String> chartmap =null;
		int reservation_type =dao.selectrtype(ruid);
		
		if(reservation_type == 3) { //결제 정보가 있을때 (수술)
			chartmap = dao.selectReserverInfo(ruid);
		}else if(reservation_type != 3) { //결제정보가 없을때  (수술 이외 )
			chartmap=dao.selectReserverInfoNopay(ruid);
		}
		return chartmap;
	}

	// 0125
	// 예약번호로 의사이름 목록 알아오기
	@Override
	public List<HashMap<String, String>> selectDocList(String ruid) {
		List<HashMap<String, String>> doclist = dao.selectDocList(ruid);
		return doclist;
	}

	// 병원페이지에서 차트내용 인서트하기 0126  0207 0208
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int insertChart(ChartVO cvo, List<HashMap<String, String>> mlist,HashMap<String, String> map) throws Throwable {
   
		int n1 =0;
		int n2=0;
		int result =0; 
		System.out.println("mlist s: "+mlist);
		String ruid =map.get("ruid");
		
		int reservation_type =dao.selectrtype(ruid);
		
		if(reservation_type ==3) {//결제정보가 있는 경우에 인서트
			n1 = dao.insertChart(cvo);	
			
		}else if(reservation_type !=3) { //결제정보가 없는 경우에 인서트 
			n1=dao.insertChartNopay(cvo);
		}
		
		if (n1 ==1) { // 차트 인서트에 성공하면 
			System.out.println("mlist: "+mlist);
			n2 = dao.insertPre(mlist); //처방전에 인서트하기 
			
		   if(n2==1) {
			   dao.updaterstatus(ruid); //스테이터스 변경하기 
			}
		}
		
		if(n1*n2 ==1) {
			result=1;
		}
		return result;
	}

/*	// 0128 0130 병원페이지에서 처방전 인서트하기
	@Override
	public int insertPre(List<HashMap<String, String>> mlist) {
		int n = dao.insertPre(mlist);
		return n;
	}

	// 처방전인서트 성공하면 예약스테이터스 변경하기
	@Override
	public void updaterstatus(String ruid) {
		dao.updaterstatus(ruid);

	}*/

	// 병원페이지에서 처방전 내용 불러오기
	@Override
	public HashMap<String, String> selectChart(HashMap<String, String> map) {
		HashMap<String, String> cmap = dao.selectChart(map);

		return cmap;
	}

	// 차트번호 불러오기
	@Override
	public String getChartuid() {
		String cuid = dao.getChartuid();
		return cuid;
	}

	// 처방전번호 알아오기
	@Override
	public String getPuid(HashMap<String, String> map) {
		String puid = dao.getPuid(map);
		return puid;
	}

	// 0129
	// 예약자번호로 처방전 인서트 내용 가져오기
	@Override
	public HashMap<String, String> selectpreinfobyruid(String ruid) {
		HashMap<String, String> preinfo = dao.selectpreinfobyruid(ruid);
		return preinfo;
	}

	// 셀렉트창에서 처방전 내용가져오기
	@Override
	public HashMap<String, String> selectPreinfo(HashMap<String, String> map2) {
		HashMap<String, String> pmap = dao.selectPreinfo(map2);
		return pmap;
	}

	// 0131 예약번호로 차트 번호 알아오기
	@Override
	public String getChartuidbyruid(String ruid) {
		String cuid = dao.getChartuidbyruid(ruid);
		return cuid;
	}

	// 0131병원페이지에서 차트 수정하기
	@Override
	public int Updatechart(HashMap<String, String> map) {
		int n = dao.Updatechart(map);
		
		if (n== 1) {
			 n = dao.Updatepre(map);// 병원페이지에서 차트 수정시 처방전 수정
		}
		return n;
	}

/*	// 병원페이지에서 차트 수정시 처방전 수정
	@Override
	public int updatepre(HashMap<String, String> map) {
		int n = dao.Updatepre(map);
		return n;
	}*/

	// 병원 차트페이지에서 처방전 부분
	@Override
	public List<HashMap<String, String>> selectPre(HashMap<String, String> map) {
		List<HashMap<String, String>> pmap2list = dao.selectPre(map);
		return pmap2list;
	}

	// 0201캘린더에 넣을 정보 가져오기
	@Override
	public List<HashMap<String, String>> selectMyPrescription(String fk_pet_uid) {
		List<HashMap<String, String>> callist = dao.selectMyPrescription(fk_pet_uid);
		return callist;
	}

	// 0202 회원이 보유한 펫 마리수 가져오기
	@Override
	public int getPetmaribyidx(int idx) {
		int pnum = dao.getPetmaribyidx(idx);
		return pnum;
	}

	// 0202 pet_uid가 가장 작은 동물의 puid 알아오기
	@Override
	public int getMinpuidbyidx(int idx) {
		int minpuid = dao.getMinpuidbyidx(idx);
		return minpuid;
	}

	// 0202 가장 작은 petuid를 가진 동물의 정보 가져오기
	@Override
	public HashMap<String, String> getPinfobyminpuid(int minpuid) {
		HashMap<String, String> minpinfo = dao.getPinfobyminpuid(minpuid);
		return minpinfo;
	}

	// 0202 idx로 반려동물의 이미지와 이름 리스트 불러오기
	@Override
	public List<HashMap<String, String>> getPmapListbyidx(int idx) {
		List<HashMap<String, String>> pmaplist = dao.getPmapListbyidx(idx);
		return pmaplist;
	}

	@Override
	public int selectrtype(String ruid) {
		int rtype =dao.selectrtype(ruid);
		return rtype;
	}




}
