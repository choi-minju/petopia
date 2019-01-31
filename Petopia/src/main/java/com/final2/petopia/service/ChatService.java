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
	
	// 채팅 뷰
	@Override
	public String viewcode(String code) throws Throwable {
		
		String n = "";
		
		n = dao.viewcode(code);
		
		return n;
	}
	
	// idx값 알아오기
	@Override
	public String viewidx(String usercode) throws Throwable {
		
		String n = "";
		
		n = dao.viewidx(usercode); 
		
		return n;
	}
	
	// 정보 insert
	@Override
	public int insertall(HashMap<String, Object> returnMap) throws Throwable {
		
		int n = 0;
		
		n = dao.insertall(returnMap);
		
		return n;
	}

	@Override
	public String viewuserid(String idx) {
		
		String n = "";
		
		n = dao.viewuserid(idx);
		
		return n;
	}

	@Override
	public String viewname_biz(String idx) {
		
		String n = "";
		
		n = dao.viewname_biz(idx);
		
		return n;
	}

	@Override
	public String viewdocname(String idx) {
		
		String n = "";
		
		n = dao.viewdocname(idx);
		
		return n;
	}
	
	
	
}
