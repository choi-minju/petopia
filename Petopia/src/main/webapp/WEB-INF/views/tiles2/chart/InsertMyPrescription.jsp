<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%String ctxPath = request.getContextPath();%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<%@page import="java.text.SimpleDateFormat"%>

<%@page import="java.util.Calendar"%>


<style>
body {
            scrollbar-face-color: #F6F6F6;

             scrollbar-highlight-color: #bbbbbb;

             scrollbar-3dlight-color: #FFFFFF;

             scrollbar-shadow-color: #bbbbbb;

             scrollbar-darkshadow-color: #FFFFFF;

             scrollbar-track-color: #FFFFFF;

             scrollbar-arrow-color: #bbbbbb;

             margin-left:"0px"; margin-right:"0px"; margin-top:"0px"; margin-bottom:"0px";

             }

             td {font-family: "돋움"; font-size: 9pt; color:#595959;}

             th {font-family: "돋움"; font-size: 9pt; color:#000000;}

             select {font-family: "돋움"; font-size: 9pt; color:#595959;}

             .divDotText {

             overflow:hidden;

             text-overflow:ellipsis;

             }

            A:link { font-size:9pt; font-family:"돋움";color:#000000; text-decoration:none; }

            A:visited { font-size:9pt; font-family:"돋움";color:#000000; text-decoration:none; }

            A:active { font-size:9pt; font-family:"돋움";color:red; text-decoration:none; }

            A:hover { font-size:9pt; font-family:"돋움";color:red;text-decoration:none;}

.divbox1{ /*전체 */
   margin-top: 3%;
   width:75%;
   background-color: #eaebed; 
   border: 0px solid gray;
   border-radius:10px;
   margin-bottom: 1%;
}

.divbox2{ /* 이미지 */
margin-top:3%;
display:inline-block;
}

.divbox3{ /* 펫정보*/
border: 1px solid gray; 
witdh:80%; 
height:20%; 
margin-top:3%;
padding-left:1%;
background-color:white;
padding-bottom:3%;
border-radius:10px;
}

.divbox4{ /* 캘린더 자리 */
 margin-top:3%;
 margin-bottom:5%;
 border: 1px solid gray;
 witdh:80%; 
 
 margin-top:3%;
 padding:3% 3% 3% 3%;
 border-radius:10px;
 background-color:white;
}

.divbox5{ /* 마지막 탭  */
background-color:white;
border: 1px solid gray;
border-top-style:none;
margin-top:5%;

padding-top:1%;
border-radius:10px; 
margin-bottom: 1%;
width:100%;

}
.btn2{
background-color:rgb(252, 118, 106);
color:white;
width:20%;
height:5%;
border-radius:15px;
margin-left: 38%;
margin-top: 1%;
margin-bottom: 2%;
}
.h3_1 {
margin-left: 1%;
margin-top:2%;
color:rgb(252, 118, 106);
}

.span{
	 
  } 

  body {
    margin: 0;
    padding: 0;
    font-size: 14px;
  }

  #top,
  #calendar.fc-unthemed {
    font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
  }

  #top {
    background: #eee;
    border-bottom: 1px solid #ddd;
    padding: 0 10px;
    line-height: 40px;
    font-size: 12px;
    color: #000;
  }

  #top .selector {
    display: inline-block;
    margin-right: 10px;
  }

  #top select {
    font: inherit;  /* mock what Boostrap does, don't compete  */
  }

  .left { float: left }
  .right { float: right }
  .clear { clear: both }

  #calendar {
    max-width: 100%;
    
    margin: 40px auto;
    padding: 2% 2% 2% 2%;
  }
  
</style>

<script type="text/javascript">
    
	$(document).ready(function(){
		//ajaxData();
		 $("#petimg").click(function(){
			 
		 });
		
		 $("#register").click(function(){
			 
			var frm=document.registerFrm;
			frm.addaction = "<%=ctxPath%>/InsertMyChartEnd.pet";
			frm.method="POST";
			frm.submit();
		 });
	});// end of $(document).ready()----------------------
	<!-- 0129-->
