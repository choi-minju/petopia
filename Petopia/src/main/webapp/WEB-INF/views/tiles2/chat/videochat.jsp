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

<script type="text/javascript" >

    // === !!! WebSocket 통신은 스크립트로 작성하는 것이다. !!! === //
    $(document).ready(function(){
        
        var url = window.location.host;   // 웹브라우저의 주소창의 포트까지 가져옴
    //  alert("url : " + url);
    //  결과값  url: 192.168.50.53:9090
    	    
    	var pathname = window.location.pathname; // '/'부터 오른쪽에 있는 모든 경로
    // 	alert("pathname : " + pathname);
    //  결과값  pathname : /board/chatting/multichat.action
    	 	
    	var appCtx = pathname.substring(0, pathname.lastIndexOf("/"));  // "전체 문자열".lastIndexOf("검사할 문자");   
   	// pathname.lastIndexOf("/") ==> 15
    // 	alert("appCtx : " + appCtx);
    //  결과값  appCtx : /board/chatting
    	 	
    	var root = url+appCtx;
    // 	alert("root : " + root);
    //  결과값   root : 192.168.50.53:9090/board/chatting
   	
    	var chatcode = $('input#hide').val();
    	alert("chatcode : " + chatcode);
    	var wsUrl = "ws://"+root+"/multichatstart.action"/+chatcode; // http가아닌 ws를 사용 //multichatstart.action 은 xml에있음
       	var websocket = new WebSocket(wsUrl);  //  /WEB-INF/web.xml 에 가서 appServlet 의 contextConfigLocation 을 수정한다. 
     // var websocket = new WebSocket("ws://192.168.50.53:9090/board/chatting/multichatstart.action");
        
     // alert(wsUrl);
    	
    	// >>>> === Javascript WebSocket 이벤트 정리 === <<<< 
	    //      onopen    ==>  WebSocket 연결
	    //      onmessage ==>  메시지 수신
	    //      onerror   ==>  전송 에러 발생
	    //      onclose   ==>  WebSocket 연결 해제
    	
    	var messageObj = {}; // 자바스크립트에서 객체 생성함.
    	
	    // === 웹소켓에 최초로 연결이 되었을 경우에 실행되어지는 콜백함수 ===
    	websocket.onopen = function() {
    	//	alert("웹소켓 연결됨!!");
    		$("#chatStatus").text("정보: 웹소켓에 연결이 성공됨!!");
    	
    	/*	
            messageObj = {};  // 초기화
            messageObj.message = "채팅방에 <span style='color: red;'>입장</span>했습니다";
            messageObj.type = "all";
            messageObj.to = "all";
        */    
            // 또는
            messageObj = { message : "채팅방에 <span style='color: red;'>입장</span>했습니다"
        		     	 , type : "all"
        		     	 , to : "all" };  // 자바스크립트에서 객체의 데이터값 초기화
        		     	
            websocket.send(JSON.stringify(messageObj));
                        // JSON.stringify() 는 값을 그 값을 나타내는 JSON 표기법의 문자열(String)로 변환한다
                        /*
	                        JSON.stringify({});                  // '{}'
							JSON.stringify(true);                // 'true'
							JSON.stringify('foo');               // '"foo"'
							JSON.stringify([1, 'false', false]); // '[1,"false",false]'
							JSON.stringify({ x: 5 });            // '{"x":5}'
                        */
        };
    	
    	// === 메시지 수신 콜백함수
        websocket.onmessage = function(evt) {
            $("#chatMessage").append(evt.data);
            $("#chatMessage").append("<br />");
            $("#chatMessage").scrollTop(99999999);
        };
        
        // === 웹소캣 연결 해제 콜백함수
        websocket.onclose = function() {
            // websocket.send("채팅을 종료합니다.");
        }
         
        
        $("#message").keydown(function (key) {
             if (key.keyCode == 13) {
                $("#sendMessage").click();
             }
          });
         
        $("#sendMessage").click(function() {
            if( $("#message").val() != "") {
                
            	// ==== 자바스크립트에서 replace를 replaceAll 처럼 사용하기 ====
	             // 자바스크립트에서 replaceAll 은 없다.
	             // 정규식을 이용하여 대상 문자열에서 모든 부분을 수정해 줄 수 있다.
	             // 수정할 부분의 앞뒤에 슬래시를 하고 뒤에 gi 를 붙이면 replaceAll 과 같은 결과를 볼 수 있다.
               // JSON.stringify() 는 값을 그 값을 나타내는 JSON 표기법의 문자열로 변환한다
               
               var message = $("#message").val();
				message = message.replace(/</gi, "&lt;"); 
            	
                messageObj = {};
                messageObj.message = message;
                
                messageObj.type = "all";
                messageObj.to = "all";
                                 
                websocket.send(JSON.stringify(messageObj));
                
                
                $("#chatMessage").append("<span style='color:red; background:white;margin-top:3px;width:100%;border-radius:5px;padding:5px;display:flex; font-weight:bold;'>[나] ▷ " + message + "</span><br/>");
                $("#chatMessage").scrollTop(99999999);
                 
                $("#message").val("");
            }
        });
    });
</script>

<body>

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
				<i class="fa fa-commenting-o" id="sendMessage" style="font-size: 40px;"></i>
			 </div>
		</div>
	</div>
	
    <div class="box" style="padding-left: 16%;">
        <img src="<%=ctxPath%>/resources/img/chat/computer-screen.png" id="startButton" style="height: 10%; width: 5%;">
        <img src="<%=ctxPath%>/resources/img/chat/phone.png" style="margin-left: 40px; height: 10%; width: 5%;" id="callButton">
        <img src="<%=ctxPath%>/resources/img/chat/phone-call.png" id="hangupButton" style="margin-left: 40px; height: 10%; width: 5%;">
        <button type="button" class="btn2">종료하기</button>
        <input type="hidden" name="hide" id="hide" value="${chatcode}" />
    </div>
	
    <div class="box" style="display: none;">
        <span>SDP Semantics:</span>
        <select id="sdpSemantics">
            <option selected value="">Default</option>
            <option value="unified-plan">Unified Plan</option>
            <option value="plan-b">Plan B</option>
        </select>
    </div>
    
	
</div>

<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>
<script src="<%=ctxPath%>/resources/js/videochat.js" async></script>

</body>

