package com.final2.petopia.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.final2.petopia.model.ChatVO;
import com.final2.petopia.model.MemberVO;
import com.final2.petopia.service.InterChatService;


@Controller
@Component
public class ChatController extends TextWebSocketHandler{
	
	@Autowired
	private InterChatService service;
	
	//화상진료인트로
	@RequestMapping(value="/chat.pet", method= {RequestMethod.GET})
	public String requireLogin_chatview(HttpServletRequest req, HttpServletResponse res) {
		
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String MemberType = loginuser.getMembertype();
		
		req.setAttribute("MemberType", MemberType);
		
		return "chat/chatview.tiles2";
	}
	
	// (관리자)상담내역 뷰 
	@RequestMapping(value="/viewlog.pet", method= {RequestMethod.GET})
	public String requireLogin_viewlog(HttpServletRequest req, HttpServletResponse res) {
		
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String MemberType = loginuser.getMembertype();
		
		req.setAttribute("MemberType", MemberType);
		
		return "chat/viewlog.tiles2";
	}
	
	//화상진료페이지
	@RequestMapping(value="/videochat.pet", method= {RequestMethod.GET})
	public String videochat(HttpServletRequest req, HttpServletResponse res) {
		
		ChatVO chatvo = new ChatVO();
		
		String chatcode = chatvo.getChatcode();
		
		req.setAttribute("chatcode", chatcode);
	
		return "chat/videochat.tiles2";
	}
	
	//랜덤코드 생성
	@RequestMapping(value="/createcode.pet", method= {RequestMethod.GET})
	@ResponseBody
	public HashMap<String, String> createcode(HttpServletRequest req, HttpServletResponse res) throws Throwable {
		
		HashMap<String, String> map = new HashMap<String, String>();
		
		ChatVO chatvo = new ChatVO();
		
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		int idx = loginuser.getIdx();
		
		Random rnd = new Random();
		String randomStr = String.valueOf(rnd.nextInt(100000))+"-"+idx;
		
		session.setAttribute("chatcode", randomStr);
		chatvo.setChatcode(randomStr);
		
		map.put("idx", String.valueOf(idx));
		map.put("code", chatvo.getChatcode());
		
		int code = service.createcode(map);
		
		if(code == 1) {
			return map;
		}
		return map;
	}
	
	// code에 따라 접속 
	@RequestMapping(value="/viewcode.pet", method= {RequestMethod.GET})
	@ResponseBody
	public HashMap<String, Object> viewcode(HttpServletRequest req, HttpServletResponse res) throws Throwable {
		
		HttpSession session = req.getSession();
		
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String usercode = req.getParameter("code");
		
		if(loginuser.getMembertype().equals("2")) {
			/*String idx_biz = String.valueOf(loginuser.getIdx());*/
			String idx = service.viewidx(usercode);
			String code = service.viewcode(usercode);
			String fk_userid = service.viewuserid(idx);
			String fk_name_biz = service.viewname_biz(idx);
			String fk_docname = service.viewdocname(idx);
			
			System.out.println(idx);
			System.out.println(code);
			System.out.println(fk_userid);
			System.out.println(fk_name_biz);
			System.out.println(fk_docname);
			
			
			HashMap<String, Object> returnMap = new HashMap<String, Object>();
		
			returnMap.put("idx", idx);
			returnMap.put("code", code);
			returnMap.put("fk_userid", fk_userid);
			returnMap.put("fk_name_biz", fk_name_biz);
			returnMap.put("fk_docname", fk_docname);
			
			int result = service.insertall(returnMap);
			if(result != 1) {
				String msg = "";
				msg = "정보 insert 실패";
				req.setAttribute("msg", msg);
			}
			return returnMap;
		}
		else {
		
			String code = service.viewcode(usercode);
			
			HashMap<String, Object> returnMap = new HashMap<String, Object>();
			
			returnMap.put("code", code);
			
			return returnMap;
		}
	}
	
	//코드 입력
	@RequestMapping(value="/videocode.pet", method= {RequestMethod.GET})
	public String videocode(HttpServletRequest req, HttpServletResponse res) {
		
		HttpSession session = req.getSession();
		String chatcode = (String)session.getAttribute("chatcode");
		
		req.setAttribute("chatcode", chatcode);
		
		return "chat/videocode.notiles";
	}
	
	//정보출력
	@RequestMapping(value="/log.pet", method= {RequestMethod.GET})
	public List<HashMap<String, Object>> viewlog(HttpServletRequest req, HttpServletResponse res) {
		
		List<HashMap<String, Object>> returnmapList = new ArrayList<HashMap<String, Object>>();
		
		String fk_idx = req.getParameter("idx");
		
		System.out.println(fk_idx);
		
		List<HashMap<String,Object>> list = service.log(Integer.parseInt(fk_idx));
		
		if(list != null) {
			for(HashMap<String, Object> datamap : list) {
				HashMap<String, Object> submap = new HashMap<String, Object>();
				
				submap.put("time", datamap.get("time"));
				submap.put("fk_userid", datamap.get("fk_userid"));
				submap.put("chatcode", datamap.get("chatcode"));
				submap.put("fk_name_biz", datamap.get("fk_name_biz"));
				submap.put("fk_docname", datamap.get("fk_docname"));
				
				System.out.println(submap.get("time"));
				System.out.println(submap.get("fk_userid"));
				System.out.println(submap.get("chatcode"));
				System.out.println(submap.get("fk_name_biz"));
				System.out.println(submap.get("fk_docname"));
				
				returnmapList.add(submap);
			}
		}
		
		return returnmapList;
	}
	
	
	
}
