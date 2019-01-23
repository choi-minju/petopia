<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String ctxPath = request.getContextPath();
%>
    
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
	
	
	.card-img-top {
		max-width: 100%;
	}
	
	.card {
		margin: 5%;
	}
	
	.resultHeader h3 {
		font-weight: bold; margin-bottom: 10%;
	}
	
	.resultHeader select {
		margin-top: 15%; margin-bottom: 10%; 
		font-size: 8pt;
	}
	
	#cnt {
		font-weight: bold;
		color: #993333;
	}

</style>


<script type="text/javascript">

	
	$(document).ready(function(){

		$("#myUL").hide();
		$("#myInput").val("${searchWord}");		
		$("#cnt").text("${cnt}");
		
		if(${cnt != 0}) {

			setBounds();
				
		}
		
	});

	function searchEnter(event) {
		
		/* $("#myUL").show();
		
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
	    } */
	    
	    if(event.keyCode == 13) {
	    	var searchWord = $("#myInput").val();
	    	location.href="<%= ctxPath%>/search.pet?searchWord="+searchWord;
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
		        <option>지역별</option>
		        <option>동물병원</option>
		        <option>동물약국</option>
		      </select>
			</div>
		</div>
		<div class="col-sm-4">
			<input type="text" id="myInput" onkeyup="searchEnter(event)" placeholder="Search for names.." title="Type in a name">
			
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
			<div class="row">
				<div class="col-sm-4">
					<input type="button" class="btn input-lg" id="inputlg" value="검색" />
				</div>
				<div class="col-sm-8">
					<input type="button" class="btn btn-primary btn-block input-lg" id="inputlg" value="맞춤추천" data-toggle="tooltip" title="로그인 후 사용가능 합니다."/>
				</div>
			</div>
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
			<c:if test="${ cnt != 0 }">
			<div class="col-sm-7">
				<div id="map" style="width:100%; height:100%; position:relative;overflow:hidden;"></div>
				
				<%-- 다음 지도 api --%>
				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=253c8ea93d1bdcc279a9c6f660649767&libraries=services,clusterer,drawing"></script>
				<script>
					
					// *** 지도 생성 시작 *** //
					var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
					    mapOption = { 
					        center: new daum.maps.LatLng(37.54699, 127.09598), // 지도의 중심좌표
					        level: 4 // 지도의 확대 레벨
					    };
	
					var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
					// *** 지도 생성 끝 *** //
					
					// *** 지도 컨트롤바 생성 시작 ***//
					// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
					var mapTypeControl = new daum.maps.MapTypeControl();
				
					// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
					// daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
					map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);
				
					// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
					var zoomControl = new daum.maps.ZoomControl();
					map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
					// *** 지도 컨트롤바 생성 끝 ***//
					
					
					// *** 검색된 병원/약국의 좌표 정보를 불러와 마커 찍어주기 시작 ***// 
					var positions = ${gson_bizmemList};
					
					var ptionsForbounds = [];
					
					var imageSrc = '<%= request.getContextPath() %>/resources/img/search/spotpin.png'; // 마커이미지의 주소입니다    
	
					for (var i = 0; i < positions.length; i ++) {
					    
					    // 마커 이미지의 이미지 크기 입니다
					    var imageSize = new daum.maps.Size(44, 49); 
					    
					    // 마커 이미지를 생성합니다    
					    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 
					    
					    // 마커를 생성합니다
					    var marker = new daum.maps.Marker({
					        map: map, // 마커를 표시할 지도
					        position: new daum.maps.LatLng(positions[i].latitude, positions[i].longitude ), // 마커를 표시할 위치
					        title : positions[i].name, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
					        image : markerImage // 마커 이미지 
					    });
					    
					    ptionsForbounds.push(new daum.maps.LatLng(positions[i].latitude, positions[i].longitude));
					    
					}
					// *** 검색된 병원/약국의 좌표 정보를 불러와 마커 찍어주기 종료 ***// 
					
					
					// *** 모든 마커를 보여주기 위해 중심좌표와 비율을 다시 설정하기 시작 *** //
					
					// 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
					var bounds = new daum.maps.LatLngBounds();   
					
					var i, marker;
					for (i = 0; i < ptionsForbounds.length; i++) {
					    
					    // LatLngBounds 객체에 좌표를 추가합니다
					    bounds.extend(ptionsForbounds[i]);
					}
					
	
					function setBounds() {
					    // LatLngBounds 객체에 추가된 좌표들을 기준으로 지도의 범위를 재설정합니다
					    // 이때 지도의 중심좌표와 레벨이 변경될 수 있습니다
					    map.setBounds(bounds);
					}
	
					
				</script>
			</div>
		    <div class="col-sm-5" align="center">
		    	<div class="row resultHeader">
		    		<div class="col-sm-8">
						<h3 align="right">검색결과 <span id="cnt"></span>건</h3>
					</div>
					<div class="col-sm-4">
						<select class="form-control input-sm" >
						        <option>평점순</option>
						        <option>거리순</option>
						</select>
					</div>
					<div style="width: 100%; height: 87%; overflow-y: auto;" >
						<%-- 
					    <div class="card text-left border-secondary">
						  <img class="card-img-top" src="<%= ctxPath %>/resources/img/hospitalimg/bbb.jpg" alt="Card image cap">
						  	<div class="card-body">
							    <h5 class="card-title">서서울동물병원</h5>
							    <p class="card-text">평점 <span class="glyphicon glyphicon-star"></span>
						    							<span class="glyphicon glyphicon-star"></span>
						    							<span class="glyphicon glyphicon-star"></span>
						    							<span class="glyphicon glyphicon-star"></span>
						    							<span class="glyphicon glyphicon-star"></span></p>
							    <a href="#" class="btn btn-primary">예약하기</a>
							</div>
					  	</div>
					  	 --%>
				  		<c:forEach items="${ bizmemList }" var="biz_mem">
				  			<div class="card text-left">
							  <img class="card-img-top" src="<%= ctxPath %>/resources/img/hospitalimg/${biz_mem.prontimg}" alt="Card image cap">
							  	<div class="card-body">
								    <h5 class="card-title">${biz_mem.name }</h5>
								    <p class="card-text">평점</p>
								    <a href="#" class="btn btn-primary">예약하기</a>
								</div>
						  	</div>
				  		</c:forEach>
					</div>
				</div>
			</div>
		</c:if>
		<c:if test="${ cnt == 0 }">
			<div class="col-sm-4"></div>
			<div class="col-sm-4">
				<h3 >검색된 결과가 없습니다.</h3>
			</div>
			<div class="col-sm-4"></div>
		</c:if>
	</div>
</div>




<div class="container" style="margin: 10%;">

</div>

<div></div>