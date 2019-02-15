<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>


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
	
	ul {
		padding: 0px;
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
			getGraph();
			getChart();
			
		});
		
		
		// 체중 추가 버튼
		$("#addWeight").click(function() {
			
			var url = "addWeight.pet?pet_UID=${pet_UID}";				
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
				$("#graph").empty();
				
				
				
				
				var html = "<table class='table table-hover'>"
						 + "	<thead>"
						 + "		<tr>"		
						 + "			<th>기록일</th>"
						 + "			<th>체중</th>"
						 + "			<th>기록자</th>"
						 + "		</tr>"
						 + "	</thead>"
						 + "	<tbody>";
						 
				if(json == ''){
					html += "		<tr>"
						  + "			<td colspan='3' align='center'>기록이없습니다.</td>"
						  + "		</tr>";
				}
		 
				
				var resultArr = [];
				for(var i=0; i<json.length; i++){
					var obj = {name: '현재 체중'
								, data: Number(json[i].PETWEIGHT_PAST)};	// 퍼센트 계산을 위해 반드시 Number로 변환
					resultArr.push(obj);
				}
				
					var i = 0;	
					
				$.each(json, function(entryIndex, entry) {
					
			
					i++;
					
						html += "		<tr>"
							  + "			<td>" + entry.PETWEIGHT_DATE + "</td>"
							  + "			<td>" + entry.PETWEIGHT_PAST + "kg </td>"
							  + "			<td>" + entry.PETWEIGHT_UID + "</td>"
							  + "		</tr>";		
					
					if(i == 1){
						$("#weight_targeted").html(entry.PETWEIGHT_TARGETED);	
					}		  
							  
				});
				
					html += "	</tbody>"
						  + "</table>";
				console.log(json);
					  
				$("#table_weight").append(html);
				
				Highcharts.chart('graph', {
				    chart: {
				        type: 'line'
				    },
				    title: {
				        text: '체중 그래프'
				    },
		/* 		    subtitle: {
				        text: 'Source: WorldClimate.com'
				    }, */
				    xAxis: {
				        categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
				    },
				    yAxis: {
				        title: {
				            text: 'Temperature (°C)'
				        }
				    },
				    plotOptions: {
				        line: {
				            dataLabels: {
				                enabled: true
				            },
				            enableMouseTracking: false
				        }
				    },
				    series: [resultArr/*,  {
				        name: 'London',
				        data: [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8]
				    } */]
				
				});
				
				
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}      
		});
		
	} // end of function getWeight()-------------------------------------------
	
	function getGraph() {
		
		
 		$.ajax({
			
			url : "getWeight.pet",   
			type : "GET",                               
			data : form_data,   
			dataType : "JSON",
			success : function(json) {
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}      
		
 		});
		
	} // end of graph
	
	
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
				
				if(json == ''){
					html += "		<tr>"
						  + "			<td colspan='3' align='center'>기록이없습니다.</td>"
						  + "		</tr>";
				}
						 
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
			<div class="out" style="margin-left: 22%;">
			
				<div class="in col-sm- col-sm-3">
					<ul style="list-style-type: none;">
					<c:if test="${petInfo.PREVIOUSPET_UID > 0}">
						<li><span class="pointer changepet" onclick="javascript:location.href='petView.pet?pet_UID=${petInfo.PREVIOUSPET_UID}'">${petInfo.PREVIOUSPET_NAME}</span></li>
						<li><i class="fa fa-angle-double-left" style="font-size: 30pt;"></i></li>
					</c:if> 
					</ul>
				</div>
				<div class="pointer in col-sm-3" onclick=window.open("careCalendar.pet?pet_UID=${pet_UID}","_self")>
					<img src="resources/img/care/${petInfo.PET_PROFILEIMG}" class="profileimg">	
					<ul style="list-style-type: none;">
						<li>${petInfo.PET_NAME}</li>
						<li>${petInfo.PET_BIRTHDAY}</li>
						<li>${petInfo.PET_GENDER}</li>
						<li>${petInfo.PET_TYPE}</li>
					</ul>
				</div>
				
				<div class="in">

				</div>
				<div class="in col-sm-3">
					<ul style="list-style-type: none;">
					<c:if test="${petInfo.NEXTPET_UID > 0}">
						<li><span class="pointer changepet" onclick="javascript:location.href='petView.pet?pet_UID=${petInfo.NEXTPET_UID}'">${petInfo.NEXTPET_NAME}</span></li>
						<li><i class="fa fa-angle-double-right" style="font-size: 30pt;"></i></li>
					</c:if> 
					</ul>
				</div>
				
			</div>	
		</div>
	</div>
	
	<div class="col-sm-12">
		<div class="row" style="text-align: center; margin-top: 5px; margin-left: 1%;">
			<div style="margin:0 auto;">
                <button type="button" id="btnRegister" class="btn btn-rounder btnmenu">수정하기</button>
                <button type="button" class="btn btn-rounder btnmenu" style="color: white; background-color: gray;" onclick="javascript:history.back();">지우기</button>
			</div>
		</div>
	</div>
	
	<div class="col-sm-12">
	<div class="row" style="margin-top: 8%;">
		<div class="out">
			
			<div class="in col-md-4" >
				현재 체중 : ${petInfo.PET_WEIGHT}kg / 목표 체중 : <span id="weight_targeted"></span> kg
				
				<div id="graph" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
				
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