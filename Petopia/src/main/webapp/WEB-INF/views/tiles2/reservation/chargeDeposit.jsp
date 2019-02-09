<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예치금 충전하기</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" defer="defer"></script> 
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.1/moment.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<style>
body { 
  margin: 0;
  font-family: Montserrat, Arial, Helvetica, sans-serif;

}
.deposit-header {
  padding: 2px 16px;
  background-color: #ff6e60;
  color: white;
  position: fixed;
  top: 0;
  z-index: 1;
  width: 100%;
}

.deposit-body {
	padding: 2px 16px;
	height: 450px;
	padding: 100px 0;
	margin: 50px auto 0 auto;
	width: 80%;

}

.deposit-footer {
  padding: 2px 16px;
  background-color: #ff6e60;
  color: white;
}

.subject{
	font-weight: bold;
	font-size: 12pt;
	border-radius: 3%;
	border-bottom: 1px solid #ff6e60;
	width: 15%;
	margin-bottom: 5%;
}
.underline {
	border-bottom: 1px solid #ff6e60;
}
.progress-container {
  width: 100%;
  height: 8px;
  background: #ff6e60;
}

.progress-bar {
  height: 8px;
  background: white;
  width: 0%;
}
label {
	font-weight: normal;
}

.btn-rounder {
	width: 80px;
	font-size: 15px;
	color: white;
	text-align: center;
	background: rgb(252, 118, 106);
	border-radius: 30px;
}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		
		
	});
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	function goPay(){
		
	}
	
</script>

</head>


<body>
 <div class="deposit-header">
	<h2>Charge for Deposit Coin</h2>
    <div class="progress-container">
    <div class="progress-bar" id="myBar"></div>
  </div> 
  </div>
  <div class="deposit-body">
   	<div class="row">
    	<div class="col-md-3">회원번호: ${idx}</div>
		<div class="col-md-3">예치금잔액: <fmt:formatNumber pattern="##,###">${depositAmount}</fmt:formatNumber>원</div>
   	</div>
   	<hr style="border-top: 0px solid gray;">
   	<div class="subject">충전금액</div>
   	<div class="row">
   		<div class="col-md-8">
    		<input type="radio" name="depositCoin" id="coin1" value="100000"/><label for="coin1">100000원</label>&nbsp;
    		<input type="radio" name="depositCoin" id="coin2" value="200000"/><label for="coin2">200000원</label>&nbsp;
    		<input type="radio" name="depositCoin" id="coin3" value="300000"/><label for="coin3">300000원</label>&nbsp;
    		<input type="radio" name="depositCoin" id="coin4" value="400000"/><label for="coin4">400000원</label>&nbsp;
    		<input type="radio" name="depositCoin" id="coin5" value="500000"/><label for="coin5">500000원</label>
   		</div>
   	</div>
   	<hr style="border-top: 0px solid gray;">
   	<div class="subject">결제방식</div>
   	<div class="row">
   		<div class="col-md-8">
    		<button type="button" class="btn btn-rounder" value="card">카드결제</button>&nbsp;
    		<button type="button" class="btn btn-rounder" value="direct">무통장입금</button>
   		</div>
   	</div>
  </div>
  <div class="deposit-footer text-center">
      <button type="button" class="btn btn-default" onClick="goPay();">확인</button>
      <button type="button" class="btn btn-default" onClick="">취소</button>
  </div>
  
  <form name="chagePayFrm">
  	<input type="hidden" id="depositType" name="depositType"/>
  </form>
</body>

<script>
// When the user scrolls the page, execute myFunction 
window.onscroll = function() {myFunction()};

function myFunction() {
  var winScroll = document.body.scrollTop || document.documentElement.scrollTop;
  var height = document.documentElement.scrollHeight - document.documentElement.clientHeight;
  var scrolled = (winScroll / height) * 100;
  document.getElementById("myBar").style.width = scrolled + "%";
}
</script>
</html>