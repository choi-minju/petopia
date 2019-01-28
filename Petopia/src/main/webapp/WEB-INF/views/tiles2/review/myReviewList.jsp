<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- === 2019.01.28 ==== --%>
<style type="text/css">
	.addColor {
		background-color: rgb(252, 118, 106);
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		// 이미지 크기 맞춤
	    $('.profile').css('height', $(".profile").width()-1);
	    
		$(window).resize(function() { 
			$('.profile').css('height', $(".profile").width());
	    });
		
		// 기간 버튼 클릭하면
		$(".periodBtn").click(function(){
			$(".periodBtn").removeClass("addColor");
			$(this).addClass("addColor");
			
			$("#period").val($(this).val());
			hospitalListAppend("1");
		});
		
		// 리뷰 쓰기 닫기
		$("#addReview").click(function(){
			var html = "";
			var btnMsg = $(this).html().substring(0, 4);
			
			if(btnMsg == "리뷰작성") {
				html = "<div class=\"col-sm-offset-9 col-sm-2\" align=\"right\">"
								+"<span class=\"star reviewStar\"><img class=\"addStar\" src=\"<%=request.getContextPath()%>/resources/img/review/star empty.png\"></span>"
								+"<span class=\"star reviewStar\"><img class=\"addStar\" src=\"<%=request.getContextPath()%>/resources/img/review/star empty.png\"></span>"
								+"<span class=\"star reviewStar\"><img class=\"addStar\" src=\"<%=request.getContextPath()%>/resources/img/review/star empty.png\"></span>"
								+"<span class=\"star reviewStar\"><img class=\"addStar\" src=\"<%=request.getContextPath()%>/resources/img/review/star empty.png\"></span>"
								+"<span class=\"star reviewStar\"><img class=\"addStar\" src=\"<%=request.getContextPath()%>/resources/img/review/star empty.png\"></span>"
							+"</div>"
							+"<div class=\"col-sm-offset-1 col-sm-10\" style='margin-top: 10px;'>"
								+"<textarea class=\"form-control\" rows=\"10\" placeholder=\"병원,약국에 대한 리뷰를 작성해주세요.\"></textarea>"
								+"<input type=\"text\" id=\"reviewCnt\">"
							+"</div>";
				$(this).html("리뷰닫기 <span class=\"glyphicon glyphicon-chevron-up\" style=\"color: white;\"></span>");
			} else {
				html = "";
				$(this).html("리뷰작성 <span class=\"glyphicon glyphicon-chevron-down\" style=\"color: white;\"></span>");
			}
			$("#reviewShow").html(html);
		});
		
		// 리뷰 별 바꾸고 별점 주기
		var reviewCnt = 0;
		$(".star").click(function(){
			var html = "";
			if($(this).is(".reviewStar")) {
				$(this).removeClass("reviewStar");
				html = "<img class=\"removeStar\" src=\"<%=request.getContextPath()%>/resources/img/review/star.png\">";
				reviewCnt += 1;
			} else {
				$(this).addClass("reviewStar");
				html = "<img class=\"addStar\" src=\"<%=request.getContextPath()%>/resources/img/review/star empty.png\">";
				
				reviewCnt -= 1;
				if(reviewCnt < 0) {
					reviewCnt = 0;
				}
			}
			$(this).html(html);
			$("#reviewCnt").val(reviewCnt);
		});
		
		hospitalListAppend("1");
		
	});
	
	// 리뷰 쓸 병원 목록 불러오기
	var len = 4;
	function hospitalListAppend(start) {
		var data = {"start":start,
					"len":len,
					"period":$("#period").val()};
		
		$.ajax({
			url: "<%=request.getContextPath()%>/selectMyReviewList.pet",
			type: "GET",
			data: data,
			dataType: "JSON",
			success: function(json){
				var html = "";
				if(json.length > 0){
					$.each(json,function(entryIndex,entry){
						html += '<div class="col-sm-12" style="margin-top: 10px; border: 1px solid #bfbfbf; border-radius: 10px; padding-top: 15px; padding-bottom:15px; font-size: 13pt;">'
									+'<div class="row">'
									+'<div class="col-sm-3">
										+'<div class="col-offset-sm-2 col-sm-8" style="padding-top: 25px;">'
											+'<div class="col-sm-12">'
												+'<img id="beforeProfile" class="profile" style="border-radius: 100%;" width="100%" height="" src="<%=request.getContextPath() %>/resources/img/member/profiles/20190120003241449452335591409.jpg">'
											+'</div>'
											+'<div class="col-sm-12" align="center" style="margin-top: 15px;">'
												+'<span style="font-weight: bold;">꽁이</span>님'
											+'</div>'
										+'</div>'
									+'</div>'
									+'<div class="col-sm-8">'
										+'<div class="row" style="margin-top: 10px;">'
											+'<div style="background-color: rgb(252, 118, 106); padding: 7px 20px 7px 20px; color: white; border-radius: 15px; width: 110px;">'
												+'예방접종'
											+'</div>'
										+'</div>'
										+'<div class="row" style="margin-top: 10px;">'
											+'<img style="border-radius: 100%; margin-right: 20px;" width="70px" height="70px" src="<%=request.getContextPath() %>/resources/img/member/profiles/20190120004107449958542776038.jpg">'
											+'<span style="font-size: 15pt; line-height: 300%; font-weight: bold;">동물 사랑 병원</span>	'			
										+'</div>'
										+'<div class="row" style="margin-top: 10px;">'
											+'<div class="col-sm-2" style="font-weight: bold;">방문일자</div>'
											+'<div class="col-sm-10">2018년 06년 23일 금요일</div>'
										+'</div>'
										+'<div class="row" style="margin-top: 5px;">'
											+'<div class="col-sm-2" style="font-weight: bold;">담당자</div>'
											+'<div class="col-sm-6">강아지 전문 000 수의</div>'
											+'<div class="col-sm-4" align="right">'
												+'<button class="btn" id="addReview" style="background-color: rgb(252, 118, 106); color: white; font-weight: bold;">리뷰작성 <span class="glyphicon glyphicon-chevron-down" style="color: white;"></span></button>'
											+'</div>'
										+'</div>'
									'+</div>'
								+'</div>'
								+'<div class="row" id="reviewShow" style="margin-top: 10px;"></div>'
							+'</div>';
					} // end of each
				} else {
					
				} // end of if~else
					
				$("#hosResult").html(html);
			},
			error: function(request, status, error){ 
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); // end of ajax
	} // end of
</script>

<div class="container" style="margin-bottom: 20px; margin-top: 20px;">
	<div class="row">
		<div class="col-sm-6">
			<button class="btn periodBtn addColor" value="0">전체</button>
			<button class="btn periodBtn" value="1">최근 1달</button>
			<button class="btn periodBtn" value="3">최근 3달</button>
			<button class="btn periodBtn" value="6">최근 6달</button>
			<input type="text" id="period">
		</div>
	</div>

	<div class="row" id="hosResult">
		<div class="col-sm-12" style="margin-top: 10px; border: 1px solid #bfbfbf; border-radius: 10px; padding-top: 15px; padding-bottom:15px; font-size: 13pt;">
			<div class="row">
				<div class="col-sm-3">
					<div class="col-offset-sm-2 col-sm-8" style="padding-top: 25px;">
						<div class="col-sm-12">
							<img id="beforeProfile" class="profile" style="border-radius: 100%;" width="100%" height="" src="<%=request.getContextPath() %>/resources/img/member/profiles/20190120003241449452335591409.jpg">
						</div>
						<div class="col-sm-12" align="center" style="margin-top: 15px;">
							<span style="font-weight: bold;">꽁이</span>님
						</div>
					</div>
				</div>
				<div class="col-sm-8">
					<div class="row" style="margin-top: 10px;">
						<div style="background-color: rgb(252, 118, 106); padding: 7px 20px 7px 20px; color: white; border-radius: 15px; width: 110px;">
							예방접종
						</div>
					</div>
					<div class="row" style="margin-top: 10px;">
						<img style="border-radius: 100%; margin-right: 20px;" width="70px" height="70px" src="<%=request.getContextPath() %>/resources/img/member/profiles/20190120004107449958542776038.jpg">
						<span style="font-size: 15pt; line-height: 300%; font-weight: bold;">동물 사랑 병원</span>					
					</div>
					<div class="row" style="margin-top: 10px;">
						<div class="col-sm-2" style="font-weight: bold;">방문일자</div>
						<div class="col-sm-10">2018년 06년 23일 금요일</div>
					</div>
					<div class="row" style="margin-top: 5px;">
						<div class="col-sm-2" style="font-weight: bold;">담당자</div>
						<div class="col-sm-6">강아지 전문 000 수의</div>
						<div class="col-sm-4" align="right">
							<button class="btn" id="addReview" style="background-color: rgb(252, 118, 106); color: white; font-weight: bold;">리뷰작성 <span class="glyphicon glyphicon-chevron-down" style="color: white;"></span></button>
							<!-- <button class="btn reviewBtn" id="showReview" style="background-color: rgb(252, 118, 106); color: white; font-weight: bold;">리뷰작성 <span class="glyphicon glyphicon-chevron-down" style="color: white;"></span></button> -->
						</div>
					</div>
				</div>
			</div><!-- end of row -->
			
			<div class="row" id="reviewShow" style="margin-top: 10px;">
				<%-- <div class="col-sm-offset-9 col-sm-2">
					<span class="star reviewStar"><img class="addStar" src="<%=request.getContextPath()%>/resources/img/review/star empty.png"></span>
					<span class="star reviewStar"><img class="addStar" src="<%=request.getContextPath()%>/resources/img/review/star empty.png"></span>
					<span class="star reviewStar"><img class="addStar" src="<%=request.getContextPath()%>/resources/img/review/star empty.png"></span>
					<span class="star reviewStar"><img class="addStar" src="<%=request.getContextPath()%>/resources/img/review/star empty.png"></span>
					<span class="star reviewStar"><img class="addStar" src="<%=request.getContextPath()%>/resources/img/review/star empty.png"></span>
				</div>
				<div class="col-sm-offset-1 col-sm-10">
					<textarea class="form-control" rows="10"></textarea>
					<input type="text" id="reviewCnt">
				</div> --%>
			</div>
		</div><!-- end of one -->
	</div>
</div>
<%-- === 2019.01.28 ==== --%>