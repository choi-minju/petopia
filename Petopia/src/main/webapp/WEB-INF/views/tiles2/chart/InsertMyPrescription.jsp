<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%String ctxPath = request.getContextPath();%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<%@page import="java.text.SimpleDateFormat"%>

<%@page import="java.util.Calendar"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%

Calendar cal = Calendar.getInstance();

String strYear = request.getParameter("year");

String strMonth = request.getParameter("month");

int year = cal.get(Calendar.YEAR);

int month = cal.get(Calendar.MONTH);

int date = cal.get(Calendar.DATE);

if(strYear != null)

{

  year = Integer.parseInt(strYear);

  month = Integer.parseInt(strMonth);

  

}else{

 

}

//년도/월 셋팅

cal.set(year, month, 1);

 

int startDay = cal.getMinimum(java.util.Calendar.DATE);

int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);

int start = cal.get(java.util.Calendar.DAY_OF_WEEK);

int newLine = 0;

 

//오늘 날짜 저장.

Calendar todayCal = Calendar.getInstance();

SimpleDateFormat sdf = new SimpleDateFormat("yyyMMdd");

int intToday = Integer.parseInt(sdf.format(todayCal.getTime()));

%>

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
	<!-- <div id="calendar"  class="calendar">
	   
	</div> -->
	
<table width="100%" border="0" cellspacing="1" cellpadding="1">

<tr>

       <td align ="right">

             <input type="button" onclick="javascript:location.href='<c:url value='/CalendarExam2.jsp' />'" value="오늘"/>

       </td>

</tr>

</table>

<!--날짜 네비게이션  -->

<table width="100%" border="0" cellspacing="1" cellpadding="1" id="KOO" bgcolor="#F3F9D7" style="border:1px solid #CED99C">


<tr>

<td height="60">

       <table width="100%" border="0" cellspacing="0" cellpadding="0">

       <tr>

             <td height="10">

             </td>

       </tr>


       <tr>

             <td align="center" >

                    <a href="<c:url value='/CalendarExam2.jsp' />?year=<%=year-1%>&amp;month=<%=month%>" target="_self">

                           <b>&lt;&lt;</b><!-- 이전해 -->

                    </a>

                    <%if(month > 0 ){ %>

                    <a href="<c:url value='/CalendarExam2.jsp' />?year=<%=year%>&amp;month=<%=month-1%>" target="_self">

                           <b>&lt;</b><!-- 이전달 -->

                    </a>

                    <%} else {%>

                           <b>&lt;</b>

                    <%} %>

                    &nbsp;&nbsp;

                    <%=year%>년

                    

                    <%=month+1%>월

                    &nbsp;&nbsp;

                    <%if(month < 11 ){ %>

                    <a href="<c:url value='/CalendarExam2.jsp' />?year=<%=year%>&amp;month=<%=month+1%>" target="_self">

                           <!-- 다음달 --><b>&gt;</b>

                    </a>

                    <%}else{%>

                           <b>&gt;</b>

                    <%} %>

                    <a href="<c:url value='/CalendarExam2.jsp' />?year=<%=year+1%>&amp;month=<%=month%>" target="_self">

                           <!-- 다음해 --><b>&gt;&gt;</b>

                    </a>

             </td>

       </tr>

       </table>

</td>

</tr>

</table>

<br>

<table border="0" cellspacing="1" cellpadding="1" bgcolor="#FFFFFF">

<THEAD>

<TR bgcolor="#CECECE">

       <TD width='100px'>

       <DIV align="center"><font color="red">일</font></DIV>

       </TD>

       <TD width='100px'>

       <DIV align="center">월</DIV>

       </TD>

       <TD width='100px'>

       <DIV align="center">화</DIV>

       </TD>

       <TD width='100px'>

       <DIV align="center">수</DIV>

       </TD>

       <TD width='100px'>

       <DIV align="center">목</DIV>

       </TD>

       <TD width='100px'>

       <DIV align="center">금</DIV>

       </TD>

       <TD width='100px'>

       <DIV align="center"><font color="#529dbc">토</font></DIV>

       </TD>

</TR>

</THEAD>

<TBODY>

<TR>

<%

//처음 빈공란 표시

for(int index = 1; index < start ; index++ )

{

  out.println("<TD >&nbsp;</TD>");

  newLine++;

}

 

for(int index = 1; index <= endDay; index++)

{

       String color = "";

 
       if(newLine == 0){          color = "RED";

       }else if(newLine == 6){    color = "#529dbc";

       }else{                     color = "BLACK"; };

       String sUseDate = Integer.toString(year); 

       sUseDate += Integer.toString(month+1).length() == 1 ? "0" + Integer.toString(month+1) : Integer.toString(month+1);

       sUseDate += Integer.toString(index).length() == 1 ? "0" + Integer.toString(index) : Integer.toString(index);

 
       int iUseDate = Integer.parseInt(sUseDate);

       
       String backColor = "#EFEFEF";

       if(iUseDate == intToday ) {

             backColor = "#c9c9c9";

       } 

       out.println("<TD valign='top' align='left' height='92px' bgcolor='"+backColor+"' nowrap>");

       %>

       <font color='<%=color%>'>

             <%=index %>

       </font>

       <%

       out.println("<BR>");

       out.println(iUseDate);

       out.println("<BR>");

       //기능 제거  

       out.println("</TD>");

       newLine++;

       if(newLine == 7)

       {

         out.println("</TR>");

         if(index <= endDay)

         {

           out.println("<TR>");

         }

         newLine=0;

       }

}

//마지막 공란 LOOP

while(newLine > 0 && newLine < 7)

{

  out.println("<TD>&nbsp;</TD>");

  newLine++;

}

%>

</TR>

</TBODY>

</TABLE>

</DIV>
  
 
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



