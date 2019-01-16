package com.final2.petopia.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.final2.petopia.model.MemberVO;
import com.final2.petopia.service.InterBiz_MemberService;

@Controller
@Component
public class Biz_MemberController {
	
	@Autowired
	private InterBiz_MemberService service;
	
	@RequestMapping(value="/joinBizMember.pet", method={RequestMethod.GET})
	public String joinBizMember() {
		
		return "join/joinBizMember.tiles1";
	} // end of public String joinBizMember()
	
	@RequestMapping(value="/editBizMember.pet", method={RequestMethod.GET})
	public String editBizMember() {
		
		return "join/editBizMember.tiles1";
	} // end of public String editBizMember()
	
	@RequestMapping(value="/bizDetail.pet", method={RequestMethod.GET})
	public String bizDetail() {
		
		return "join/bizDetail.tiles1";
	} // end of public String bizDetail()
	
	
	// 아이디 중복검사
	@RequestMapping(value="/idcheck.action", method= {RequestMethod.GET})
	public String idcheck(HttpServletRequest req) {
		
		String userid = req.getParameter("userid");
		if(userid != null) {			
			int isUseuserid = service.idDuplicateCheck(userid);
			JSONObject jsonObject = new JSONObject();			
			jsonObject.put("cnt",isUseuserid);			
			req.setAttribute("cnt", jsonObject);
			
		}
		
		return "join/idDuplicateCheck.tiles1";
	}
	

}
