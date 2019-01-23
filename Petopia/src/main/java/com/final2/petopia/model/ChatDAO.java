package com.final2.petopia.model;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ChatDAO implements InterChatDAO {
	
	// 의존객체 주입
	@Autowired
	private SqlSessionTemplate sqlsession;

	@Override
	public int addcode(HashMap<String, String> map) {
		
		int n = sqlsession.insert("chat.addcode", map);
		
		return n;
	}
	
}
