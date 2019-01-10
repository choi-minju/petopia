<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ page import="java.net.InetAddress" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<div>
<div class="header">
  <a href="#default" class="logo">PETOPIA</a>
  <div class="header-right">
    <button type="button" class="btn btn-rounder" id="btnLogin">&nbsp;&nbsp;로그인&nbsp;&nbsp;</button>
  </div>
</div>

<div class="navbar1">
  <div class="dropdown1">
  <div class="row">
    <button type="button" class="btnmenu dropbtn" style="font-size: 16px;">병원/약국찾기
    </button>
    <button type="button" class="btnmenu dropbtn" style="font-size: 16px;">병원예약관리 
    </button>
    <button type="button" class="btnmenu dropbtn" style="font-size: 16px;">상담 
    </button>
    <button type="button" class="btnmenu dropbtn" style="font-size: 16px;">반려동물수첩 
    </button>
    <button type="button" class="btnmenu dropbtn" style="font-size: 16px;">커뮤니티 
    </button>
   </div>
    <div class="dropdown-content"> 
      <div class="row"> 
          <div class="column" id="search">
          </div>
        <div class="column" id="reservation">
          <a href="<%= ctxPath %>/reservation.pet">병원예약</a>
          <a href="<%= ctxPath %>/reservationList.pet">예약내역</a>
          <a href="<%= ctxPath %>/deposit.pet">예치금관리</a>
        </div>
        <div class="column" id="consult">
          <a href="#">1:1 문의상담</a>
          <a href="#">화상진료</a>
        </div>
        <div class="column" id="petCare">
          <a href="#">반려동물관리</a>
          <a href="#">반려동물케어</a>
          <a href="#">진료기록관리</a>
          <a href="#">나의 병원리뷰</a>
        </div>
        <div class="column" id="board">
          <a href="#">공지사항</a>
          <a href="#">이벤트</a>
          <a href="#">자유게시판</a>
        </div>
      </div>
    </div>
   </div>
</div>
</div>
