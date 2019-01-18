<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	.profile label { 
		display: inline-block; 
		padding: 3% 4%;
		color: #999;
		font-size: inherit;
		line-height: normal; 
		vertical-align: middle; 
		cursor: pointer; 
	} 
	.profile input[type="file"] { 
		/* 파일 필드 숨기기 */
		position: absolute; 
		width: 1px; 
		height: 1px; 
		padding: 0; 
		margin: -1px; 
		overflow: hidden;
		clip:rect(0,0,0,0); 
		border: 0; 
	}
	
	/* imaged preview */ 
	.filebox .upload-display { 
		/* 이미지가 표시될 지역 */ 
		margin-bottom: 5px; 
	} 
	
	.filebox .upload-thumb-wrap { 
		/* 추가될 이미지를 감싸는 요소 */ 
		display: inline-block; 
		vertical-align: middle; 
		border: 1px solid #ddd; 
		border-radius: 100%; 
		background-color: #fff; 
	} 
	
	.filebox .upload-display img { 
		/* 추가될 이미지 */
		display: block; 
		max-width: 100%; 
		width: 100%; 
		height: auto;
	}
	
	.radius-box {
	    width: 125px;
	    height:125px;
	    object-fit: cover;
	    object-position: top;
	    border-radius: 50%;
	}
	
	.btns {
		border:none; 
		background: inherit;
		font-size: 13pt;
	}
	
	.error {
		color: red;
	}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		

	}); // end of $(document).ready();
	
</script>

