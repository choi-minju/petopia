package com.final2.petopia.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	
	@RequestMapping(value="/login.pet", method={RequestMethod.GET})
	public String login() {
		
		return "join/login.tiles1";
	} // end of login
	
	@RequestMapping(value="/infoMember.pet", method={RequestMethod.GET})
	public String infoMember(HttpServletRequest req) {
		
		List<HashMap<String, String>> tagList = service.selectRecommendTagList();
		
		req.setAttribute("tagList", tagList);
		
		return "member/infoMember.tiles2";
	} // end of infoMember

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