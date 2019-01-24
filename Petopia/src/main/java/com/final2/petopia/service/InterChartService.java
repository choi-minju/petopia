package com.final2.petopia.service;

import java.util.HashMap;
import java.util.List;

import com.final2.petopia.model.ChartVO;
import com.final2.petopia.model.PetVO;
import com.final2.petopia.model.ReservationVO;

public interface InterChartService {

	List<PetVO> selectpetlist(int idx); // 펫정보 가져오기 
	
	int insertmychart(HashMap<String, String> mychartmap);

	ChartVO selectchartinfo(int idx); //차트 인포 불러오기 

	 List<HashMap<String,String>> selectreserveinfo(int idx); //예약 정보 가져오기 

	int selecttabuid( HashMap<String,Object> paramap); //탭에 넣을 예약번호 알아오기 
  
	//0124
	List<HashMap<String, String>> selectBizReservationList(HashMap<String, String> paraMap);//기업회원번호로 진료예약리스트

	int getTotalCountNoSearch(int idx_biz); //기업번호로 갯수 세오기 

	HashMap<String,String> selectReserverInfo(String ruid); //예약번호를 이용하여 차트에 예약자 정보 불러오기

	/*List<HashMap<String, String>> selectDocList(String ruid); //예약번호로 의사이름 목록 알아오기
*/
	


	




    
}
