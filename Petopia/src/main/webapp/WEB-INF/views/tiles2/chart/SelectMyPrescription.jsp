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
 height:120%; 
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
height:80%;
}
.btn1{
background-color:rgb(252, 118, 106);
color:white;
width:20%;
height:5%;
border-radius:15px;
margin-top: 1%;
margin-bottom: 2%;
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
    max-height: 50%;
    margin: 40px auto;
    padding: 0 10px;
  }
  
 
</style>

<script type="text/javascript">
    
	<%-- $(document).ready(function(){
		/* 달력 시작  */
		  $('#calendar').fullCalendar({
			  
			 
		      header: {
		        left: 'prev,next today',
		        center: 'title',
		        right: 'month,agendaWeek,agendaDay,listWeek'
		      },
		      defaultDate: '2019-01-12',
		      navLinks: true, 
		      editable: true,
		      eventLimit: true, 
		      events:function(start,end,title) {//json 타입의 배열을 ajax로 가져오기 
		    	  
		    	  var data ={ "bidx":"2"}; //기업회원 채번해오기!!
					$.ajax({
			            url : "<%=ctxPath%>/selectReserveinfo.pet" ,
			            type:"GET",
			            data: data,
			            dataType :"json", 
			            success : function(json) {
			            	var events=[];
			            	$.each(json,function(entryIndex,entry){
			            		event.push({
			            			title:entry.title,
			            			start:entry.start,
			            		    end:entry.end
			            		  });	
			            	}); //end of each
			            }, //end of success
			            error : function(request,status,error) {
			                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: " +error);
			            }
			        }); //end f ajax
		      }
		    }); // end of  $('#calendar').fullCalendar --%>

	/* 달력  끝  */
	});// end of $(document).ready()----------------------
	



</script>
<div class="container divbox1">
  <h3 style="color:rgb(252, 118, 106);margin-left: 3%;">처방전 관리 </h3>
   <div class="divbox2">
    <a heref=""><img src="<%=ctxPath%>/resources/img/chart/cat1.jpg"  width="100" height="100" style="border-radius: 50%;"> </a>
    
   </div>
  <div class="divbox3">
	  <p style="padding-top:1%;">생년월일: ${pvo.pet_birthday}</p>
	  <p>성별:   ${pvo.pet_gender}</p>
	  <p>몸무게: ${pvo.pet_weight} kg</p>
  </div>
  
 <div class="divbox4">
	<div id="calendar"  class="calendar">
	   
	</div>
 </div>
  
  
 
<div class="tab-content divbox5">
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
        <hr Style="width:100%; height:2%;"></hr>
        <div style="margin-left: 70%;">
	       <p>예치금: </p>
	       <p>본인 부담금:</p>
	       <p>진료비 총액:</p>
       </div>
   </div>
    <div id="menu1" class="tab-pane fade" style="padding-left:2%;"> 
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
        <hr Style="width:80%; height:2%;"></hr>
         <div style="margin-left: 70%;">
	       <p>예치금: </p>
	       <p>본인 부담금:</p>
	       <p>진료비 총액:</p>
       </div>
    </div>
    <div id="menu2" class="tab-pane fade" style="padding-left:2%;">
       <h3>동물사랑 병원</h3>
      <p>진료예약일자: 2019년01월5일 </p>
       <p>방문일자: 2019년01월8일 </p>
       <hr Style="width:80%; height:2%;"></hr>
       <h3 style="font-weight:bold;color:pink;">검사결과 </h3>
       <p>담당수의사 </p>
       <p>처방안내</p>
       <p>처방약</p>
       <p>주의사항</p>
       <p>내용</p>
        <hr Style="width:80%; height:2%;"></hr>
       <div style="margin-left: 70%;">
	       <p>예치금: </p>
	       <p>본인 부담금:</p>
	       <p>진료비 총액:</p>
       </div>
    </div>
    <div id="menu3" class="tab-pane fade" style="padding-left:2%;">
	     <h3>동물사랑 병원</h3>
	      <p>진료예약일자: 2019년01월5일 </p>
	       <p>방문일자: 2019년01월8일 </p>
	       <hr Style="width:80%; height:2%;"></hr>
	       <h3 style="font-weight:bold;color:pink;">검사결과 </h3>
	       <p>담당수의사 </p>
	       <p>처방안내</p>
	       <p>처방약</p>
	       <p>주의사항</p>
	       <p>내용</p>
	        <hr Style="width:80%; height:2%;"></hr>
	         <div style="margin-left: 70%;">
		       <p>예치금: </p>
		       <p>본인 부담금:</p>
		       <p>진료비 총액:</p>
	         </div>
	     <button type="button" class="btn1">수정하기</button>
    </div>
  </div>
</div>

