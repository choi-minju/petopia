<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
.btn1 {
	width: 80px;
	font-size: 15px;
	color: white;
	text-align: center;
	background: grey;
	border: solid 0px grey;
	border-radius: 30px;
}

.btn2 {
	width: 80px;
	font-size: 15px;
	color: white;
	text-align: center;
	background: rgb(252, 118, 106);
	border: solid 0px grey;
	border-radius: 30px;
}
</style>

<script type="text/javascript">

	$(document).ready(function() {
		var dog = ${bizmvo.dog};
		var cat = ${bizmvo.cat};
		var smallani = ${bizmvo.smallani};
		var etc = ${bizmvo.etc};
		
		if(dog == '1'){
			$("#dog").addClass("btn2");
		}
		if(cat == '1'){
			$("#cat").addClass("btn2");
		}
		if(smallani == '1'){
			$("#smallani").addClass("btn2");
		}
		if(etc == '1'){
			$("#etc").addClass("btn2");
		}
	});

</script>


<div class="container">
	<div class="col-sm-12">
		<div class="col-sm-12" align="center">
			<h2>기업상세</h2>
		</div>
			<div class="col-sm-offset-2 col-sm-8 preview-image"
				style="margin-bottom: 15px;">
				<div class="row">
					<div style="width: 100%;">
						<div id="myCarousel" class="carousel slide" data-ride="carousel">
							<!-- Indicators -->
							<ol class="carousel-indicators">
							</ol>

							<!-- Wrapper for slides -->
							<div class="carousel-inner">
								<div class="item active">
									<img src="<%=request.getContextPath()%>/resources/img/hospitalimg/${bizmvo.prontimg}" style="width: 100%;">
								</div>
								
								<c:if test="${imgList != null}">
									<c:forEach items="${imgList}" var="img">
										<div class="item">
											<img src="<%=request.getContextPath()%>/resources/img/hospitalimg/${img}" style="width: 100%;">
										</div>
									</c:forEach>
								</c:if>
							</div>

							<!-- Left and right controls -->
							<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
								<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
								<span class="sr-only">Previous</span>
							</a>
							<a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
								<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
								<span class="sr-only">Next</span>
							</a>
						</div>
					</div>
				</div>

				<div align="center">
					<h3>${bizmvo.name}</h3>
				</div>

				<div class="row">
					<span>${bizmvo.intro}</span>
				</div>

				<div class="row" style="margin-top: 5%;">
					<label>진료/처방가능 동물</label>
				</div>

				<div class="row">
					<button type="button" class="btn1 pettype" id="dog">강아지</button>
					<button type="button" class="btn1 pettype" id="cat">고양이</button>
					<button type="button" class="btn1 pettype" id="smallani">소동물</button>
					<button type="button" class="btn1 pettype" id="etc">기타</button>
				</div>

				<hr style="height: 1px; background-color: grey; border: none; margin-bottom: 0px;">

				<div class="row" style="padding-top: 20px;">
		            <div class="col-sm-6" style="padding-left: 0%;">
		            	<label>진료시간(운영시간)</label><BR>
		            	<div class="col-sm-4">
		            		<span>${bizmvo.weekday}</span>
		            	</div>
						<div class="col-sm-4">
							<span>${bizmvo.wdstart}-${bizmvo.wdend}</span>
						</div>
						<div class="col-sm-4">
							<span>${bizmvo.satstart}-${bizmvo.satend}</span>
						</div>
		            </div>
               
					<div class="col-sm-6">
						<label>점심시간</label><BR>
						<div class="col-sm-4">
							<span>${bizmvo.lunchstart}-${bizmvo.lunchend}</span>
						</div>
						<div class="col-sm-4">
							<span>${bizmvo.dayoff}</span>
						</div>
					</div>
				</div><!-- row -->
				
				<div class="row" style="margin-top: 30px;">
					<label>연락처</label>
					<div style="margin-top: 5px;">
						<span>${bizmvo.phone}</span> 
						<span class="glyphicon glyphicon-earphone" style="margin-left: 10px;"></span>
						<button type="button" style="background-color: #ff6e60; color: white; margin-left: 10px; border: 0; border-radius: 6px;" onClick="javascript: location.href='<%=ctxPath%>/reservation.pet?idx_biz=${idx_biz}'">예약하기</button>
					</div>
				</div>

				<div>
					<img src="<%=request.getContextPath()%>/resources/img/hospitalimg/aaa.PNG" style="width: 100%; height: 90px;">
				</div>

				<div class="row" style="margin-top: 30px;">
					<label>병원 특이사항</label>
				</div>
				<div class="row">
					<c:forEach items="${tagList}" var="tag">
						<span style="color: rgb(252, 118, 106); font-weight: bold;">#${tag}</span>&nbsp;&nbsp;
					</c:forEach>
				</div>
				<hr style="height: 1px; background-color: grey; border: none; margin-bottom: 0px;">

				<div class="row" style="margin-top: 20px;">
					<label>위치</label>
				</div>
				
				<div>
					<label>주소</label>
					(${bizmvo.postcode})&nbsp;${bizmvo.addr1}&nbsp;${bizmvo.addr2}
				</div>
				
				<div id="map" style="width: 500px; height: 400px;"></div>
				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d95bf006c44a2e98551f0af770a55949"></script>
				<script>
					var container = document.getElementById('map');
					var options = {
						center : new daum.maps.LatLng(${bizmvo.latitude},${bizmvo.longitude}),
						level : 3
					};
					var map = new daum.maps.Map(container, options);

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
					
					var imageSrc = '<%= request.getContextPath() %>/resources/img/search/spotpin.png'; // 마커이미지의 주소입니다    
					
					 // 마커 이미지의 이미지 크기 입니다
				    var imageSize = new daum.maps.Size(44, 49); 
				    
				    // 마커 이미지를 생성합니다    
				    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 
				    
				    // 마커를 생성합니다
				    var marker = new daum.maps.Marker({
				        map: map, // 마커를 표시할 지도
				        position: new daum.maps.LatLng(${bizmvo.latitude}, ${bizmvo.longitude} ), // 마커를 표시할 위치
				        title : ${bizmvo.name}, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
				        image : markerImage // 마커 이미지 
				    });
				    
				    marker.setMap(map);
				</script>
				
				<div>
					<label>찾아오시는 길</label>
					${bizmvo.easyway}
				</div>
				
				
				<div>
					<label>의료진</label>
					<c:forEach items="${docList}" var="doc">
						
						<div class="row">
							${doc.docname}
							<c:if test="${doc.dog == '1'}">
								<button type="button" class="btn2 pettype">강아지</button>
							</c:if>
							<c:if test="${doc.dog != '1'}">
								<button type="button" class="btn1 pettype">강아지</button>
							</c:if>
							
							<c:if test="${doc.cat == '1'}">
								<button type="button" class="btn2 pettype">고양이</button>
							</c:if>
							<c:if test="${doc.cat != '1'}">
								<button type="button" class="btn1 pettype">고양이</button>
							</c:if>
							
							<c:if test="${doc.smallani == '1'}">
								<button type="button" class="btn2 pettype">소동물</button>
							</c:if>
							<c:if test="${doc.smallani != '1'}">
								<button type="button" class="btn1 pettype">소동물</button>
							</c:if>
							
							<c:if test="${doc.etc == '1'}">
								<button type="button" class="btn2 pettype">기타</button>
							</c:if>
							<c:if test="${doc.etc != '1'}">
								<button type="button" class="btn1 pettype">기타</button>
							</c:if>
							
						</div>
					</c:forEach>
				</div>
				
			</div>
	</div>
</div>







