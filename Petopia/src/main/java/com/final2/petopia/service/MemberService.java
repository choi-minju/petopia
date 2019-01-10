package com.final2.petopia.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.final2.petopia.model.InterMemberDAO;

@Service
public class MemberService implements InterMemberService {
	
	@Autowired
	private InterMemberDAO dao;

	// 태그 리스트 보여주기
	@Override
	public List<HashMap<String, String>> selectRecommendTagList() {
		List<HashMap<String, String>> tagList = dao.selectRecommendTagList();
		
		return tagList;
	} // end of public List<HashMap<String, String>> selectRecommendTagList()
	
}