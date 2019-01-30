package com.final2.petopia.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.final2.petopia.model.InterNotificationDAO;

@Service
public class NotificationService implements InterNotificationService {
	
	//===== 의존객체 주입(DI:Dependency Injection)  =====
	@Autowired
	private InterNotificationDAO dao;
	
	//===== 양방향 암호화 알고리즘인 AES256을 사용하여 암호화/복호화하기 위한 클래스 의존객체 주입(DI:Dependency Injection) =====
	//@Autowired
	//private AES256 aes;
	
	// ----------------------------------------------------------------------------------------------------------
	
	// 회원의 고유번호를 이용한 안읽은 알림 갯수 나타내기
	@Override
	public String selectUnreadNotificationCount(int idx) {
		
		String unreadNotificationCount = dao.selectUnreadNotificationCount(idx);
		
		return unreadNotificationCount;
	}

}
