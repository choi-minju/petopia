<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">

	.jumbotron {
		background-color: white;
		color: black;
	}
	
	#myInput {
	  background-image: url('<%= request.getContextPath() %>/resources/img/homeheader/magnifying-glass.png');
	  background-position: 10px 12px;
	  background-repeat: no-repeat;
	  width: 100%;
	  font-size: 16px;
	  padding: 12px 20px 12px 40px;
	  border: 1px solid #ddd;
	  margin-bottom: 12px;
	}
	
	#myUL {
	  list-style-type: none;
	  padding: 0;
	  
	  margin: 0;
	}
	
	#myUL li a {
	  border: 1px solid #ddd;
	  margin-top: -1px; /* Prevent double borders */
	  background-color: #f6f6f6;
	  padding: 12px;
	  text-decoration: none;
	  font-size: 18px;
	  color: black;
	  display: block;
	}
	
	#myUL li a:hover:not(.header) {
	  background-color: #eee;
	}
	
	h2 {
		margin-bottom: 3%;
		font-weight: bold;
	}
	
	hr {
		border-color: #a6a6a6;
	}
	
	

</style>


<script type="text/javascript">

	
	$(document).ready(function(){

		$("#myUL").hide();
		
		$("#myInput").val("${searchWord}");
		
	});

	function myFunction() {
	    
		$("#myUL").show();
		
		var input, filter, ul, li, a, i, txtValue;
	    input = document.getElementById("myInput");
	    filter = input.value.toUpperCase();
	    ul = document.getElementById("myUL");
	    li = ul.getElementsByTagName("li");
	    for (i = 0; i < li.length; i++) {
	        a = li[i].getElementsByTagName("a")[0];
	        txtValue = a.textContent || a.innerText;
	        if (txtValue.toUpperCase().indexOf(filter) > -1) {
	            li[i].style.display = "";
	        } else {
	            li[i].style.display = "none";
	        }
	    }
	}


</script>





<div class="jumbotron">
	<h2 align="center">병원/약국 찾기</h2> 
	<div class="row">
		<div class="col-sm-2"></div>
		<div class="col-sm-2">
		  	<div class="form-group">
			  <select class="form-control input-lg">
		        <option>동물병원</option>
		        <option>동물약국</option>
		      </select>
			</div>
		</div>
		<div class="col-sm-4">
			<input type="text" id="myInput" onkeyup="myFunction()" placeholder="Search for names.." title="Type in a name">
			
			<!-- <ul id="myUL">
			  <li><a href="#">Adele</a></li>
			  <li><a href="#">Agnes</a></li>
			
			  <li><a href="#">Billy</a></li>
			  <li><a href="#">Bob</a></li>
			
			  <li><a href="#">Calvin</a></li>
			  <li><a href="#">Christina</a></li>
			  <li><a href="#">Cindy</a></li>
			</ul> -->
			
		</div>
		<div class="col-sm-2">
			<input type="button" class="btn btn-primary btn-block input-lg" id="inputlg" value="맞춤추천"/>
		</div>
		<div class="col-sm-2"></div>
	</div>
</div>


<div class="row">
	<div class="col-sm-1"></div>
	<div class="col-sm-10">
		<hr/>
	</div>
	<div class="col-sm-1"></div>	
</div>


<div class="container">
	<div class="row">
		<div class="col-sm-7">
			<div id="map" style="width:100%; height:100%; position:relative;overflow:hidden;"></div>
			
			<%-- 다음 지도 api --%>
			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=253c8ea93d1bdcc279a9c6f660649767&libraries=services,clusterer,drawing"></script>
			<script>
		
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				    mapOption = { 
				        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
				        level: 3 // 지도의 확대 레벨
				    };
			
				var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
			
				// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
				var mapTypeControl = new daum.maps.MapTypeControl();
			
				// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
				// daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
				map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);
			
				// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
				var zoomControl = new daum.maps.ZoomControl();
				map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
				
		
				// 주소-좌표 변환 객체를 생성합니다
				var geocoder = new daum.maps.services.Geocoder();
		
				// 주소로 좌표를 검색합니다
				geocoder.addressSearch('서울특별시 성동구 금호1가동', function(result, status) {
		
				    // 정상적으로 검색이 완료됐으면 
				     if (status === daum.maps.services.Status.OK) {
				    	 
		
				        var coords = new daum.maps.LatLng(result[0].y, result[0].x);
		
				        // 결과값으로 받은 위치를 마커로 표시합니다
				        var marker = new daum.maps.Marker({
				            map: map,
				            position: coords
				        });
		
				        // 인포윈도우로 장소에 대한 설명을 표시합니다
				        var infowindow = new daum.maps.InfoWindow({
				            content: '<div style="width:150px;text-align:center;padding:6px 0;">우리회사</div>'
				        });
				        infowindow.open(map, marker);
		
				        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				        map.setCenter(coords);
				    } 
				});
				
				
			</script>
		</div>
	    <div class="col-sm-5" align="center">
			<h3 style="font-weight: bold; margin-bottom: 10%;">검색결과 X건</h3>
			<div style="border: 1px solid black; width: 100%; height: 87%;" ></div>
		</div>
	</div>
</div>


<div class="container" style="margin: 10%;">

</div>

<div>

</div>