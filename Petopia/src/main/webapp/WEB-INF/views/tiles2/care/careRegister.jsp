<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	

<style type="text/css">
	
	form {
		margin: 0 auto;
	}
	
	.profile input[type="file"] {
		/* 파일 필드 숨기기 */
		position: absolute;
		width: 1px;
		height: 1px;
		padding: 0;
		margin: -1px;
		overflow: hidden;
		clip: rect(0, 0, 0, 0);
		border: 0;
	}
	
	ul {
		list-style-type: none;
		padding: 0px;
	}

	.date {
		background-image: url("resources/img/care/calendar.png");
		background-size: contain;
		background-repeat: no-repeat;
		background-position: center right;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		$(".datepicker").datepicker({
		      dateFormat:"yy/mm/dd",
		      dayNamesMin:["일", "월", "화", "수", "목", "금", "토"],
		      monthNames:["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
		      onSelect:function( d ){
		          var arr = d.split("/");
		         $(".datepicker").text(arr[0]);
		         $(".datepicker").append(arr[1]);
		         $(".datepicker").append(arr[2]);
		      }
		      });
		
		$("#caertype").val("${fk_caretype_UID}");
		
		getCaretype_info();
		
		$("#caertype").bind("change", function() {
			getCaretype_info();
		}); // #타입이 채운 이후 -> 주문량을 채운다.

		// 등록버튼
		$("#btnRegister").click(function() {

			//폼 submit
			var registerFrm = document.registerFrm;
			registerFrm.action = "careRegisterEnd.pet";
			registerFrm.method = "POST";
			registerFrm.submit();

		});

	}); // end of ready()-------------------------------------------

	function getCaretype_info() {

		var form_data = {
			caertype : $("#caertype").val()
		};

		$.ajax({
			url : "getCaretype_info.pet",
			type : "GET", // method
			data : form_data, // 위의 URL 페이지로 사용자가 보내는 ajax 요청 데이터.
			dataType : "JSON", // URL 페이지로 부터 받아오는 데이터타입
			success : function(json) { // 데이터 전송이 성공적으로 이루어진 후 처리해줄 callback 함수

				$("#displayCaretype_info").empty();

				var html = "";

				$.each(json, function(entryIndex, entry) {
					html += "<div style='padding: 10px; border: 1px solid gray;'>" + entry.CARETYPE_INFO + "</div>";
				});

				$("#displayCaretype_info").append(html);
			},
			error : function(request, status, error) {
				alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
			}
		});

	} // end of function getCaretype_info()-------------------------------------------
	
</script>



<div class="container">
	<div class="col-sm-12">
		<div class="" style="background-color: #f2f2f2;">
			<div class="col-sm-12" align="center">
				<h2>케어등록/수정</h2>
			</div>

			<div class="col-sm-12">
				<form name="registerFrm">
					<input type="hidden" name="fk_pet_UID" value="16" /> <%-- 수정_value를 받아와야 한다. --%>
				
					<div class="col-sm-offset-2 col-sm-8 preview-image" style="margin-bottom: 20px;">
					
						<div class="row">
							<div class="col-sm-3">
								<div class="profile" style="background-color: #d9d9d9; height: 150px; border-radius: 100%;" align="center">
									<label for="input-file">프로필</label> 
									<input type="file" id="input-file" class="upload-hidden must" name="" />
								</div>
							</div>
							<div class="col-sm-9">
								<ul>
									<li>
										<select id="caertype" name="fk_caretype_UID">	
																							
										<c:if test="${caretypeList != null && not empty caretypeList}">
										
										<c:forEach var="map" items="${caretypeList}">
											<option value="${map.CARETYPE_UID}">${map.CARETYPE_NAME}</option>
										</c:forEach>
										
										</c:if>

										</select>
									</li>
									
									<div id="displayCaretype_info">

									</div>
									
								</ul>
							</div>
						</div>

						<div class="row">
							<div class="col-sm-12">
								<ul>
									<li>내용</li>
									<li><textarea id="content" name="care_contents" rows="10" cols="100" style="width: 95%; height: 212px;" placeholder="각 항목에 관련된 안내사항 또는 예시"></textarea></li>
								</ul>							
							</div>
						</div>

						<!-- Multiple Radios (inline) -->
						<div class="row">
							<div class="col-sm-12">
								<ul>
									<li>메모</li>
									<li><textarea id="content" name="care_memo" rows="10" cols="100" style="width: 95%; height: 212px;" placeholder="각 항목에 관련된 안내사항 또는 예시"></textarea></li>
								</ul>							
							</div>
						</div>
						
						<!-- Multiple Radios (inline) -->
						<div class="row">
							<div class="col-sm-12">
								<div>사진 올리기</div>
								<div style="display: inline-block;"><input type="file" id="" class="" name="" /></div>				
							</div>
						</div> 
	
						<!-- Multiple Radios (inline) -->
						<div class="row"> 
							<div class="col-sm-12">
								<div style="padding: 0px;">시작 일시</div>
								<div class="col-sm-4" style="display: inline-block;"><input type="text" id="" class="form-control input-md short datepicker date" name="care_start" autocomplete="off" /></div>
								<div class="col-sm-4" align="center" style="display: inline-block;"><i class="fa fa-angle-double-right" style="font-size: 30pt;"></i></div>
								<div class="col-sm-4" style="display: inline-block;"><input type="text" id="" class="form-control input-md short datepicker date" name="care_end" autocomplete="off" /></div>	
							</div>
						</div>  
	
						<!-- Multiple Radios (inline) -->
						<div class="row"> 
							<div class="col-sm-12">					
								<ul>
									<li>알림</li>
									<li>
										<select id="" class="" name="care_alarm">
											<option value="5">5분전</option>
											<option value="10">10분전</option>
										</select>
									</li>
									<li style="margin-left: 20%;">
										<button type="button" id="btnRegister">등록</button>
										<button type="button" onclick="javascript:history.back();">취소</button>
									</li>
								</ul>								
							</div>
						</div>  
						
					</div>
				</form>
				
			<!-- <div class="col-sm-12"> -->
			</div>
		</div>
	</div>
</div>
