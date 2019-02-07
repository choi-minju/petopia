<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- ==== 2019.02.07 ==== -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		$(".contents").click(function(){
			if(${sessionScope.loginuser == null}) {
				var bool = confirm("댓글은 로그인 후에 작성할 수 있습니다. 로그인 하시겠습니까?");
				
				if(bool == true) {
					location.href = "<%=request.getContextPath()%>/login.pet";
					
					return;
				} else {
					$(':focus').blur();
					
					return;
				} // end of if~else
			} // end of if
		}); // end of $(".contents").click();
		
	}); // end of $(document).ready()
	
	function reviewBlind(review_uid) {
		
		var bool = confirm("해당 리뷰를 블라인드 요청하시겠습니까?");
		
		if(bool == true) {
			
			var data = {"review_uid":review_uid,
						"rv_blind":3};
			
			$.ajax({
				url: "<%=request.getContextPath()%>/reviewBlindByReview_uid.pet",
				type: "POST",
				data: data,
				dataType: "JSON",
				success: function(json){
					
					if(json == 0) {
						alert("블라인드 요청 실패하였습니다.");
					} else {
						alert("블라인드 요청되었습니다.");
					}
					location.reload();
				},
				error: function(request, status, error){ 
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			}); // end of ajax()
			
		} else {
			$(':focus').blur();
			
			return;
		} // end of if~else
	} // end of function setBlindReviewUID(review_uid)
	
	function reviewBlindCancle(review_uid) {
		
		var bool = confirm("해당 리뷰를 블라인드 요청을 취소하시겠습니까?");
		
		if(bool == true) {
			
			var data = {"review_uid":review_uid,
						"rv_blind":0};
			
			$.ajax({
				url: "<%=request.getContextPath()%>/reviewBlindByReview_uid.pet",
				type: "POST",
				data: data,
				dataType: "JSON",
				success: function(json){
					
					if(json == 0) {
						alert("블라인드 요청 실패하였습니다.");
					} else {
						alert("블라인드 요청되었습니다.");
					}
					location.reload();
				},
				error: function(request, status, error){ 
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			}); // end of ajax()
			
		} else {
			$(':focus').blur();
			
			return;
		} // end of if~else
	} // end of function reviewBlindCancle(review_uid)
	
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
				<c:if test="${reviewMap.RV_BLIND == '0'}">
					<button class="btn" onclick="reviewBlind(${reviewMap.REVIEW_UID});" style="background-color: rgb(252, 118, 106); color: white; font-weight: bold;">블라인드요청</button>
				</c:if>
				<c:if test="${reviewMap.RV_BLIND == '3'}">
					<button class="btn" onclick="reviewBlindCancle(${reviewMap.REVIEW_UID});">블라인드요청취소</button>
				</c:if>
				<button class="btn" onclick="javascript:location.href='<%=request.getContextPath()%>/bizReviewList.pet'">목록</button>
			</div>
		</div>
	
		<form name="delReviewFrm">
			<input type="hidden" name="review_UID"/>
		</form>
		
		<div class="row">
			<div class="col-sm-offset-1 col-sm-10">
				<div class="col-sm-12" style="border: 1px solid #bfbfbf; border-radius: 10px;">
					<div class="row">
						<input type="hidden" id="review_uid" name="review_uid" value="${reviewMap.REVIEW_UID}"/>
						<input type="hidden" id="fk_userid" name="fk_userid" value="${reviewMap.FK_USERID}"/>
						<textarea class="form-control contents" id="rc_content" name="rc_content" rows="5" placeholder="주제와 무관한 댓글, 악플은 삭제될 수 있습니다." style="border: none;resize: none;"></textarea>
					</div>
					<div class="row" align="right" style="border-top: 1px solid #bfbfbf;">
						<div class="col-sm-offset-10 col-sm-2">
							<button type="button" class="btn" onclick="addComments();" style="margin-top: 2px; background-color: rgb(252, 118, 106); color: white; font-weight: bold; color: white;">등록</button>
						</div>
					</div>
				</div>
				<div class="col-sm-12" style="margin-top: 10px;">
					<input type="hidden" id="totalPage" />
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
			</div>
		</div>
	</div>
</div>
<!-- ==== 2019.02.07 ==== -->