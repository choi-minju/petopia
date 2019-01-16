<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%String ctxPath = request.getContextPath();%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<style>
.calendar{
margin-top:3%; 
margin-bottom:2%; 
border: 1px solid gray; 
witdh:500%; 
height:120%; 
margin-top:3%;
padding: 4% 4% 4% 4%;
border-radius:10px;

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
	});// end of $(document).ready()----------------------
	



</script>
<div class="container" style="margin-top: 3%;">
  
   <div style="margin-top:3%;">
    <a heref=""><img src="<%=ctxPath%>/resources/img/chart/cat1.jpg"  width="15%" height="20%" style="border-radius: 50%;"> </a>
     <a heref=""><img src="<%=ctxPath%>/resources/img/chart/cat1.jpg"  width="15%" height="20%" style="border-radius: 50%;"> </a>
     <a heref=""><img src="<%=ctxPath%>/resources/img/chart/cat1.jpg"  width="15%" height="20%" style="border-radius: 50%;"> </a>
   </div>
  
  <div style="border: 1px solid gray; witdh:500%; height:20%; margin-top:3%;padding-left:1%;padding-top:3%;padding-bottom:3%;border-radius:10px;">
	  <p style="padding-top:1%;">생년월일: 2000년도 9월 13일 </p>
	  <p>성별:  여아</p>
	  <p>몸무게: 소형 </p>
  </div>
  
  <div id="calendar"  class="calendar" style="">
	 
  </div>
  
 
<div class="tab-content"style="border: 1px solid gray;border-top-style:none;margin-left:1%;
      padding-top:1%;border-radius:10px; margin-bottom: 1%;">
   <div class="container" Style="width:100%;">
	    <ul class="nav nav-tabs">
		    <li class="active"><a data-toggle="tab" href="#home">Home</a></li>
		    <li><a data-toggle="tab" href="#menu1">Menu 1</a></li>
		    <li><a data-toggle="tab" href="#menu2">Menu 2</a></li>
		    <li><a data-toggle="tab" href="#menu3">Menu 3</a></li>
	    </ul>
</div>
    
    <div id="home" class="tab-pane fade in active" style="padding-left:2%;">
      <h3>동물사랑 병원</h3>
      <p>진료예약일자: 2019년01월5일 </p>
       <p>방문일자: 2019년01월8일 </p>
       <hr Style="width:100%; height:2%;"></hr>
       <h3 style="font-weight:bold;color:pink;">검사결과 </h3>
       <p>담당수의사 </p>
       <p>처방안내</p>
       <p>처방약</p>
       <p>주의사항</p>
       <p>내용</p>
        <hr style="width:100%; height:2%;"></hr>
        <div style="margin-left: 70%;">
	       <p>예치금: </p>
	       <p>본인 부담금:</p>
	       <p>진료비 총액:</p>
       </div>
    </div>
    
  </div>
</div>
