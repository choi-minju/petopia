<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<script type="text/javascript">
	$(document).ready(function(){
		
	});
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
</script>	    
<div class="container" style="margin-bottom: 8%;">
	<div  style="margin-top: 8%;">
  		<h2>Deposit History</h2>
  		<p>예치금 사용내역을 확인할 수 있습니다.</p>
	</div>
  <ul class="nav nav-tabs">
    <li class="active"><a data-toggle="tab" href="#home">전체</a></li>
    <li><a data-toggle="tab" href="#menu1">충전내역</a></li>
    <li><a data-toggle="tab" href="#menu2">사용내역</a></li>
  </ul>

  <div class="tab-content">
    <div id="home" class="tab-pane fade in active">
      <h3>전체 사용 내역</h3>
      	<div class="table-responsive">
      	<table class="table">
      		<tr>
      			<th>NO</th>
      			<th>금액</th>
      			<th>충전/사용일</th>
      			<th>변경</th>
      			<th>비고</th>
      		</tr>
      		<tr>
      			<td>1</td>
      			<td>100000</td>
      			<td>2019-01-24 15:50</td>
      			<td><button type="button" class="btn btn-default">취소신청</button></td>
      			<td>없음</td>
      		</tr>
      		<tr>
      			<td>1</td>
      			<td>100000</td>
      			<td>2019-01-24 15:50</td>
      			<td><button type="button" class="btn btn-default">예약상세</button></td>
      			<td>없음</td>
      		</tr>
      	</table>
      	</div>
    </div>
    <div id="menu1" class="tab-pane fade">
      <h3>충전내역</h3>
      <div class="table-responsive">
      	<table class="table">
      		<tr>
      			<th>NO</th>
      			<th>금액</th>
      			<th>충전/사용일</th>
      			<th>변경</th>
      			<th>비고</th>
      		</tr>
      		<tr>
      			<td>1</td>
      			<td>100000</td>
      			<td>2019-01-24 15:50</td>
      			<td><button type="button" class="btn btn-default">취소신청</button></td>
      			<td>없음</td>
      		</tr>
      		<tr>
      			<td>1</td>
      			<td>100000</td>
      			<td>2019-01-24 15:50</td>
      			<td><button type="button" class="btn btn-default">예약상세</button></td>
      			<td>없음</td>
      		</tr>
      	</table>
      	</div>
    </div>
    <div id="menu2" class="tab-pane fade">
      <h3>사용내역</h3>
      <div class="table-responsive">
      	<table class="table">
      		<tr>
      			<th>NO</th>
      			<th>금액</th>
      			<th>충전/사용일</th>
      			<th>변경</th>
      			<th>비고</th>
      		</tr>
      		<tr>
      			<td>1</td>
      			<td>100000</td>
      			<td>2019-01-24 15:50</td>
      			<td><button type="button" class="btn btn-default">취소신청</button></td>
      			<td>없음</td>
      		</tr>
      		<tr>
      			<td>1</td>
      			<td>100000</td>
      			<td>2019-01-24 15:50</td>
      			<td><button type="button" class="btn btn-default">예약상세</button></td>
      			<td>없음</td>
      		</tr>
      	</table>
      	</div>
    </div>
  </div>
</div>