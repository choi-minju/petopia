<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	input, textarea {border: solid gray 1px;}
	
	
	.long {width: 470px;}
	.short {width: 120px;} 
		
	.moveStyle  {text-decoration: underline;
				 color: #fc766b;
   	             cursor: pointer;
				}
	
	[class*="col-"] {
	   padding-top: 15px;
	   padding-bottom: 15px;
	   background-color: #ffffff;
	   /* background-color: rgba(86, 61, 124, .15); */
	   border: 0px solid #999;
	   /* border: 1px solid rgba(86, 61, 124, .2); */
	   margin: 0%;
	   padding: 0.5%;
	   text-align:left;
	}
	
</style>

<script type="text/javascript">
	
	$(document).ready(function(){
	    
		$(".move").bind("mouseover", function(event){
			 var $target = $(event.target);
			 $target.addClass("moveStyle");
		});
		  
		$(".move").bind("mouseout", function(event){
			 var $target = $(event.target);
			 $target.removeClass("moveStyle");
		});
	
		<%--
		// 댓글이 있을때만 ajax(비동기 자바스크립트)
		if(${consultvo.commentCount > 0}) {
			goCommentList("1"); // 처음에 1페이지를 보여주겠다. : 초기치 설정(최신댓글 순으로 최대5개까지)	
		}
		--%>
	}); // end of ready()-------------------------------------------
	
	
	
	// ===== 댓글쓰기 ======
	function goCommentAdd() {
		var frm = document.commentAddFrm;
		<%--
		var nicknameval = frm.nickname.value.trim();
		
		if(nicknameval=="") {
			alert("먼저 로그인하세요!!");
			return;
		}
		--%>
		
		var cscmt_contentsval = frm.cscmt_contents.value.trim();
		if(cscmt_contentsval=="") {
			alert("내용을 입력하세요.");
			frm.content.value = "";
			frm.content.focus();
			return;
		}
		
		var queryString = $("form[name=commentAddFrm]").serialize(); // form의 name이 addWriteFrm인것
		
		console.log(queryString); // form의 name이 addWriteFrm인것의 name값들
		// fk_userid=leejy&name=%EC%9D%B4%EC%A7%80%EC%98%88&content=hello&parentSeq=3
		
		$.ajax({
    		url:"<%=request.getContextPath()%>/consultCommentAdd.pet",
    		type:"POST",
    		data:queryString,
    		dataType:"JSON",
    		success:function(json){
    			
    			var html = "<div class='col-xs-12 col-md-12'>"
		    			  +"	<div class='col-xs-12 col-md-12'>"
		    			  +"		<span  style='font-weight:bold;'>똑똑이</span> 수의사"
		    			  +"		<span  style='color:#b2b3b2; margin-left:20px; font-size:90%;'>"+json.CSCMT_WRITEDAY+"</span>"
		    			  +"	</div>"
		    			  +"	<div class='col-xs-12 col-md-12'>"+json.CSCMT_CONTENTS+"</div>"
		    			  +"	<hr align='center' width='98%' style='border:0.5px dotted #999;'>"
		    			  +"</div>";

    			// 댓글쓰기 할때 위로 쌓이니까 prepend
    			$("#commentDisplay").prepend(html);
    			frm.content.value = "";
    		},
    		error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
    	});
		
	}

	
</script>

