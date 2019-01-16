<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String ctxPath = request.getContextPath();%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<script type="text/javascript">
    
	$(document).ready(function(){
	    	
		
		$('#calendar').fullCalendar({
			  defaultView: 'month'
			});
		
		$('#calendar').fullCalendar({
			  schedulerLicenseKey: 'GPL-My-Project-Is-Open-Source'
			});
		
		initThemeChooser({

		      init: function(themeSystem) {
		        $('#calendar').fullCalendar({
		          themeSystem: themeSystem,
		          header: {
		            left: 'prev,next today',
		            center: 'title',
		            right: 'month,agendaWeek,agendaDay,listMonth'
		          },
		          defaultDate: '2019-01-12',
		          weekNumbers: true,
		          navLinks: true, // can click day/week names to navigate views
		          editable: true,
		          eventLimit: true, // allow "more" link when too many events
		          events: [
		           
		            {
		              id: 999,
		              title: 'Repeating Event',
		              start: '2019-01-16T16:00:00'
		            },
		            {
		              title: '택배',
		              start: '2019-01-16',
		              end: '2019-01-16'
		            },
		            {
		              title: '여행',
		              start: '2019-01-16T14:30:00',
		              end: '2019-01-18T12:30:00'
		            },
		            {
		              title: 'Happy Hour',
		              start: '2019-01-12T17:30:00'
		            }
		          ]
		        });
		      },

		      change: function(themeSystem) {
		        $('#calendar').fullCalendar('option', 'themeSystem', themeSystem);
		      }

		    });

		 
	
	});// end of $(document).ready()----------------------
</script>
<style>
.btn1{
	background-color:rgb(252, 118, 106); 
	color:white; 
	width:15%;
	height:8%;
	border-radius: 10px;
	margin-top:37%;
    padding-top:0;
 }
 .btn2{
	background-color:rgb(252, 118, 106); 
	color:white; 
	width:5%;
	height:8%;
	border-radius: 10px;
 }
 
 .div1{
    width:70%;
    heigth:40%;
    float:left;
 }
 

 .div2{
   width:25%;
   height:8%;
   overflow:hidden;
   margin-top: 5%;
   margin-right:20%; 
   
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
    font: inherit; /* mock what Boostrap does, don't compete  */
  }

  .left { float: left }
  .right { float: right }
  .clear { clear: both }

  #calendar {
    max-width: 900px;
    margin: 40px auto;
    padding: 0 10px;
  }
  
 }
</style>
<div class="container" style="margin-top: 3%; ">
   
   <h3 style="color:rgb(252, 118, 106);margin-left: 3%;" >진료 & 예약 관리</h3>
  
  <div class="div1">
	<div id="calendar"  class="calendar"
	 style ="border: 1px solid gray;
	   height:80%;width:80%;border-radius:10px; padding:3% 3% 3% 3%;margin-bottom: 3%; ">
	</div>
 </div>
	<div class="div2">  
	  <input type="text" class="input1"  placeholder="회원 이름으로 검색하기"/>
	  <button type="button" class="btn2" style="width:30%; height:50%">검색</button>
     </div> 
      <button  type="button" class="btn1">오늘 진료관리</button>
  </div>
   

</div>