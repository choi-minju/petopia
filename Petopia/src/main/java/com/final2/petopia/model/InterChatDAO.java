package com.final2.petopia.model;

import java.util.HashMap;

import org.springframework.stereotype.Repository;

@Repository
public interface InterChatDAO {

	int addcode(HashMap<String, String> map);

	String viewcode(String code);

	String viewidx(String usercode); // idx값 알아오기

	int insertall(HashMap<String, String> returnMap); // videochat DB에 insert

	String selectend(String idx); // idx에 따라 회원정보 가져오기 

}
