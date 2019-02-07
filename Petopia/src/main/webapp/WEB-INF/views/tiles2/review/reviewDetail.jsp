<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- ==== 2019.02.04 ==== -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<script type="text/javascript">
	
	$(document).ready(function(){
		showComments("1"); /* === 2019.02.06 === */
	}); // end of $(document).ready()
	
	function goDel(review_UID) {
		var frm = document.delReviewFrm;
		frm.review_UID.value = review_UID;
		
		frm.action = "<%=request.getContextPath()%>/updateReviewStatus.pet";
		frm.method = "POST";
		frm.submit();
	} // end of function goDel(review_UID)
	
	// === 2019.02.05 ==== //
	// 댓글쓰기
	function addComments() {
		
		var data = {"review_uid":$("#review_uid").val(),
					"rc_content":$("#rc_content").val(),
					"fk_userid":$("#fk_userid").val()};
		
		$.ajax({
			url: "<%=request.getContextPath()%>/addComments.pet",
			type: "POST",
			data: data,
			dataType: "JSON",
			success: function(json){
				$("#rc_content").val("");
				
				showComments("1");/* === 2019.02.06 === */
			},
			error: function(request, status, error){ 
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); // end of ajax
		
	} // end of function addComments()
	
	/* === 2019.02.06 === */
	// 댓글 리스트 보기
	function showComments(currentPageNo) {
		
		var data = {"currentPageNo":currentPageNo,
					"review_uid":$("#review_uid").val()};
		
		$.ajax({
			url: "<%=request.getContextPath()%>/selectReviewCommentsList.pet",
			type: "GET",
			data: data,
			dataType: "JSON",
			success: function(json){
				var html = "";
				
				if(json.length > 0) {
					$.each(json, function(entryIndex,entry){
						if(entry.FK_RC_ID == "0") {
							html += '<div class="row" style="padding: 10px;">'
										+'<div class="col-sm-12">'
											+'<div class="row">'
												+'<img src="<%=request.getContextPath() %>/resources/img/member/profiles/'+entry.FILENAME+'" width="20px" height="20px" style="border-radius: 10px;">'
												+'&nbsp;<span style="font-weight: bold;">'+entry.RC_NICKNAME+'</span>'
											+'</div>'
											+'<div class="row" style="margin-top: 5px;">'
												+entry.RC_CONTENT
											+'</div>'
											+'<div class="row" style="margin-top: 5px; color: gray;">'
												+'<span>'+entry.RC_WRITEDATE+'</span>'
											+'</div>'
											+'<div class="row" style="margin-top: 5px;">'
												+'<button class="btn" style="font-size: 8pt; border: none; padding: 7px;">답글</button>'
											+'</div>'
										+'</div>'
									+'</div>';
						} else {
							html += '<div class="row" style="padding: 10px 10px 10px 15px; background-color: #f2f2f2;">'
										+'<div class="col-sm-1" align="right">'
											+'<span class="glyphicon glyphicon-menu-right"></span>'
										+'</div>'
										+'<div class="col-sm-11">'
											+'<div class="row">'
												+'<img src="<%=request.getContextPath() %>/resources/img/member/profiles/${entry.FILENAME}" width="20px" height="20px" style="border-radius: 10px;">'
												+'&nbsp;<span style="font-weight: bold;">'+entry.RC_NICKNAME+'</span>'
											+'</div>'
											+'<div class="row" style="margin-top: 5px;">'
												+entry.RC_CONTENT
											+'</div>'
											+'<div class="row" style="margin-top: 5px; color: gray;">'
												+'<span>'+entry.RC_WRITEDATE+'</span>'
											+'</div>'
											+'<div class="row" style="margin-top: 5px;">'
												+'<button class="btn" style="font-size: 8pt; border: none; padding: 7px;">답글</button>'
											+'</div>'
										+'</div>'
									+'</div>';
						} // end of if~else
						
					}); // end of each
				} else {
					html = "";
				} // end of if~else
					
				$("#commentsResult").html(html);
				showPageBar(currentPageNo);
			},
			error: function(request, status, error){ 
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); // end of ajax
		
	} // end of function showComments(currentPageNo)
	/* === 2019.02.06 === */
	// === 2019.02.05 ==== //
	
	// 댓글 페이지바 만들기
	function showPageBar(currentPageNo) {
		var data = {"review_uid":$("#review_uid").val()};
		
		$.ajax({
			url: "<%=request.getContextPath()%>/selectReviewCommentsTotalPage.pet",
			type: "GET",
			data: data,
			dataType: "JSON",
			success: function(json){
				var html = "";
				
				var totalPage = json;
				var blockSize = 5;
				var loop = 1;
				
				var pageNo = Math.floor((currentPageNo - 1)/blockSize) * blockSize + 1;
				
				if(pageNo != 1) {
					html += "<li><a href=\"javascript:showComments("+(pageNo-1)+")\">이전</a></li>";
				}
				
				while(!(loop > blockSize || pageNo > totalPage)) {
					if(pageNo == currentPageNo) {
						html += "<li><a style='color:black;'>"+pageNo+"</a></li>";
					} else {
						html += "<li><a href=\"javascript:showComments("+pageNo+")\">"+pageNo+"</a></li>";
					} // end of if~else
						
					pageNo++;
					loop++;
				} // end of while
					
				if(!(pageNo > totalPage)) {
					html += "<li><a href=\"javascript:showComments("+(pageNo+1)+")\">다음</a></li>";
				} // end of if
				
				$("#pageBar").empty().html(html);
			},
			error: function(request, status, error){ 
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});// end of ajax
	} // end of function showPageBar(currentPageNo)
	
</script>

<div class="container" style="margin-top: 15px; margin-bottom: 15px;">
	<div class="col-sm-offset-1 col-sm-10" style="border: 1px solid #ddd; border-radius: 10px; padding: 10px;">
		<div class="row">
			<div class="col-sm-6">
				<span style="font-size: 13pt; font-weight: bold;">[${reviewMap.FK_NICKNAME}] 회원님의 [${reviewMap.HOSNAME}] 리뷰입니다.</span>
			</div>
		</div>
		
		<div class="row">
			<div class="col-sm-3">
				<img class="profile" style="border-radius: 100%;" width="15%" src="<%=request.getContextPath() %>/resources/img/member/profiles/${reviewMap.FILENAME}">
				<span>${reviewMap.FK_NICKNAME}&nbsp;${reviewMap.RV_WRITEDATE}</span>
			</div>
			<div class="col-sm-offset-7 col-sm-2" align="right">
				<c:forEach begin="1" end="${reviewMap.STARTPOINT}">
					<img class="addStar" width="15px" height="15px" src="<%=request.getContextPath()%>/resources/img/review/star.png">
				</c:forEach>
				
				<c:forEach begin="1" end="${5-reviewMap.STARTPOINT}">
					<img class="addStar" width="15px" height="15px" src="<%=request.getContextPath()%>/resources/img/review/star empty.png">
				</c:forEach>
			</div>
		</div>
		
		<hr style="margin: 0; margin-top: 10px; margin-bottom: 10px;">
		
		<div class="row">
			<div class="col-sm-12">
				${reviewMap.RV_CONTENTS}
			</div>
		</div>
		
		
		<div class="row">
			<div class="col-sm-offset-8 col-sm-4" align="right">
				<button class="btn" onclick="javascript:location.href='<%=request.getContextPath()%>/allReviewList.pet'">목록</button>
				<c:if test="${sessionScope.loginuser != null}">
					<c:if test="${sessionScope.loginuser.userid == reviewMap.FK_USERID}">
						<button class="btn" onclick="jsvascript:location.href='<%=request.getContextPath()%>/editReview.pet?review_UID=${reviewMap.REVIEW_UID}'">수정</button>
						<button class="btn"onclick="goDel(${reviewMap.REVIEW_UID});">삭제</button>
					</c:if>
				</c:if>
			</div>
		</div>
	
		<form name="delReviewFrm">
			<input type="hidden" name="review_UID"/>
		</form>
		
		<%-- ==== 2019.02.05 ==== --%>
		<div class="row">
			<div class="col-sm-offset-1 col-sm-10">
				<div class="col-sm-12" style="border: 1px solid #bfbfbf; border-radius: 10px;">
					<div class="row">
						<input type="hidden" id="review_uid" name="review_uid" value="${reviewMap.REVIEW_UID}"/>
						<input type="hidden" id="fk_userid" name="fk_userid" value="${reviewMap.FK_USERID}"/>
						<textarea class="form-control" id="rc_content" name="rc_content" rows="5" placeholder="주제와 무관한 댓글, 악플은 삭제될 수 있습니다." style="border: none;resize: none;"></textarea>
					</div>
					<div class="row" align="right" style="border-top: 1px solid #bfbfbf;">
						<div class="col-sm-offset-11 col-sm-1">
							<button type="button" class="btn" onclick="addComments();" style="margin-top: 2px; background-color: rgb(252, 118, 106); color: white; font-weight: bold; color: white;">등록</button>
						</div>
					</div>
				</div>
				<%-- ==== 2019.02.05 ==== --%>
				<%-- ==== 2019.02.06 ==== --%>
				<div class="col-sm-12" style="margin-top: 10px;">
					<span style="font-weight: bold;">댓글 <span>${totalCnt}</span>개</span>
					<button type="button" onclick="showComments('1')" class="btn" style="background-color: white;"><span class="glyphicon glyphicon-repeat"></span></button>
				</div>
				
				<div class="col-sm-12" id="commentsResult">
				</div>
				
				<div class="col-sm-12" align="center">
					<div class="col-sm-12">
						<ul class="pagination pagination-sm" id="pageBar">
					  	</ul>
				  	</div>
				</div>
				<%-- ==== 2019.02.06 ==== --%>
			</div>
		</div>
	</div>
</div>
<!-- ==== 2019.02.04 ==== -->