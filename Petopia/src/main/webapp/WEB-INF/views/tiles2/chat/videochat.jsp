<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String ctxPath = request.getContextPath();
%>    

<head>

    <meta charset="utf-8">
    <meta name="description" content="WebRTC code samples">
    <meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1, maximum-scale=1">
    <meta itemprop="description" content="Client-side WebRTC code samples">
    <meta itemprop="image" content="../../../images/webrtc-icon-192x192.png">
    <meta itemprop="name" content="WebRTC code samples">
    <meta name="mobile-web-app-capable" content="yes">
    <meta id="theme-color" name="theme-color" content="#ffffff">

    <base target="_blank">

    <title>화상 상담</title>

    <link href="//fonts.googleapis.com/css?family=Roboto:300,400,500,700" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="<%=ctxPath%>/resources/css/videochat.css"/>

</head>
<style type="text/css">
	.btn2 {
		  margin-left:57%;
		  background:#ff9577;
		  color:white;
		  border:1px solid white;
		  cursor:pointer;
		  transition:800ms ease all;
		  outline:none;
		  cursor: pointer; 
    }
    .btn2:hover{
		  background:white;
		  color:#ff9577;
	}
</style>

<script type="text/javascript" src="<%=ctxPath%>/resources/js/json2.js"></script>
<!-- JSON.stringify() 는 값을 그 값을 나타내는 JSON 표기법의 문자열로 변환해주는 것인데 이것을 사용하기 위해서는 json2.js 가 필요하다. -->
<script src="http://26.42.136.15:3000/socket.io/socket.io.js"></script>
<script src="https://code.jquery.com/jquery-1.11.1.js"></script>

<script type="text/javascript" >

    // === !!! WebSocket 통신은 스크립트로 작성하는 것이다. !!! === //
    $(document).ready(function(){
    		
    	var socket = io("http://26.42.136.15:3000");
        
        //msg에서 키를 누를떄
        $("#message").keydown(function(key){
            //해당하는 키가 엔터키(13) 일떄
            if(key.keyCode == 13){
                //msg_process를 클릭해준다.
                sendMessage.click();
            }
        });
        
        //msg_process를 클릭할 때
        $("#sendMessage").click(function(){
            //소켓에 send_msg라는 이벤트로 input에 #msg의 벨류를 담고 보내준다.
             socket.emit("send_msg", $('#name').val(), $("#message").val());
            //#msg에 벨류값을 비워준다.
            $("#message").val("");
        });
        
      //소켓 서버로 부터 send_msg를 통해 이벤트를 받을 경우 
        socket.on('send_msg', function(message) {
            //div 태그를 만들어 텍스트를 msg로 지정을 한뒤 #chat_box에 추가를 시켜준다.
            $("<span style='color:red; background:white;margin-top:3px;width:100%;border-radius:5px;padding:5px;display:flex; font-weight:bold;'>[나] ▷ </span><br/>").text(message).appendTo("#chatMessage");
        });

    });
  
</script>

<body>

<form name="videochatFrm">
<div id="container">
    <h1 style="padding-left: 15%; padding-right: 15%;">화상진료</h1>
	<h2 style="margin-top: 4%; padding-left: 13%; padding-right: 15%;">Mine</h2>
    <video id="localVideo" style="width: 500px; height: 500px; margin-left: 200px;" playsinline autoplay></video>
    <div style="display: inline-block;">
    <h2 style="margin-top: 4%; padding-left: 13%; padding-right: 15%; margin-top: 65%;">Doctor</h2>
    <video id="remoteVideo" style="width: 250px; height: 250px; margin-left: 20px;" playsinline autoplay></video>
	</div>
	
	<div id="chatStatus" style="margin-right: 10%; float: right; display: inline-block;">
	<h2>ChatMessage</h2>	
		<div style="background: #e5e5e5; border: 1px solid black; height: 400px;"> 
			<div id="chatMessage" style="position: absolute; overflow: auto; max-width: 280px; max-height: 350px; word-break: break-all;">
			<!-- <table>태그속에는 style="table-layout: fixed" -->
			<!-- word-break는 단어와 상관없이 부분에서 자르고, word-wrap: break-word는 단어에따라 잘라준다. -->
			</div>
			 <div style="margin-top:350px;">
				<input type="text" id="message" size="30" placeholder="메세지 내용" style="border:0; background:whitesmoke;"/>
				<input type="text" style="display: none" id="name" class="name" value="${Name}" /> 
				<i class="fa fa-commenting-o" id="sendMessage" style="font-size: 40px;"></i>
			 </div>
		</div>
	</div>
	<input type="text" id="zzz" value="zzz" style="display:none;"/>
    <div class="box" style="padding-left: 16%;">
        <img src="<%=ctxPath%>/resources/img/chat/computer-screen.png" id="startButton" style="height: 10%; width: 5%;">
        <img src="<%=ctxPath%>/resources/img/chat/phone.png" style="margin-left: 40px; height: 10%; width: 5%;" id="callButton">
        <img src="<%=ctxPath%>/resources/img/chat/phone-call.png" id="hangupButton" style="margin-left: 40px; height: 10%; width: 5%;">
        <button type="button" class="btn2" onClick="javascript:location.href='<%= ctxPath %>/home.pet'">종료하기</button>
    </div>
	
    <div style="display: none" class="box">
        <span>설정 변경</span>
        <select id="sdpSemantics">
            <option selected value="">Default</option>
            <option value="unified-plan">Unified Plan</option>
            <option value="plan-b">Plan B</option>
        </select>
    </div>
    
</div>
</form>
<script src="<%=ctxPath%>/resources/js/videochat.js" async></script>
<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>


</body>