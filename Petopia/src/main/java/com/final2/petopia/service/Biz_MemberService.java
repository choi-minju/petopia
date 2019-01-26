package com.final2.petopia.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.reflection.SystemMetaObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.final2.petopia.model.Biz_MemberVO;
import com.final2.petopia.model.InterBiz_MemberDAO;
import com.final2.petopia.model.MemberVO;

@Service
public class Biz_MemberService implements InterBiz_MemberService {
	
	@Autowired
	private InterBiz_MemberDAO dao;

	@Override
	public List<HashMap<String, String>> selectHaveTagList() {
		
		List<HashMap<String, String>> tagList = dao.selectHaveTagList();
		
		return tagList;
	}

	@Override
	public int selectBizMemberIdIsUsed(String userid) {
		
		int cnt = dao.selectBizMemberIdIsUsed(userid);
		
		return cnt;
	}
	
	// 태그가 있는 경우 회원가입
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int insertMemberByMvoTagList(Biz_MemberVO bmvo, String[] tagNoArr, String[] tagNameArr) {
		
		int result = 0;
		
		// 회원가입할 회원번호 받아오기
		int idx = dao.selectMemberNoSeq();
		
		// 회원번호 mvo에 넣기
		bmvo.setIdx_biz(idx);
		
		// member 테이블 insert
		int n1 = dao.insertMemberByMvo(bmvo);

		// login_log 테이블 insert
		int n2 = dao.insertLogin_logByMvo(bmvo);
		
		// have_tag 테이블 insert
		List<HashMap<String, String>> selectTagList = new ArrayList<HashMap<String, String>>();
		
		for(int i=0; i<tagNoArr.length; i++) {
			HashMap<String, String> selectTagMap = new HashMap<String, String>();
			selectTagMap.put("FK_TAG_UID", tagNoArr[i]);
			selectTagMap.put("FK_TAG_NAME", tagNameArr[i]);
			selectTagMap.put("FK_IDX", String.valueOf(idx));
			
			selectTagList.add(selectTagMap);
		} // end of for
		
		int n3 = dao.insertHave_tagByTagList(selectTagList);
		
		int n4 = dao.insertBizInfo(bmvo);
		
		
		
		if(n1*n2*n3*n4 == 0) {
			// 회원가입 실패
			result = 0;
		} else {
			// 회원가입 성공
			result = 1;
		} // end of if~else
		
		return result;
	}

	@Override
	public int insertMemberByMvo(Biz_MemberVO bmvo) {
		
		int result = 0;
		
		// 회원가입할 회원번호 받아오기
		int idx = dao.selectMemberNoSeq();
		
		// 회원번호 mvo에 넣기
		bmvo.setIdx_biz(idx);
		
		// member 테이블 insert
		int n1 = dao.insertMemberByMvo(bmvo);

		// login_log 테이블 insert
		int n2 = dao.insertLogin_logByMvo(bmvo);
		
		if(n1*n2 == 0) {
			// 회원가입 실패
			result = 0;
		} else {
			// 회원가입 성공
			result = 1;
		} // end of if~else
		
		
		return result;	
	}


	
}
