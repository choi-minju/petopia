<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">

	.subjectstyle { color: #fc766b;
    	            cursor: pointer; }
	
	a{text-decoration: none;}
	
	.content {
	   padding-top: 5px;
	   padding-bottom: 5px;
	   background-color: #eee;
	   border: 0px solid #999;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$(".subject").bind("mouseover", function(event){
			 var $target = $(event.target);
			 $target.addClass("subjectstyle");
		});
		  
		$(".subject").bind("mouseout", function(event){
			 var $target = $(event.target);
			 $target.removeClass("subjectstyle");
		});
		
		/* 뷰단에서 검색시 검색어 그대로 있도록 */
		searchKeep();
		
		$("#search").keydown(function(event){
			if(event.keyCode == 13) {
				goSearch();
			}
		});
		
	}); // end of $(document).ready()----------------------
	
	
	// 뷰단에서 검색시 검색어 그대로 있도록
	function searchKeep(){
		if(${search!=null && search!="" && search!="null"}) {
			$("#colname").val("${colname}");
			$("#search").val("${search}");
		}
	}
	
	// 글목록에서 제목, 작성자, 글내용으로 검색 
	function goSearch() {
		var frm = document.searchFrm;
		frm.action = "<%=request.getContextPath()%>/consultList.action";
		frm.method = "GET";
		frm.submit();
	}
	
	// 글제목 클릭시 글 상세보기
	function goDetail(consult_UID, goBackURL) {
		var frm = document.goDetailFrm;
		frm.consult_UID.value = consult_UID;
		frm.gobackURL.value = goBackURL;
		frm.action = "consultDetail.pet";
		frm.method = "GET";
		frm.submit();
	}
	
</script>


<div style="padding: 5% 10% 0% 10%;  margin-bottom: 0.2%; border: solid 0px red;" class="container">
	<h3  style="border:0.5px solid #fc766b; border-radius:3px; padding:1%;">&nbsp;&nbsp;&nbsp;1:1상담내역</h3>
	<div align="center">
		
		
		<div class="row">
			<div class="col-xs-12 col-md-4" style="background-color: #ffffff;"></div>
			<div class="col-xs-12 col-md-8" style="background-color: #ffffff;">
				 
				<form name="searchFrm" >
				<select name="colname" id="colname" class="content" style="height:4%; width:23%; margin-left:20%;">
					<option value="cs_title">제목</option>
					<option value="nickname">작성자</option>
					<option value="cs_contents">글내용</option>
				</select>
				
				<input type="text" name="search" id="search" size="30" style="border: 1px solid #999; border-radius: 25px;" />
				<button type="button" style="background-color:#fc766b; border: 1px solid #fc766b; border-radius:50px; width:10%; height:4%; color:#ffffff; padding-right:10px; font-size:12px;" onClick="goSearch();">
					<img src="<%=request.getContextPath() %>/resources/img/consultIcon/search-01-01.png" style="width:38%; padding-right:1px;">검색
				</button> 
				</form>
				
			</div>
		</div>
		
		<div class="row">
			<div class="col-xs-1 col-md-1 content">글번호</div>
			<div class="col-xs-5 col-md-5 content">글제목</div>	
			<div class="col-xs-2 col-md-2 content">작성자</div>
			<div class="col-xs-3 col-md-3 content">작성날짜</div>
			<div class="col-xs-1 col-md-1 content">조회수</div>
		</div>
		
		<!-- 로그인한 사람만 보이도록 -->
		<c:forEach var="consultvo" items="${consultList}">
			<div class="row" style="border-bottom: 1px solid #bebebe;">
				<div class="col-xs-1 col-md-1 content"  style="background-color: #ffffff;">${consultvo.consult_UID}</div>
				<div class="col-xs-5 col-md-5 subject content" align="left"  style="background-color: #ffffff;"  onClick="goDetail('${consultvo.consult_UID}', '${goBackURL}');">${consultvo.cs_title}
				<span style="font-size:90%; color:#b2b3b2;">&nbsp;[댓글${consultvo.commentCount}]</span></div>	
				<div class="col-xs-2 col-md-2 content"  style="background-color: #ffffff;">${consultvo.nickname}</div>
				<div class="col-xs-3 col-md-3 content"  style="background-color: #ffffff;">${consultvo.cs_writeday}</div>
				<div class="col-xs-1 col-md-1 content"  style="background-color: #ffffff;">${consultvo.cs_hit}</div>
			</div>
		
		<%-- 
		<c:if test="${consultvo.cs_secret==1}"> <!-- ( (공개글 && (비공개글 && (아이디가 로그인한 유저랑 같을 경우||댓글을 단 수의사일 경우)) ) 
			<div class="row" style="border-bottom: 1px solid #bebebe;">
				<div class="col-xs-1 col-md-1 content"  style="background-color: #ffffff;">${consultvo.consult_UID}</div>
				<div class="col-xs-5 col-md-5 subject content" align="left"  style="background-color: #ffffff;"  onClick="goDetail('${consultvo.consult_UID}', '${goBackURL}');">${consultvo.cs_title}</div>	
				<div class="col-xs-2 col-md-2 content"  style="background-color: #ffffff;">${consultvo.nickname}</div>
				<div class="col-xs-3 col-md-3 content"  style="background-color: #ffffff;">${consultvo.cs_writeday}</div>
				<div class="col-xs-1 col-md-1 content"  style="background-color: #ffffff;">${consultvo.cs_hit}</div>
			</div>
		</c:if>
		<c:if test="${consultvo.cs_secret==0}"> <!--  (비공개글 && 아이디가 로그인한 유저랑 다를 경우)
			<div class="row" style="border-bottom: 1px solid #bebebe;">
				<div class="col-xs-1 col-md-1 content"  style="background-color: #ffffff;">${consultvo.consult_UID}</div>
				<div class="col-xs-5 col-md-5 subject content" align="left" style="background-color: #ffffff; font-size:80%; color:#b2b3b2; padding-top:0.7%;">비공개글입니다. 작성자만 읽을 수 있습니다.</div>	
				<div class="col-xs-2 col-md-2 content"  style="background-color: #ffffff;">${consultvo.nickname}</div>
				<div class="col-xs-3 col-md-3 content"  style="background-color: #ffffff;">${consultvo.cs_writeday}</div>
				<div class="col-xs-1 col-md-1 content"  style="background-color: #ffffff;">${consultvo.cs_hit}</div>
			</div>
		</c:if>
		--%>
		</c:forEach>
		
		
		<div align="center" style="width:55%; margin-top:50px;" > 
			${pagebar}
		</div>
		<br/>
		
		
		<div class="col-xs-12 col-md-12" style="background-color: #ffffff;">
			<div class="col-xs-10 col-md-9" style="background-color: #ffffff;"></div>
			<div class="col-xs-2 col-md-3" style="background-color: #ffffff;">
				<button type="button" id="btnWrite" style="margin-left:35%; background-color: #ffffff; border: 1px solid #fc766b; border-radius:50px; width:80%; height:5%; color:#fc766b;"
				onClick="javascript:location.href='consultAdd.pet'">글쓰기</button>
			</div>
		</div>
		
	</div> <!-- table -->
	
</div> <!-- 전체 -->


<br/>


<!-- 글 상세보기 폼 -->
<form name="goDetailFrm" >
	<input type="hidden" name="consult_UID" />
	<input type="hidden" name="gobackURL" />
</form>

<!-- 끝 -->
