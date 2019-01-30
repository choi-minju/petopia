<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String ctxPath = request.getContextPath();%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/jquery-ui-1.11.4.custom/jquery-ui.js"></script>

<style>
 .span{
	padding-left:5%;
	padding-top: 2%;
	font-weight: bold;
  } 
  .span input  {
   font-weight: normal;
  }
  .btn1{
  
  }
</style>
<script type="text/javascript">
    
	$(document).ready(function(){
		
		$("#register").click(function(){
			var frm = document.chartFrm;
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
		});  // 합계버튼 
		//0130 스피너  추가복용약 
		$("#spinnerOqty1").spinner({
	  	      spin: function( event, ui ) {
	  	        if( ui.value > 10 ) {
	  	          $( this ).spinner( "value", 0 ); 
	  	          return false;
	  	        } 
	  	        else if ( ui.value < 0 ) {
	  	          $( this ).spinner( "value", 10 );
	  	          return false;
	  	        }
	  	      }
	  	    });
		
		$("#spinnerOqty1").bind("spinstop", function(){
			
			var html = "<div class='span col-md-8'>추가 처방 약 정보</div>";
			
			var spinnerOqtyVal = $("#spinnerOqty1").val();
			
			if(spinnerOqtyVal == "0") {
				$("#textbox1").empty();
				return;
			}
			else
			{
				for(var i=0; i<parseInt(spinnerOqtyVal); i++) {
					html +='<div style="margin-bottom:3%;"> <div class="span col-md-6">-처방 약 이름 : <input type="text" name="rx_name"/></div>'+    
					   '<div class="span col-md-12">-투약 량 : <input type="text" name="dosage"/></div>'+
					   '<div  class="span col-md-12">-하루 복용 횟수 :<input type="text" name="dose_number"/></div></div>';
					  
				}
				
				$("#textbox1").empty();
				$("#textbox1").append(html);	
			}
		});
		
	});// end of $(document).ready()----------------------
</script>
<div class="container"> 
<Form name="chartFrm" 
  style="margin-left:18%; border:0px solid black;border-radius:10px;width:70%; background-color: #eaebed">
<div class="row">  
   
   <div class="col-md-12 ">
   <h4 style="text-align:center; padding-top: 6%;">[ ${chartmap.pet_name} ] 님의 진료기록</h4>
   <div class="span col-md-12">1.날짜: <span>${chartmap.reservation_DATE}</span></div>
   <div class="span col-md-12" >2.병원 이름: <span>${sessionScope.loginuser.name}</span></div>
   <div class="span col-md-12" >3.담당의사 이름: 
     <select id="docname" name="doc_name" style="font-weight: normal;">
	     <c:forEach var="map" items="${doclist}">
	       <option value="${map.DOCNAME}">${map.DOCNAME}</option>
	      </c:forEach>
     </select>
   </div>
   <div class="span col-md-12">4.진료 회원 이름: <span>${chartmap.name}</span></div>
   <div class="span col-md-12">5.진료 동물 종류: <span>${chartmap.pet_type}</span></div>
   <div class="span col-md-12">6.진료 동물 이름: <span>${chartmap.pet_name}</span></div>
   <div class="span col-md-12">7.진료종류: <span>${chartmap.reservation_type}</span></div>
   <div class="span col-md-6">8.처방 약 이름 : <input type="text" name="rx_name"/></div>    
   <div class="span col-md-3" >
    <input id="spinnerOqty1" value="0" style="width: 30px; height: 20px; padding-top: 5%;">
   </div>
   <div class="span col-md-12">9.투약 량 : <input type="text" name="dosage"/></div>
   <div  class="span col-md-12">10.하루 복용 횟수 :<input type="text" name="dose_number"/></div> 
   <div id="textbox1"></div>
   <div class="span col-md-12">11.주의 사항: </div>
   <div class="span col-md-12"><textarea  name="cautions" style="width:50%; height:15%;"></textarea></div>
   <div class="span col-md-12">12.노트 : </div>
   <div class="span col-md-12"><textarea  name="chart_contents" style="width:50%; height:15%;"></textarea></div>
   
	<hr style="width:100%; height:3%; color:white;"></hr>
	<div class="span col-md-8 ">13.사용한 예치금 : <span id="pament_pay"> ${chartmap.payment_pay}원 </span></div>
	<div class="span col-md-8 ">14.사용한 포인트 : <span id="payment_point">${chartmap.payment_point} POINT</span></div>
	<div class="span col-md-8 ">15.본인 부담금 :   <span> <input type="number"  id="addpay" name="addpay"/>원</span>
	 <button type="button" id="btnplus">총합</button></div>
	<div class="span col-md-8 ">16.총     합 : <span id="paytotal"></span>원</div>
   
   </div>
    <button type="button" id="register" class="btn1" style="margin-left: 42%; margin-top: 4%;margin-bottom:2%;
       background-color:rgb(252, 118, 106);color:white;width:20%;height:5%;border-radius:4px;">등록하기</button> 
</div>
<input type="text" name="fk_reservation_UID" value="${chartmap.fk_reservation_UID}"/>
<input type="text" name="fk_pet_UID" value="${chartmap.fk_pet_UID}"/>
<input type="text" name="fk_idx" value="${chartmap.fk_idx}"/>
<input type="text" name="fk_idx_biz" value="${chartmap.fk_idx_biz}"/>
<input type="text" name="chart_UID" value="${chart_UID}"/>
<input type="text" name="chart_type" value="${chartmap.reservation_type}"/>
<input type="text" name="bookingdate" value="${chartmap.bookingdate}"/>
<input type="text" name="reservation_DATE" value="${chartmap.reservation_DATE}"/>
<input type="text" name="biz_name" value="${sessionScope.loginuser.name}"/>
<input type="text" name="name" value="${chartmap.name}"/>
<input type="text" name="pet_type" value="${chartmap.pet_type}"/>
<input type="text" name="pet_name" value="${chartmap.pet_name}"/>
<input type="text" name="reservation_type" value="${chartmap.reservation_type}"/>
<input type="text" name="payment_pay" id="payment_pay"    value="${chartmap.payment_pay}"/>
<input type="text" name="payment_point" id="payment_point"  value="${chartmap.payment_point}"/>
<input type="text" name="totalpay" id="totalpay" value=""/>
<input type="text" name="rx_regName" value="${sessionScope.loginuser.name}"/> 


</Form>
</div>