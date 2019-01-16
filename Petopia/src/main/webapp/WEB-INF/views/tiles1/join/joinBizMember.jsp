<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
   
	.btn1 {
	   width: 80px;
	   font-size:15px;
	   color: white;
	   text-align: center;
	   background: grey;
	   border: solid 0px grey;
	   border-radius: 30px;
	}
	
	.cancelbtn, .submitbtn {
		background-color: inherit;
		border: 1px;
	}
	
	.error {
		color: red;
		align-content: center;
	}
	
	#error_passwd { 
		color: red; 
		padding-left: 10px; 
		margin-bottom: 5px;
	}
	
</style>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script type="text/javascript">
   $(document).ready(function(){
	   
	   $(".error").hide();
	   $("#error_passwd").hide();
	   
	  /*  $(".requiredInfo").each(function(){			
			$(this).blur(function(){
				var data = $(this).val().trim();
				if(data.length == 0) {
					// 입력하지 않거f나 공백만 입력했을 경우
					// swal("입력하지 않거나 공백만 입력했을 경우");
								
					$(this).parent().find(".error").show();
					$(":input").attr("disabled",true);
					$("#btnRegister").attr("disabled",true); 
					$(this).attr("disabled",false);
				}
				else{
					// 공백이 아닌 글자를 입력한 경우
					// swal("공백이 아닌 글자를 입력한 경우");
					$(this).parent().find(".error").hide();
					$(":input").attr("disabled",false);
					$("#btnRegister").attr("disabled",false); 
				}
			});
			
		});// end of $(".requiredInfo").each()----------------	 */	
	   
	   
	   
       $(".upload-hidden").hide();
      
       $('.profile').css('height', $(".profile").width()-1);
       $('.radius-box').css('width', $(".profile").width());
       $('.radius-box').css('height', $(".radius-box").width()-1);
       
      $(window).resize(function() { 
         $('.profile').css('height', $(".profile").width());
         $('.radius-box').css('height', $(".profile").width());
         $('.radius-box').css('width', $(".profile").width());
       });
      
      // 수정해서 사용****************
      var imgTarget = $('.preview-image .upload-hidden'); 
      imgTarget.on('change', function(){ 
         var parent = $(this).parent(); 
         parent.children('.upload-display').remove(); 
         if(window.FileReader){ 
            //image 파일만
            if (!$(this)[0].files[0].type.match(/image\//)) return; 
            var reader = new FileReader(); 
            reader.onload = function(e){ 
               var src = e.target.result; parent.prepend('<div class="profile upload-display"><div class="upload-thumb-wrap"><img width="100%" src="'+src+'" class="upload-thumb radius-box"></div></div>'); 
            } 
            reader.readAsDataURL($(this)[0].files[0]); 
            
            $(".profile").css('background-color','#f2f2f2');
         }
      });
      
      
      $("#userid").blur(function(){			
			
    	  	var email = $(this).val();
			var regexp_email = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; 
	         // e메일을 검사해주는 정규표현식 객체 생성
			var bool = regexp_email.test(email);
    	  
			var idchk = $("#userid").val().trim();				
			$.ajax({							
				url: "idcheck.action",
				type: "GET",
				data : {userid:$("#userid").val()},
				dataType :"json",
				success : function(json){						
					if(json.cnt>0 || idchk.length == 0){								
						$("#iderror").show();
						$("#userid").val("");
						$("#userid").focus();
						$(":input").attr("disabled",false);
						$("#error_passwd").hide(); 			
						return;								
					}else{
						alert("사용 가능한 아이디입니다.");
						$("#iderror").hide();						
						$("#pwd").focus();
						flag=1;
					}						
				}								
			});	
			
			if(!bool) {
	        	$(this).parent().find(".error").show();
				$(":input").attr("disabled",true);
				$("#btnRegister").attr("disabled",true);
				
				$(this).attr("disabled",false);
	        } 
	        else {
	        	$(this).parent().find(".error").hide();
				$(":input").attr("disabled",false);
				$("#btnRegister").attr("disabled",false);
	        }
		});// end of $("#userid").blur(function()
				
		
		$("#pwd").blur(function() {
			
			
			var passwd = $(this).val();
			
			/* var regexp_pw = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;  */
			
			var regexp_passwd = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g); 
			/* 암호는 숫자,영문자,특수문자가 포함된 형태의 8~15글자 이하만 허락해주는 정규표현식 객체 생성 */
			
			var bool = regexp_passwd.test(passwd);
			/* 암호 정규표현식 검사를 하는 것 
			      정규표현식에 만족하면 리턴값은 true,
			      정규표현식에 틀리면 리턴값은 false */
			      
			if(!bool) {
				$("#error_passwd").show();
				$(":input").attr("disabled",true).addClass("bgcol");
				$("#btnRegister").attr("disabled",true); 
				$(this).attr("disabled",false).removeClass("bgcol");
			}   
			else {
				$("#error_passwd").hide();
				$(":input").attr("disabled",false).removeClass("bgcol");
				$("#btnRegister").attr("disabled",false); 
				$("#pwdcheck").focus();
			}
			
		});// end of $("#pwd").blur()-------------------
		
		$("#pwdcheck").blur(function(){
			var passwd = $("#pwd").val();
			var passwdCheck = $(this).val();
			
			if(passwd != passwdCheck) {
				$(this).parent().find(".error").show();
				$(":input").attr("disabled",true).addClass("bgcol");
				$("#btnRegister").attr("disabled",true);
				
			//	$("#pwd").attr("disabled",false).removeClass("bgcol");
				$(this).attr("disabled",false).removeClass("bgcol");
			}
			else {
				$(this).parent().find(".error").hide();
				$(":input").attr("disabled",false).removeClass("bgcol");
				$("#btnRegister").attr("disabled",false);
			}
			
		});// end of $("#pwdcheck").blur()--------------

      
      
      
      
      
      
   });// end of $(document).ready()----------------------
   
   
   <%-- 주소 --%>
   function sample6_execDaumPostcode() {
       new daum.Postcode({
           oncomplete: function(data) {
               // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

               // 각 주소의 노출 규칙에 따라 주소를 조합한다.
               // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
               var addr = ''; // 주소 변수
               var extraAddr = ''; // 참고항목 변수

               //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
               if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                   addr = data.roadAddress;
               } else { // 사용자가 지번 주소를 선택했을 경우(J)
                   addr = data.jibunAddress;
               }

               // 우편번호와 주소 정보를 해당 필드에 넣는다.
               document.getElementById('sample6_postcode').value = data.zonecode;
               document.getElementById("sample6_address").value = addr;
               // 커서를 상세주소 필드로 이동한다.
               document.getElementById("sample6_detailAddress").focus();
           }
       }).open();
   }
	
   <%-- 아이디체크 --%>
   function idCheck(){
		
		if(flag==0){
			$.ajax({					
				url: "<%=request.getContextPath()%>/idDuplicateCheck.aciton",
				type: "post",
				data : {userid:$("#userid").val()},
				dataType :"json",
				success : function(json){						
					if(json.cnt>0){							
						swal("사용 불가능한 아이디입니다.");	
						$("#userid").attr("disabled",false);
						flag=0;
						$("#userid").val("");
						//$(":input").attr("disabled",false);
						
						return;
					
					}else{
						swal("사용 가능한 아이디입니다.");
						flag =1;
					//	$("#pwd").focus();
					}						
				}								
			});		   			    	 
		}else{
			return;
		}
	}
   
   
   
   
   
   
