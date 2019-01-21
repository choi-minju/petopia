package com.final2.petopia.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.final2.petopia.model.Biz_MemberVO;
import com.final2.petopia.service.SearchService;

@Controller
public class SearchController {
	
	@Autowired
	private SearchService service;
	
	// 검색어를 입력 후 엔터했을때 지도화면으로 보내기
	@RequestMapping(value="/search.pet", method= {RequestMethod.GET})
	public String search(HttpServletRequest req) {
		
		String searchWord = req.getParameter("searchWord");
		
		int cnt = service.searchCount(searchWord);
		// 지도화면으로 넘어갈때 몇건 검색되었는지도 보내기
		
		req.setAttribute("searchWord", searchWord);
		req.setAttribute("cnt", cnt);
		
		return "search/index.tiles2";
		
	}
	
	// 검색어를 기준으로 지역별, 병원별, 약국별 갯수 보여주는 AJAX
	@RequestMapping(value="/getNumberbysearchWord.pet", method= {RequestMethod.GET})
	@ResponseBody
	public HashMap<String, Integer> getNumberbysearchWord(HttpServletRequest req) {
		
		String searchWord = req.getParameter("searchWord");

		HashMap<String, Integer> CountMap = new HashMap<String, Integer>();
		
		if(searchWord != null && !searchWord.trim().isEmpty()) {
			
			CountMap = service.searchCountMap(searchWord);
			// 단어를 기준으로 지역명 - 몇건, 병원이름 - 몇건, 약국이름 - 몇건 이런식으로 보여주기
	
		}
		
		return CountMap;
		
	}
	
	
	// 검색결과가 1개인 경우(사용자가 병원 또는 약국 이름을 알고 검색 한 경우) 병원 풀네임을 받아 보여주고, 바로 병원 정보로 갈 수 있도록 링크 생성하기
	@RequestMapping(value="wordCompleteAndSetDirect.pet", method= {RequestMethod.GET})
	@ResponseBody
	public Biz_MemberVO wordCompleteAndSetDirect(HttpServletRequest req) {
		
		String searchWord = req.getParameter("searchWord");
		
		Biz_MemberVO bizvo = service.getFullnameAndIdx(searchWord);
		
		return bizvo;
		
	}
	
	
	
}
