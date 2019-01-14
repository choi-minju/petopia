<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<style>
.container-fluid {
	padding-top: 70px;
	padding-bottom: 70px;
}
</style>

<script type="text/javascript">
 $(document).ready(function(){
	 $(".myPetList").hide();
	 
	 $("#mainPet").click(function(){ 
		 if($('input:radio[id=mainPet]').is(':checked')){
		     $('.myPetList').show();
		 } else if($('input:radio[id=newPet]').is(':checked')) {
		     $('.myPetList').hide();
		 }
		 else{
			 $('.myPetList').hide(); 
		 }	
	 });
	 
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
          right: 'agendaWeek' 
        },
        defaultView: 'agenda',
        dayClick: function(date) {
          alert('clicked ' + date.format());
        },
        select: function(startDate, endDate) {
          alert('selected ' + endDate.format());
        },
        visibleRange: function(currentDate) {
            return {
              start: currentDate.clone().subtract(1, 'days'),
              end: currentDate.clone().add(14, 'days') // exclusive end, so 3
            };
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
	        	<label class="radio-inline"><input type="radio" id="mainPet" name="optradio">기존정보</label>
				<label class="radio-inline"><input type="radio" id="newPet" name="optradio">새로입력하기</label>
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
				  <label for="petName">반려동물 이름</label>
				  <input type="text" class="form-control" id="petName">
				</div>
	          <p>
	          	<label>동물군</label>
	          	<select class="petType">
	          		<option value="1">강아지</option>
	          		<option value="2">고양이</option>
	          		<option value="3">소동물</option>
	          		<option value="4">기타</option>
	          	</select>
	          </p>
	          <div class="form-group">
	          	<label for="petName">성별</label>
	          	<label class="radio-inline"><input type="radio" id="mainPet" name="optradio">기존정보</label>
			  	<label class="radio-inline"><input type="radio" id="newPet" name="optradio">새로입력하기</label>
			  </div>
	          <div class="form-group">
				  <label for="petcolor">색상</label>
				  <input type="text" class="form-control" id="petcolor">
				</div>
	        </div>
	        <div class="panel-footer">
	          <button class="btn btn-lg">저장</button>
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
	    <!-- <div class="col-sm-4 col-xs-12">
	      <div class="panel panel-default text-center">
	        <div class="panel-heading">
	          <h3>Select an Hour</h3>
	        </div>
	        <div class="panel-body">
	          <p>
	          	<select>
	          		<option>10:00</option>
	          		<option>10:00</option>
	          		<option>10:00</option>
	          		<option>10:00</option>
	          		<option>10:00</option>
	          	</select>
	          </p>
	        </div>
	        <div class="panel-footer">
	          <h3>$49</h3>
	          <h4>per month</h4>
	          <button class="btn btn-lg">Sign Up</button>
	        </div>
	      </div>      
	    </div> -->    
	  </div>
	</div>
</div>