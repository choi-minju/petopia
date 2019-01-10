<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
	.btns {
		margin-top: 5px;
	}
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("#loginBtn").click(function(){
			
		});
	}); // end of $(document).ready();
	
</script>

<div class="col-sm-12">
	<div class="row" align="center">
		<div class="col-sm-offset-2 col-md-8" style="background-color: #f2f2f2; margin-bottom: 20px; padding-bottom: 20px;">
			<div class="col-sm-offset-4 col-sm-4">
				<h3>Login</h3>
				<hr style="height: 1px; background-color: #d9d9d9;border: none;"/>
				<form name="loginFrm">
					<div class="form-group">
						<div class="input-group">
							<input type="text" class="form-control" id="uLogin" placeholder="Login">
							<label for="uLogin" class="input-group-addon glyphicon glyphicon-user"></label>
						</div>
					</div> <!-- /.form-group -->

					<div class="form-group">
						<div class="input-group">
							<input type="password" class="form-control" id="uPassword" placeholder="Password">
							<label for="uPassword" class="input-group-addon glyphicon glyphicon-lock"></label>
						</div> <!-- /.input-group -->
					</div> <!-- /.form-group -->

					<div class="checkbox" align="left">
						<label>
							<input type="checkbox"> Remember me
						</label>
					</div> <!-- /.checkbox -->
					
					<div class="row">
						<button type="button" class="btn" data-toggle="modal" data-target="#idFindModal" style="background-color: #F2CFAA; color: white;">아이디찾기</button>
						<button type="button" class="btn" data-toggle="modal" data-target="#pwFindModal" style="background-color: #EBA58A; color: white;">비밀번호찾기</button>
						<button type="button" class="btn" id="loginBtn" style="background-color: rgb(252, 118, 106); color: white;">Login</button>
					</div>
				</form>
				<h4>OR</h4>
				<span>sns 로그인은 일반회원만 가능합니다.</span>
				<button type="button" class="form-control btns" style="background-color: #fef01b; color: white; border: none;">Login with Kakaotalk</button>
				<button type="button" class="form-control btns" style="background-color: #2DB400; color: white; border: none;">Login with Naver</button>
				<button type="button" class="form-control btns" style="background-color: #80e5ff; color: white; border: none;">Login with Google</button>
				<button type="button" class="form-control btns" style="background-color: #3b5998; color: white; border: none;">Login with Facebook</button>
			</div>
		</div>
	</div>
	

	<div class="modal fade" id="idFindModal" role="dialog">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Find ID</h4>
				</div>
				
				<div class="modal-body">
					<div class="row">
						<div class="col-sm-offset-1 col-sm-10">
							<span style="color: #999;">이름</span>
							<input type="text" class="form-control" id="name" name="name" style="border: none; border-bottom: 2px solid rgb(252, 118, 106);"/>
						</div>
					</div>
					
					<div class="row" style="margin-top: 20px;">
						<div class=" col-sm-offset-1 col-sm-10">
							<span style="color: #999;">휴대폰번호</span>
							<input type="text" class="form-control" id="phone" name="phone" style="border: none; border-bottom: 2px solid rgb(252, 118, 106);"/>
						</div>
					</div>
					
					<div class="row" style="margin-top: 20px;">
						<div class="col-sm-offset-1 col-sm-10">
							<button type="button" class="form-control" style="background-color: rgb(252, 118, 106); color: white;">휴대폰 본인 인증하기</button>
						</div>
					</div>
					
					<!-- 인증화면 -->
					<div class="row" style="margin-top: 20px;">
						<div class="col-sm-offset-1 col-sm-10">
							<span>010-1234-5678로 보낸<br> 인증번호를 입력해주세요.</span>
						</div>
					</div>
					
					<div class="row" style="margin-top: 20px;">
						<div class=" col-sm-offset-1 col-sm-10">
							<span style="color: #999;">인증번호</span>
							<input type="text" class="form-control" id="code" name="code" style="border: none; border-bottom: 2px solid rgb(252, 118, 106);"/>
						</div>
					</div>
					
					<div class="row" style="margin-top: 20px;">
						<div class="col-sm-offset-1 col-sm-10">
							<button type="button" class="form-control" style="background-color: rgb(252, 118, 106); color: white;">확인</button>
						</div>
					</div>
					
					<!-- 아이디 결과 -->
					<div class="row" style="margin-top: 20px;">
						<div class=" col-sm-offset-1 col-sm-10">
							<span style="color: #999;">홍길동님의 아이디</span>
							<input type="text" class="form-control" id="userid" name="userid" value="hongkd" readonly="readonly" style="border: none; border-bottom: 2px solid rgb(252, 118, 106);"/>
						</div>
					</div>
				</div>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="pwFindModal" role="dialog">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Find Password</h4>
				</div>
				
				<div class="modal-body">
					<div class="row">
						<div class="col-sm-offset-1 col-sm-10">
							<span style="color: #999;">ID</span>
							<input type="text" class="form-control" id="userid" name="userid" style="border: none; border-bottom: 2px solid rgb(252, 118, 106);"/>
						</div>
					</div>
					
					<div class="row" style="margin-top: 20px;">
						<div class=" col-sm-offset-1 col-sm-10">
							<span style="color: #999;">email</span>
							<input type="text" class="form-control" id="email" name="email" style="border: none; border-bottom: 2px solid rgb(252, 118, 106);"/>
						</div>
					</div>
					
					<div class="row" style="margin-top: 20px;">
						<div class="col-sm-offset-1 col-sm-10">
							<button type="button" class="form-control" style="background-color: rgb(252, 118, 106); color: white;">이메일 본인 인증하기</button>
						</div>
					</div>
					
					<!-- 인증화면 -->
					<div class="row" style="margin-top: 20px;">
						<div class="col-sm-offset-1 col-sm-10">
							<span>hongkd@gmail.com로 보낸<br> 인증번호를 입력해주세요.</span>
						</div>
					</div>
					
					<div class="row" style="margin-top: 20px;">
						<div class=" col-sm-offset-1 col-sm-10">
							<span style="color: #999;">인증번호</span>
							<input type="text" class="form-control" id="code" name="code" style="border: none; border-bottom: 2px solid rgb(252, 118, 106);"/>
						</div>
					</div>
					
					<div class="row" style="margin-top: 20px;">
						<div class="col-sm-offset-1 col-sm-10">
							<button type="button" class="form-control" style="background-color: rgb(252, 118, 106); color: white;">확인</button>
						</div>
					</div>
					
					<!-- 비밀번호 결과 -->
					<div class="row" style="margin-top: 20px;">
						<div class=" col-sm-offset-1 col-sm-10">
							<span style="color: #999;">새비밀번호</span>
							<input type="password" class="form-control" id="pwd" name="pwd" style="border: none; border-bottom: 2px solid rgb(252, 118, 106);"/>
							
							<span style="color: #999; margin-top: 20px;">새비밀번호 재입력</span>
							<input type="password" class="form-control" id="pwdCheck" name="pwdCheck" style="border: none; border-bottom: 2px solid rgb(252, 118, 106);"/>
						</div>
					</div>
				</div>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</div>