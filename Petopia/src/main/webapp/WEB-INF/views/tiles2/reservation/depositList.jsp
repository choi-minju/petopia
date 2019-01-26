<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<%-- [190126] 일반회원 예치금 목록 --%>
<script type="text/javascript">
	$(document).ready(function(){
		all("1");
		
		$("#all").click(function(){
			all("1");
		});
		
		$("#charged").click(function(){
			charged("1");
		});
		
		$("#used").click(function(){
			charged("1");
		});
		
	});
	
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	function all(currentShowPageNo){
		var form_data = {"currentShowPageNo":currentShowPageNo
						, "type": "-1"};
		
		$.ajax({
			url: "<%= ctxPath %>/depositHistory.pet",
			data: form_data,
			type: "GET",
			dataType: "JSON",
			success : function(json){
				var html = "";
				$.each(json, function(entryIndex, entry){
					html += "<tr><td>"+entry.deposit_UID+"</td>"+
							"<td>"+entry.depositcoin+"</td>"+
							"<td>"+entry.deposit_date+"</td>"+
							"<td>"+entry.showDepositStatus+"</td>"+
							"<td>";
					if(entry.deposit_status=="1"){
						html += "<button type='button' class='btn btn-default' onClick='goCancleDeposit("+entry.deposit_UID+");'>충전취소</button>";
					}
					else if(entry.deposit_status=="2"){
						html += "<button type='button' class='btn btn-default' onClick='javascript:location.href=/reservationView.pet?payment_UID="+entry.fk_payment_UID+"'>예약상세</button>";
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
				$("#allContents").empty().html(html);
				makePageBar(currentShowPageNo, "-1");

			},
			error: function(request, status, error){
				if(request.readyState == 0 || request.status == 0) return;
				else alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}

		}); // end of ajax
	}
	
	
	function charged(currentShowPageNo){
		var form_data = {"currentShowPageNo":currentShowPageNo
						, "type": "1"};
		
		$.ajax({
			url: "<%= ctxPath %>/depositHistory.pet",
			data: form_data,
			type: "GET",
			dataType: "JSON",
			success : function(json){
				var html = "";
				$.each(json, function(entryIndex, entry){
					html += "<tr><td>"+entry.deposit_UID+"</td>"+
							"<td>"+entry.depositcoin+"</td>"+
							"<td>"+entry.deposit_date+"</td>"+
							"<td>";
					if(entry.deposit_status=="1"){
						html += "<button type='button' class='btn btn-default' onClick='goCancleDeposit("+entry.deposit_UID+");'>충전취소</button>";
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
				$("#chargedContents").empty().html(html);
				makePageBar(currentShowPageNo, "1");

			},
			error: function(request, status, error){
				if(request.readyState == 0 || request.status == 0) return;
				else alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}

		}); // end of ajax
	}
	

	function used(currentShowPageNo){
		var form_data = {"currentShowPageNo":currentShowPageNo
						, "type": "2"};
		
		$.ajax({
			url: "<%= ctxPath %>/depositHistory.pet",
			data: form_data,
			type: "GET",
			dataType: "JSON",
			success : function(json){
				var html = "";
				$.each(json, function(entryIndex, entry){
					html += "<tr><td>"+entry.deposit_UID+"</td>"+
							"<td>"+entry.depositcoin+"</td>"+
							"<td>"+entry.deposit_date+"</td>"+
							"<td>"+
							"<button type='button' class='btn btn-default' onClick='javascript:location.href=/reservationView.pet?payment_UID="+entry.fk_payment_UID+"'>예약상세</button>"+
							"</td><td></td></tr>";		
				}); // end of each
				$("#usedContents").empty().html(html);
				makePageBar(currentShowPageNo, "2");

			},
			error: function(request, status, error){
				if(request.readyState == 0 || request.status == 0) return;
				else alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}

		}); // end of ajax
	}
	
	function makePageBar(currentShowPageNo, type){
		var form_data = {sizePerPage:"5",
						type: type};
		$.ajax({
			url: "<%= request.getContextPath()%>/depositHistoryPageBar.pet",
			data: form_data,
			type:"GET",
			dataType:"JSON",
			success: function(json){
				
				if(json.totalPage > 0){
					var totalPage = json.totalPage;
					var pageBarHTML = "";
					var blockSize = 10;
					
					var loop = 1; 
					
					var pageNo = Math.floor((currentShowPageNo-1)/blockSize)*blockSize+1;
					if(json.type==-1){
						if( pageNo!= 1){
							pageBarHTML += "&nbsp;<a href='javascript:all(\""+(pageNo-1)+"\");'>[이전]</a>&nbsp;";
						}
						while(!(loop>blockSize || pageNo > totalPage)){
							if(pageNo == currentShowPageNo){
								pageBarHTML += "&nbsp;<span style='font-weight: bold; text-decoration:underline; color: maroon;'>"+pageNo+"</span>&nbsp;";
							}
							else{
								pageBarHTML += "&nbsp;<a href='javascript:all(\""+pageNo+"\");'>"+pageNo+"</a>&nbsp;";
							}
							
							loop++;
							pageNo++;
						}
						
						if( !(pageNo>totalPage)){
							pageBarHTML += "&nbsp;<a href='javascript:all(\""+pageNo+"\");'>[다음]</a>&nbsp;";
						}
						
						$("#pageBarAll").empty().html(pageBarHTML);
					}
					else if(json.type==1){
						if(pageNo!= 1){
							pageBarHTML += "&nbsp;<a href='javascript:charged(\""+(pageNo-1)+"\");'>[이전]</a>&nbsp;";
						}
						while(!(loop>blockSize || pageNo > totalPage)){
							if(pageNo == currentShowPageNo){
								pageBarHTML += "&nbsp;<span style='font-weight: bold; text-decoration:underline; color: maroon;'>"+pageNo+"</span>&nbsp;";
							}
							else{
								pageBarHTML += "&nbsp;<a href='javascript:charged(\""+pageNo+"\");'>"+pageNo+"</a>&nbsp;";
							}
							
							loop++;
							pageNo++;
						}
						
						if( !(pageNo>totalPage)){
							pageBarHTML += "&nbsp;<a href='javascript:charged(\""+pageNo+"\");'>[다음]</a>&nbsp;";
						}
						
						$("#pageBarCharged").empty().html(pageBarHTML);
					}
					else if(json.type==2){
						if( pageNo!= 1){
							pageBarHTML += "&nbsp;<a href='javascript:used(\""+(pageNo-1)+"\");'>[이전]</a>&nbsp;";
						}
						while(!(loop>blockSize || pageNo > totalPage)){
							if(pageNo == currentShowPageNo){
								pageBarHTML += "&nbsp;<span style='font-weight: bold; text-decoration:underline; color: maroon;'>"+pageNo+"</span>&nbsp;";
							}
							else{
								pageBarHTML += "&nbsp;<a href='javascript:used(\""+pageNo+"\");'>"+pageNo+"</a>&nbsp;";
							}
							
							loop++;
							pageNo++;
						}
						if( !(pageNo>totalPage)){
							pageBarHTML += "&nbsp;<a href='javascript:used(\""+pageNo+"\");'>[다음]</a>&nbsp;";
						}
						$("#pageBarUsed").empty().html(pageBarHTML);
					}
					
				}
				else{
					if(json.type==-1){
						$("#pageBarAll").empty();
					}
					else if(json.type==1){
						$("#pageBarCharged").empty();
					}
					else if(json.type==2){
						$("#pageBarUsed").empty();
					}
					pageBarHTML = "";
				}
			},
			error: function(request, status, error){
				if(request.readyState == 0 || request.status == 0) return;
				else alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		});
		
	} // end of makeCommentPageBar

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
      	<div id="pageBarAll" class="text-center"></div>
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
      	<div id="pageBarCharged" class="text-center"></div>
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
      	<div id="pageBarUsed" class="text-center"></div>
      	</div>
    </div>
  </div>
</div>