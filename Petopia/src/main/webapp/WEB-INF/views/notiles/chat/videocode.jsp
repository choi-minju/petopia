<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.InetAddress" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%
	String ctxPath = request.getContextPath();

	InetAddress inet = InetAddress.getLocalHost();
	String serverIP = inet.getHostAddress();
	int portnumber = request.getServerPort();
	
	String serverName = "http://"+serverIP+":"+portnumber;
%>    

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="mobile-web-app-capable" content="yes">
<meta id="theme-color" name="theme-color" content="#1e1e1e">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		
		var n = "${n}";
		
		$("#code").keydown(function(event){
			
			if(event.keyCode == 13) {
				join();
			}
		});
		
		$("#join-button").click(function(){
			join();
		});
		
	}); // end of document.ready
		
	function join() {
		
		var chatcode = $('input#code').val();
		/* var confirmcode = $("#div_code").find("input[id=hide]").val(); */
		var confirmcode = $('input#hide').val();
		if(chatcode == confirmcode) {
			var frm = document.videochatFrm;
			parent.location.href="<%= serverName %><%= ctxPath %>/videochat.pet";
			frm.submit();
		}
		else{
			alert("번호가 일치하지 않습니다 다시입력해주세요");
		}
	}

</script>

<body style="background-color: rgb(252, 118, 106);">
<form name="videochatFrm" style="background-color: rgb(252, 118, 106);">
	<div id="div_code" align="center">
		<span style="color: white; font-size: 12pt;">상담을 위한 코드를 입력해주세요</span><br/>
		<input type="text" name="code" id="code" size="15" placeholder="123456" required />
		<input type="hidden" name="hide" id="hide" value="${chatcode}" />
		<c:if test="${n == 0}">
			<span style="color: red;">번호가 맞지않습니다 다시 시도해주세요.</span>
		</c:if>
	</div>
	</br>
	<div id="div_input" align="center">
		<button id="join-button" type="button" class="btn btn-default myclose" data-dismiss="modal">확인</button>
	</div>
</form>
</body>