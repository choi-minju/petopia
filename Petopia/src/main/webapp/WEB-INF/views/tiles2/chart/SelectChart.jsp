<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String ctxPath = request.getContextPath();%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/jquery-ui-1.11.4.custom/jquery-ui.js"></script>

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
		
		//var dname=${cmap.doc_name} 
		//$("#docname").val(dname);
		
		$("#Edit").click(function(){
			var frm = document.chartFrm;
			frm.action="<%=ctxPath%>/EditChart.pet";
			frm.method="POST";
			frm.submit();
		});
		
		//0131 스피너  추가복용약 
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
   <h4 style="text-align:center; padding-top: 6%;">[ ${cmap.pet_name} ] 님의 진료기록</h4>
   <div class="span col-md-12">1.날짜: <span>${cmap.reservation_DATE}</span></div>
   <div class="span col-md-12" >2.병원 이름: <span>${sessionScope.loginuser.name}</span></div>
   <div class="span col-md-12" >3.담당의사 이름: 
     <select id="docname" name="doc_name" style="font-weight: normal;">
          <option value='' selected>${cmap.doc_name}</option>
          <option value=''>-- 선택 --</option>
	     <c:forEach var="map" items="${doclist}">
	       <option value="${map.DOCNAME}">${map.DOCNAME}</option>
	      </c:forEach>
     </select>
   </div>
   <div class="span col-md-12">4.진료 회원 이름: <span>${cmap.name}</span></div>
   <div class="span col-md-12">5.진료 동물 종류: <span>${cmap.pet_type}</span></div>
   <div class="span col-md-12">6.진료 동물 이름: <span>${cmap.pet_name}</span></div>
   <div class="span col-md-12">7.진료종류: <span>${cmap.reservation_type}</span></div>
    <div class="span col-md-8" >
	    <input id="spinnerOqty1" value="0" style="width: 30px; height: 20px; padding-top: 5%;">
   </div>
	   <c:forEach var="pmap" items="${pmap2list}">
		   <div class="span col-md-6">8.처방 약 이름 : <input type="text" name="rx_name" placeholder="${pmap.rx_name}"/></div>    
		   <div class="span col-md-12">9.투약 량 : <input type="text" name="dosage" placeholder="${pmap.dosage}"/></div>
		   <div class="span col-md-12">10.하루 복용 횟수 :<input type="text" name="dose_number" placeholder="${pmap.dose_number}"/></div> 
		   <div id="textbox1"></div> 
	   </c:forEach>
   <div class="span col-md-12">11.주의 사항: </div>
   <div class="span col-md-12"><textarea  name="cautions" style="width:50%; height:15%;" placeholder="${cmap.cautions}"></textarea></div>
   <div class="span col-md-12">12.노트 : </div>
   <div class="span col-md-12"><textarea  name="chart_contents" style="width:50%; height:15%;"placeholder="${cmap.chart_contents}"></textarea></div>
   
    <button type="button" id="Edit" class="btn1" style="margin-left: 42%; margin-top: 4%;margin-bottom:2%;
       background-color:rgb(252, 118, 106);color:white;width:20%;height:5%;border-radius:4px;">수정하기</button> 
</div>
</div>
 <input type="text" name="fk_pet_UID" value="${cmap.fk_pet_UID}"/>
<input type="text" name="fk_idx" value="${cmap.fk_idx}"/>
<input type="text" name="fk_idx_biz" value="${cmap.fk_idx_biz}"/>
<input type="text" name="chart_type" value="${cmap.reservation_type}"/>
<input type="text" name="bookingdate" value="${cmap.bookingdate}"/>
<input type="text" name="reservation_DATE" value="${cmap.reservation_DATE}"/>
<input type="text" name="biz_name" value="${sessionScope.loginuser.name}"/>
<input type="text" name="name" value="${cmap.name}"/>
<input type="text" name="pet_type" value="${cmap.pet_type}"/>
<input type="text" name="pet_name" value="${cmap.pet_name}"/>
<input type="text" name="reservation_type" value="${cmap.reservation_type}"/>
<input type="text" name="payment_pay" id="payment_pay"    value="${cmap.payment_pay}"/>
<input type="text" name="payment_point" id="payment_point"  value="${cmap.payment_point}"/>
<input type="text" name="totalpay" id="totalpay" value=""/> 


</Form>
</div>