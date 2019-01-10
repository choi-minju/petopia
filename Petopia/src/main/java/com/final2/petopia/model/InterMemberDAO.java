package com.final2.petopia.model;

import java.util.HashMap;
import java.util.List;

public interface InterMemberDAO {

	// 태그 리스트 보여주기
	List<HashMap<String, String>> selectRecommendTagList();

}
