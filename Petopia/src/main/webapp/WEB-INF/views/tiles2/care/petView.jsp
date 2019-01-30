<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
	
	.pointer {
		cursor: pointer;
	}
	
	.in {
		display: inline-block;
	}
	
	.out {
		width: 100%;
		text-align: center;
	}
	
	.profileimg {
		border-radius: 100%;
		width: 150px;
		height: 150px;
	}
	
	.alarm {
		background-color: #f2f2f2;
		height: 50px;
		padding: 7px;
		margin-top: 3%;
		text-align: left;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function () {
		
		getWeight();
		getChart();
		initButton();	
		
	}); // end of ready()-------------------------------------------
	
	function initButton(){
		
		// 체중 Ajax
		$("#changepet").click(function() {
			
			getWeight();
			getChart();
			
		});
		
		
		// 체중 추가 버튼
		$("#addWeight").click(function() {
			
			var url = "addWeight.pet";				
			window.open(url, "addWeight"
					 , "left=500px, top=100px, width=300px, height=230px");
			
		});
		
	} // end of function initButton()-------------------------------------------
	
	function getWeight() {
		
		var form_data = {pet_UID : "${pet_UID}"};
		
 		$.ajax({
			
			url : "getWeight.pet",   
			type : "GET",                               
			data : form_data,   
			dataType : "JSON",
			success : function(json) {
				$("#table_weight").empty();
				
				var html = "<table class='table table-hover'>"
						 + "	<thead>"
						 + "		<tr>"		
						 + "			<th>기록일</th>"
						 + "			<th>체중</th>"
						 + "			<th>기록자</th>"
						 + "		</tr>"
						 + "	</thead>"
						 + "	<tbody>";
				
				$.each(json, function(entryIndex, entry) {
					html += "		<tr>"
						  + "			<td>" + entry.PETWEIGHT_DATE + "</td>"
						  + "			<td>" + entry.PETWEIGHT_PAST + "</td>"
						  + "			<td>" + entry.PETWEIGHT_UID + "</td>"
						  + "		</tr>";		
				});
				
					html += "	</tbody>"
						  + "</table>";
						

				$("#table_weight").append(html);
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}      
		});
		
	} // end of function getWeight()-------------------------------------------
	
	function getChart() {
		
		var form_data = {pet_UID : "${pet_UID}"};
	
 		$.ajax({
			
			url : "getChart.pet",   
			type : "GET",                               
			data : form_data,   
			dataType : "JSON",
			success : function(json) {
				$("#table_chart").empty();
				
				var html = "<table class='table table-hover'>"
						 + "	<thead>"
						 + "		<tr>"		
						 + "			<th>No.</th>"
						 + "			<th>병원</th>"
						 + "			<th>날짜</th>"
						 + "		</tr>"
						 + "	</thead>"
						 + "	<tbody>";
				
				$.each(json, function(entryIndex, entry) {
					html += "		<tr>"
						  + "			<td>" + entry.CHART_UID + "</td>"
						  + "			<td>" + entry.BIZ_NAME + "</td>"
						  + "			<td>" + entry.RESERVATION_DATE + "</td>"
						  + "		</tr>";		
				});
				
					html += "	</tbody>"
						  + "</table>";
						

				$("#table_chart").append(html);
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}      
		});
		
	} // end of function getWeight()-------------------------------------------
	
</script>

<div class="container" style="margin-top: 10px;">
	
	<div class="col-sm-12">
		<div class="row">
			<div class="out">
				<div class="in" style="margin-right: 12%;">
					<ul style="list-style-type: none;">
						<li><span class="pointer changepet" onclick="javascript:location.href='petView.pet?pet_UID=${petInfo.PREVIOUSPET_UID}'">${petInfo.PREVIOUSPET_NAME}</span></li>
						<li><i class="fa fa-angle-double-left" style="font-size: 30pt;"></i></li>
					</ul>
				</div>
				<div class="pointer in" onclick=window.open("careCalendar.pet?pet_UID=${pet_UID}","_self")>
					<img src="resources/img/care/${petInfo.PET_PROFILEIMG}" class="profileimg">	
				</div>
				
				<div class="in">
					<ul style="list-style-type: none;">
						<li>${petInfo.PET_NAME}</li>
						<li>${petInfo.PET_BIRTHDAY}</li>
						<li>${petInfo.PET_GENDER}</li>
						<li>${petInfo.PET_TYPE}</li>
					</ul>
				</div>
				<div class="in" style="margin-left: 6%;">
					<ul style="list-style-type: none;">
						<li><span class="pointer changepet" onclick="javascript:location.href='petView.pet?pet_UID=${petInfo.NEXTPET_UID}'">${petInfo.NEXTPET_NAME}</span></li>
						<li><i class="fa fa-angle-double-right" style="font-size: 30pt;"></i></li>
					</ul>
				</div>
			</div>	
		</div>
	</div>
	
	<div class="col-sm-12">
		<div class="row" style="text-align: center; margin-top: 5px; margin-right: 10px;" >
			<div style="margin:0 auto;">
				<button type="button">수정하기</button>
				<button type="button">지우기</button>	
			</div>
		</div>
	</div>
	
	<div class="col-sm-12">
	<div class="row" style="margin-top: 8%;">
		<div class="out">
			
			<div class="in col-md-4" >
				현재 체중 : ${petInfo.PET_WEIGHT}kg / 목표 체중 : 1kg
				<img src="resources/img/care/chart.PNG" />				
				<div id="table_weight">

				</div>
				<button id="addWeight" type="button">제충추가</button>				
			</div>	
				
			<div class="in col-md-4">
				<div class="alarm">
					<div>
						Simple Title
					</div>
					<div>
						content
					</div>
				</div>
				
				<div class="alarm">
					<div>
						Simple Title
					</div>
					<div>
						content
					</div>
				</div>
				
				<div class="alarm">
					<div>
						Simple Title
					</div>
					<div>
						content
					</div>
				</div>				
			</div>	
			
			<div class="in col-md-4">
				최근 진료 기록
				<div id="table_chart">
					
				</div>
			</div>
				
		</div>
	</div>
	</div> 


</div>    