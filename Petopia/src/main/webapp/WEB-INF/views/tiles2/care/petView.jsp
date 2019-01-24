<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
	
	.pointer {
		cursor: pointer;
	}
	
	.in {
		display: inline-block;
	}
	
	.out {
		width: 100%;
		text-align: center;
	}
	
	.profileimg {
		border-radius: 100%;
		width: 150px;
		height: 150px;
	}
	
	.alarm {
		background-color: #f2f2f2;
		height: 50px;
		padding: 7px;
		margin-top: 3%;
		text-align: left;
	}
	
</style>

<div class="container" style="margin-top: 10px;">
	
	<div class="row">
		<div class="out">
			<div class="in" style="margin-right: 12%;">
				<ul style="list-style-type: none;">
					<li>다른 반려동물</li>
					<li><i class="fa fa-angle-double-left" style="font-size: 30pt;"></i></li>
				</ul>
			</div>
			<div class="pointer in" onclick=window.open("careCalendar.pet?pet_UID=${pet_UID}","_self")>
				<img src="resources/img/care/dog.png" class="profileimg">	
			</div>
			
			<div class="in">
				<ul style="list-style-type: none;">
					<li>반려동물이름</li>
					<li>생일</li>
					<li>성별</li>
					<li>종</li>
				</ul>
			</div>
			<div class="in" style="margin-left: 6%;">
				<ul style="list-style-type: none;">
					<li>다른 반려동물</li>
					<li><i class="fa fa-angle-double-right" style="font-size: 30pt;"></i></li>
				</ul>
			</div>
		</div>	
	</div>
	
	
	<div class="row" style="text-align: center; margin-top: 5px;">
		<div style="margin:0 auto;">
			<button type="button">수정하기</button>
			<button type="button">지우기</button>	
		</div>
	</div>
	
	
	<div class="row" style="margin-top: 8%;">
		<div class="out">
			<div class="in col-md-4" >
				현재 체중 : 0kg / 목표 체중 : 1kg
				<img src="resources/img/care/chart.PNG">
				<table class="table table-hover">
				    <thead>
				      <tr>
				        <th>기록일</th>
				        <th>체중</th>
				        <th>기록자</th>
				      </tr>
				    </thead>
				    <tbody>
				      <tr>
				        <td>John</td>
				        <td>Doe</td>
				        <td>john@example.com</td>
				      </tr>
				      <tr>
				        <td>Mary</td>
				        <td>Moe</td>
				        <td>mary@example.com</td>
				      </tr>
				      <tr>
				        <td>July</td>
				        <td>Dooley</td>
				        <td>july@example.com</td>
				      </tr>
				    </tbody>
				</table>
			</div>	
				
			<div class="in col-md-4">
				<div class="alarm">
					<div>
						Simple Title
					</div>
					<div>
						content
					</div>
				</div>
				
				<div class="alarm">
					<div>
						Simple Title
					</div>
					<div>
						content
					</div>
				</div>
				
				<div class="alarm">
					<div>
						Simple Title
					</div>
					<div>
						content
					</div>
				</div>
				
			</div>	
			<div class="in col-md-4">
				최근 진료 기록
				<table class="table table-hover">
				    <thead>
				      <tr>
				        <th>No.</th>
				        <th>병원</th>
				        <th>날짜</th>
				      </tr>
				    </thead>
				    <tbody>
				      <tr>
				        <td>John</td>
				        <td>Doe</td>
				        <td>john@example.com</td>
				      </tr>
				      <tr>
				        <td>Mary</td>
				        <td>Moe</td>
				        <td>mary@example.com</td>
				      </tr>
				      <tr>
				        <td>July</td>
				        <td>Dooley</td>
				        <td>july@example.com</td>
				      </tr>
				    </tbody>
				</table>
			</div>	
		</div>
	</div>
	


</div>    