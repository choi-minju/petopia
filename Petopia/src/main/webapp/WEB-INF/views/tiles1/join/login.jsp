<%@page import="com.final2.petopia.model.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">
	.btns {
		margin-top: 5px;
	}
</style>
<<<<<<< HEAD
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
=======
>>>>>>> refs/remotes/origin/hyunjae

<script type="text/javascript">

	$(document).ready(function(){
		
		$("#pwd").keydown(function(event){
			if(event.keyCode == 13) {
				goLogin();
			}
		});
		
		$("#loginBtn").click(function(){
			goLogin();
		}); // end of $("#loginBtn").click()
	}); // end of $(document).ready();
	
	function goLogin() {
		var userid = $("#userid").val().trim();
		var pwd = $("#pwd").val().trim();
		
		if(userid == null || userid == "") {
			alert("아이디를 입력하세요!");
			
			return;
		}
		
		if(pwd == null || pwd == "") {
			alert("비밀번호를 입력하세요!");
			
			return;
		}
		
		var frm = document.loginFrm;
		frm.action = "<%=request.getContextPath()%>/loginSelect.pet";
		frm.method = "POST";
		frm.submit();
	} // end of function goLogin()
	
</script>
<<<<<<< HEAD

<!-- 카카오 로그인  -->
<script type='text/javascript'>
	Kakao.init('b5a80832c3cb255d6b0092b12fa51f95');
	function loginWithKakao() {
		// 로그인 창을 띄웁니다.
		Kakao.Auth.login({
			success: function(authObj) {
				//alert(JSON.stringify(authObj));
				Kakao.API.request({
				
					url: '/v1/user/me',
					success: function(res) {
						//alert(JSON.stringify(res)); //<---- kakao.api.request 에서 불러온 결과값 json형태로 출력
						//alert(JSON.stringify(authObj)); //<----Kakao.Auth.createLoginButton에서 불러온 결과값 json형태로 출력
						
						var frm = document.kakaoLogin;
						frm.userid.value = res.kaccount_email;
						frm.nickname.value = res.properties['nickname'];
						frm.method = "POST";
						frm.action = "<%=request.getContextPath()%>/kakaoLogin.pet";
						frm.submit();
						
						console.log(res.id);//<---- 콘솔 로그에 id 정보 출력(id는 res안에 있기 때문에  res.id 로 불러온다)
						console.log(res.kaccount_email);//<---- 콘솔 로그에 email 정보 출력 (어딨는지 알겠죠?)
						console.log(res.properties['nickname']);//<---- 콘솔 로그에 닉네임 출력(properties에 있는 nickname 접근 
						// res.properties.nickname으로도 접근 가능 )
						//console.log(authObj.access_token);//<---- 콘솔 로그에 토큰값 출력
					}
				})
			},
			fail: function(err) {
				alert(JSON.stringify(err));
			}
		});
	};
</script>
<!-- {"error":"unauthorized","error_description":"unauthorized - unregistered website domain"} -->

<%
	MemberVO loginuser = (MemberVO)request.getAttribute("loginuser");
	if(loginuser == null) {
		Cookie[] cookies = request.getCookies();
		
		String cookie_key = "";
		String cookie_value = "";
		boolean flag = false;
		
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				cookie_key = cookie.getName();
				if("saveUserid".equals(cookie_key)) {
					cookie_value = cookie.getValue();
					flag = true;
					break;
				} // end of if
			} // end of for
		} // end of if
%>

