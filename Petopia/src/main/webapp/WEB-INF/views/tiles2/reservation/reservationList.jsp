<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<style> 
.search {
  width: 130px;
  box-sizing: border-box;
  border: 2px solid #ccc;
  border-radius: 4px;
  font-size: 16px;
  background-color: white;
  background-position: 10px 10px; 
  background-repeat: no-repeat;
  padding: 12px 20px 12px 12px;
  -webkit-transition: width 0.4s ease-in-out;
  transition: width 0.4s ease-in-out;
}

.search:focus {
  width: 100%;
}
td{
	text-align: center;
	font-size: 13px;
}
th{
	text-align: center;
	font-size: 15px;
}
</style>
<script type="text/javascript">
	function goPaymentDeposit(reservation_UID, fk_idx){
		window.location.href="<%=ctxPath%>/goPayDeposit.pet?fk_reservation_UID="+reservation_UID+"&fk_idx="+fk_idx;
	}

</script>
<div class="container">
  <h2>Reservatil List</h2>
  <p>예약내역을 확인할 수 있습니다.</p>  
  <i class="glyphicon glyphicon-search"></i><input class="form-control search" id="myInput" type="text" name="search" placeholder="Search..">
  <br>
  <table class="table table-bordered table-striped">
    <thead>
      <tr>
        <th>예약번호</th>
        <th>병원명</th>
        <th>연락처</th>
        <th>진료과</th>
        <th>반려동물명</th>
        <th>진료타입</th>
        <th>진료일시</th>
        <th>예약일시</th>
        <th>예약상태</th>
        <th>취소</th>
      </tr>
    </thead>
    <tbody id="myTable">
      <c:forEach var="rmap" items="${reservationList}">
      <tr>
		<td>${rmap.reservation_UID}</td>
        <td>${rmap.biz_name}</td>
        <td>${rmap.phone}</td>
        <td>${rmap.pet_type}</td>
        <td>${rmap.pet_name}</td>
        <td>${rmap.reservation_type}</td>
        <td>${rmap.reservation_DATE}</td>
        <td>${rmap.bookingdate}</td>
        <td>
        <c:if test="${rmap.reservation_status=='1'}">
        	<button type="button" class="btn btn-rounder btnmenu" onClick="goPaymentDeposit(${rmap.reservation_UID}, ${rmap.fk_idx})">결제하기</button>
        </c:if>
        <c:if test="${rmap.reservation_status!='1'}">
        	${rmap.rv_status}
        </c:if>
        </td>
        <td>
        	<c:if test="${rmap.reservation_status=='1'|| rmap.reservation_status=='2'}">
        	<button type="button" class="btn btn-rounder btnmenu" onClick="goRsvCancle(${rmap.reservation_UID})">취소</button>
        	</c:if>
        	<c:if test="${rmap.reservation_status=='3' || rmap.reservation_status=='4' || rmap.reservation_status=='5'}">
        	<a class="btn btn-rounder btnmenu" style="color: white; background-color: gray; cursor: default;">취소</a>
        	</c:if>
        </td>
      </tr>
	  </c:forEach>
    </tbody>
  </table>
  <div class="text-center">${pageBar}</div>
  <p>Note that we start the search in tbody, to prevent filtering the table headers.</p>
</div>


<script type="text/javascript">
$(document).ready(function(){
  $("#myInput").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });
});
</script>