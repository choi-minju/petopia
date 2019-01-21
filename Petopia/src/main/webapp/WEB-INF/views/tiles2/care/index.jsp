<%@ page language="java" contentType="text/html; charset=UTF-8"
<<<<<<< HEAD
    pageEncoding="UTF-8"%>
=======
	pageEncoding="UTF-8"%>
>>>>>>> refs/remotes/origin/hyunjae

<style type="text/css">
<<<<<<< HEAD

	.image {
	  opacity: 1;
	  display: block;
	  width: 100%;
	  height: auto;
	  transition: .5s ease;
	  backface-visibility: hidden;
	}
		
	.pet-box{
		margin: 30px;
	    border: 1px solid #dadada;
	    border-radius: 7px;
	    background: rgba(234,234,234,0.3);
	}    
	
	.pet-img-box{
		width:100%;
		margin-top: 10px;
		border:1px solid #dadada;
		border-radius: 7px;
		background:#fff;
		text-align:center;
	}
	
	.pet-img-box img{
		width:180px;
		height:160px;
	}
		
		
	.prod-none{
		display:none;
	}
	
	.pet-hover{
		position:absolute;
	    left: 0;
	    top: 0;
	    width:218px;
		height:272px;
	    background-color: rgba(54,66,72,0.5);
	    border-radius: 7px;
	}
		
	.pet-hover div{
		font-size: 16px;
	    position: relative;
	    margin: auto;
	    left: 0;
	    right: 0;
	    top: 0;
	    bottom: 0;
	    color: #fff;
	    font-weight:500;
	    border: 1.3px solid #fff;
	    width: 100px;
	    height: 43px;
	    line-height: 45px;
	    box-sizing: border-box;
	    text-align: center;
	}
		
		
</style>

<script type="text/javascript">
	
$(document).ready(function() {
	
	$('.pet-hover').addClass('prod-none');
	
	$('.pet-box').hover(function(){
		var num = $('.pet-box').index(this);
		$('.pet-box a').eq(num).removeClass('prod-none'); // class="pet-box"의 <a>와 num이 같다면
	},function(){
		$('.pet-hover').addClass('prod-none');
	});

});



</script>

<div>
	<div class="container" style="min-height: 800px;">
		<h2 style="text-align: center;">반려동물관리</h2>
		<div class="row col-sm-offset-2 col-sm-8">
			<div class="col-lg-3 pet-box" style="padding-top: 5%; border: 1px gray solid;">
				<div class="pet-img-box">
					<img src="resources/img/care/dog.png" alt="Avatar" style="width:100%">
				</div>
				<div>이름</div>
				<div><span>생일</span> | <span>개월수</span></div>
				<div><span>사이즈</span> | <span>성별</span> | <span>몸무게</span></div>
				<!-- <button type="button">정보수정</button><button type="button">관리</button><button type="button">지우기</button> -->
				<a href="#" class="pet-hover"><br/><br/><div>정보수정</div><br/><div>관리</div><br/><div>지우기</div></a>
				<!-- <a href="#" class="pet-hover"></a><br/>
				<a href="#" class="pet-hover"><div>지우기</div></a> -->
			</div>
		
			<div class="col-lg-3 pet-box" style="padding-top: 5%; border: 1px gray solid;">
				<div class="pet-img-box">
					<img src="resources/img/care/dog.png" alt="Avatar" class="image" style="width:100%">
				</div>
				<div>이름</div>
				<div><span>생일</span> | <span>개월수</span></div>
				<div><span>사이즈</span> | <span>성별</span> | <span>몸무게</span></div>
				<!-- <button type="button">정보수정</button><button type="button">관리</button><button type="button">지우기</button> -->
				<a href="#" class="pet-hover"><br/><br/><div>정보수정</div><br/><div>관리</div><br/><div>지우기</div></a>
				<!-- <a href="#" class="pet-hover"></a><br/>
				<a href="#" class="pet-hover"><div>지우기</div></a> -->
			</div>	
		
			<div class="col-lg-3 pet-box" style="padding-top: 5%; border: 1px gray solid;">
				<div class="pet-img-box">
					<img src="resources/img/care/dog.png" alt="Avatar" class="image" style="width:100%">
				</div>
				<div>이름</div>
				<div><span>생일</span> | <span>개월수</span></div>
				<div><span>사이즈</span> | <span>성별</span> | <span>몸무게</span></div>
				<!-- <button type="button">정보수정</button><button type="button">관리</button><button type="button">지우기</button> -->
				<a href="#" class="pet-hover"><br/><br/><div>정보수정</div><br/><div>관리</div><br/><div>지우기</div></a>
				<!-- <a href="#" class="pet-hover"></a><br/>
				<a href="#" class="pet-hover"><div>지우기</div></a> -->
			</div>			
		
		</div>
			




		</div>
	</div>

=======
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
	border-radius: 7px;
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
	<div class="row">
		<div class="col-sm-12">
			<div class="col-sm-3 pet-box">
				<div class="pet-img-box">
					<img src="resources/img/care/dog.png">
				</div>
				<div>이름</div>
				<div>
					<span>생일</span> | <span>개월수</span>
				</div>
				<div>
					<span>사이즈</span> | <span>성별</span> | <span>몸무게</span>
				</div>
				<a href="#" class="pet-hover"><br /> <br />
					<div>정보수정</div> <br />
					<div>관리</div> <br />
					<div>지우기</div></a>
			</div>

		</div>

	</div>

	<div class="row">
		<div class="col-sm-12">
			<a href="careRegister.pet">
				<div class="col-sm-3 pet-box">
					<div class="pet-img-box">
						<ul>
							<li><img src="resources/img/care/plus.png"
								class="no-img-box"></li>
							<li>반려동물 추가하기</li>
						</ul>
					</div>
				</div>
			</a>
		</div>

	</div>
>>>>>>> refs/remotes/origin/hyunjae

</div>