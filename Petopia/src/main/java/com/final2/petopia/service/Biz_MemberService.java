package com.final2.petopia.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.final2.petopia.model.InterBiz_MemberDAO;

@Service
public class Biz_MemberService implements InterBiz_MemberService {
	
	@Autowired
	private InterBiz_MemberDAO dao;

	@Override
	public int idDuplicateCheck(String userid) {
		
		int n = dao.idDuplicateCheck(userid);
		
		return n;
	}

}
