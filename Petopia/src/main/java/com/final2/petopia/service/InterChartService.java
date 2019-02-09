package com.final2.petopia.service;

import java.util.HashMap;
import java.util.List;
import com.final2.petopia.model.ChartVO;
import com.final2.petopia.model.PetVO;
import com.final2.petopia.model.ReservationVO;

public interface InterChartService {

	int insertmychart(HashMap<String, String> mychartmap);

	ChartVO selectchartinfo(int idx); // 차트 인포 불러오기

	List<HashMap<String, String>> selectreserveinfo(int idx); // 예약 정보 가져오기

	int selecttabuid(HashMap<String, Object> paramap); // 탭에 넣을 예약번호 알아오기

	// 0124
	List<HashMap<String, String>> selectBizReservationList(HashMap<String, String> paraMap);// 기업회원번호로 진료예약리스트

	int getTotalCountNoSearch(int idx_biz); // 기업번호로 갯수 세오기

	HashMap<String, String> selectReserverInfo(String ruid); // 예약번호를 이용하여 차트에 예약자 정보 불러오기

	// 0125
	List<HashMap<String, String>> selectDocList(String ruid); // 예약번호로 의사이름 목록 알아오기

	int insertChart(ChartVO cvo, List<HashMap<String, String>> mlist, HashMap<String, String> map) throws Throwable; // 병원페이지에서 차트 내용 인서트하기
	// 0128 0130 0207


	HashMap<String, String> selectChart(HashMap<String, String> map); // 차트 내용 불러오기

	String getChartuid(); // 차트번호 채번하기

	String getPuid(HashMap<String, String> map);// 처방전번호 알아오기

	// 0129
	HashMap<String, String> selectpreinfobyruid(String ruid); // 예약자번호로 처방전 인서트 내용 가져오기

	HashMap<String, String> selectPreinfo(HashMap<String, String> map2); // 셀렉트창에서 처방전 내용가져오기

	// 0131 예약번호로 차트 번호 알아오기
	String getChartuidbyruid(String ruid);

	int Updatechart(HashMap<String, String> map, ChartVO cvo, List<HashMap<String, String>> plist); // 병원페이지에서 차트 수정하기

	//int updatepre(HashMap<String, String> map); // 병원페이지에서 차트 수정시 처방전 수정

	List<HashMap<String, String>> selectPre(HashMap<String, String> map); // 병원 차트페이지에서 처방전 부분

	// 0201 캘린더에 넣을 리스트 가져오기
	List<HashMap<String, String>> selectMyPrescription(String fk_pet_uid);

	// 0202 회원이 보유한 반려동물 수 알아오기
	int getPetmaribyidx(int idx);

	// 0202pet_uid가 가장 작은 동물의 puid 알아오기
	int getMinpuidbyidx(int idx);

	// 0202petuid가 가장 작은 동물의 정보 가져오기
	HashMap<String, Object> getPinfobyminpuid(int minpuid);

	// 0202 idx로 반려동물의 이미지와 이름 리스트 불러오기
	List<HashMap<String, String>> getPmapListbyidx(int idx);

	//0208 타입 받아오기 
	int selectrtype(String ruid);

	//0209 펫이미지 클릭시 보여질 정보 
	HashMap<String, Object> getPinfo(String puid);

	

}
