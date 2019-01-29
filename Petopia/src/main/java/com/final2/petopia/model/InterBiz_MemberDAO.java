package com.final2.petopia.model;

import java.util.HashMap;
import java.util.List;

public interface InterBiz_MemberDAO {

	// 태그 리스트 보여주기
	List<HashMap<String, String>> selectRecommendTagList();

	// 아이디 중복확인
	int selectBizMemberIdIsUsed(String userid);

	// 회원가입할 회원번호 받아오기
	int selectMemberNoSeq();

	// member 테이블 insert
	int insertMemberByMvo(Biz_MemberVO bmvo);
	
	// login_log 테이블 insert
	int insertLogin_logByMvo(Biz_MemberVO bmvo);
	
	// have_tag 테이블 insert
	int insertHave_tagByTagList(List<HashMap<String, String>> selectTagList);
	
	// biz_info 테이블 insert
	int insertBizInfo(Biz_MemberVO bmvo);

	// biz_info_img 테이블 insert
	int insertBizInfoImg(List<HashMap<String, String>> addImgmapList);
	
	// doctors 테이블 insert
	int insertDoctor(List<HashMap<String, String>> docList);

	

}
