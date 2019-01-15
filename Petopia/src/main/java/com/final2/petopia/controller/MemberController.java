package com.final2.petopia.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.final2.petopia.common.AES256;
import com.final2.petopia.common.FileManager;
import com.final2.petopia.common.SHA256;
import com.final2.petopia.model.MemberVO;
import com.final2.petopia.service.InterMemberService;

@Controller
public class MemberController {
	
	@Autowired
	private InterMemberService service;
	
	@Autowired
	private AES256 aes;
	
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value="/join.pet", method={RequestMethod.GET})
	public String join() {
		
		return "join/join.tiles1";
	} // end of public String join()
	
	@RequestMapping(value="/joinMember.pet", method={RequestMethod.GET})
	public String joinMember(HttpServletRequest req) {
		
		List<HashMap<String, String>> tagList = service.selectRecommendTagList();
		
		req.setAttribute("tagList", tagList);
		
		return "join/joinMember.tiles1";
	} // end of public String join()
	
	@RequestMapping(value="/joinMemberInsert.pet", method={RequestMethod.POST})
	public String joinMemberInsert(MultipartHttpServletRequest req, MemberVO mvo) {
		
		MultipartFile attach = mvo.getAttach();
		
		if(!attach.isEmpty()) {
			HttpSession session = req.getSession();
			String root = session.getServletContext().getRealPath("/");
			String path = root+"resources"+File.separator+"profiles";
			
			System.out.println(">>> 확인용 path => "+path);
			
			String newFileName = "";
			
			byte[] bytes = null; // 첨부파일을 WAS(톰캣)에 저장할때 사용되는 용도
			long fileSize = 0; // 파일크기를 읽어오기 위한 용도
			
			try {
				bytes = attach.getBytes(); // 첨부된 파일을 바이트 단위로 파일을 다 읽어오는 것
				
				newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path);
				// 첨부된 파일을 WAS(톰캣)의 디스크로 파일올리기를 하는 것
				
				System.out.println(">>> 확인용 newFileName ==> "+newFileName);
				
				mvo.setFileName(newFileName);
				mvo.setProfileimg(attach.getOriginalFilename());
				
			} catch (Exception e) {
				e.printStackTrace();
			} // end of try~catch
		} // end of if --> 첨부파일
		
		String[] tagNoArr = req.getParameterValues("tagNo");
		String[] tagNameArr = req.getParameterValues("tagName");
		
		/*System.out.println("userid : "+mvo.getUserid()+", pwd : "+mvo.getPwd()+", name : "+mvo.getName());
		System.out.println("nicname : "+mvo.getNickname()+", birthday : "+mvo.getBirthday()+", gender : "+mvo.getGender());
		System.out.println("phone : "+mvo.getPhone()+", newFileName : "+mvo.getFileName()+", OriginalFilename : "+mvo.getOrgFilename());
		
		for(int i=0; i<tagNoArr.length; i++) {
			
			System.out.println("tagNoArr[i]: "+tagNoArr[i]);
			System.out.println("tagNameArr[i]: "+tagNameArr[i]);
			
		} // end of for */
		
		try {
			// member pwd, phone 암호화
			mvo.setPwd(SHA256.encrypt(mvo.getPwd()));
			mvo.setPhone(aes.encrypt(mvo.getPhone()));
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} // end of try-catch
		
		int result = 0;
		if(tagNoArr != null && tagNameArr != null) {
			// 태그가 있는 경우 회원가입
			result = service.insertMemberByMvoTagList(mvo, tagNoArr, tagNameArr);
		} else {
			// 태그가 없는 경우 회원가입
			result = service.insertMemberByMvo(mvo);
		} // end of if~else
		
		String msg = "";
		String loc = "";
		if(result == 1) {
			msg = "회원가입 성공!";
			loc = req.getContextPath()+"/index.pet";
		} else {
			msg = "회원가입 실패!";
			loc = "javascript:histroy.back();";
		} // end of if
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		return "msg";
	} // end of joinMemberInsert()
	
	// *** 아이디 중복 체크 *** //
	@RequestMapping(value="/idDuplicateCheck.pet", method={RequestMethod.GET})
	@ResponseBody
	public HashMap<String, String> idDuplicateCheck(HttpServletRequest req) {
		
		HashMap<String, String> idDuplicateMap = new HashMap<String, String>();
		
		String userid = req.getParameter("userid");
		System.out.println("userid: "+userid);
		
		int cnt = service.selectMemberIdIsUsed(userid);
		
		String msg = "";
		if(cnt == 0) {
			msg = "<span style='color: blue;'>사용가능한 아이디입니다.</span>";
		} else {
			msg = "<span  style='color: red;'>이미 사용중인 아이디입니다.</span>";
		} // end of if~else
		
		idDuplicateMap.put("CNT", String.valueOf(cnt));
		idDuplicateMap.put("MSG", msg);
		System.out.println("msg: "+idDuplicateMap.get("MSG"));
		
		return idDuplicateMap;
	} // end of public HashMap<String, String> idDuplicateCheck(HttpServletRequest req)
	
	// *** 로그인 *** //
	@RequestMapping(value="/login.pet", method={RequestMethod.GET})
	public String login() {
		
		return "join/login.tiles1";
	} // end of login
	
	@RequestMapping(value="/loginSelect.pet", method={RequestMethod.POST})
	public String loginSelect(HttpServletRequest req, HttpServletResponse res) {
		
		String userid = req.getParameter("userid");
		String pwd = req.getParameter("pwd");
		String saveUserid = req.getParameter("saveUserid");
		
		pwd = SHA256.encrypt(pwd);
		
		HashMap<String, String> loginMap = new HashMap<String, String>();
		loginMap.put("USERID", userid);
		loginMap.put("PWD", pwd);
		
		MemberVO loginuser = service.loginSelectByUseridPwd(loginMap);
		
		String msg = "";
		String loc = "";
		if(loginuser == null) {
			// 아이디나 비번이 틀린 경우
			msg = "아이디 또는 비밀번호가 틀립니다.";
			loc = "javascript:history.back();";
		} else if(loginuser != null && loginuser.isIdleStatus() == true) {
			msg = "로그인 한 지 1년이 지나서 휴면계정이 되었습니다. 관리자에게 문의 바랍니다.";
			loc = "javascript:history.back();";
		} else {
			HttpSession session = req.getSession();
			session.setAttribute("loginuser", loginuser);
			
			// 쿠키에 아이디 저장
			Cookie cookie = new Cookie("saveUserid", loginuser.getUserid());
			if(saveUserid != null) {
				cookie.setMaxAge(7*24*60*60);
			} else {
				cookie.setMaxAge(0);
			} 
			
			cookie.setPath("/");
			
			res.addCookie(cookie);
			
			msg = "로그인 성공!";
			if(session.getAttribute("goBackURL") != null) {
				loc = (String)session.getAttribute("goBackURL");
				
				session.removeAttribute("goBackURL");
			} else {
				loc = req.getContextPath()+"/index.pet";
			}// end of if~else
		} // end of if~else
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		return "msg";
	} // end of public String loginSelect()
	
	@RequestMapping(value="/logout.pet", method={RequestMethod.GET})
	public String logout(HttpServletRequest req, HttpSession session) {
		session.invalidate();
		
		req.setAttribute("msg", "로그아웃되었습니다.");
		req.setAttribute("loc", req.getContextPath()+"/index.pet");
		
		return "msg";
	} // end of 
	
	@RequestMapping(value="/infoMember.pet", method={RequestMethod.GET})
	public String requireLogin_infoMember(HttpServletRequest req, HttpServletResponse res) {
		
		List<HashMap<String, String>> tagList = service.selectRecommendTagList();
		
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		// 로그인 한 사용자의 정보 가져오기
		MemberVO mvo = service.selectMemberByUserid(loginuser.getUserid());
		try {
			mvo.setPhone(aes.decrypt(mvo.getPhone()));
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} // end of try~catch
		
		/*System.out.println("userid : "+mvo.getUserid()+", pwd : "+mvo.getPwd()+", name : "+mvo.getName());
		System.out.println("nicname : "+mvo.getNickname()+", birthday : "+mvo.getBirthday()+", gender : "+mvo.getGender());
		System.out.println("phone : "+mvo.getPhone()+", newFileName : "+mvo.getFileName()+", OriginalFilename : "+mvo.getProfileimg());*/
		
		// 저장된 사용자 태그 조회
		List<HashMap<String, String>> haveTagList = service.selectHave_tagByIdx(loginuser.getIdx());
		
		/*for(HashMap<String, String> haveTagMap : haveTagList) {
			
			System.out.println("FK_TAG_UID: "+haveTagMap.get("FK_TAG_UID"));
			System.out.println("FK_TAG_NAME: "+haveTagMap.get("FK_TAG_NAME"));
			 
		} // end of for	*/	
		
		req.setAttribute("tagList", tagList);
		req.setAttribute("mvo", mvo);
		req.setAttribute("haveTagList", haveTagList);
		
		return "member/infoMember.tiles2";
	} // end of requireLogin_infoMember
	
	@RequestMapping(value="/updateMember.pet", method={RequestMethod.POST})
	public String updateMember(MultipartHttpServletRequest req, MemberVO mvo) {
		
		MultipartFile attach = mvo.getAttach();
		
		if(!attach.isEmpty()) {
			String beforeFile = req.getParameter("beforeFile");
			
			HttpSession session = req.getSession();
			String root = session.getServletContext().getRealPath("/");
			String path = root+"resources"+File.separator+"profiles";
			
			System.out.println(">>> 확인용 path => "+path);
			
			String newFileName = "";
			
			byte[] bytes = null; // 첨부파일을 WAS(톰캣)에 저장할때 사용되는 용도
			long fileSize = 0; // 파일크기를 읽어오기 위한 용도
			
			try {
				fileManager.doFileDelete(beforeFile, path);
				
				bytes = attach.getBytes(); // 첨부된 파일을 바이트 단위로 파일을 다 읽어오는 것
				
				newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path);
				// 첨부된 파일을 WAS(톰캣)의 디스크로 파일올리기를 하는 것
				
				System.out.println(">>> 확인용 newFileName ==> "+newFileName);
				
				mvo.setFileName(newFileName);
				mvo.setProfileimg(attach.getOriginalFilename());
				
			} catch (Exception e) {
				e.printStackTrace();
			} // end of try~catch
		} // end of if --> 첨부파일
		
		String[] tagNoArr = req.getParameterValues("tagNo");
		String[] tagNameArr = req.getParameterValues("tagName");
		
		System.out.println("userid : "+mvo.getUserid()+", pwd : "+mvo.getPwd()+", name : "+mvo.getName());
		System.out.println("nicname : "+mvo.getNickname()+", birthday : "+mvo.getBirthday()+", gender : "+mvo.getGender());
		System.out.println("phone : "+mvo.getPhone()+", newFileName : "+mvo.getFileName()+", OriginalFilename : "+mvo.getProfileimg());
		
		for(int i=0; i<tagNoArr.length; i++) {
			
			System.out.println("tagNoArr[i]: "+tagNoArr[i]);
			System.out.println("tagNameArr[i]: "+tagNameArr[i]);
			
		} // end of for
		
		try {
			// member pwd, phone 암호화
			mvo.setPwd(SHA256.encrypt(mvo.getPwd()));
			mvo.setPhone(aes.encrypt(mvo.getPhone()));
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} // end of try-catch
		
		int result = 0;
		if(tagNoArr != null && tagNameArr != null) {
			// 태그가 있는 경우 회원수정
			result = service.updateMemberByMvoTagList(mvo, tagNoArr, tagNameArr);
		} else {
			// 태그가 없는 경우 회원수정
			result = service.updateMemberByMvo(mvo);
		} // end of if~else
		
		String msg = "";
		String loc = "";
		if(result == 1) {
			msg = "회원수정 성공!";
			loc = req.getContextPath()+"/infoMember.pet";
		} else {
			msg = "회원가입 실패!";
			loc = "javascript:histroy.back();";
		} // end of if
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		return "msg";
	} // end of editMember()

	@RequestMapping(value="/adminListMember.pet", method={RequestMethod.GET})
	public String adminListMember() {
		
		return "admin/member/listMember.tiles2";
	} // end of infoMember
	
	@RequestMapping(value="/adminInfoMember.pet", method={RequestMethod.GET})
	public String adminInfoMember(HttpServletRequest req) {
		
		List<HashMap<String, String>> tagList = service.selectRecommendTagList();
		
		req.setAttribute("tagList", tagList);
		
		return "admin/member/adminInfoMember.tiles2";
	} // end of public String adminInfoMember()
	
}