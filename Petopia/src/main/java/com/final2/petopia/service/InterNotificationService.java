package com.final2.petopia.service;

public interface InterNotificationService {

	// 회원의 고유번호를 이용한 안읽은 알림 갯수 나타내기
	int selectUnreadNotificationCount(int idx);

}
