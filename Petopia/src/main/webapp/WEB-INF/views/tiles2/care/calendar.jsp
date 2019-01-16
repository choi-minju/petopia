<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>

  #wrap {
    width: 1100px;
    margin: 0 auto;
    padding-top: 10%;
  }

  #external-events {
    float: right;
    width: 250px;
    /* margin-left: 20px; */
    /* border: 1px solid #ccc; */
    /* background: #eee; */
    text-align: center;
  }

  #external-events h4 {
    font-size: 16px;
    margin-top: 0;
    padding-top: 1em;
  }

  #external-events .fc-event {
  	display: inline-block;
    margin: 0px auto;
    padding: 10px;
    width: 60px;
    border: 1px solid black;
    background-color: transparent;
    color: black;
    cursor: pointer;
  }

  #external-events p {
    margin: 1.5em 0;
    font-size: 11px;
    color: #666;
  }

  #external-events p input {
    margin: 0;
    vertical-align: middle;
  }

  #calendar {
    float: left;
    width: 900px;
  }
  
  .profile {
  	border-radius: 50%;
  }

  fieldset {
    display: block;
    margin-inline-start: 2px;
    margin-inline-end: 2px;
    padding-block-start: 0.35em;
    padding-inline-start: 0.75em;
    padding-inline-end: 0.75em;
    padding-block-end: 0.625em;
    min-inline-size: min-content;
    border-width: 2px;
    border-style: groove;
    border-color: threedface;
    border-image: initial;
  }
 
         #tables {display: table; width: 100%;}  디스플레이 테이블을 적용시켜준다

        .row {display: table-row;}                  디스플레이 row(세로)를 적용시켜준다

        .cell {display: table-cell;}                   디스플레이 cell(가로)를 적용시켜준다



</style>


<script>

  $(document).ready(function() {


    /* initialize the external events
    -----------------------------------------------------------------*/

    $('#external-events .fc-event').each(function() {

      // store data so the calendar knows to render an event upon drop
      $(this).data('event', {
        title: $.trim($(this).text()), // use the element's text as the event title
        stick: true // maintain when user navigates (see docs on the renderEvent method)
      });

      // make the event draggable using jQuery UI
      $(this).draggable({
        zIndex: 999,
        revert: true,      // will cause the event to go back to its
        revertDuration: 0  //  original position after the drag
      });

    });


    /* initialize the calendar
    -----------------------------------------------------------------*/

    $('#calendar').fullCalendar({
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
      },
      editable: true,
      droppable: true, // this allows things to be dropped onto the calendar
      drop: function() {
        // is the "remove after drop" checkbox checked?
        if ($('#drop-remove').is(':checked')) {
          // if so, remove the element from the "Draggable Events" list
          $(this).remove();
        }
      }
    });


  });

</script>


<div class="container">
	<h2 style="text-align: center;">케어관리</h2>
	
	<div class="row" style="margin-top: 5%;">
		<div class="col-md-3">
			<li style="list-style-type: none;">
				<ul><span>동물명</span></ul>
				<ul><img src="resources/img/care/dog.png" class="profile" /></ul>
			</li>
		</div>

		<div class="col-md-3">
			<li style="list-style-type: none;">
				<ul><span>동물명</span></ul>
				<ul><img src="resources/img/care/dog.png" class="profile" /></ul>
			</li>
		</div>

		<div class="col-md-3">
			<li style="list-style-type: none;">
				<ul><span>동물명</span></ul>
				<ul><img src="resources/img/care/dog.png" class="profile" /></ul>
			</li>
		</div>

	</div>
	
	<div id='wrap' style="margin-bottom: 10%;">
	   
		<!-- 캘린더 content -->	
	    <div id='calendar' style="border: 0px solid green;"></div>
	 
		<div class="row">
			 
			<li style="list-style-type: none;">
				<ul><div align="center">동물명</div></ul>
				<ul><div align="center"><img src="resources/img/care/dog.png" class="profile" /></div></ul>
				<ul><div align="center" style="border: 1px solid gray;">ㅇㅇㅇ일째 목욕을 안해주었어요</div></ul>
			</li>
			
		</div>
	
		<div class="row">
	
			<div id='external-events' style="border: 0px solid red;">
		      <li style="list-style-type: none;">
		      	<ul><div class='fc-event'><i class="fa fa-cutlery"></i>&nbsp;식사</div>&nbsp;<div class='fc-event'><i class="fa fa-lemon-o"></i>&nbsp;간식</div></ul>
		      	<ul><div class='fc-event'><i class="fa fa-cutlery"></i>&nbsp;용변</div>&nbsp;<div class='fc-event'><i class="fa fa-lemon-o"></i>&nbsp;미용</div></ul>
		      	<ul><div class='fc-event'><i class="fa fa-cutlery"></i>&nbsp;목욕</div>&nbsp;<div class='fc-event'><i class="fa fa-lemon-o"></i>&nbsp;양치</div></ul>
		      	<ul><div class='fc-event'><i class="fa fa-cutlery"></i>&nbsp;접종</div>&nbsp;<div class='fc-event'><i class="fa fa-lemon-o"></i>&nbsp;진료</div></ul>
		      	<ul><div class='fc-event'><i class="fa fa-cutlery"></i>&nbsp;체중</div>&nbsp;<div class='fc-event'><i class="fa fa-lemon-o"></i>&nbsp;투약</div></ul>
		      	<ul><div class='fc-event'><i class="fa fa-cutlery"></i>&nbsp;메모</div>&nbsp;<div class='fc-event'><i class="fa fa-lemon-o"></i>&nbsp;기념</div></ul>
		      </li>
	
		      <p>
		        <input type='checkbox' id='drop-remove' />
		        <label for='drop-remove'>remove after drop</label>
		      </p>
		    </div>
	    
	    </div>
	
	    <div style='clear:both'></div>
	  
	</div>
	  
	  <!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
	  <fieldset>

		<!-- File Button --> 
		<div class="row">
<!-- 		
			<table class="table table-hover">
			    <thead>
			      <tr>
			        <th><h3>sysdate</h3></th>
			      </tr>
			    </thead>
			    <tbody>
			      <tr>
			        <td>John</td>
			        <td>Doe</td>
			        <td>john@example.com</td>
			      </tr>
			      <tr>
			        <td>Mary</td>
			        <td>Moe</td>
			        <td>mary@example.com</td>
			      </tr>
			      <tr>
			        <td>July</td>
			        <td>Dooley</td>
			        <td>july@example.com</td>
			      </tr>
			    </tbody>
			</table>

 -->	  
  	<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
	  
	  
	  
			 <table class="table table-sm">
			  <thead>
			    <tr>
			      <th colspan="3">Handle</th>
			    </tr>
			  </thead>
			  <tbody>
			    <tr>
			      <td>Mark</td>
			      <td>Otto</td>
			      <td>@mdo</td>
			    </tr>
			    <tr>
			      <td>Jacob</td>
			      <td>Thornton</td>
			      <td>@fat</td>
			    </tr>
			    <tr>
			      <td colspan="2">Larry the Bird</td>
			      <td>@twitter</td>
			    </tr>
			  </tbody>
			</table>
	  
		</div>

	</fieldset>  
	  
</div>









