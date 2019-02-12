<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> 
	<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript">

	$(document).ready(function() {
	
	    $("input.date").datepicker({
		      dateFormat:"yy/mm/dd",
		      dayNamesMin:["일", "월", "화", "수", "목", "금", "토"],
		      monthNames:["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
		      onSelect:function( d ){
		          var arr = d.split("/");
		         $("#datepicker").text(arr[0]);
		         $("#datepicker").append(arr[1]);
		         $("#datepicker").append(arr[2]);
		      } 
	    });
	    
	});	// end of ready()-------------------------------------------
	
	function updateWeight() {
		
		var weightFrm = document.weightFrm;
		weightFrm.method = "POST";
		weightFrm.action = "/addWeightEnd.pet"
		weightFrm.submit();
		self.close();
		
	}
	
</script> 

<div class="container">
	<form name="weightFrm">
		<div><input id="weight" name="weight" type="text" value="name" readonly /></div>
		<div>
			<input id="weight" name="weight" type="text" /> kg
			<input id="weight_targerted" name="weight_targerted" type="text" /> kg
		</div>
		<input type="date" id="datepicker" class="form-control input-md" name="care_start" autocomplete="off" />
		<button type="button" onclick="updateWeight();">추가하기</button>
	</form>
</div>