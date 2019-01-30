package com.final2.petopia.model;

import java.util.HashMap;

import org.springframework.stereotype.Repository;

@Repository
public interface InterChatDAO {

	int addcode(HashMap<String, String> map);

	String viewcode(String code);

	String selectend(HashMap<String, String> map); // 화상상담종료시 ID에해당하는값 select

}
