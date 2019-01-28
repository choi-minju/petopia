<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>	
<style>
.container-fluid {
	padding-top: 70px;
	padding-bottom: 70px;
}
.noneBorderText{
  padding: 3px;
  border: none;
  font-size: 13px;
  height: 13px; 
  border-bottom: 1px solid #A6A6A6;
} 
</style>

<script type="text/javascript">
 $(document).ready(function(){
	$("#makeSchedule").hide();
	if(scheduleCount >0){
		
		$('#calendar').fullCalendar({
	      selectable: true,
	      header: {
	        left: 'prev,next today',
	        center: 'title',
	        right: 'month,agendaSevenDay,agendaDay' 
	      },
	      contentHeight: 300,
	      views: {
	    	  agendaSevenDay: {
	    	     type: 'agenda',
	    	     duration: { days: 7 },
	    	     buttonText: 'week'
	    	   }
		  },
	      defaultView: 'agendaSevenDay',
	      visibleRange: function(currentDate) {
	          return {
	            start: currentDate.clone().subtract(1, 'days'),
	            end: currentDate.clone().add(7, 'days') // exclusive end, so 3
	          };
	      },
	      events: function(start, end, timezone, callback){
	    	  var form_data = {"idx_biz": ${sessionScope.loginuser.idx}};
	        	
	        	$.ajax({
	        		url: "selectScheduleList.pet",
	        		type: "GET",
	        		data: form_data,
	        		dataType: "JSON",
	        		success: function(json){
	        			var events = [];
	        			$.each(json, function(entryIndex, entry){
	        				var schstatus = entry.schedule_status;
	        				if(schstatus=="2"){
		        				events.push({
		        					id: entry.schedule_UID,
		            				title: entry.title, 
		            				start: entry.start,
		            				end: entry.end,
		            				backgroundColor: "gray"
		        				});
	        				}
	        				else {
	        					events.push({
	            					id: entry.schedule_UID,
	                				title: entry.title, 
	                				start: entry.start,
	                				end: entry.end
	            				});
	    					}
	        				
	        			});
	        			callback(events);
	        		},// end of success
	        		error: function(request, status, error){
	        			if(request.readyState == 0 || request.status == 0) return;
	        			else alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        		}
	        	});// end of $.ajax
	      },	
	      eventClick: function(eventObj) {
	    		  alert("선택완료");
		       	  $(this).css('border-color', 'rgb(252, 118, 110)');
		  		  $(this).css('backgroundColor', 'rgb(252, 118, 106)');
		  		
		  		  var scheduledate = chageDateFormat(eventObj.start);
		  		  $("#schedule_date").text(scheduledate);
		  		  $("#reservation_DATE").val(eventObj.start);
		  		  $("#fk_schedule_UID").val(eventObj.id);
	     	}
	    });
	} 
	else {
		$("#makeSchedule").show();
	}
	
	
	$("#btnMakeSchedule").click(function(){
		location.href="<%= ctxPath %>/insertScheduleFirst?idx_biz=${idx_biz}";
	});

	
 });
 
 
 function goReset(){
	 
 }
	function chageDateFormat(date) {
//		"Tue  Jan  22   2019       09:    00:    00 GMT+0000" -> "yyyy-mm-dd hh24:mi"
//		 0123 4567 8910 1112131415 161718 192021
//		String[] weekend = {"Sun", "Mon", "Tue", "Wed", "Thr", "Fri", "Sat"};
		var Months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
		var result = "";
		date = date.toString();
		result += date.substring(11, 15);
		for(var i=0; i<Months.length; i++) {
			if(date.substring(4,7) == Months[i]) {
				if(i+1<10) {
					result += "년 0"+(i+1);
				}
				else {
					result += "년 "+(i+1);
				}
			}
		}
		result += "월 "+date.substring(8, 10) + "일 "+date.substring(16, 21);
		
		return result;
	}


</script>
<div class="container">
	<!-- Container (Pricing Section) -->
	<div id="pricing" class="container-fluid">
	  <div class="text-center">
	    <h2>Reservation Calendar</h2>
	    <h4>우리 병원의 스케줄을 확인할 수 있습니다.</h4>
	  </div>
	  <div class="row slideanim">
	    <div class="col-sm-4 col-xs-12" id="makeSchedule">
	      <div class="panel panel-default text-center">
	        <div class="panel-heading">
	          <h3>My Pet Info</h3> 
	        </div>
	        <div class="panel-body text-left">
				<p>최근 2주 내 스케줄이 없습니다.</p>
				<p><button type="button" id="btnMakeSchedule">스케줄 생성하기</button></p>
				<p>스케줄 생성하기 버튼을 클릭하시면 금일로부터 2주 분량의 스케줄이 자동 생성됩니다.</p>
				<p>스케줄을 한번 생성하신 이후부터는 매일 자동으로 스케줄이 갱신/생성됩니다.</p>
	        </div>
	        <div class="panel-footer">
	        </div>
	      </div>      
	    </div>
	         
	    <div class="col-sm-8 col-xs-12">
	      <div class="panel panel-default text-center">
	        <div class="panel-heading">
	          <h3>My Schedule</h3>
	        </div>
	        <div class="panel-body">
	         <div id="calendar"></div>
	        </div>
	        <div class="panel-footer">
	        </div>
	      </div>      
	    </div>        
	  </div>
	  
	</div>
</div>