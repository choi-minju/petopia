<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	.image {
		opacity: 1;
		display: block;
		width: 100%;
		height: auto;
		transition: .5s ease;
		backface-visibility: hidden;
	}
	
	.pet-box {
		margin: 10px 3px 10px 3px;
		padding: 4px;
		padding-top: 2%;
		border: 1px solid #dadada;
		background: rgba(234, 234, 234, 0.3);
	}
	
	.no-img-box {
		height: 2%;
		width: 2%;
		margin-top: 10px;
		border-radius: 7px;
		background: #fff;
		text-align: center;
		width: 20%;
	}
	
	.pet-img-box {
		width: 100%;
		margin-top: 10px;
		border: 1px solid #dadada;
		background: #fff;
		text-align: center;
	}
	
	.pet-img-box img {
		width: 100%;
		height: 180px;
	}
	
	.no-img-box img {
		height: 2%;
		width: 2%;
		margin-top: 10px;
		border-radius: 7px;
		background: #fff;
		text-align: center;
		width: 20%;
	}
	
	.prod-none {
		display: none;
	}
	
	.pet-hover {
		position: absolute;
		left: 0;
		top: 0;
		width: 218px;
		height: 272px;
		background-color: rgba(54, 66, 72, 0.5);
		border-radius: 7px;
	}
	
	.pet-hover div {
		font-size: 16px;
		position: relative;
		margin: auto;
		left: 0;
		right: 0;
		top: 0;
		bottom: 0;
		color: #fff;
		font-weight: 500;
		border: 1.3px solid #fff;
		width: 100px;
		height: 43px;
		line-height: 45px;
		box-sizing: border-box;
		text-align: center;
	}
	
	ul {
		list-style-type: none;
		padding: 0px;
	}
</style>

<script type="text/javascript">
	$(document).ready(function() {

		$('.pet-hover').addClass('prod-none');

		$('.pet-box').hover(function() {
			var num = $('.pet-box').index(this);
			$('.pet-box a').eq(num).removeClass('prod-none'); // class="pet-box"의 <a>와 num이 같다면
		}, function() {
			$('.pet-hover').addClass('prod-none');
		});

	});
</script>

<div class="container" style="min-height: 800px;">
	<h2 align="center">반려동물관리</h2>

	<c:if test="${pvoList != null}">
	
	<c:forEach var="pvo" items="${pvoList}">
	
	<div class="row">
		<div class="col-sm-12">
		
			<div class="col-sm-3 pet-box">
				<div class="pet-img-box">
					<img src="resources/img/care/${pvo.pet_profileimg}">
				</div>
				<div>${pvo.pet_name}</div>
				<div>
					<span>${pvo.pet_birthday}생일</span> | <span>개월수</span>
				</div>
				<div>
					<span>사이즈</span> | <span>${pvo.pet_gender}성별</span> | <span>${pvo.pet_weight}몸무게</span>
				</div>
				<a href="#" class="pet-hover"><br/><br/>
					<div>정보수정</div><br/>
					<div onclick=window.open("petView.pet?pet_UID=${pvo.pet_UID}","_self")>관리</div><br/>
					<div>지우기</div>
				</a>
			</div>

		</div>
		
		<!-- <a href="petRegister.pet">
		<div class="col-sm-3 pet-box">
			<div class="pet-img-box">
				<ul>
					<li><img src="resources/img/care/plus.png"
						class="no-img-box"></li>
					<li>반려동물 추가하기</li>
				</ul>
			</div>
		</div>
		</a> --> 
		
	</div>
	
	</c:forEach>
	
	</c:if>
	


</div>