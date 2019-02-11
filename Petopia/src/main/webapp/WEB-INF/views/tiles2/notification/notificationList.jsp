<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<style>
.notificationList {
					border-bottom: 1px solid #fc766b;
					background-color: ivory;
					padding: 1%;
					cursor: pointer;
					
					}
					
.notContent {
			 
			 }


</style>


<script type="text/javascript">

	$(document).ready(function(){

		showNotificationList();
		
		// 새로고침 이미지 넣어서 누를 때마다 ajax불러오게 할거임

	}); // end of $(document).ready()----------------------
	
	function showNotificationList(){
		
		$.ajax({
			url:"<%=ctxPath%>/notificationListAJAX.pet", 
			type:"GET",
			//data:form_data,
			dataType:"JSON",
			success:function(json){ 
				
				var html = "";
				
				if(json.length > 0){
					$.each(json, function(entryIndex, entry){
						if(entry)
						html += "<div class='row notificationList' onclick='location.href=\""+entry.NOT_URL+"\"'>"
							  + "<div class='col-xs-1 col-md-1 notContent'>"+entry.NOT_UID+"</div>"
							  + "<div class='col-xs-2 col-md-2 notContent'>["+entry.NOT_TYPE+"]</div>"
							  + "<div class='col-xs-7 col-md-7 notContent'>"+entry.NOT_MESSAGE+"</div>"
							  + "<div class='col-xs-1 col-md-1 notContent'>재알림</div>"
							  + "<div class='col-xs-1 col-md-1 notContent'>지우기</div>"
							  + "</div>";
					});
				}
				else{
					html += "<div>알림이 없습니다.</div>";
				}
				
				$("#notificationList").empty().html(html);
			},
			error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		
		}); // $.ajax({
	
	} // function showNotificationList(){
	

</script>

<div class="container" style="padding-top:8%; margin-bottom: 0.2%;">
	<h3 style="border:0.5px solid #fc766b; border-radius:3px; padding:1%;">NOTIFICATION LIST</h3>
	<div align="center">
		<div id="notificationList" style="width:90%; margin-top:5%; margin-bottom:5%; "></div>
	</div>
</div>