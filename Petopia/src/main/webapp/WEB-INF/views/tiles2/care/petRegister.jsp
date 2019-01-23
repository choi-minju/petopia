<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style type="text/css">

	form {
		margin: 0 auto;
	}
	
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
		clip: rect(0, 0, 0, 0);
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
	
	ul {
		list-style-type: none;
		padding: 0px;
	}
	
	.short {
		width: 50%;
	}
	
	.petbrith {
		background-image: url("resources/img/care/calendar.png");
		background-size: contain;
		background-repeat: no-repeat;
		background-position: center right;
	}
	
</style>

<script type="text/javascript">
	$(document).ready(function() {
		$(".upload-hidden").hide();

		// 이미지 크기 맞춤
		$('.profile').css('height', $(".profile").width() - 1);
		$('.radius-box').css('width', $(".profile").width());
		$('.radius-box').css('height',
				$(".radius-box").width() - 1);

		$(window).resize(
				function() {
					$('.profile').css('height',
							$(".profile").width());
					$('.radius-box').css('height',
							$(".profile").width());
					$('.radius-box').css('width',
							$(".profile").width());
				});

		// profile에 이미지 띄우기
		var imgTarget = $('.preview-image .upload-hidden');
		imgTarget.on('change', function() {
			var parent = $(this).parent();
			parent.children('.upload-display')
					.remove();
			if (window.FileReader) {
				//image 파일만
				if (!$(this)[0].files[0].type
						.match(/image\//))
					return;
				var reader = new FileReader();
				reader.onload = function(e) {
					var src = e.target.result;
					parent.prepend('<div class="profile upload-display"><div class="upload-thumb-wrap"><img width="100%" src="' + src + '" class="upload-thumb radius-box"></div></div>');
				}
				reader.readAsDataURL($(this)[0].files[0]);

				$(".profile").css('background-color', '#f2f2f2');
			}
		}); // end of imgChange

		$(function() {
			$("#datepicker").datepicker();
		});

		// 등록버튼
		$("#btnRegister").click(function() {

			//폼 submit
			var registerFrm = document.registerFrm;
			registerFrm.action = "petRegisterEnd.pet";
			registerFrm.method = "POST";
			registerFrm.submit();
		});

	}); // end of ready()-------------------------------------------
</script>



<div class="container">
	<div class="col-sm-12">
		<div class="" style="background-color: #f2f2f2;">
			<div class="col-sm-12" align="center">
				<h2>반려동물 등록</h2>
			</div>

			<div class="col-sm-12">
				<form name="registerFrm">
					<input type="hidden" name="fk_idx" value="${loginuser.idx}" />
				
					<div class="col-sm-offset-2 col-sm-8 preview-image" style="margin-bottom: 20px;">
					
						<div class="row">
							<div class="col-sm-3">
								<div class="profile" style="background-color: #d9d9d9; height: 150px; border-radius: 100%;" align="center">
									<label for="input-file">프로필</label> 
									<input type="file" id="input-file" class="upload-hidden must" name="pet_profileimg" />
								</div>
							</div>
							<div class="col-sm-9">
								<ul>
									<li>이름은 무엇인가요?</li>
									<li><input type="text" id="textinput" class="form-control input-md short" name="pet_name" placeholder="내용을 입력하세요" /></li>
									<li><hr align="left" style="border: solid 1px; width: 50%;"></li>
								</ul>
								<ul style="list-style-type: none;">
									<li>생일은 언제인가요?(선택)</li>
									<li><input type="text" id="datepicker" class="form-control input-md short petbrith" name="pet_birthday" /></li>
								</ul>
							</div>
						</div>

						<div class="row">
							<div class="col-sm-12">
								<ul class="petKind">
									<li>어떤 종류인가요?</li>
									<li>
										<div class="col-sm-3" style="padding: 0px;">
											<select id="selectbasic" class="form-control" name="pet_type">
												<option value="dog">개</option>
												<option value="cat">고양이</option>
												<option value="smallani">소동물</option>
												<option value="etc">기타</option>
											</select>
										</div>
									</li>
									<li>
									<%-- 
										<div class="col-sm-8 col-sm-offset-1" style="padding: 0px;">
											<input type="search" id="searchinput" class="form-control input-md" name="searchinput" placeholder="기타" />
										</div>
									--%>
									</li>
								</ul>
							</div>
						</div>

						<!-- Multiple Radios (inline) -->
						<div class="row">
							<div class="col-sm-12">
								<ul>
									<li>몸무게를 입력해주세요(선택)</li>
									<li>
										<div class="col-sm-12" style="padding: 0px;">
											<label class="radio-inline" for="radios-0"><input type="radio" id="radios-0" name="pet_size" value="L">대(L)</label> 
											<label class="radio-inline" for="radios-1"><input type="radio" id="radios-1" name="pet_size" value="M">중(M)</label> 
											<label class="radio-inline" for="radios-2"><input type="radio" id="radios-2" name="pet_size" value="S">소(S)</label>
										</div>
									</li>
									<li>
										<div class="col-sm-5" style="padding: 0px;">
											<input type="search" id="searchinput" class="form-control input-md" name="pet_weight" placeholder="소수점 한자리까지 입력 가능합니다.">
										</div>&nbsp; <span style="font-size: large;">kg</span>
									</li>
								</ul>
							</div>
						</div>
						<!-- 여기서부터 수정해야함 -->
						<!-- Multiple Radios (inline) -->
						<div class="form-group">
							<ul style="list-style-type: none;">
								<li>성별은 무엇인가요?(선택)</li>
								<li>
									<div class="col-md-4">
										<label class="radio-inline" for="radios-4"><input type="radio" id="radios-4" name="pet_gender" value="1">남아</label> 
										<label class="radio-inline" for="radios-5"><input type="radio" id="radios-5" name="pet_gender" value="2">여아</label>
									</div>
								</li>
							</ul>
						</div>

						<!-- Multiple Radios (inline) -->
						<div class="form-group">
							<ul style="list-style-type: none;">
								<li>중성화 여부를 선택해주세요(선택)</li>
								<li>
									<div class="col-md-4">
										<label class="radio-inline" for="radios-6"><input type="radio" id="radios-6" name="pet_neutral" value="1">예</label> 
										<label class="radio-inline" for="radios-7"><input type="radio" id="radios-7" name="pet_neutral" value="0">아니요</label> 
										<label class="radio-inline" for="radios-7"><input type="radio" id="radios-7" name="pet_neutral" value="2">모름</label>
									</div>
								</li>
							</ul>
						</div>
						<%--
						<!-- Multiple Checkboxes (inline) -->
						<div class="form-group">
							<ul style="list-style-type: none;">
								<li>예방접종한 것을 선택해주세요(선택)</li>
								<li>
									<div>
										<label class="checkbox-inline" for="checkboxes-0"><input type="checkbox" name="checkboxes" id="checkboxes-0" value="">종합백신</label> 
										<label class="checkbox-inline" for="checkboxes-1"><input type="checkbox" name="checkboxes" id="checkboxes-1" value="">기생충</label>
										<label class="checkbox-inline" for="checkboxes-2"><input type="checkbox" name="checkboxes" id="checkboxes-2" value="">기타</label>
									</div>
								</li>
								<li><div>
										<input id="searchinput" name="searchinput" type="search"
											placeholder="기타" class="form-control input-md">
									</div></li>
							</ul>
						</div>
						--%>
						<!-- Text input-->
						<div class="form-group">
							<ul style="list-style-type: none;">
								<li>과거병력 / 수술력을 입력해주세요(선택)</li>
								<li><textarea id="content" name="medical_history" rows="10" cols="100" style="width: 95%; height: 212px;" placeholder="과거 병력 / 수술력을 입력해주세요."></textarea></li>
							</ul>
						</div>

						<!-- Text input-->
						<div class="form-group">
							<ul style="list-style-type: none;">
								<li>알러지 입력해주세요(선택)</li>
								<li><textarea id="content" name="allergy" rows="10" cols="100" style="width: 95%; height: 212px;" placeholder="알려지 종류를 입력해주세요"></textarea></li>
							</ul>
						</div>

						<div class="row">
							<div class="col-sm-12">
								<button type="button" id="btnRegister">등록</button>
								<button type="button" onclick="javascript:history.back();">취소</button>
							</div>
						</div>

					</div>
				</form>
			</div>
		</div>
	</div>
</div>
