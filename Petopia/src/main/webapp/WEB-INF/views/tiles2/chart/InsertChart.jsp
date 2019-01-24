<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String ctxPath = request.getContextPath();%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<style>
 .span{
	padding-left:5%;
	padding-top: 2%;
  } 
  .btn1{
  
  }
</style>
<script type="text/javascript">
    
	$(document).ready(function(){
		
		$("#register").click(function(){
			var frm = document.prescriptFrm;
			frm.action="<%=ctxPath%>/InsertChartEnd.pet";
			frm.method="POST";
			frm.submit();
		});
		
		$("#btnplus").click(function(){
			var payment_pay =$("#payment_pay").val();
			var payment_point=$("#payment_point").val();
	
			var addpay=$("#addpay").val();
			
			var sum = addpay*1+payment_point*1+payment_pay*1;
			$("#paytotal").text(sum);
		});
	});// end of $(document).ready()----------------------
</script>
<div class="container"> 
<Form name="prescriptFrm" 
  style="margin-left:18%; border:0px solid black;border-radius:10px;width:70%; background-color: #eaebed">
<div class="row">  
   
   <div class="col-md-12 ">
   <h4 style="text-align:center; padding-top: 6%;">[ ${chartmap.pet_name} ] 님의 진료기록</h4>
   <div class="span col-md-12"><span>1.날짜: ${chartmap.reservation_DATE}</span></div>
   <div class="span col-md-12" ><span>2.병원 이름: ${sessionScope.loginuser.name }</span></div>
   <div class="span col-md-12" ><span>3.담당의사 이름: </span></div>
   <div class="span col-md-12"><span>3.진료 회원 이름: ${chartmap.name}</span></div>
   <div class="span col-md-12"><span>4.진료 동물 종류: ${chartmap.pet_type}</span></div>
   <div class="span col-md-12"><span>5.진료 동물 이름: ${chartmap.pet_name}</span></div>
   <div class="span col-md-12"><span>6.진료종류: ${chartmap.reservation_type}</span></div>
   <div class="span col-md-12"><span>7.투약 명 : </span><input type="text" name="mname"/></div>
   <div class="span col-md-12"><span>8.주의 사항:</span></div>
	<div class="span col-md-12"><textarea  name="caution" style="width:50%; height:15%;"></textarea></div>
	<div class="span col-md-12"><span>9.노트 : </span></div>
	<div class="span col-md-12"><textarea  name="note" style="width:50%; height:15%;"></textarea></div>
   
	<hr style="width:100%; height:3%; color:white;"></hr>
	<div class="span col-md-8 ">10.사용한 예치금 : <span id="pament_pay"> ${chartmap.payment_pay}원 </span></div>
	<div class="span col-md-8 ">11.사용한 포인트 : <span id="">${chartmap.payment_point} POINT</span></div>
	<div class="span col-md-8 ">12.본인 부담금 :   <span> <input type="number"  id="addpay" name="addpay"/>원</span>
	 <button type="button" id="btnplus">총합</button></div>
	<div class="span col-md-8 ">13.총     합 : <span id="paytotal"></span>원</div>
   
   </div>
    <button type="button" id="register" class="btn1" style="margin-left: 42%; margin-top: 4%;margin-bottom:2%;
       background-color:rgb(252, 118, 106);color:white;width:20%;height:5%;border-radius:4px;">등록하기</button> 
</div>
<input type="hidden" name="" value="${chartmap.pet_name}"/>
<input type="hidden" name="" value="${chartmap.reservation_DATE}"/>
<input type="hidden" name="" value="${chartmap.docname}"/>
<input type="hidden" name="" value="${chartmap.name}"/>
<input type="hidden" name="" value="${chartmap.pet_type}"/>
<input type="hidden" name="" value="${chartmap.pet_name}"/>
<input type="hidden" name="" value="${chartmap.reservation_type}"/>
<input type="hidden" name="payment_pay" id="payment_pay"    value="${chartmap.payment_pay}"/>
<input type="hidden" name="payment_point" id="payment_point"  value="${chartmap.payment_point}"/>
<input type="hidden" name="payment_total" id="payment_total" value="${chartmap.payment_total}"/>



</Form>
</div>