<div style="padding: 5% 10% 0% 10%;  margin-bottom: 0.2%;" class="container"> 
	<h3 style="border:0.5px solid #fc766b; border-radius:3px; padding:1%;">&nbsp;&nbsp;&nbsp;1:1상담 상세보기</h3>
	
	<%--<hr align="left" width="100%" style="border:1px solid #999;"> --%>
	<div align="center">
		
		<div class="col-xs-12 col-md-12" style="padding:1.5% 0% 1.5% 3%; text-align: center;">
			<img src="<%=request.getContextPath() %>/resources/img/consultIcon/cat.jpg" class="col-xs-1 col-md-1" style="border-radius:100%;border:0px solid #999;width:4%;height:5.5%;padding:0px;" />
			<span class="col-xs-9 col-md-9" style="padding-left:2%; padding-top:0.8%; font-size:100%;">${consultvo.name}님 ${consultvo.cs_writeday}</span>
			<span class="col-xs-2 col-md-2" style="padding-top:0.8%; font-size:110%; color:#b2b3b2;text-align:right;">
			<c:if test="${consultvo.cs_secret==0}">비공개</c:if>
			<c:if test="${consultvo.cs_secret==1}">공개</c:if></span>
		</div>
		
		<hr align="center" width="94%" style="border:0.5px solid #b2b3b2;">
		
		<div class="col-xs-12 col-md-12">
			<%--
			<div class="col-xs-12 col-md-12">
				<div class="col-xs-3 col-md-2">작성자</div>
				<div style="border: 1px solid #999;" class="col-xs-9 col-md-10"> 이지예 </div>
			</div>
			 --%>
			 
			<div class="col-xs-12 col-md-12">
				<div class="col-xs-1 col-md-1" >글제목</div>
				<div style="border: 0px solid #999; font-size:130%;" class="col-xs-9 col-md-9">${consultvo.cs_title}</div>
				<div class="col-xs-2 col-md-2">
					<button type="button" onClick="javascript:location.href='<%=request.getContextPath()%>/consultEdit.pet?consult_UID=${consultvo.consult_UID}'" 
						style="background-color: #fc766b; border: 1px solid #fc766b; border-radius:50px; width:48%; height:4%; color:#ffffff; font-size:12px;">글수정</button>
					<button type="button" onClick="javascript:location.href='<%=request.getContextPath()%>/consultDelete.pet?consult_UID=${consultvo.consult_UID}'" 
						style="background-color: #fc766b; border: 1px solid #fc766b; border-radius:50px; width:48%; height:4%; color:#ffffff; font-size:12px;">글삭제</button>
				</div>
			</div>
			
			<%--
			<div class="col-xs-12 col-md-12">
				<div class="col-xs-3 col-md-2">글내용</div>
			</div>
			 --%>
			<div class="col-xs-12 col-md-12">
				<div class="col-xs-12 col-md-12" style="background-color: #F1F1F1; border: 0px solid #999; height:auto; padding:20px; border-radius:5px; " >${consultvo.cs_contents}</div>
			</div>
			
			<div class="col-xs-12 col-md-12">
				<div class="col-xs-1 col-md-1">이전글</div>
				<div class="col-xs-11 col-md-11" >
				<span class="move" onClick="javascript:location.href='consultDetail.pet?consult_UID=${consultvo.previous}'">▲ ${consultvo.previousTitle}</span></div>
			</div>
			<div class="col-xs-12 col-md-12" style="margin-bottom:3%;">
				<div class="col-xs-1 col-md-1">다음글 </div>
				<div class="col-xs-11 col-md-11">
				<span class="move" onClick="javascript:location.href='consultDetail.pet?consult_UID=${consultvo.next}'">▼ ${consultvo.nextTitle}</span></div>
			</div>
		</div>	
		
	</div> 
	
	<hr align="left" width="100%" style="border:0.5px solid #999;">
	
	<!-- ===== #84. 댓글쓰기 폼 추가 ===== -->
	<form name="commentAddFrm">
		<input type="hidden" name="userid" value="${sessionScope.loginuser.userid}" readonly />
		<span class="col-xs-12 col-md-12">
			<span style="font-weight:bold;">작성자</span>
			<input type="text" name="nickname" value="똑똑이" style="margin-left:30px; color:#fc766b; border:0px solid #999;" readonly/>
		</span>
		<span class="col-xs-12 col-md-12" style="margin-right:20px; margin-bottom:3%;">댓글쓰기
			<input type="text" name="cscmt_contents" class="long" style="margin-left:20px; width:80%; border-radius:5px; border:1px solid #999; height:100px;"/>
		    <!-- 댓글에 달리는 원게시물 글번호(즉, 댓글의 부모글 글번호) -->
		    <input type="hidden" name="fk_consult_UID" value="${consultvo.consult_UID}" />
		    <button type="button" style="margin-left:1px; width:10%; border-radius:5px; border:1px solid #999; height:100px;" onClick="goCommentAdd();" >작성</button> 
	    </span>
	</form>
	
	<div id="commentDisplay"></div>
	
</div> <!-- 전체 -->


	
<br/>
	