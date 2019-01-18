<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String ctxPath = request.getContextPath();%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<style>
 .span{
	 padding-left:5%;
	 padding-top: 2%;
  } 
  .btn1{
  margin-left: 42%;
  margin-top: 4%;
  margin-bottom:2%;
  background-color:rgb(252, 118, 106);
 color:white;
 width:20%;
 height:5%;
 border-radius:4px;
  }
</style>
<script type="text/javascript">
    
	$(document).ready(function(){
		
	});// end of $(document).ready()----------------------
</script>
<div class="container"> 
<Form name="prescriptFrm" 
 style="margin-left:18%; border:0px solid black;border-radius:10px;width:70%; background-color: #eaebed">
<div class="row">  
   
   <div class="col-md-12 ">
   <h4 style="text-align:center; padding-top: 6%;">야옹님의 진료기록</h4>
   <div class="span col-md-12 "><span>1.날짜: 2019년 01원 14일 </span></div>
   <div class="span col-md-12" ><span>2.병원 이름: 뚝딱뚜딱 병원</span></div>
   <div class="span col-md-12"><span>3.진료 회원 아이디: mint</span></div>
   <div class="span col-md-12"><span>4.진료 동물 종류: 고양이</span></div>
   <div class="span col-md-12"><span>5.진료 동물 이름: 냥냥이1</span></div>
   <div class="span col-md-12"><span>6.처방전 번호: A102</span></div>
   <div class="span col-md-12"><span>7.처방 약 이름 : </span><input type="checkbox"/></div>
   <div class="span col-md-12"><span>8.투약 량 : 백신</span></div>
   <div  class="span col-md-12"><span>9.하루 복용 횟수 :
      <select name="times" name="times">
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
      </select>
   </span>
   </div>  
	<div class="span col-md-12"><span>10.주의 사항:</span></div>
	<div class="span col-md-12"><textarea name="caution" style="width:50%; height:15%;"></textarea></div>
	<div class="span col-md-12"><span>11.노트 : </span></div>
	<div class="span col-md-12"><textarea name="note" style="width:50%; height:15%;"></textarea></div>
   
   
   </div>
    <button type="button" id="register" class="btn1">등록하기</button> 
</div>
</Form>
</div>
