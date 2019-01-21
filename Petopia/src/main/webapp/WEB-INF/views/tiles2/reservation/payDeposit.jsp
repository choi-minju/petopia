<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.collapsible {
  background-color: #777;
  color: white;
  cursor: pointer;
  padding: 18px;
  width: 100%;
  border: none;
  text-align: left;
  outline: none;
  font-size: 15px;
}

.active, .collapsible:hover {
  background-color: #555;
}

.content {
  padding: 0 18px;
  max-height: 0;
  overflow: hidden;
  transition: max-height 0.2s ease-out;
  background-color: #f1f1f1;
}
.noneBorderText{
  padding: 3px;
  border: none;
  font-size: 13px;
  height: 13px; 
  border-bottom: 1px solid #A6A6A6;
} 
</style>
<div class="container">
	<div class="text-center">
	    <h2>Payment Deposits</h2>
	    <h4>예치금 결제</h4>
	</div>
	<form name="payDepositFrm">
	<button type="button" class="collapsible btn-default">Reservation Info</button>
	<div class="content">
	  <div class="row">
	   <div class="col-md-8 col-xs-12">
         <p>
         	<label class="label label-info"> 병원명 </label>&nbsp;&nbsp;&nbsp;
         	<span class="noneBorderText">${returnMap.biz_name}</span>
         	<input type="hidden"  name="fk_idx" value="${returnMap.fk_idx}"/>
         </p>
         <p>
         	<label class="label label-info"> 연락처 </label>&nbsp;&nbsp;&nbsp;
         	<span class="noneBorderText">${returnMap.phone}</span>
         	<input type="hidden"  value=""/>
         </p>
         <p>
         	<label class="label label-info"> 진료과 </label>&nbsp;&nbsp;&nbsp;
         	<span class="noneBorderText" id="mypetopt">${returnMap.pet_type}</span>
         	<input type="hidden" id="fk_pet_UID" name="fk_pet_UID" value="${returnMap.fk_pet_UID}"/>
         </p>
         <p>
         	<label class="label label-info">진료타입</label>&nbsp;
         	<span class="noneBorderText" id="mypetopt">${returnMap.reservation_type}</span>
         	<input type="hidden" id="reservation_type" name="reservation_type"/>
         </p>
         <p>
         	<label class="label label-info">반려동물</label>&nbsp;
         	<span class="noneBorderText" id="mypetopt">${returnMap.pet_name}</span>
         </p>
         <p>
         	<label class="label label-info"> 진료일 </label>&nbsp;&nbsp;&nbsp;
         	<span class="noneBorderText" id="schedule_date">${returnMap.reservation_DATE}</span>
         	<input type="hidden" name="fk_reservation_UID" value="${returnMap.reservation_UID}"/>
         </p>
	          
	     </div>
	   </div>
	</div>
	
	<button type="button" class="collapsible">Payment Info</button>
	<div class="content">
	   <div class="row">
	   <div class="col-md-8 col-xs-12">
         <p>
         	<label class="label label-warning"> 결제금액 </label>&nbsp;&nbsp;&nbsp;
         	<span class="noneBorderText">100,000원</span>
         	<input type="hidden"  name="payment_total" value="-100000"/>
         </p>
         <p>
         	<label class="label label-warning"> 예치금 잔액 </label>&nbsp;&nbsp;&nbsp;
         	<%-- <span class="noneBorderText"><fmt:formatNumber value="${depositAmount}" pattern="###,###"/>원</span> --%>
         	<input type="hidden" value=""/>
         </p>
         <p>
         	<label class="label label-warning"> 진료과 </label>&nbsp;&nbsp;&nbsp;
         	<span class="noneBorderText" id="mypetopt">${returnMap.pet_type}</span>
         	<input type="hidden" id="fk_pet_UID" name="fk_pet_UID" value="${returnMap.fk_pet_UID}"/>
         </p>
         <p>
         	<label class="label label-warnning">진료타입</label>&nbsp;
         	<span class="noneBorderText" id="mypetopt">${returnMap.reservation_type}</span>
         	<input type="hidden" id="reservation_type" name="reservation_type"/>
         </p>
         <p>
         	<label class="label label-info">반려동물</label>&nbsp;
         	<span class="noneBorderText" id="mypetopt">${returnMap.pet_name}</span>
         </p>
         <p>
         	<label class="label label-info"> 진료일 </label>&nbsp;&nbsp;&nbsp;
         	<span class="noneBorderText" id="schedule_date">${returnMap.reservation_DATE}</span>
         	<input type="hidden" name="fk_reservation_UID" value="${returnMap.reservation_UID}"/>
         </p>
	          
	     </div>
	   </div>
	</div>
	<button type="button" class="collapsible">Open Section 2</button>
	<div class="content">
	  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
	</div>
	<button type="button" class="collapsible">Open Section 3</button>
	<div class="content">
	  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
	</div>
	</form>
</div>
<script>
var coll = document.getElementsByClassName("collapsible");
var i;

for (i = 0; i < coll.length; i++) {
  coll[i].addEventListener("click", function() {
    this.classList.toggle("active");
    var content = this.nextElementSibling;
    if (content.style.maxHeight){
      content.style.maxHeight = null;
    } else {
      content.style.maxHeight = content.scrollHeight + "px";
    } 
  });
}
</script>