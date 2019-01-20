<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>

	.custom-select {
	  position: relative;
	  font-family: Arial;
	}
	
	.custom-select select {
	  display: none; /*hide original SELECT element:*/
	}
	
	.select-selected {
	  background-color: rgb(252, 118, 106);
	  border-radius: 5px 0 0 5px;
	}
	
	/*style the arrow inside the select element:*/
	.select-selected:after {
	  position: absolute;
	  content: "";
	  top: 14px;
	  right: 10px;
	  width: 0;
	  height: 0;
	  border: 6px solid transparent;
	  border-color: rgb(252, 118, 106) transparent transparent transparent;
	}
	
	/*point the arrow upwards when the select box is open (active):*/
	.select-selected.select-arrow-active:after {
	  border-color: transparent transparent #fff transparent;
	  top: 7px;
	}
	
	/*style the items (options), including the selected item:*/
	.select-items div,.select-selected {
	  color: white;
	  padding: 11px 18px;
	  border: 1px solid transparent;
	  border-color: transparent transparent rgba(0, 0, 0, 0.1) transparent;
	  cursor: pointer;
	  user-select: none;
	}
	
	/*style items (options):*/
	.select-items {
	  position: absolute;
	  background-color: rgb(252, 118, 106);
	  top: 100%;
	  left: 0;
	  right: 0;
	  z-index: 99;
	}
	
	/*hide the items when the select box is closed:*/
	.select-hide {
	  display: none;
	}
	
	.select-items div:hover, .same-as-selected {
	  background-color: rgba(0, 0, 0, 0.1);
	}

	#search {
	  padding: 10px;
	  font-size: 17px;
	  border: 0px solid grey;
	  float: left;
	  width: 60%;
	  background: #f1f1f1;
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

