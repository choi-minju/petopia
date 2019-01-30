package com.final2.petopia.service;

import java.util.HashMap;

import org.springframework.stereotype.Service;

@Service
public interface InterChatService {

	int createcode(HashMap<String, String> map) throws Throwable; // 랜덤 코드 생성

	String viewcode(String code) throws Throwable; // 채팅 뷰

	String viewidx(String usercode) throws Throwable; // idx 알아오기

	int insertall(HashMap<String, String> returnMap) throws Throwable; //  정보 insert

	String selectend(String idx); // idx에 따라 회원정보 가져오기 

}
