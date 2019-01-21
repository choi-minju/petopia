<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%String ctxPath = request.getContextPath();%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<style>

.divbox1{ /*전체 */
   margin-top: 3%;
   width:75%;
   background-color: #eaebed; 
   border: 0px solid gray;
   border-radius:10px;
   margin-bottom: 1%;
}

.divbox2{ /* 이미지 */
margin-top:3%;
}

.divbox3{ /* 펫정보*/
border: 1px solid gray; 
witdh:80%; 
height:20%; 
margin-top:3%;
padding-left:1%;
background-color:white;
padding-bottom:3%;
border-radius:10px;
}

.divbox4{ /* 캘린더 자리 */
 margin-top:3%;
 margin-bottom:5%;
 border: 1px solid gray;
 witdh:80%; 
 
 margin-top:3%;
 padding:3% 3% 3% 3%;
 border-radius:10px;
 background-color:white;
}

.divbox5{ /* 마지막 탭  */
background-color:white;
border: 1px solid gray;
border-top-style:none;
margin-top:5%;

padding-top:1%;
border-radius:10px; 
margin-bottom: 1%;
width:100%;

}
.btn2{
background-color:rgb(252, 118, 106);
color:white;
width:20%;
height:5%;
border-radius:15px;
margin-left: 38%;
margin-top: 1%;
margin-bottom: 2%;
}
.h3_1 {
margin-left: 1%;
margin-top:2%;
color:rgb(252, 118, 106);
}

.span{
	 
  } 

  body {
    margin: 0;
    padding: 0;
    font-size: 14px;
  }

  #top,
  #calendar.fc-unthemed {
    font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
  }

  #top {
    background: #eee;
    border-bottom: 1px solid #ddd;
    padding: 0 10px;
    line-height: 40px;
    font-size: 12px;
    color: #000;
  }

  #top .selector {
    display: inline-block;
    margin-right: 10px;
  }

  #top select {
    font: inherit;  /* mock what Boostrap does, don't compete  */
  }

  .left { float: left }
  .right { float: right }
  .clear { clear: both }

  #calendar {
    max-width: 100%;
    
    margin: 40px auto;
    padding: 2% 2% 2% 2%;
  }
  
 
</style>

<script type="text/javascript">
    
	$(document).ready(function(){
		//ajaxData();
		
		$('#calendar').fullCalendar({
			  defaultView: 'month'
			});
		
		$('#calendar').fullCalendar({
			  schedulerLicenseKey: 'GPL-My-Project-Is-Open-Source'
			});
		
		 $("#register").click(function(){
			 
			var frm=document.registerFrm;
			frm.addaction = "<%=ctxPath%>/InsertMyChartEnd.pet";
			frm.method="POST";
			frm.submit();
		 });
	});// end of $(document).ready()----------------------
	



</script>
<div class="container divbox1">
   <h3 class="h3_1">진료기록 입력하기</h3>
   <div class="divbox2">
    <a heref=""><img src="<%=ctxPath%>/resources/img/chart/${pvo.pet_profileimg}"  width="10%" height="13%" style="border-radius: 50%;"> </a>
     <a heref=""><img src="<%=ctxPath%>/resources/img/chart/cat1.jpg"  width="10%" height="13%" style="border-radius: 50%;"> </a>
     <a heref=""><img src="<%=ctxPath%>/resources/img/chart/cat1.jpg"  width="10%" height="13%" style="border-radius: 50%;"> </a>
   </div>
  
  <div class="divbox3">
	  <p style="padding-top:1%;">생년월일: ${pvo.pet_birthday}</p>
	  <p>성별:   ${pvo.pet_gender}</p>
	  <p>몸무게: ${pvo.pet_weight} kg</p>
  </div>
  
  <div id="calendar"  class="calendar divbox4">
	 
  </div>
  
 
<div class="tab-content divbox5 container">
   <div class="container" Style="width:100%;">
	    <ul class="nav nav-tabs">
		    <li class="active"><a data-toggle="tab" href="#home">Home</a></li>
		    <li><a data-toggle="tab" href="#menu1">Menu 1</a></li>
		    <li><a data-toggle="tab" href="#menu2">Menu 2</a></li>
		    <li><a data-toggle="tab" href="#menu3">Menu 3</a></li>
	    </ul>
    </div>
    <form name="registerFrm">
    <div id="home" class="tab-pane fade in active" style="padding-left:2%;">
      
       <h3>${nickname}</h3>
       <p>진료예약일자:${rvo.bookingdate}  </p>
       <p>방문일자: ${rvo.reservation_DATE}</p>
       <hr Style="width:100%; height:2%;"></hr>
       <div class="span col-md-10"><h3 style="font-weight:bold;color:pink; margin-top:0">진료결과 </h3></div>
       <div class="span col-md-10"><p>담당수의사: </p><input type="text" name="docname" style="margin-bottom: 1%;"/></div>
       <div class="span col-md-10"><p>병  명:   </p><input type="text" name="dname" style="margin-bottom: 1%;"/></div>
       <div class="span col-md-10"><p>처방약: </p><input type="text" name="mname" style="margin-bottom: 1%;"/></div>
       <div class="span col-md-10"><p>주의사항: </p><textarea name="caution" style="width:40%;height:20%; margin-bottom: 1%;"></textarea></div>
       <div class="span col-md-10"><p>내  용: </p><textarea name="memo" style="width:40%;height:20%;"></textarea></div>
        <hr style="width:100%; height:2%;"></hr>
        <div style="margin-left: 70%;">
	       <p>예치금: </p>
	       <p>본인 부담금:</p>
	       <p>진료비 총액:</p>
       </div>
      </div>
        </form>
        <button type="button" class="btn2" id="register">등록하기</button>
    </div>
    </div>
  </div>

