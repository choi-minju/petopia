package com.final2.petopia.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.final2.petopia.model.Biz_MemberVO;
import com.final2.petopia.model.InterSearchDAO;

@Service
public class SearchService {

	@Autowired
	private InterSearchDAO dao; 
	
	// 단어를 기준으로 지역명 - 몇건, 병원이름 - 몇건, 약국이름 - 몇건 이런식으로 보여주기
	public HashMap<String, Integer> searchCountMap(String searchWord) {
		HashMap<String, Integer> searchCountMap = dao.searchCountMap(searchWord); 
		return searchCountMap;
	}

	// 검색결과가 1개인 경우(사용자가 병원 또는 약국 이름을 알고 검색 한 경우) 병원 풀네임을 받아 보여주고, 바로 병원 정보로 갈 수 있도록 링크 생성하기
	public Biz_MemberVO getFullnameAndIdx(String searchWord) {
		Biz_MemberVO bizvo = dao.getFullnameAndIdx(searchWord);
		return bizvo;
	}

	// 검색창으로 넘어갈때 검색된 병원/약국 수 보내기 
	public int searchCount(String searchWord) {
		int cnt = dao.searchCount(searchWord);
		return cnt;
	}

}
