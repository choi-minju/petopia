
package com.final2.petopia.model;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface InterChartDAO {

	int insertmychart(HashMap<String, String> mychartmap);// 마이페이지에서 처방전 입력하기

	ChartVO selectchartinfo(int idx); // 차트 정보 불러오기

	List<HashMap<String, String>> selectreserveinfo(int idx); // 예약정보 가져오기

	int selecttabuid(HashMap<String, Object> paramap); // 탭에 넣을 예약번호 알아오기

	// 0124
	List<HashMap<String, String>> selectBizReservationList(HashMap<String, String> paraMap); // 기업회원예약진료리스트

	int getTotalCountNoSearch(int idx_biz);

	HashMap<String, String> selectReserverInfo(String ruid); // 예약번호로 예약자 정보 불러오기

	List<HashMap<String, String>> selectDocList(String ruid); // 예약번호로 의사 이름 알아오기

	int insertChart(ChartVO cvo);// 병원페이지에서 차트 입력하기
	// 0128

	int insertPre(List<HashMap<String, String>> mlist);// 병원페이지에서 처방전 입력하기

	void updaterstatus(String ruid);// 처방전 인서트 성공하면 예약 스테이터스 변경하기

	HashMap<String, String> selectChart(HashMap<String, String> map); // 병원페이지에서 차트 내용불러오기

	String getChartuid(); // 차트번호가져오기

	String getPuid(HashMap<String, String> map); // 처방전 번호 알아오기

	// 0129
	// 예약자번호로 처방전 인서트 내용 가져오기
	HashMap<String, String> selectpreinfobyruid(String ruid);

	HashMap<String, String> selectPreinfo(HashMap<String, String> map2); // 셀렉트창에서 처방전 내용가져오기

	// 0131 예약번호로 차트번호 알아오기
	String getChartuidbyruid(String ruid);

	int Updatechart(HashMap<String, String> map);// 병원페이지에서 차트 수정하기

	int Updatepre(HashMap<String, String> map);// 0131병원페이지에서 차트 수정시 처방전 수정

	List<HashMap<String, String>> selectPre(HashMap<String, String> map);// 병원 차트페이지에서 처방전 부분

	// 0201 캘린더에 넣을 리스트 가져오기
	List<HashMap<String, String>> selectMyPrescription(String fk_pet_uid);

	// 0202 회원이 보유한 펫 마리수 가져오기
	int getPetmaribyidx(int idx);

	// 0202pet_uid가 가장 작은 동물의 puid 알아오기
	int getMinpuidbyidx(int idx);

	// 0202 가장 작은 petuid를 가진 동물의 정보 가져오기
	HashMap<String, String> getPinfobyminpuid(int minpuid);

	// 0202 idx로 반려동물의 이미지와 이름 리스트 불러오기
	List<HashMap<String, String>> getPmapListbyidx(int idx);

}