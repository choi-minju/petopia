<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
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
	 /* $(".myPetList").hide();
	 
	 $("#mainPet").click(function(){ 
		 if($('input:radio[id=mainPet]').is(':checked')){
		     $('.myPetList').show();
		 } else if($('input:radio[id=newPet]').is(':checked')) {
		     $('.myPetList').hide();
		 }
		 else{
			 $('.myPetList').hide(); 
		 }	
	 }); */
	 
	/*  $("#date").datepicker({
		 	minDate: 0, 
         	maxDate: "+14D",
			dateFormat:"yy/mm/dd",
			dayNamesMin:["일", "월", "화", "수", "목", "금", "토"],	// 배열을 잡은것.
			monthNames:["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
			onSelect:function( d ){
				// 연,월,일 구하기
//				alert(d + "선택됐습니다");
				var arr = d.split("/");
				$("#date").text(arr[0]);
				$("#date").text(arr[1]);
				$("#date").text(arr[2]);
				
				// 요일 구하기
				var date = new Date( $("#date").datepicker({dateFormat:'yy/mm/dd'}).val() );
				alert("date : "+date.getDay() );	// 0(일요일)~6(토요일)
				
				var week = new Array("일", "월", "화", "수", "목", "금", "토");
				$("#date").append( week[ date.getDay() ] );
			}
		}); */

	   /* $('#calendar').fullCalendar({
	      defaultView: 'month',
	      events: 'https://fullcalendar.io/demo-events.json'
	   });
 */
	
 	
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
    	  var form_data = {"idx_biz": "5"};
        	
        	$.ajax({
        		url: "selectScheduleList.pet",
        		type: "GET",
        		data: form_data,
        		dataType: "JSON",
        		success: function(json){
        			var events = [];
        			$.each(json, function(entryIndex, entry){
        				var schstatus = entry.schedule_status;
        				if(schstatus=="1"){
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
      }	
      ,	
      eventClick: function(eventObj) {
     		alert(eventObj.start);
     	    $(this).css('border-color', 'rgb(252, 118, 110)');
			$(this).css('backgroundColor', 'rgb(252, 118, 106)');
			
			$("#schedule_UID").text(eventObj.start);
     	}
    });
	 
		
     
 });
</script>
<div class="container">
	<!-- Container (Pricing Section) -->
	<div id="pricing" class="container-fluid">
	  <div class="text-center">
	    <h2>Reservation</h2>
	    <h4>원하시는 날짜와 시간을 선택하세요.</h4>
	  </div>
	  <div class="row slideanim">
	    <div class="col-sm-4 col-xs-12">
	      <div class="panel panel-default text-center">
	        <div class="panel-heading">
	          <h3>My Pet Info</h3> 
	        </div>
	        <div class="panel-body text-left">
	        	<!-- <p>
	        		<label class="radio-inline"><input type="radio" id="mainPet" name="optradio">기존정보</label>
					<label class="radio-inline"><input type="radio" id="newPet" name="optradio">새로입력하기</label>
				</p> -->
	          <p class="myPetList">
	          	<label for="sel1">반려동물을 선택하세요</label>
			      <select class="form-control " id="sel1">
			        <option>1</option>
			        <option>2</option>
			        <option>3</option>
			        <option>4</option>
			      </select>
	          </p>
	          	<div class="form-group">
				  <label for="petName" class="col">반려동물 이름</label>
				  <input type="text" class="form-control" id="petName" disabled/>
				</div>
	          <p>
	          	<label class="col">동물군</label>
	          	<select class="petType form-control">
	          		<option value="1" disabled>강아지</option>
	          		<option value="2" disabled>고양이</option>
	          		<option value="3" disabled>소동물</option>
	          		<option value="4" disabled>기타</option>
	          	</select>
	          </p>
	          <div class="form-group">
	          	<label class="col">성별</label>
	          	<div class="">
	          	<label class="radio-inline"><input type="radio" id="gender1" name="genderradio" value="1" disabled/>남</label>
			  	<label class="radio-inline"><input type="radio" id="gender2" name="genderradio" value="2" disabled/>여</label>
			  	</div>
			  </div>
	          <div class="form-group">
				  <label for="petcolor" class="col">색상</label>
				  <input type="text" class="form-control" id="petcolor" readOnly/>
				</div>
	        </div>
	        <div class="panel-footer">
	        </div>
	      </div>      
	    </div>     
	    <div class="col-sm-8 col-xs-12">
	      <div class="panel panel-default text-center">
	        <div class="panel-heading">
	          <h3>Choose a Day</h3>
	        </div>
	        <div class="panel-body">
	         <div id="calendar"></div>
	        </div>
	        <div class="panel-footer">
	        </div>
	      </div>      
	    </div>        
	  </div>
	  <form>
	  <div class="row">
	  	 <div class="col-sm-12 col-xs-12">
	      <div class="panel panel-info text-center">
	        <div class="panel-heading">
	          <h6>Choose Result</h6>
	        </div>
	        <div class="panel-body text-left">
	        <div class="row">
	          <p>
	          	<label class="label label-info"> 이름 </label>
	          	<span class="noneBorderText">이름</span>
	          	<input type="hidden"  value="홍길동"/>
	          </p>
	          <p>
	          	<label class="label label-info"> 연락처 </label>
	          	<span class="noneBorderText">010-8888-7777</span>
	          	<input type="hidden"  value="홍길동"/>
	          </p>
	          <p>
	          	<label class="label label-info"> 진료과 </label>
	          	<span class="noneBorderText">고양이</span>
	          	<input type="hidden"  value="홍길동"/>
	          </p>
	          <p>
	          	<label class="label label-info"> 진료일 </label>
	          	<span class="noneBorderText" id="schedule_UID"></span>
	          	<input type="hidden" name="schedule_date" value="홍길동"/>
	          </p>
	        </div>
	       </div>
	      </div>      
	    </div>  
	  </div>
	  </form>
	</div>
</div>