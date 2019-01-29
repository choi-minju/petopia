<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- === 2019.01.28 ==== --%>
<style type="text/css">
	.addColor {
		background-color: rgb(252, 118, 106);
	}
</style>

<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
		
		hospitalListAppend("1");

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
		
		// === 2019.01.29 === //
		$(document).on('click', '.btn', function() {
			$('.summernote').summernote({
				placeholder: '병원,약국에 대한 리뷰를 작성해주세요.',
		        tabsize: 2,
		        height: 300
			});
		});
		
		// 별점 주기
		$(document).on('click', '.star', function() {
			var cl = $(this).attr('class');
			var str_cl = String(cl);
			var index = str_cl.indexOf('index');
			var idx = str_cl.substring(index+5, index+6);
			
			var reviewCnt = Number($("#reviewCnt"+idx).val());
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
			} // end of if~else
			$(this).html(html);

			$("#reviewCnt"+idx).val(reviewCnt);
		}); // end of $(document).on() 별점 주기
		
	}); // end of $(document).ready();
	
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
									+'<div class="col-sm-3">'
										+'<div class="col-offset-sm-2 col-sm-8" style="padding-top: 25px;">'
											+'<div class="col-sm-12">'
												+'<img class="profile" style="border-radius: 100%;" width="100%" height="" src="<%=request.getContextPath() %>/resources/img/member/profiles/'+entry.PET_PROFILEIMG+'">'
											+'</div>'
											+'<div class="col-sm-12" align="center" style="margin-top: 15px;">'
												+'<span style="font-weight: bold;">'+entry.PET_NAME+'</span>님'
											+'</div>'
										+'</div>'
									+'</div>'
									+'<div class="col-sm-8">'
										+'<div class="row" style="margin-top: 10px;">'
											+'<div style="background-color: rgb(252, 118, 106); padding: 7px 20px; color: white; border-radius: 15px;">'
												+ entry.CHART_TYPE
											+'</div>'
										+'</div>'
										+'<div class="row" style="margin-top: 10px;">'
											+'<img style="border-radius: 100%; margin-right: 20px;" width="70px" height="70px" src="<%=request.getContextPath() %>/resources/img/member/profiles/'+entry.FILENAME+'">'
											+'<span style="font-size: 15pt; line-height: 300%; font-weight: bold;">'+entry.NAME+'</span>	'			
										+'</div>'
										+'<div class="row" style="margin-top: 10px;">'
											+'<div class="col-sm-2" style="font-weight: bold;">방문일자</div>'
											+'<div class="col-sm-10">'+entry.RESERVATION_DATE+'</div>'
										+'</div>'
										+'<div class="row" style="margin-top: 5px;">'
											+'<div class="col-sm-2" style="font-weight: bold;">담당자</div>'
											+'<div class="col-sm-6">'+entry.DOC_NAME+'</div>'
											+'<div class="col-sm-4" align="right">';
								if(entry.REVIEWCNT=="0") {
									html += '<button class="btn" id="addReview'+entry.FK_RESERVATION_UID+'" onclick="showAddReview('+entry.FK_RESERVATION_UID+');" style="background-color: rgb(252, 118, 106); color: white; font-weight: bold;">리뷰작성 <span class="glyphicon glyphicon-chevron-down" style="color: white;"></span></button>';

								} else {
									html += '<button class="btn" id="showReview'+entry.FK_RESERVATION_UID+'" onclick="showReview('+entry.FK_RESERVATION_UID+');" style="background-color: rgb(252, 118, 106); color: white; font-weight: bold;">리뷰보기 <span class="glyphicon glyphicon-chevron-down" style="color: white;"></span></button>';
								} // end of if
									
								html += '</div>'
										+'</div>'
									+'</div>'
								+'</div>'
								+'<div class="row" id="reviewShow'+entry.FK_RESERVATION_UID+'" style="margin-top: 10px;"></div>'
							+'</div>';
					}); // end of each
				} else {
					html += '<div class="col-sm-12" style="margin-top: 10px; border: 1px solid #bfbfbf; border-radius: 10px; padding-top: 15px; padding-bottom:15px; font-size: 13pt;">'
								+'<div class="row">'
								+'해당하는 데이터가 없습니다.'
								+'</div>'
							+'</div>';
				} // end of if~else
					
				$("#hosResult").html(html);
			},
			error: function(request, status, error){ 
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); // end of ajax
	} // end of function hospitalListAppend(start)
	
	// 리뷰 작성 또는 리뷰 닫기
	function showAddReview(index) {
		var html = "";
		var btnMsg = $("#addReview"+index).html().substring(0, 4);
		
		if(btnMsg == "리뷰작성") {
			html = '<div class="col-sm-offset-1 col-sm-1">'
						+'<button class="btn addColor" style="color: white;" onclick="addReviewFrm('+index+');">등록</button>'
					+'</div>'
					+'<div class="col-sm-offset-7 col-sm-2" align="right">'
						+'<span class="star reviewStar index'+index+'"><img class="addStar" src=\"<%=request.getContextPath()%>/resources/img/review/star empty.png"></span>'
						+'<span class="star reviewStar index'+index+'"><img class="addStar" src=\"<%=request.getContextPath()%>/resources/img/review/star empty.png"></span>'
						+'<span class="star reviewStar index'+index+'"><img class="addStar" src=\"<%=request.getContextPath()%>/resources/img/review/star empty.png"></span>'
						+'<span class="star reviewStar index'+index+'"><img class="addStar" src=\"<%=request.getContextPath()%>/resources/img/review/star empty.png"></span>'
						+'<span class="star reviewStar index'+index+'"><img class="addStar" src=\"<%=request.getContextPath()%>/resources/img/review/star empty.png"></span>'
					+'</div>'
					+'<div class="col-sm-offset-1 col-sm-10" style="margin-top: 10px;">'
						/* +'<textarea class="form-control\" rows="10" placeholder="병원,약국에 대한 리뷰를 작성해주세요."></textarea>' */
						+'<input type="hidden" id="reviewCnt'+index+'" id="reviewCnt'+index+'">'
						+'<input type="hidden" id="fk_reservation_UID'+index+'" value="'+index+'">'
						+'<textarea class="summernote" id="rv_contents'+index+'" rows="10"></textarea>'
						/* +'<div class="summernote" name="rv_contents"><div>' */
					+'</div>';
			$("#addReview"+index).html('리뷰닫기 <span class="glyphicon glyphicon-chevron-up" style="color: white;"></span>');
		} else {
			html = "";
			$("#addReview"+index).html('리뷰작성 <span class="glyphicon glyphicon-chevron-down" style="color: white;"></span>');
		}
		$("#reviewShow"+index).html(html);
	} // end of function showReview(index)
	
	// 리뷰 쓰기
	function addReviewFrm(idx) {
		var frm = document.addReview;
		frm.startpoint.value = $("#reviewCnt"+idx).val();
		frm.fk_reservation_UID.value = $("#fk_reservation_UID"+idx).val();
		frm.rv_contents.value = $("#rv_contents"+idx).val();
		
		frm.action = "<%=request.getContextPath()%>/addReview.pet";
		frm.method = "POST";
		frm.submit();
	} // end of function addReview(idx)
	
	// 리뷰 보기 
	function showReview(index) {
		var html = "";
		var btnMsg = $("#showReview"+index).html().substring(0, 4);
		
		if(btnMsg == "리뷰보기") {
			// ajax로 해당하는 값의 리뷰 불러오기 하는중....
			
			$("#showReview"+index).html('리뷰닫기 <span class="glyphicon glyphicon-chevron-up" style="color: white;"></span>');
		} else {
			html = "";
			$("#showReview"+index).html('리뷰보기 <span class="glyphicon glyphicon-chevron-down" style="color: white;"></span>');
		}
		$("#reviewShow"+index).html(html);
	} // end of function showReview(index)
	
	// === 2019.01.29 === //
</script>

<div class="container" style="margin-bottom: 20px; margin-top: 20px;">
	<%-- === 2019.01.29 === --%>
	<div class="col-sm-offset-1 col-sm-10">
		<div class="row">
			<div class="col-sm-6">
				<button class="btn periodBtn addColor" value="0">전체</button>
				<button class="btn periodBtn" value="1">최근 1달</button>
				<button class="btn periodBtn" value="3">최근 3달</button>
				<button class="btn periodBtn" value="6">최근 6달</button>
				<input type="hidden" id="period"><%-- === 2019.01.29 === --%>
			</div>
		</div>
	
		<div class="row" id="hosResult">
		</div>
	</div>
	
	<form name="addReview">
		<input type="hidden" name="startpoint">
		<input type="hidden" name="fk_reservation_UID">
		<input type="hidden" name="rv_contents">
	</form>
	<%-- === 2019.01.29 === --%>
</div>
<%-- === 2019.01.28 ==== --%>