</script>

<!-- ff6e60 -->


<div class="col-sm-12" style="margin-top: 8%; margin-bottom: 8%">
   <div class="col-sm-offset-2 col-sm-8" style="background-color: #f2f2f2;`">
      
      <div class="col-sm-12" align="center">
         <h2>기업회원 회원가입</h2>
      </div>
      <form name="joinFrm">
         <div class="col-sm-offset-2 col-sm-8 preview-image" style="margin-bottom: 15px;">
         <div class="row">
               <div class="col-sm-3">
                  <div class="profile" style="background-color: #d9d9d9; height: 150px; border-radius: 100%;" align="center">
                     <label for="input-file">프로필</label>
                     <input type="file" class="upload-hidden" id="input-file" name="profileimg"/>
                  </div>
               </div>
         
            <div class="row">
               <div class="col-sm-4" style="padding-top: 35px;">
                  <label style="color: #999;">ID(email)</label>
                  <input type="text" class="requiredInfo form-control" id="userid" name="userid" />
                  <span class="error" id="iderror">사용하실 수 없는 ID이거나 이메일 형식에 맞지 않습니다.</span>
               </div>
               <!-- <input type="button" id="idcheck" class="form-control" onclick="" value="중복확인" style=" width: 10%; margin-top: 54px; background-color: #ff6e60; color: white;"  > -->
            </div>
            
            <div class="row">
	            <div class="col-sm-4" style="padding-top: 35px;">
	                  <label style="color: #999;">password</label>
	                  <input type="password" class="requiredInfo form-control" id="pwd" name="pwd" />
	                  <span id="error_passwd">암호는 영문자,숫자,특수기호가 혼합된 8~15 글자로만 입력가능합니다.</span>
	            </div>
	            <div class="col-sm-4" style="padding-top: 35px;">
	                  <label style="color: #999;">password Check</label>
	                  <input type="password" class="requiredInfo form-control" id="pwdcheck" name="pwdcheck" />
	                  <span class="error">암호가 일치하지 않습니다.</span>
	            </div>
            </div>
            
            <div class="row" style="padding-top: 20px;" align="center">
               <div class="col-sm-3 text-left">
                  <label  style="color: #999;">병원/약국명</label>
                  <input type="text" class="requiredInfo form-control" id="bizname" name="bizname"/>
                  <span class="error">필수입력 사항입니다.</span>
               </div>
               <div class="col-xs-2 text-left">
                  <label style="color: #999;">대표자명</label>
                  <input type="text" class="requiredInfo form-control" id="ceoname" name="ceoname"/>
                  <span class="error">필수입력 사항입니다.</span>
	               </div>
               <div class="col-sm-3 text-left" style="width:18%;">
                  <label style="color: #999;">사업자번호</label>
                  <input type="text" class="requiredInfo form-control" id="biznumber" name="biznumber"/>
                  <span class="error">필수입력 사항입니다.</span>
               </div>
            </div>
            
            <div class="row" style="padding-top: 20px;" >
               <div class="col-sm-3">
                  <label style="color: #999;">대표 연락처</label>
                  <input type="text" class="requiredInfo form-control" id="ceonumber" name="ceonumber" style="width: 80%;"/>
                  <span class="error">필수입력 사항입니다.</span>
               </div>
            </div>
            
            <div class="row" style="padding-top: 20px;">
               <div class="col-sm-3" style="width: 15%;">
                  <label style="color: #999;">주소</label> 
                  <input type="text" class="requiredInfo form-control" id="sample6_postcode" placeholder="우편번호">
                  <span class="error">필수입력 사항입니다.</span>
               </div>
               	<input type="button" class="requiredInfo form-control" onclick="sample6_execDaumPostcode()" value="우편번호" style=" width: 10%; margin-top: 20px; background-color: #ff6e60; color: white;"  >
            </div>
            <div class="row">
               <div class="col-sm-6" style="padding-top: 5px;">
                  <input type="text" class="requiredInfo form-control" id="sample6_address" placeholder="주소">
               </div>
            </div>
            <div class="row">
               <div class="col-sm-6" style="padding-top: 5px;">
                  <input type="text" class="requiredInfo form-control" id="sample6_detailAddress" placeholder="상세주소">
               </div>
            </div>

            <div class="row" style="padding-top: 20px;">
               <div class="col-sm-6">
                  <label style="color: #999;">대표 이미지</label>
                  <input type="file" class="form-control" id="ceoimage" name="ceoimage"/>
               </div>
            </div>
            
            <div class="row" style="padding-top: 20px;">
               <div class="col-sm-6">
                  <label style="color: #999;">추가 이미지</label>
                  <input type="file" class="form-control" id="addimage" name="addimage"/>
               </div>
               <div style="margin-top:23px;">
               <button type="button"><span class="glyphicon glyphicon-plus"></span></button>
               </div>
            </div><!-- row -->
            
                 
            <div class="row" style="padding-top: 20px;">
	            <div class="col-sm-6">
	            <label style="color: #999;">진료시간(운영시간)</label><BR>
	               <div class="col-sm-4" style="padding-left: 0px;">
	                  <select class="requiredInfo form-control">
	                  <option selected="selected" value="">평일</option>
	                  <option value="">월~금(주 5)</option>
	                  <option value="">화~금(주 4)</option>
	                  <option value="">월,수,금(주 3)</option>
	                  </select>
	               </div>
	               
	               <div class="col-sm-4" style="padding-right: 0px;">
	               		<input type="time" class="requiredInfo form-control" >
	               </div>
	               <div class="col-sm-4" style="padding-right: 0px;">
	               		<input type="time" class="requiredInfo form-control">
	               </div>
	            </div>
               
               <div class="col-sm-6">
	               <div class="col-sm-12" style="margin-left: 12%;">
	               <label style="color: #999;">일요일/공휴일</label>
	               		<input type="text" class="requiredInfo form-control" >
	               </div>
               </div>
            </div><!-- row -->
            
            
            <div class="row" style="padding-top: 20px;">
               <div class="col-sm-3" style="padding-right: 0px; width: 18%;">
                  <label style="color: #999;">점심시간</label>
                  <input type="time" class="requiredInfo form-control">
               </div>
               
               <div class="col-sm-3" style="padding-right: 0px; width: 18%;">
               		<input type="time" class="requiredInfo form-control" style="margin-top: 20px;">
               </div>
               	
               <div class="col-sm-3" style="padding-right: 0px; width: 18%;">
               <label style="color: #999;">토요일</label>
               		<input type="time" class="requiredInfo form-control">
               </div>
               
               <div class="col-sm-3" style="padding-right: 0px; width: 18%;">
               		<input type="time" class="requiredInfo form-control" style="margin-top: 20px;">
               </div>
            </div><!-- row -->
            
            <div class="row" style="padding-top: 20px;">
               <div class="col-sm-6">
                  <label style="color: #999;">특이사항</label>
                  <input type="text" class="requiredInfo form-control" id="birthday" name="birthday"/>
               </div>
            </div>
            
            <div class="row" style="padding-top: 20px;">
               <div class="col-sm-6">
                  <label style="color: #999;">진료/처방 가능 동물군 (다중 선택 가능)</label><br/>
                  <div style="margin-top: 10px;">
	                  <button type="button" class="btn1">강아지</button>
	                  <button type="button" class="btn1">고양이</button>
	                  <button type="button" class="btn1">소동물</button>
	                  <button type="button" class="btn1">기타</button>
                  </div>
               </div>
            </div>
            
            <div class="row" style="padding-top: 20px;">
               <div class="col-sm-3">
                  <label style="color: #999;">의료진 소개</label><br/>
                  <label style="color: #999;">(성함 및 직책병기)</label>
                  <input type="text" class="requiredInfo form-control" id="birthday" name="birthday" style="width: 100%"/>
               </div>
                <div style="margin-top: 45px;">
	                  <button type="button" class="btn1">강아지</button>
	                  <button type="button" class="btn1">고양이</button>
	                  <button type="button" class="btn1">소동물</button>
                </div>
            </div>
            <div class="row">
               <div class="col-sm-3" style="margin-top: 2%;">
                  <input type="text" class="requiredInfo form-control" id="birthday" name="birthday" style="width: 100%"/>
               </div >
                <div style="margin-top: 20px;">
	                  <button type="button" class="btn1">강아지</button>
	                  <button type="button" class="btn1">고양이</button>
	                  <button type="button" class="btn1">소동물</button>
                </div>
            </div>
            
            <div class="row tagList1" style="margin-top: 3%;">
               <div class="col-sm-2">
                  <label style="color: #999;">시설상태</label>
               </div>
               <div class="col-sm-10">
                  <input type="checkbox" class="" id="tag1" name="tag" value="깨끗함"/> <label style="color: #999;" for="tag1">#깨끗함</label>
                  <input type="checkbox" class="" id="tag2" name="tag" value="세련됨"/> <label style="color: #999;" for="tag2">#세련됨</label>
                  <input type="checkbox" class="" id="tag3" name="tag" value="동물친화적"/> <label style="color: #999;" for="tag3">#동물친화적</label>
                  <input type="checkbox" class="" id="tag4" name="tag" value="대형병원"/> <label style="color: #999;" for="tag4">#대형병원</label>
                  <input type="checkbox" class="" id="tag5" name="tag" value="종합병원"/> <label style="color: #999;" for="tag5">#종합병원</label>
                  <input type="checkbox" class="" id="tag6" name="tag" value="편안한"/> <label style="color: #999;" for="tag6">#편안한</label>
               </div>
            </div>
            
            <div class="row tagList2" style="margin-top: 3%;">
               <div class="col-sm-2">
                  <label style="color: #999;">서비스</label>
               </div>
               <div class="col-sm-10">
                  <input type="checkbox" class="" id="tag7" name="tag" value="친절한"/> <label style="color: #999;" for="tag7">#친절한</label>
                  <input type="checkbox" class="" id="tag8" name="tag" value="친절한"/> <label style="color: #999;" for="tag8">#세심한</label>
                  <input type="checkbox" class="" id="tag9" name="tag" value="친절한"/> <label style="color: #999;" for="tag9">#잘봐주는</label>
               </div>
            </div><!-- 이 외의 것은 DB 연결후에 하기!!! -->
            
            <div class="row" align="center" style="margin-top: 3%;">
               <input type="checkbox" class="requiredInfo" id="agree" name="agree"/> <label style="color: #999;" for="agree">서비스 이용 및 약관에 동의합니다.</label>
            </div>
         </div>
         
            <hr style="height: 1px; background-color: white; border: none; margin-bottom: 0px;">
            <div class="row">
	            <div class="col-sm-6">
	            <button type="button" class="cancelbtn" style="width: 100%; height: 60px;">CANCEL</button>
	            </div>
	            <div class="col-sm-6">
	            <button type="button" class="submitbtn" id="btnRegister" onClick="goRegister(event);" style="width: 100%; height: 60px;">SUBMIT</button>
	            </div>
            </div>
         </div>
      </form>
   </div>
</div>