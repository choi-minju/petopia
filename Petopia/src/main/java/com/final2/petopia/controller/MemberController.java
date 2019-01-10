package com.final2.petopia.controller;

import java.io.File;
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

import com.final2.petopia.model.MemberVO;
import com.final2.petopia.service.InterMemberService;

@Controller
public class MemberController {
	
	@Autowired
	private InterMemberService service;
	
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
		
		MultipartFile profileimg = mvo.getProfileimg();
		
		if(!profileimg.isEmpty()) {
			HttpSession session = req.getSession();
			String root = session.getServletContext().getRealPath("/");
			String path = root+"resources"+File.separator+"profiles";
			
			System.out.println(">>> 확인용 path => "+path);
			
			String newFileName = "";
			
			byte[] bytes = null; // 첨부파일을 WAS(톰캣)에 저장할때 사용되는 용도
			long fileSize = 0; // 파일크기를 읽어오기 위한 용도
			
			try {
				bytes = profileimg.getBytes(); // 첨부된 파일을 바이트 단위로 파일을 다 읽어오는 것
				
				newFileName = fileManager.doFileUpload(bytes, profileimg.getOriginalFilename(), path);
				// 첨부된 파일을 WAS(톰캣)의 디스크로 파일올리기를 하는 것
				
				System.out.println(">>> 확인용 newFileName ==> "+newFileName);
				
				mvo.setFileName(newFileName);
				mvo.setOrgFilename(profileimg.getOriginalFilename());
				
			} catch (Exception e) {
				e.printStackTrace();
			} // end of try~catch
		} // end of if --> 첨부파일
		
		System.out.println("userid : "+mvo.getUserid()+", pwd : "+mvo.getPwd()+", name : "+mvo.getName());
		System.out.println("nicname : "+mvo.getNickname()+", birthday : "+mvo.getBirthday()+", gender : "+mvo.getGender());
		System.out.println("phone : "+mvo.getPhone());
		
		return "join/joinMember.tiles1";
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