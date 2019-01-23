<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath = request.getContextPath();
%>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>

<script type="text/javascript">
	

</script>

<div class="header">
<nav class="navbar navbar-default navbar-fixed-top">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span> 
      </button>
      <a class="navbar-brand logo" href="<%= ctxPath %>/home.pet" style="font-size: 18px; font-weight: bold;">PETOPIA</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
      	<c:if test="${sessionScope.loginuser == null }">
        <li><a href="<%= ctxPath %>/join.pet">회원가입</a></li>
        <li><a href="<%= ctxPath %>/login.pet" >로그인</a></li>
        </c:if>
        <c:if test="${sessionScope.loginuser != null }">
        <li><a href="<%= ctxPath %>/logout.pet">로그아웃</a></li>
        <li class="dropdown">
           <a class="dropdown-toggle" data-toggle="dropdown">마이페이지
           <span class="caret"></span></a>
           <ul class="dropdown-menu">
             <li><a href="<%= ctxPath %>/careIndex.pet">반려동물수첩</a></li>
			<li><a href="<%= ctxPath %>/infoMember.pet">나의정보보기</a></li>
			<li><a href="<%= ctxPath %>/myReviewList.pet">나의병원리뷰</a></li>
			<li><a href="<%= ctxPath %>/InsertMyPrescription.pet">나의진료관리</a></li>
           </ul>
        </li>
        </c:if>
      </ul>
    </div>
  </div>
</nav>
</div>



</body>
</html>