<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	#search {
	  padding: 10px;
	  font-size: 17px;
	  border: 0px solid grey;
	  float: left;
	  width: 80%;
	  background: #f1f1f1;
	  border-radius: 10px 0 0 10px;
	}
	
	#search:focus {
	  outline: none;
	}
	
	#searchBtn {
	  float: left;
	  width: 20%;
	  padding: 10px;
	  height: 45px;
	  background: rgb(252, 118, 106);
	  color: white;
	  font-size: 17px;
	  border: 0px solid grey;
	  border-left: none;
	  cursor: pointer;
	  border-radius: 0 10px 10px 0;
	}
	
	#searchBtn:hover {
	  background: #0b7dda;
	}
	
</style>

<div class="col-sm-12" style="margin-top: 20px;">
	<div class="col-sm-offset-2 col-sm-8" style="background-color: white;">
			<form>
				<div class="col-sm-12" style="margin-top: 10px; margin-bottom: 10px;">
					<div class="col-sm-2">
						<select class="form-control" style="height: 45px;">
							<option value="">등급별</option>
							<option value="1">1등급</option>
							<option value="2">2등급</option>
							<option value="3">3등급</option>
						</select>
					</div>
					
					<div class="col-sm-offset-6 col-sm-4">
						<input type="text" name="search" id="search" class="" placeholder="Search..">
						<button type="button" id="searchBtn"><i class="fa fa-search"></i></button>
					</div>
				</div>
			</form>
		
		<table class="table" style="margin-top: 20px;">
			<thead style="background-color: #f2f2f2;">
				<tr>
					<th align="center"></th>
					<th align="center">번호</th>
					<th align="center">이름</th>
					<th align="center">회원등급</th>
					<th align="center">연락처</th>
					<th align="center">대표반려동물명</th>
					<th align="center">no show 경고횟수</th>
					<th align="center">관리</th>
				</tr>
			</thead>
			
			<tbody>
				<tr>
					<td><input type="checkbox"/></td>
					<td>1</td>
					<td>홍길동</td>
					<td>1등급</td>
					<td>010-1234-5678</td>
					<td>멍멍</td>
					<td>green(5회)</td>
					<td>
						<a href="<%=request.getContextPath() %>/adminInfoMember.pet">
							<img src="<%=request.getContextPath() %>/resources/img/memberIcon/pencil-edit-square.png">
						</a>
						<a onclick=""> <!-- 휴면일 경우 회원으로 바꿀건지 confrim 띄우고 바꾸기 -->
							<img src="<%=request.getContextPath() %>/resources/img/memberIcon/equalizer-music-controller.png">
						</a>
						<a onclick=""> <!-- 회원일 경우 탈퇴할 건지 confrim 띄우고 바꾸기 -->
							<img src="<%=request.getContextPath() %>/resources/img/memberIcon/delete-button.png">
						</a>
						<a onclick=""> <!-- 탈퇴한 경우 다시 회원으로 할 건지 confrim 띄우고 바꾸기 -->
							<img src="<%=request.getContextPath() %>/resources/img/memberIcon/verified.png">
						</a>
					</td>
				</tr>
			</tbody>
		</table>
		<div align="center">
		  <ul class="pagination">
		  	<li><a href="#">이전</a></li>
		    <li><a href="#">1</a></li>
		    <li><a href="#">2</a></li>
		    <li><a href="#">3</a></li>
		    <li><a href="#">4</a></li>
		    <li><a href="#">5</a></li>
		    <li><a href="#">다음</a></li>
		  </ul>
		 </div>
	</div>
</div>