<script type="text/javascript">

	$(document).ready(function(){
		/* ======================================= select 시작 ======================================= */
		var x, i, j, selElmnt, a, b, c;
		/*look for any elements with the class "custom-select":*/
		x = document.getElementsByClassName("custom-select");
		for (i = 0; i < x.length; i++) {
		  selElmnt = x[i].getElementsByTagName("select")[0];
		  /*for each element, create a new DIV that will act as the selected item:*/
		  a = document.createElement("DIV");
		  a.setAttribute("class", "select-selected");
		  a.innerHTML = selElmnt.options[selElmnt.selectedIndex].innerHTML;
		  x[i].appendChild(a);
		  /*for each element, create a new DIV that will contain the option list:*/
		  b = document.createElement("DIV");
		  b.setAttribute("class", "select-items select-hide");
		  for (j = 1; j < selElmnt.length; j++) {
		    /*for each option in the original select element,
		    create a new DIV that will act as an option item:*/
		    c = document.createElement("DIV");
		    c.innerHTML = selElmnt.options[j].innerHTML;
		    c.addEventListener("click", function(e) {
		        /*when an item is clicked, update the original select box,
		        and the selected item:*/
		        var y, i, k, s, h;
		        s = this.parentNode.parentNode.getElementsByTagName("select")[0];
		        h = this.parentNode.previousSibling;
		        for (i = 0; i < s.length; i++) {
		          if (s.options[i].innerHTML == this.innerHTML) {
		            s.selectedIndex = i;
		            h.innerHTML = this.innerHTML;
		            y = this.parentNode.getElementsByClassName("same-as-selected");
		            for (k = 0; k < y.length; k++) {
		              y[k].removeAttribute("class");
		            }
		            this.setAttribute("class", "same-as-selected");
		            break;
		          }
		        }
		        h.click();
		    });
		    b.appendChild(c);
		  }
		  x[i].appendChild(b);
		  a.addEventListener("click", function(e) {
		      /*when the select box is clicked, close any other select boxes,
		      and open/close the current select box:*/
		      e.stopPropagation();
		      closeAllSelect(this);
		      this.nextSibling.classList.toggle("select-hide");
		      this.classList.toggle("select-arrow-active");
		    });
		}
		function closeAllSelect(elmnt) {
		  /*a function that will close all select boxes in the document,
		  except the current select box:*/
		  var x, y, i, arrNo = [];
		  x = document.getElementsByClassName("select-items");
		  y = document.getElementsByClassName("select-selected");
		  for (i = 0; i < y.length; i++) {
		    if (elmnt == y[i]) {
		      arrNo.push(i)
		    } else {
		      y[i].classList.remove("select-arrow-active");
		    }
		  }
		  for (i = 0; i < x.length; i++) {
		    if (arrNo.indexOf(i)) {
		      x[i].classList.add("select-hide");
		    }
		  }
		}
		/*if the user clicks anywhere outside the select box,
		then close all select boxes:*/
		document.addEventListener("click", closeAllSelect);
		/* ======================================= select 끝 ======================================= */
		
		showMemberList("1");
		
		$("#orderBy").bind("change", function(){
			showMemberList("1");
		});
		
		$("#searchBtn").click(function(){
			showMemberList("1");
		}); // end of 
		
		
	}); // $(document).ready();
	
	function showMemberList(currentShowPageNo) {
		var searchData = {"currentShowPageNo":currentShowPageNo,
						  "orderBy":$("#orderBy").val(),
						  "searchWhat":$("#searchWhat").val(),
						  "search":$("#search").val()};
		
		$.ajax({
			url: "<%=request.getContextPath()%>/selectMemberList.pet",
			type: "GET",
			data: searchData,
			dataType: "JSON",
			success: function(json){
				var html = "";
				
				if(json.length > 0){
					$.each(json,function(entryIndex,entry){
						html += "<tr>"
									+"<td><input type=\"checkbox\" id=\"memberno\" value=\""+entry.idx+"\"/></td>"
									+"<td>"+entry.idx+"</td>"
									+"<td>"+entry.userid+"</td>"
									+"<td>"+entry.name+"</td>"
									+"<td>"+entry.nickname+"</td>"
									+"<td>"+entry.phone+"</td>"
									+"<td>"+entry.noshow+"</td>"
									+"<td>";
						if(entry.lastlogindategap >= 12) {
										html += "휴면";	
						} else {
							if(entry.member_status == 1) {
										html += "회원";
							} else if(entry.member_status == 0) {
										html += "탈퇴"
							} // end of if~else if
						} // end of if~else
							 html += "</td>"
									+"<td>"
										+"<a href=\"<%=request.getContextPath() %>/adminInfoMember.pet\">"
											+"<img src=\"<%=request.getContextPath() %>/resources/img/memberIcon/pencil-edit-square.png\">"
										+"</a>&nbsp;";
						if(entry.lastlogindategap >= 12) {
									html += "<a>"
											+"<img src=\"<%=request.getContextPath() %>/resources/img/memberIcon/equalizer-music-controller.png\">"
										+"</a>&nbsp;";
						} else {
							if(entry.member_status == 1) {
									html += "<a>"
											+"<img src=\"<%=request.getContextPath() %>/resources/img/memberIcon/delete-button.png\">"
										+"</a>&nbsp;";
							} else if(entry.member_status == 0) {
									html += "<a>"
											+"<img src=\"<%=request.getContextPath() %>/resources/img/memberIcon/verified.png\">"
										+"</a>&nbsp;";
							} // end of if~else if
						} // end of if~else
							html += "</td>"
								+"</tr>";
					}); // end of each
				} else {
					html += "<tr>"
						 + "<td colspan='7' align='center'>회원이 없습니다.</td>"
						 + "</tr>";
				} //  end of if ~ else
				
				$("#result").empty().html(html);
			},
			error: function(request, status, error){ 
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); // end of ajax
	} // end of function showMemberList(currentShowPageNo)
</script>

<div class="container">
	<div class="col-sm-12" style="margin-top: 20px;background-color: white;">
		<form name="searchFrm">
			<div class="row" style="margin-top: 10px; margin-bottom: 10px; padding-left: 4%; padding-right: 4%;">
				<div class="col-sm-2">
					<select class="form-control" id="orderBy" name="orderBy" style="height: 45px;">
						<option value="">정렬</option>
						<option value="name">이름순</option>
						<option value="noshow">no-show많은순</option>
						<option value="regdate">신규가입순</option>
					</select>
				</div>
				
				<div class="col-sm-offset-4 col-sm-6"><%-- 이름, 닉네임, 아이디로 검색 --%>
					<div class="custom-select" style="width:20%; float: left;">
  						<select name="searchWhat" id="searchWhat">
							<option value="">검색</option>
							<option value="userid">아이디</option>
							<option value="name">이름</option>
							<option value="nickname">닉네임</option>
						</select>
					</div>
					<input type="text" name="search" id="search" class="" placeholder="Search..">
					<button type="button" id="searchBtn"><i class="fa fa-search"></i></button>
				</div>
			</div>
		</form>
		
		<div class="row">
			<div class="table-responsive" style="width: 100%; padding-left: 5%; padding-right: 5%;">
				<table class="table" style="margin-top: 20px;width: 100%;">
					<thead style="background-color: #f2f2f2;">
						<tr>
							<th width="5%" align="center"></th>
							<th width="5%" align="center">번호</th>
							<th width="20%" align="center">아이디</th>
							<th width="10%" align="center">이름</th>
							<th width="10%" align="center">닉네임</th>
							<th width="10%" align="center">휴대전화</th>
							<th width="10%" align="center">no show</th>
							<th width="10%" align="center">회원상태</th>
							<th width="20%" align="center">관리</th>
						</tr>
					</thead>
					
					<tbody id="result">
					</tbody>
				</table>
			</div>
		</div>
		
		<div class="row" align="center">
			<div class="col-sm-12">
				<ul class="pagination pagination-sm">
				  	<li><a href="#">이전</a></li>
				    <li><a href="#">1</a></li>
				    <li><a href="#">2</a></li>
				    <li><a href="#">3</a></li>
				    <li><a href="#">4</a></li>
				    <li><a href="#">5</a></li>
				    <li><a href="#">6</a></li>
				    <li><a href="#">7</a></li>
				    <li><a href="#">8</a></li>
				    <li><a href="#">9</a></li>
				    <li><a href="#">10</a></li>
				    <li><a href="#">다음</a></li>
			  	</ul>
		  	</div>
		</div>
	</div>
</div>