<div class="col-sm-12" style="margin-top: 20px;">
	<div class="col-sm-offset-2 col-md-8" style="background-color: white;">
		
		<div class="col-sm-12" align="center">
			<h2>[홍길동]님 회원</h2>
		</div>
		<div class="col-sm-12">
			<form name="editFrm">
				<div class="col-sm-offset-2 col-md-8 preview-image" style="margin-bottom: 20px;">
					<div class="row">
						<div class="col-sm-3">
							<div class="profile" style="height: 150px; border-radius: 100%;" align="center">
								<img width="100%" src="<%=request.getContextPath() %>/resources/img/memberIcon/profileTest.jpg" class="upload-thumb radius-box">
							</div>
						</div>
						<div class="col-sm-9" style="padding-top: 28px;">
							<span style="color: #999;">ID(email)</span>
							<input type="text" class="form-control must" id="userid" name="userid" value="hongkd" readonly="readonly"/>
							<input type="hidden" class="form-control must" id="membertype" name="membertype" value="1" />
						</div>
					</div>
					<br>
					
					<div class="row">
						<div class="col-sm-6">
							<span style="color: #999;">name</span>
							<input type="text" class="form-control must" id="name" name="name" value="홍길동" readonly="readonly"/>
						</div>
						
						<div class="col-sm-6">
							<span style="color: #999;">nickname</span>
							<input type="text" class="form-control must" id="nickname" name="nickname" value="hong길동" readonly="readonly"/>
						</div>
					</div><!-- row -->
					
					<div class="row">
						<div class="col-sm-6">
							<span style="color: #999;">birthday</span>
							<input type="date" class="form-control must" id="birthday" name="birthday" value="2019-01-10" readonly="readonly"/>
						</div>
						
						<div class="col-sm-6">
							<span style="color: #999;">gender</span><br>
							<input type="text" class="form-control" value="남성" readonly="readonly">
						</div>
					</div><!-- row -->
					
					<div class="row">
						<div class="col-sm-6">
							<span style="color: #999;">phone</span>
							<input type="text" class="form-control must" id="phone" name="phone" value="010-1234-5678" readonly="readonly"/>
						</div>
					</div><!-- row -->
					
					<div class="row tagList1" style="margin-top: 3%;">
						<div class="col-sm-2">
							<span style="color: #999;">시설상태</span>
						</div>
						<div class="col-sm-10">
							<c:forEach var="tag" items="${tagList}">
								<c:if test="${tag.TAG_TYPE == '시설상태'}">
									<div class="col-sm-4">
										<input type="checkbox" class="" id="" name="tag" value="${tag.TAG_UID}"/> <label style="color: #999;" for="tag1">#${tag.TAG_NAME}</label>
										<input type="hidden" class="" id="" name="tag" value="${tag.TAG_NAME}"/>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div><!-- row -->
					
					<div class="row tagList2" style="margin-top: 3%;">
						<div class="col-sm-2">
							<span style="color: #999;">서비스</span>
						</div>
						<div class="col-sm-10">
							<c:forEach var="tag" items="${tagList}">
								<c:if test="${tag.TAG_TYPE == '서비스'}">
									<div class="col-sm-4">
										<input type="checkbox" class="" id="" name="tag" value="${tag.TAG_UID}"/> <label style="color: #999;" for="tag1">#${tag.TAG_NAME}</label>
										<input type="hidden" class="" id="" name="tag" value="${tag.TAG_NAME}"/>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div><!-- row -->
					
					<div class="row tagList3" style="margin-top: 3%;">
						<div class="col-sm-2">
							<span style="color: #999;">가격</span>
						</div>
						<div class="col-sm-10">
							<c:forEach var="tag" items="${tagList}">
								<c:if test="${tag.TAG_TYPE == '가격'}">
									<div class="col-sm-4">
										<input type="checkbox" class="" id="" name="tag" value="${tag.TAG_UID}"/> <label style="color: #999;" for="tag1">#${tag.TAG_NAME}</label>
										<input type="hidden" class="" id="" name="tag" value="${tag.TAG_NAME}"/>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div><!-- row -->
					
					<div class="row tagList4" style="margin-top: 3%;">
						<div class="col-sm-2">
							<span style="color: #999;">전문분야</span>
						</div>
						<div class="col-sm-10">
							<c:forEach var="tag" items="${tagList}">
								<c:if test="${tag.TAG_TYPE == '전문분야'}">
									<div class="col-sm-4">
										<input type="checkbox" class="" id="" name="tag" value="${tag.TAG_UID}"/> <label style="color: #999;" for="tag1">#${tag.TAG_NAME}</label>
										<input type="hidden" class="" id="" name="tag" value="${tag.TAG_NAME}"/>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div><!-- row -->
					
					<div class="row tagList5" style="margin-top: 3%;">
						<div class="col-sm-2">
							<span style="color: #999;">시간</span>
						</div>
						<div class="col-sm-10">
							<c:forEach var="tag" items="${tagList}">
								<c:if test="${tag.TAG_TYPE == '시간'}">
									<div class="col-sm-4">
										<input type="checkbox" class="" id="" name="tag" value="${tag.TAG_UID}"/> <label style="color: #999;" for="tag1">#${tag.TAG_NAME}</label>
										<input type="hidden" class="" id="" name="tag" value="${tag.TAG_NAME}"/>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div><!-- row -->
					
					<div class="row tagList6" style="margin-top: 3%;">
						<div class="col-sm-2">
							<span style="color: #999;">편의시설</span>
						</div>
						<div class="col-sm-10">
							<c:forEach var="tag" items="${tagList}">
								<c:if test="${tag.TAG_TYPE == '편의시설'}">
									<div class="col-sm-4">
										<input type="checkbox" class="" id="" name="tag" value="${tag.TAG_UID}"/> <label style="color: #999;" for="tag1">#${tag.TAG_NAME}</label>
										<input type="hidden" class="" id="" name="tag" value="${tag.TAG_NAME}"/>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div><!-- row -->
					
					<hr style="height: 1px; background-color: #d9d9d9;border: none;"/>
				
					<div class="row">
						<div class="col-sm-offset-1 col-sm-5">
							<button type="button" class="btns" style="color: #999;" onclick="javascript:location.href='<%=request.getContextPath()%>/index.pet'">CANCEL</button>
						</div>
						<div class="col-sm-offset-1 col-sm-5">
							<button type="button" id="goJoinBtn" class="btns" style="color: rgb(252, 118, 106);">SUBMIT</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>