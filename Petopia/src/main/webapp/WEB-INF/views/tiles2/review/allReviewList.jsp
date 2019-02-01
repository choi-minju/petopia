<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- === 2019.01.31 === 시작 --%>
<style>
	.addColor {
		background-color: rgb(252, 118, 106); 
		color: white; 
		font-weight: bold;
	}
	
	.Astyle {
		color: black;
		text-decoration: none;
	}
	
	.Astyle:hover {
		color: rgb(252, 118, 106);
		text-decoration: none;
	}
</style>

<script type="text/javascript">

	$(document).ready(function(){
		//showReviewList("1");
		// 기간 버튼 클릭하면
		$(".periodBtn").click(function(){
			$(".periodBtn").removeClass("addColor");
			$(this).addClass("addColor");
			
			$("#period").val($(this).val());
		}); // end of $(".periodBtn").click();
	}); // end of $(document).ready();
	
	function showReviewList(currentPageNo) {
		
		var data = {"currentPageNo":currentPageNo,
					"period":$("#period").val(),
					"searchWhat":$("#searchWhat").val(),
					"search":$("#search").val()};
		
		$.ajax({
			url: "<%=request.getContextPath()%>/selectReviewList.pet",
			type: "GET",
			data: data,
			dataType: "JSON",
			success: function(json){
				alert(json.length);
			},
			error: function(request, status, error){ 
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); // end of ajax
		
		
	} // end of function showReviewList(currentPageNo)

</script>

<div class="container" style="margin-top: 15px; margin-bottom: 15px;">
	<div class="row">
		<div class="col-sm-offset-1 col-sm-10" style="margin-top: 20px;background-color: white;">
			<form name="searchFrm" onsubmit="return false">
				<div class="row" style="margin-top: 10px; margin-bottom: 10px;">
					<div class="col-sm-6">
						<button class="btn periodBtn addColor" value="0">전체</button>
						<button class="btn periodBtn" value="1">최근 1달</button>
						<button class="btn periodBtn" value="3">최근 3달</button>
						<button class="btn periodBtn" value="6">최근 6달</button>
						<input type="hidden" id="period"><%-- === 2019.01.29 === --%>
					</div>
					
					<div class="col-sm-6"><%-- 이름, 닉네임, 아이디로 검색 --%>
						<div class="custom-select" style="width:20%; float: left;">
	  						<select name="searchWhat" id="searchWhat" class="form-control">
								<option value="">검색</option>
								<option value="userid">아이디</option>
								<option value="name">이름</option>
								<option value="nickname">닉네임</option>
							</select>
						</div>
						<input type="text" name="search" id="search" class="form-control" placeholder="Search.." style="width: 60%; float: left;">
						<button type="button" class="btn addColor" id="searchBtn" style="width: 20%; height: 34px"><i class="fa fa-search"></i></button>
					</div>
				</div>
			</form>
		</div>
	</div><%-- 검색 --%>
	
	<div class="row" id="reviewList">
		<div class="col-sm-offset-1 col-sm-10" style="">
			<div class="table-responsive">
				<table class="table" style="margin-top: 20px;width: 100%;">
					<thead style="background-color: #f2f2f2;">
						<tr>
							<th width="7%" style="text-align: center;">번호</th>
							<th width="50%" style="text-align: center;">제목</th>
							<th width="20%" style="text-align: center;">아이디</th>
							<th width="13%" style="text-align: center;">평점</th>
							<th width="10%" style="text-align: center;">날짜</th>
						</tr>
					</thead>
					
					<tbody id="result">
						<tr>
							<td>1</td>
							<td><a href="<%=request.getContextPath()%>/reviewDetail.pet?fk_review_UID=1" class="Astyle">[민주] 회원님의 [ㅇㅇ동물병원] 리뷰입니다.</a></td>
							<td>minju3667@naver.com</td>
							<td>
								<img class="addStar" width="10px" height="10px" src="<%=request.getContextPath()%>/resources/img/review/star.png">
								<img class="addStar" width="10px" height="10px" src="<%=request.getContextPath()%>/resources/img/review/star.png">
								<img class="addStar" width="10px" height="10px" src="<%=request.getContextPath()%>/resources/img/review/star.png">
								<img class="addStar" width="10px" height="10px" src="<%=request.getContextPath()%>/resources/img/review/star empty.png">
								<img class="addStar" width="10px" height="10px" src="<%=request.getContextPath()%>/resources/img/review/star empty.png">
								<span style="font-size: 10pt;">3</span>
							</td>
							<td>2019.01.31</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div><%-- 내용 --%>
	
	<div class="row" align="center">
		<div class="col-sm-12">
			<ul class="pagination pagination-sm" id="pageBar">
		  	</ul>
	  	</div>
	</div>
</div>
<%-- === 2019.01.31 === 끝 --%>