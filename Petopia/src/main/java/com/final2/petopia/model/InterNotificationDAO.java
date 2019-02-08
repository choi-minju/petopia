package com.final2.petopia.model;

import java.util.HashMap;
import java.util.List;

public interface InterNotificationDAO {

	// 회원의 고유번호를 이용한 안읽은 알림 갯수 나타내기
	int selectUnreadNotificationCount(int idx);
	
	// 회원의 고유번호를 이용한 심플 알림정보 가져오기(알림타입과 그 갯수)
	List<HashMap<String, String>> selectNotificatioSimplenList(int idx);

}