<div class="col-sm-12" style="margin-top: 5%; margin-bottom: 5%">
	<div class="row" align="center">
		<div class="col-sm-offset-2 col-md-8" style="background-color: #f2f2f2; margin-bottom: 20px; padding-bottom: 20px;">
			<div class="col-sm-offset-4 col-sm-4">
				<h3>Login</h3>
				<hr style="height: 1px; background-color: #d9d9d9;border: none;"/>
				<form name="loginFrm">
					<div class="form-group">
						<div class="input-group">
							<input type="text" class="form-control" id="userid" name="userid" placeholder="Login"
							<% if(flag == true) { %>
								value=<%=cookie_value %>
							<%} %>
							>
							<label for="uLogin" class="input-group-addon glyphicon glyphicon-user"></label>
						</div>
					</div> <!-- /.form-group -->

					<div class="form-group">
						<div class="input-group">
							<input type="password" class="form-control" id="pwd" name="pwd" placeholder="Password">
							<label for="uPassword" class="input-group-addon glyphicon glyphicon-lock"></label>
						</div> <!-- /.input-group -->
					</div> <!-- /.form-group -->

					<div class="checkbox" align="left">
						<label>
							<input type="checkbox" name="saveUserid"
								<% if(flag == true) { %>
								checked="checked"
								<%} %>
							> Remember me
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
				<a id="custom-login-btn" href="javascript:loginWithKakao()">
					<img src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="300px"/>
				</a>
				
				<button type="button" class="form-control btns" style="background-color: #2DB400; color: white; border: none;">Login with Naver</button>
				<button type="button" class="form-control btns" style="background-color: #80e5ff; color: white; border: none;">Login with Google</button>
				<button type="button" class="form-control btns" style="background-color: #3b5998; color: white; border: none;">Login with Facebook</button>
				
				
			</div>
		</div>
	</div>

	<form name="kakaoLogin">
		<input name="userid" />
		<input name="nickname" />
	</form>

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
							<input type="text" class="form-control" id="useridCode" name="useridCode" style="border: none; border-bottom: 2px solid rgb(252, 118, 106);"/>
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
							<input type="text" class="form-control" id="passwdCode" name="passwdCode" style="border: none; border-bottom: 2px solid rgb(252, 118, 106);"/>
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

=======
<%
	MemberVO loginuser = (MemberVO)request.getAttribute("loginuser");
	if(loginuser == null) {
		Cookie[] cookies = request.getCookies();
		
		String cookie_key = "";
		String cookie_value = "";
		boolean flag = false;
		
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				cookie_key = cookie.getName();
				if("saveUserid".equals(cookie_key)) {
					cookie_value = cookie.getValue();
					flag = true;
					break;
				} // end of if
			} // end of for
		} // end of if
%>

<div class="col-sm-12" style="margin-top: 5%; margin-bottom: 5%">
	<div class="row" align="center">
		<div class="col-sm-offset-2 col-md-8" style="background-color: #f2f2f2; margin-bottom: 20px; padding-bottom: 20px;">
			<div class="col-sm-offset-4 col-sm-4">
				<h3>Login</h3>
				<hr style="height: 1px; background-color: #d9d9d9;border: none;"/>
				<form name="loginFrm">
					<div class="form-group">
						<div class="input-group">
							<input type="text" class="form-control" id="userid" name="userid" placeholder="Login"
							<% if(flag == true) { %>
								value=<%=cookie_value %>
							<%} %>
							>
							<label for="uLogin" class="input-group-addon glyphicon glyphicon-user"></label>
						</div>
					</div> <!-- /.form-group -->

					<div class="form-group">
						<div class="input-group">
							<input type="password" class="form-control" id="pwd" name="pwd" placeholder="Password">
							<label for="uPassword" class="input-group-addon glyphicon glyphicon-lock"></label>
						</div> <!-- /.input-group -->
					</div> <!-- /.form-group -->

					<div class="checkbox" align="left">
						<label>
							<input type="checkbox" name="saveUserid"
								<% if(flag == true) { %>
								checked="checked"
								<%} %>
							> Remember me
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
>>>>>>> refs/remotes/origin/hyunjae
</div>
<% } else { %>
	<script type="text/javascript">
		alert("이미 로그인 하셨습니다!!");
		location.href=histroy.back();
	</script>
<%	} %>