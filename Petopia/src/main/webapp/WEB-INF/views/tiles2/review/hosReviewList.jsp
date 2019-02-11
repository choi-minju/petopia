<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
	.addColor {
		background-color: rgb(252, 118, 106); 
		color: white; 
		font-weight: bold;
	}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		
		//alert("idx: "+${idx_biz});
		var data = {"idx":${idx_biz}};
		
		$.ajax({
			url: "<%= request.getContextPath()%>/showHosReview.pet",
			type: "GET",
			data: data,
			dataType: "JSON",
			success: function(json){
				var html = "";
				
				if(json.length > 0) {
					$.each(json, function(entryIndex, entry){
						
						html += '<div class="col-sm-12" style="margin-top: 10px;">'
									+'<div class="col-sm-3">'
										+'<img class="profile" style="border-radius: 100%;" width="15%" src="<%=request.getContextPath() %>/resources/img/member/profiles/'+entry.FILENAME+'">'
										+'<span>&nbsp;'+entry.FK_NICKNAME+'&nbsp;'+entry.RV_WRITEDATE+'</span>'
									+'</div>'
									+'<div class="col-sm-offset-7 col-sm-2" align="right">';
									for(var i = 0; i<entry.STARTPOINT; i++) {
										html += '<img class="addStar" width="15px" height="15px" src="<%=request.getContextPath()%>/resources/img/review/star.png">';
									}
									
									for(var i = 0; i<5 - entry.STARTPOINT; i++) {
										html += '<img class="addStar" width="15px" height="15px" src="<%=request.getContextPath()%>/resources/img/review/star empty.png">';
									}
									
								html += '</div>'
								+'</div>'
								+'<div class="col-sm-12" style="margin-top: 10px; border-bottom: 1px solid #e6e6e6;">'
									+'<div class="col-sm-12">'
										+entry.RV_CONTENTS
									+'</div>'
									+'<div class="col-sm-12" align="right">'
										+'<button class="btn btn-xs" style="background-color: white; border: none;"><img src="<%=request.getContextPath()%>/resources/img/review/sms-bubble-speech.png">&nbsp;댓글보기</button>'
									+'</div>'
								+'</div>';
					});
				} else {
					html += '<div class="col-sm-12" style="margin-top: 10px;">'
								+'해당하는 리뷰가 없습니다'
							+'</div>';
				}
				
				$("#resultReview").html(html);
			},
			error: function(request, status, error){ 
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); // end of ajax
		
		$.ajax({
			url: "<%= request.getContextPath()%>/selectAvgStarPoint.pet",
			type: "GET",
			data: data,
			dataType: "JSON",
			success: function(json) {
				var html = '<div class="col-sm-12">';
				var starpoint = json;
				
				for(var i = 0; i<starpoint; i++) {
					html += '<img class="addStar" width="30px" height="30px" src="<%=request.getContextPath()%>/resources/img/review/star.png">';
				}
				
				for(var i = 0; i<5 - starpoint; i++) {
					html += '<img class="addStar" width="30px" height="30px" src="<%=request.getContextPath()%>/resources/img/review/star empty.png">';
				}
				
				html += '</div>';
				
				$("#resultStarPoint").html(html);
			},
			error: function(request, status, error){ 
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); // end of ajax 
		
	}); // end of $(document).ready();
	
</script>

<label style="font-weight: bold;">병원리뷰</label>

<div class="col-sm-12">
	<div id="resultStarPoint"></div>
	<div id="resultReview"></div>
	<div class="col-sm-12" align="right">
		<button class="btn btn-xs addColor">리뷰 더보기</button>
	</div>
</div>
