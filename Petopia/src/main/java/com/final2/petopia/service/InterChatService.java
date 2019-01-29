package com.final2.petopia.service;

import java.util.HashMap;

import org.springframework.stereotype.Service;

@Service
public interface InterChatService {

	int createcode(HashMap<String, String> map) throws Throwable; // 랜덤 코드 생성

	String viewcode(String code) throws Throwable; // 채팅 뷰

	int chatend(HashMap<String, String> map) throws Throwable; // 채팅 종료

}
