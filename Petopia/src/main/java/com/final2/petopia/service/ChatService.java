package com.final2.petopia.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
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
		
}
