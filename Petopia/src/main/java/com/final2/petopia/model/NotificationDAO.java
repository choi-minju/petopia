package com.final2.petopia.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class NotificationDAO implements InterNotificationDAO{
	
	//===== 의존객체 주입(DI:Dependency Injection)  =====
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	// ----------------------------------------------------------------------------------------------------------

	// 회원의 고유번호를 이용한 안읽은 알림 갯수 나타내기
	@Override
	public int selectUnreadNotificationCount(int idx) {
		
		int unreadNotificationCount = sqlsession.selectOne("notification.selectUnreadNotificationCount", idx);
		
		return unreadNotificationCount;
	}
	
	// 회원의 고유번호를 이용한 심플 알림정보 가져오기(알림타입과 그 갯수)
	@Override
	public List<HashMap<String, String>> selectNotificatioSimplenList(int idx) {
		
		List<HashMap<String, String>> n_List = sqlsession.selectList("notification.selectNotificatioSimplenList", idx);
		
		return n_List;
	}

}
