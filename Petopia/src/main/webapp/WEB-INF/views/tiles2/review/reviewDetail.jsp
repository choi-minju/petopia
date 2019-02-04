<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- ==== 2019.02.04 ==== -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<script type="text/javascript">
	
	function goDel(review_UID){
		var frm = document.delReviewFrm;
		frm.review_UID.value = review_UID;
		
		frm.action = "<%=request.getContextPath()%>/updateReviewStatus.pet";
		frm.method = "POST";
		frm.submit();
	} // end of 
	
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
	</div>
	
	<form name="delReviewFrm">
		<input type="hidden" name="review_UID"/>
	</form>	
</div>
<!-- ==== 2019.02.04 ==== -->