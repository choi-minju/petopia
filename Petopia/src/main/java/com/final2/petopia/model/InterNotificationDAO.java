package com.final2.petopia.model;

public interface InterNotificationDAO {

	// 회원의 고유번호를 이용한 안읽은 알림 갯수 나타내기
	String selectUnreadNotificationCount(int idx);

}