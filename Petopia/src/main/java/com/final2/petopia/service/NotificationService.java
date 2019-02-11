package com.final2.petopia.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.final2.petopia.model.InterNotificationDAO;
import com.final2.petopia.model.NotificationVO;

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
	public int selectUnreadNotificationCount(int idx) {
		
		int unreadNotificationCount = dao.selectUnreadNotificationCount(idx);
		
		return unreadNotificationCount;
	}
	
	// 회원의 고유번호를 이용한 심플 알림정보 가져오기(알림타입과 그 갯수)
	@Override
	public List<HashMap<String, String>> selectNotificatioSimplenList(int idx) {
		
		List<HashMap<String, String>> n_List = dao.selectNotificatioSimplenList(idx);
		
		return n_List;
	}
	
	// 알림 리스트 가져오기
	@Override
	public List<NotificationVO> selectNotificationList(int idx) {
		
		List<NotificationVO> notificationList = dao.selectNotificationList(idx);
		
		return notificationList;
	}

}
