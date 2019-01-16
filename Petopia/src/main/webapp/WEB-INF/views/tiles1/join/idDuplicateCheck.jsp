<%--
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중복 ID 검사하기</title>

<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/style.css">
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-3.3.1.min.js"></script>

<script type="text/javascript">

	$(document).ready(function() {
		
		$("#error").hide();
		
		$("#userid").keydown(function(event){
		//	console.log(event.keyCode);
		    if(event.keyCode == 13) {
		    	// 엔터를 했을 경우
		    	goCheck();
		    }
		});
		
	});// end of $(document).ready()--------------
	

	function goCheck() {
		
		var userid = $("#userid").val().trim();
		
		if(userid == "") {
			$("#error").show();
			
			$("#userid").val("");
			$("#userid").focus();
			return;
		}
		else {
			$("#error").hide();
			
			var frm = document.frmIdcheck;
			frm.method = "post";
			frm.action = "idDuplicateCheck.do";
			frm.submit();
		}
	}// end of goCheck()---------------
	
	
	// **** 팝업창에서 부모창으로 값 넘기기 일반적인 방법 ****//
	/* 	function setUserID(userid) {
			var openerfrm = opener.document.registerFrm;
			// opener는 팝업창을 열게한 부모창을 말한다.
			// 여기서 부모창은 memberform.jsp 페이지이다.
			
			openerfrm.userid.value = userid;
			openerfrm.pwd.focus();
			
			self.close();
			// 여기서 self 는 팝업창 자기자신을 말한다.
			// 지금의 self 는 idcheck.jsp 페이지 이다.
		}// end of setUserID(userid)--------------------- 
	*/
		
		
	// **** 팝업창에서 부모창으로 값 넘기기 jQuery를 사용한 방법 ****//
	function setUserID(userid) {
	//  $("#userid", opener.document).val(userid);
	//  또는	
	    $(opener.document).find("#userid").val(userid);
	
	//	$("#pwd", opener.document).focus();
	//  또는
	    $(opener.document).find("#pwd").focus();
		
		self.close();
		// 여기서 self 는 팝업창 자기자신을 말한다.
		// 지금의 self 는 idcheck.jsp 페이지 이다.
		
	}// end of setUserID(userid)-----------------

</script>

</head>
<body style="background-color: #fff0f5;">

<c:if test="${method == 'GET'}">
<form name="frmIdcheck">
	<table style="width: 95%; height: 90%;">
		<tr>
			<td style="text-align: center;">
				아이디를 입력하세요<br style="line-height: 200%;"/>
				<input type="text" id="userid" name="userid" size="20" class="box" /><br style="line-height: 300%;"/> 
				<span id="error" style="color: red; font-size: 12pt; font-weight: bold;">아이디를 입력하세요!!</span><br/><br/>   
				<button type="button" class="box" onClick="goCheck();">확인</button>
			</td>
		</tr>
	</table>
</form>
</c:if>

<c:if test="${method == 'POST'}">

	<c:if test="${isUseuserid == true}">
		<br style="line-height: 200%"/>
		<br style="line-height: 200%"/>   
		<div align="center">
			ID로 [<span style="color:red; font-weight: bold;">${userid}</span>]를 사용할 수 있습니다.
			<br/><br/><br/>
			<button type="button" onClick="setUserID('${userid}');">닫기</button>
		</div>
	</c:if>
	
	<c:if test="${isUseuserid == false}">
			<br style="line-height: 200%"/>   
			<div align="center">
				<span style="color:red; font-weight: bold;">[${userid}]는 이미 사용중입니다.</span>
			<br/>
			
			<form name="frmIdcheck" action="idDuplicateCheck.do" method="post">
	          <table style="width: 95%; height: 90%;">
				<tr>
					<td style="text-align: center;">
						아이디를 입력하세요<br style="line-height: 200%;"/>
						<input type="text" id="userid" name="userid" size="20" class="box" /><br style="line-height: 300%;"/>
						<span id="error" style="color: red; font-size: 12pt; font-weight: bold;">아이디를 입력하세요!!</span><br/><br/>    
						<button type="button" class="box" onClick="goCheck();">확인</button>
					</td>
				</tr>
			</table>
            </form>
			</div>
	</c:if>

</c:if>

</body>
</html>
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    ${cnt}
