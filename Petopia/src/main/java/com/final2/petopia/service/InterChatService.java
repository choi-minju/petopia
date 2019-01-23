package com.final2.petopia.service;

import java.util.HashMap;

import org.springframework.stereotype.Service;

@Service
public interface InterChatService {

	int createcode(HashMap<String, String> map) throws Throwable; // 랜덤코드생성

}
