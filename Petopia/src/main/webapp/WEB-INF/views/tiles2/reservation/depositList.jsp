<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<style>


</style>
<script type="text/javascript">
	$(document).ready(function(){
		
	});
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	$("#all").click(function(){
		$.getJSON("<%= ctxPath %>/depositHistoryAll.pet", function(json){
			var html = "";
			$.each(json, function(entryIndex, entry){
				html += "<tr><td>"+entry.deposit_UID+"</td>"+
						"<td>"+entry.depositcoin+"</td>"+
						"<td>"+entry.deposit_date+"</td>"+
						"<td>"+entry.showDepositStatus+"</td>"+
						"<td>";
				if(entry.deposit_status=="1"){
					html += "<button type='button' class='btn btn-default' onClick='goCancleDeposit("+entry.deposit_UID+");'>"+충전취소+"</button>";
				}
				else if(entry.deposit_status=="2"){
					html += "<button type='button' class='btn btn-default' onClick='javascript:location.href=/reservationView.pet?payment_UID="+entry.fk_payment_UID+"'>"+예약상세+"</button>";
				}
				else if(entry.deposit_status=="3"){
					html += "환불완료";
				}
				else if(entry.deposit_status=="4"){
					html += "출금완료";
				}
				html += "</td>";
				html += "<td></td></tr>";		
			}); // end of each
			$("#allContents").empty();
			$("#allContents").html(html);
		}); // end of ajax
		
	});
	
</script>	    
<div class="container" style="margin-bottom: 8%;">
	<div  style="margin-top: 8%;">
  		<h2>Deposit History</h2>
  		<p>예치금 사용내역을 확인할 수 있습니다.</p>
	</div>
  <ul class="nav nav-tabs">
    <li class="active"><a data-toggle="tab" id="all" href="#home">전체</a></li>
    <li><a data-toggle="tab" id="charged" href="#menu1">충전내역</a></li>
    <li><a data-toggle="tab" id="used" href="#menu2">사용내역</a></li>
  </ul>

  <div class="tab-content">
    <div id="home" class="tab-pane fade in active">
      <h3>전체 사용 내역</h3>
      	<div class="table-responsive">
      	<table class="table">
      		<thead>
      		<tr>
      			<th>NO</th>
      			<th>금액</th>
      			<th>충전/사용일</th>
      			<th>상태</th>
      			<th>변경</th>
      			<th>비고</th>
      		</tr>
      		</thead>
      		<tbody id="allContents">
      		</tbody>
      	</table>
      	<div id="pageBarAll"></div>
      	</div>
    </div>
    <div id="menu1" class="tab-pane fade">
      <h3>충전내역</h3>
      <div class="table-responsive">
      	<table class="table">
      		<thead>
      		<tr>
      			<th>NO</th>
      			<th>금액</th>
      			<th>충전일</th>
      			<th>취소/환불</th>
      			<th>비고</th>
      		</tr>
      		</thead>
      		<tbody id="chargedContents">
      		</tbody>
      	</table>
      	<div id="pageBarCharged"></div>
      	</div>
    </div>
    <div id="menu2" class="tab-pane fade">
      <h3>사용내역</h3>
      <div class="table-responsive">
      	<table class="table">
      		<thead>
      		<tr>
      			<th>NO</th>
      			<th>금액</th>
      			<th>사용일</th>
      			<th>예약상태</th>
      			<th>비고</th>
      		</tr>
      		</thead>
      		<tbody id="usedContents">
      		</tbody>
      	</table>
      	<div id="pageBarUsed"></div>
      	</div>
    </div>
  </div>
</div>