<%-- function getNextmon(){

	form_data={
			startDay:${paramap.startDay},
			endDay:${paramap.endDay},
			start:${paramap.start},
			todayCal:${paramap.todayCal},
			startDay:${paramap.startDay},
			sdf:${paramap.sdf},
			intToday:${paramap.intToday},	
			year:${paramap.year},
			month:${paramap.month},
			date:${paramap.date}
	}	
  $.ajax({
	  url="<%=ctxPath%>/getCalendar.pet",
	type="GET",
	data: form_data,
	dataType:JSON,
	success:function(json){
		var html1 =
			    "<table width='100%' border='0' cellspacing='0' cellpadding='0'>"+
	             "<tr>"+
	             "<td height='10'>"+
	              "</td></tr><tr>"+
	              "<td align='center'>"+
			      "<tr>"+
                  "<td align='center'>"+
                  "<a href='<c:url value=\'"+/getCalendar.pet+'/>?year='+json.year-1+'&amp;month='+json.month+'target='_self'>"+
                  "<b>&lt;&lt;</b>"+
                  "</a>";
                <c:if test="json.month > 0">
                  html1 += "<a href='<c:url value=\'"+/getCalendar.pet+'/>?year='+json.year+'&amp;month='+json.month-1+'target='_self''>"+
                         "<b>&lt;</b>"+"</a>";<!-- 이전달 -->
                </c:if>
                <c:if test="json.month < 0">
                     html1 += "<b>&lt;</b>&nbsp;&nbsp;";
                </c:if>
                   html1 +="<p>"+json.year+"년 </p>";
                   html1 +="<p>"+json.month+1 +"월</p> &nbsp;&nbsp;";

                <c:if test="json.month < 11">
	                html1 += "<a href='<c:url value=\'"+/getCalendar.pet+'/>?year='+json.year+'&amp;month='+json.month+1+'target='_self'>"+
	                         "<b>&gt;</b></a>";
	                 
	                 <c:if test="json.month > 11">
	                   html1 += "<a href='<c:url value=\'"+/getCalendar.pet+'/>?year='+json.year+1+'&amp;month='+json.month+'target='_self'>"+
	                            "<b>&gt;&gt;</b></a>";
	                 </c:if>
                    html1 +="</td></tr></table>";
                 </c:if>
              var html2 ="<TR bgcolor='#CECECE'>"+
                   "<TD width='100px'>"+
                   "<DIV align='center'>"+
                   "<font color='red'>일</font></DIV></TD>"+
                   "<TD width='100px'>"+
                   "<DIV align='center'>월</DIV></TD>"+
			        "<TD width='100px'>"+
			        "<DIV align='center'>화</DIV></TD>"+
			        "<TD width='100px'>"+
			        "<DIV align='center'>수</DIV></TD>"+
			        "<TD width='100px'>"+
			        "<DIV align='center'>목</DIV></TD>"+
			        "<TD width='100px'>"+
			        "<DIV align='center'>금</DIV></TD>"+
			        "<TD width='100px'>"+
			        "<DIV align='center'><font color='#529dbc'>토</font></DIV></TD></TR>";
            var html3="";
			for(int json.index = 1; json.index < json.start ; json.index++ ){
				  html3+="<TD >&nbsp;</TD>";
				  json.newLine++;
			     }
			for(int json.index = 1; json.index <= json.endDay; json.index++){
			       
		       String color = "";

		         if(json.newLine == 0){         
		        	   color = "RED";
                    }else if(json.newLine == 6){    
                    	color = "#529dbc";
                    }else{ 
                        color = "BLACK";}

		       String sUseDate = Integer.toString(json.year); 

		       sUseDate += Integer.toString(json.month+1).length() == 1 ? "0" + Integer.toString(json.month+1) : Integer.toString(json.month+1);

		       sUseDate += Integer.toString(json.index).length() == 1 ? "0" + Integer.toString(json.index) : Integer.toString(json.index);

		       int iUseDate = Integer.parseInt(sUseDate);

		       String backColor = "#EFEFEF";

		       if(iUseDate ==json.intToday ) {

		             backColor = "#c9c9c9";
		       } 
			   
		       html3=+"<TD valign='top' align='left' height='92px' bgcolor='"+backColor+"' nowrap>";

		      if(json.iUseDate == json.intToday ) {
		        	    backColor = "#c9c9c9";

		               } 
		           html3 +="<TD valign='top' align='left' height='92px' bgcolor='"+backColor+"' nowrap>"+
                           "<font color=json.paramap.color>"+json.index+"</font>";

                    html3 +="<BR>"+
                            "<p>"+json.iUseDate+"</p>"
                            "<BR>";
		               //기능 제거  
                    html3 +="</TD>";

		               json..newLine++;

		               if(json.newLine == 7){
		            	   html3 +="</TR>";
		                 if(json.index <= json.endDay)
		                 {
		                	html3 +="<TR>";
		                 }
		                 json.newLine=0;

		               }
		        }

		        //마지막 공란 LOOP

		        while(json.newLine > 0 && json.newLine < 7){
		           html3 += "<TD>&nbsp;</TD>";
		           json.newLine++;
		        }

		     $("#months").html(html1);
		     $("#weeks").html(html2);
		     $("#days").html(html3);
	},error: function(request, status, error){ 
        alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
    }
  });//end of ajax
	 --%>	
	}
