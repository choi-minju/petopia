package com.final2.petopia.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.final2.petopia.model.InterChatDAO;

@Service
public class ChatService implements InterChatService {
	
	@Autowired
	private InterChatDAO dao;
	
	// 랜덤코드 생성
	@Override
	public int createcode(HashMap<String, String> map) throws Throwable{
		
		int n = 0;
		
		n = dao.addcode(map);
		
		return n;
	}
	
	// 채팅 뷰
	@Override
	public String viewcode(String code) throws Throwable {
		
		String n = "";
		
		n = dao.viewcode(code);
		
		return n;
	}
	
	// 채팅 종료
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int chatend(HashMap<String, String> map) throws Throwable {
		
		int n = 0;
		String result1 = "";
		int result2 = 0;
		
		result1 = dao.selectend(map);
		
		if(result1 != null) {
			result2 = dao.insertend(map);
			
			if(result2 > 0) {
				n = 1;
			}
		}
		
		return n;
	}
		
}
