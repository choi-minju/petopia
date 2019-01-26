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
			$("#totalpay").val(sum);
		});
	});// end of $(document).ready()----------------------
</script>
<div class="container"> 
<Form name="prescriptFrm" 
  style="margin-left:18%; border:0px solid black;border-radius:10px;width:70%; background-color: #eaebed">
<div class="row">  
   
   <div class="col-md-12 ">
   <h4 style="text-align:center; padding-top: 6%;">[ ${chartmap.pet_name} ] 님의 진료기록</h4>
   <div class="span col-md-12">1.날짜: <span>${chartmap.reservation_DATE}</span></div>
   <div class="span col-md-12" >2.병원 이름: <span>${sessionScope.loginuser.name}</span></div>
   <div class="span col-md-12" >3.담당의사 이름: 
     <select id="docname" name="doc_name">
	     <c:forEach var="map" items="${doclist}">
	       <option value="${map.DOCNAME}">${map.DOCNAME}</option>
	      </c:forEach>
     </select>
   </div>
   <div class="span col-md-12">3.진료 회원 이름: <span>${chartmap.name}</span></div>
   <div class="span col-md-12">4.진료 동물 종류: <span>${chartmap.pet_type}</span></div>
   <div class="span col-md-12">5.진료 동물 이름: <span>${chartmap.pet_name}</span></div>
   <div class="span col-md-12">6.진료종류: <span>${chartmap.reservation_type}</span></div>
   <div class="span col-md-12">7.투약 명 :  <input type="text" name="mname"/></div>
   <div class="span col-md-12">8.주의 사항: </div>
   <div class="span col-md-12"><textarea  name="cautions" style="width:50%; height:15%;"></textarea></div>
   <div class="span col-md-12">9.노트 : </div>
   <div class="span col-md-12"><textarea  name="chart_contents" style="width:50%; height:15%;"></textarea></div>
   
	<hr style="width:100%; height:3%; color:white;"></hr>
	<div class="span col-md-8 ">10.사용한 예치금 : <span id="pament_pay"> ${chartmap.payment_pay}원 </span></div>
	<div class="span col-md-8 ">11.사용한 포인트 : <span id="payment_point">${chartmap.payment_point} POINT</span></div>
	<div class="span col-md-8 ">12.본인 부담금 :   <span> <input type="number"  id="addpay" name="addpay"/>원</span>
	 <button type="button" id="btnplus">총합</button></div>
	<div class="span col-md-8 ">13.총     합 : <span id="paytotal"></span>원</div>
   
   </div>
    <button type="button" id="register" class="btn1" style="margin-left: 42%; margin-top: 4%;margin-bottom:2%;
       background-color:rgb(252, 118, 106);color:white;width:20%;height:5%;border-radius:4px;">등록하기</button> 
</div>
<input type="hidden" name="fk_pet_UID" value="${chartmap.fk_pet_UID}"/>
<input type="hidden" name="fk_idx" value="${chartmap.fk_idx}"/>
<input type="hidden" name="fk_idx_biz" value="${chartmap.fk_idx_biz}"/>
<input type="hidden" name="chart_type" value="${chartmap.reservation_type}"/>
<input type="hidden" name="bookingdate" value="${chartmap.bookingdate}"/>
<input type="hidden" name="reservation_DATE" value="${chartmap.reservation_DATE}"/>
<input type="hidden" name="biz_name" value="${sessionScope.loginuser.name}"/>
<input type="hidden" name="name" value="${chartmap.name}"/>
<input type="hidden" name="pet_type" value="${chartmap.pet_type}"/>
<input type="hidden" name="pet_name" value="${chartmap.pet_name}"/>
<input type="hidden" name="reservation_type" value="${chartmap.reservation_type}"/>
<input type="hidden" name="payment_pay" id="payment_pay"    value="${chartmap.payment_pay}"/>
<input type="hidden" name="payment_point" id="payment_point"  value="${chartmap.payment_point}"/>
<input type="hidden" name="totalpay" id="totalpay" value=""/>



</Form>
</div>