</script>
<div class="container divbox1">
   <h3 class="h3_1">진료기록 관리하기</h3>
   <div class="row" >
   
	   <c:forEach items="${petlist}" var="pvo" varStatus="status">
		    <div class="col-md-3" style="display:inlineblock;float:left;">
		    <img src="<%=ctxPath%>/resources/img/chart/${pvo.pet_profileimg}" id="petimg"  width="50%"style="border-radius: 50%;display:block;"> 
		    <span style="font-weight: bold;padding-left: 10%;">[${pvo.pet_name}] 님</span>
		    </div>
	    </c:forEach>
  
   </div>
  
  <div class="divbox3">
	   <div class="container" Style="width:100%;">
		  <c:forEach items="${petlist}" var="pvo" >
			  <p style="padding-top:1%;">생년월일: ${pvo.pet_birthday}</p>
			  <p>성별:   ${pvo.pet_gender}</p>
			  <p>몸무게: ${pvo.pet_weight} kg</p>
		  </c:forEach>
	   </div>
  </div>
  
<div class="divbox4" id="content" style="width:712px" >
	
<table width="100%" border="0" cellspacing="1" cellpadding="1">
<!-- 버튼  -->
<tr>
     <td align ="right">

       <input type="hidden" onclick="javascript:location.href='<c:url value='/InsertMyPrescription.pet' />'" value="오늘"/>

     </td>
</tr> 

</table>

<!--날짜 네비게이션  -->

<table width="100%" border="0" cellspacing="1" cellpadding="1" id="KOO" bgcolor="#F3F9D7" style="border:1px solid #CED99C">
	<tr>
		<td height="60">
		    <div id="months"></div>
		</td>
	</tr>
</table>
<br>

<table border="0" cellspacing="1" cellpadding="1" bgcolor="#FFFFFF">

<THEAD>
<div id="weeks"></div>
</THEAD>

<TBODY>
<TR>
<div id="days"></div>
</TR>
</TBODY>
</TABLE>
</DIV>
</div>  
 
<div class="tab-content divbox5 container">
   <div class="container" Style="width:100%;">
	    <ul class="nav nav-tabs">
		    <li class="active"><a data-toggle="tab" href="#home">Home</a></li>
		    <li><a data-toggle="tab" href="#menu1">Menu 1</a></li>
		    <li><a data-toggle="tab" href="#menu2">Menu 2</a></li>
		    <li><a data-toggle="tab" href="#menu3">Menu 3</a></li>
	    </ul>
    </div>
    <form name="registerFrm">
    <div id="home" class="tab-pane fade in active" style="padding-left:2%;">
      
       <h3></h3>
       <p>진료예약일자:  </p>
       <p>방문일자: </p>
       <hr Style="width:100%; height:2%;"></hr>
       <div class="span col-md-10"><h3 style="font-weight:bold;color:pink; margin-top:0">진료결과 </h3></div>
       <div class="span col-md-10"><p>담당수의사: </p><input type="text" name="docname" style="margin-bottom: 1%;"/></div>
       <div class="span col-md-10"><p>처방약: </p><input type="text" name="mname" style="margin-bottom: 1%;"/></div>
        <div  class="span col-md-10"><span>하루 복용 횟수 :</span>
	      <select name="mtimes" style="margin-bottom: 1%;">
	        <option value="1">1</option>
	        <option value="2">2</option>
	        <option value="3">3</option>
	      </select>
	     </div>
        <div class="span col-md-10"><p>복용량: </p><input type="text" name="ms" style="margin-bottom: 1%;"/></div>
       <div class="span col-md-10"><p>주의사항: </p><textarea name="caution" style="width:40%;height:20%; margin-bottom: 1%;"></textarea></div>
       <div class="span col-md-10"><p>내  용: </p><textarea name="memo" style="width:40%;height:20%;"></textarea></div>
        <hr style="width:100%; height:2%;"></hr>
        <div style="margin-left: 70%;">
	       <p>예치금: </p>
	       <p>본인 부담금:</p>
	       <p>진료비 총액:</p>
       </div>
      </div>
        <input type="hidden" value="${sessionScope.loginuser.name}" name="name"/>
        </form>
        <button type="button" class="btn2" id="register">등록하기</button>
    </div>
   </div>



