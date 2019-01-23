package com.final2.petopia.model;

import java.util.HashMap;

import org.springframework.stereotype.Repository;

@Repository
public interface InterChatDAO {

	int addcode(HashMap<String, String> map);

}
