<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header_admin.jsp" %>
<%
	String login = request.getParameter("login");
%>
<input type="hidden" name="login" id="login" value=<%=login%> >
<script>
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//AOS init//
	AOS.init();
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//page설정
function page_function(page,total){
	currentPage = page;
	total = total;
	pagePerContent = 5;
	blockPerPage = 5;
	totalPage = Math.ceil(total/pagePerContent);
	currentBlock = Math.ceil(currentPage / blockPerPage);
	totalBlock = Math.ceil(totalPage/blockPerPage);
	startPage = (currentBlock*blockPerPage)-(blockPerPage-1);
	endPage = (currentBlock*blockPerPage);
	
	if(endPage > totalPage){
		endPage = totalPage;
	}
	
	startnum = (page * pagePerContent) - pagePerContent;
	endnum = pagePerContent;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//user_dash_detail 창닫기
function close_dash(type){
		if(type == "user"){
			$("#user_dash_detail").html("");
			$("#user_dash_detail").css("display","none");
		}else if(type == "brd"){
			$("#brd_dash_detail").html("");
			$("#brd_dash_detail").css("display","none");
		}
		};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//멤버 탈퇴 처리
function leave_member(){
	
	var length = $("input:checkbox[name=uidx]:checked").length;
	var answer = confirm('[' +length+ ']명의 회원을 탈퇴처리 하십니까?');
	
	$("input:checkbox[name=uidx]:checked").each(function(){
		$.ajax({
			url : "/delete_user",
			data : "uidx="+this.value,
			success : function(){
				success_length++;
			},error : function(data){
				error_length++;
			}
		});
	});
	alert('회원정보변경이 완료되었습니다.');
	location.href='/admin';
}		
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//user_dash 제작 function//	
function open_user_dash(type,page){
	if(type == "total"){
		$("#user_dash_detail").css("display","block");
		
		var page = page;
		var total = parseInt($("#total_user").html());

		//page getter_setter
		page_function(page,total);
		
		//page 숫자에 맞는 내용 불러오기
		$.ajax({
			url : "/open_user_dash",
			data : "startnum="+startnum+"&endnum="+endnum,
			dataType : "json",
			contentType : "application/json",
			success : function(data){
				html = "";
				html += "<div class='col-12' style='min-height:350px;'>";
				html += "<table class=\"table small text-center text-muted\">";
				html += "<tr class=\"bg-light\">";
				html += "<td><i class=\"ri-check-line\"></i></td><td>아이디</td><td>레벨</td><td>회원유형</td><td>가입일</td>";
				html += "</tr>";
				$.each(data,function(index,item){
					html += "<tr>";
					html += "<td><input type='checkbox' name='uidx' id='uidx_check' value="+this.uidx+"></td>";
					html += "<td>"+this.userid+"</td>";
					html += "<td>"+this.grade+"</td>";
					html += "<td>"+this.role+"</td>";
					html += "<td>"+this.regdate+"</td>";
					html += "</tr>";
				});
				html += "</table>";
				html += "</div>";
				html += "<hr>";
				html += "<div class=\"p-2 col-12 text-center mt-2 mb-5\">";
				html += "<button type=\"button\" class=\"btn btn-lg btn-danger rounded font-weight-bold\" style=\"font-size:12px;\" id=\"user_delete_btn\" onclick='leave_member()'><i class=\"ri-delete-bin-line me-2\"></i>탈퇴처리</button>";
				html += "</div>";
				
				
					// pagination
				html += "<nav aria-label=\"...\" class=\"col-12 text-center\">";
				html += "<ul class=\"pagination justify-content-center\">";
				if(currentPage <= 1){
					html += "<li class=\"page-item disabled\">";	
					html += "<a class=\"page-link\">&lt;&lt;</a>";
				}else{
					html += "<li class=\"page-item\">";
					html += "<a class=\"page-link\" href=\"javascript:open_user_dash('"+type+"','"+(parseInt(currentPage)-1)+"')\">&lt;&lt;</a>";
				}
				
				html += "</li>";
				for(var i = startPage; i<=endPage; i++){
					if(i == currentPage){
						html += "<li class=\"page-item active\" aria-current=\"page\">";
						html += "<a class=\"page-link\">"+i+"</a>";
					}else{
						html += "<li class=\"page-item\" aria-current=\"page\">";
						html += "<a class=\"page-link\" href=\"javascript:open_user_dash('"+type+"','"+i+"')\">"+i+"</a>";
					}
					
					html += "</li>";
				}
				
				if(currentPage >= totalPage){
					html += "<li class=\"page-item disabled\">";
					html += "<a class=\"page-link\">&gt;&gt;</a>";
				}else{
					html += "<li class=\"page-item\">";
					html += "<a class=\"page-link\" href=\"javascript:open_user_dash('"+type+"','"+(parseInt(currentPage)+1)+"')\">&gt;&gt;</a>";
				}
				html += "</li>";
				html += "</ul>";
				html += "</nav>";
				//pagination
				
				

				html += "<div class=\"p-2 col-12 text-center\">";
				html += "<button type=\"button\" class=\"btn btn-lg btn-secondary rounded font-weight-bold\" style=\"font-size:12px;\" onclick='javascript:close_dash(\"user\")'><i class=\"ri-logout-box-r-line me-2\"></i>창닫기</button>";
				html += "</div>";
				
				$("#user_dash_detail").html(html);
				
			},error : function(data){
				console.log(data);
			}
		});
	}else if(type == "month"){
		$("#user_dash_detail").css("display","block");
		
		var page = page;
		var total = parseInt($("#month_user").html());

		//page getter_setter
		page_function(page,total);
		
		//page 숫자에 맞는 내용 불러오기
		$.ajax({
			url : "/open_user_dash_month",
			data : "startnum="+startnum+"&endnum="+endnum,
			dataType : "json",
			contentType : "application/json",
			success : function(data){
				html = "";
				html += "<div class='col-12' style='min-height:350px;'>";
				html += "<table class=\"table small text-center text-muted\">";
				html += "<tr class=\"bg-light\">";
				html += "<td><i class=\"ri-check-line\"></i></td><td>아이디</td><td>레벨</td><td>회원유형</td><td>가입일</td>";
				html += "</tr>";
				$.each(data,function(index,item){
					html += "<tr>";
					html += "<td><input type='checkbox' name='uidx' id='uidx_check' value="+this.uidx+"></td>";
					html += "<td>"+this.userid+"</td>";
					html += "<td>"+this.grade+"</td>";
					html += "<td>"+this.role+"</td>";
					html += "<td>"+this.regdate+"</td>";
					html += "</tr>";
				});
				html += "</table>";
				html += "</div>";
				html += "<hr>";
				html += "<div class=\"p-2 col-12 text-center mt-2 mb-5\">";
				html += "<button type=\"button\" class=\"btn btn-lg btn-danger rounded font-weight-bold\" style=\"font-size:12px;\" id=\"user_delete_btn\" onclick='leave_member()'><i class=\"ri-delete-bin-line me-2\"></i>탈퇴처리</button>";
				html += "</div>";
				
				// pagination
				html += "<nav aria-label=\"...\" class=\"col-12 text-center\">";
				html += "<ul class=\"pagination justify-content-center\">";
				if(currentPage <= 1){
					html += "<li class=\"page-item disabled\">";	
					html += "<a class=\"page-link\">&lt;&lt;</a>";
				}else{
					html += "<li class=\"page-item\">";
					html += "<a class=\"page-link\" href=\"javascript:open_user_dash('"+type+"','"+(parseInt(currentPage)-1)+"')\">&lt;&lt;</a>";
				}
				
				html += "</li>";
				for(var i = startPage; i<=endPage; i++){
					if(i == currentPage){
						html += "<li class=\"page-item active\" aria-current=\"page\">";
						html += "<a class=\"page-link\">"+i+"</a>";
					}else{
						html += "<li class=\"page-item\" aria-current=\"page\">";
						html += "<a class=\"page-link\" href=\"javascript:open_user_dash('"+type+"','"+i+"')\">"+i+"</a>";
					}
					
					html += "</li>";
				}
				
				if(currentPage >= totalPage){
					html += "<li class=\"page-item disabled\">";
					html += "<a class=\"page-link\">&gt;&gt;</a>";
				}else{
					html += "<li class=\"page-item\">";
					html += "<a class=\"page-link\" href=\"javascript:open_user_dash('"+type+"','"+(parseInt(currentPage)+1)+"')\">&gt;&gt;</a>";
				}
				html += "</li>";
				html += "</ul>";
				html += "</nav>";
				//pagination
				
				

				html += "<div class=\"p-2 col-12 text-center\">";
				html += "<button type=\"button\" class=\"btn btn-lg btn-secondary rounded font-weight-bold\" style=\"font-size:12px;\" onclick='javascript:close_dash(\"user\")'><i class=\"ri-logout-box-r-line me-2\"></i>창닫기</button>";
				html += "</div>";
				
				$("#user_dash_detail").html(html);
				
			},error : function(data){
				console.log(data);
			}
		});
	}
};


//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//brd_dash 제작 function//	
function open_brd_dash(type,page){
	if(type == "total"){
		$("#brd_dash_detail").css("display","block");
		
		var page = page;
		var total = parseInt($("#total_board").html());
		
		//page getter_setter
		page_function(page,total);
		
		//page 숫자에 맞는 내용 불러오기
		$.ajax({
			url : "/open_brd_dash",
			data : "startnum="+startnum+"&endnum="+endnum,
			dataType : "json",
			contentType : "application/json",
			success : function(data){
				html = "";
				html += "<div class='col-12' style='min-height:350px;'>";
				html += "<table class=\"table small text-center text-muted\">";
				html += "<tr class=\"bg-light\">";
				html += "<td>No.</td><td>문의제목</td><td>문의일</td>";
				html += "</tr>";
				
				$.each(data,function(index,item){
					html += "<tr>";
					html += "<td>"+this.bidx+"</td>";
					html += "<td>"+this.btitle+"</td>";
					html += "<td>"+this.regdate+"</td>";
					html += "</tr>";
				});
				
				html += "</table>";
				html += "</div>";
				html += "<hr>";
				
				// pagination
				html += "<nav aria-label=\"...\" class=\"col-12 text-center\">";
				html += "<ul class=\"pagination justify-content-center\">";
				if(currentPage <= 1){
					html += "<li class=\"page-item disabled\">";	
					html += "<a class=\"page-link\">&lt;&lt;</a>";
				}else{
					html += "<li class=\"page-item\">";
					html += "<a class=\"page-link\" href=\"javascript:open_brd_dash('"+type+"','"+(parseInt(currentPage)-1)+"')\">&lt;&lt;</a>";
				}
				
				html += "</li>";
				
				for(var i = startPage; i<=endPage; i++){
					if(i == currentPage){
						html += "<li class=\"page-item active\" aria-current=\"page\">";
						html += "<a class=\"page-link\">"+i+"</a>";
					}else{
						html += "<li class=\"page-item\" aria-current=\"page\">";
						html += "<a class=\"page-link\" href=\"javascript:open_brd_dash('"+type+"','"+i+"')\">"+i+"</a>";
					}
					html += "</li>";
				}
				
				if(currentPage >= totalPage){
					html += "<li class=\"page-item disabled\">";
					html += "<a class=\"page-link\">&gt;&gt;</a>";
				}else{
					html += "<li class=\"page-item\">";
					html += "<a class=\"page-link\" href=\"javascript:open_brd_dash('"+type+"','"+(parseInt(currentPage)+1)+"')\">&gt;&gt;</a>";
				}
				html += "</li>";
				html += "</ul>";
				html += "</nav>";
				//pagination
				
				html += "<div class=\"p-2 col-12 text-center\">";
				html += "<button type=\"button\" class=\"btn btn-lg btn-secondary rounded font-weight-bold\" style=\"font-size:12px;\" onclick='javascript:close_dash(\"brd\")'><i class=\"ri-logout-box-r-line me-2\"></i>창닫기</button>";
				html += "</div>";
				
				$("#brd_dash_detail").html(html);
				 
			},error : function(data){
				console.log(data);
			}
		});
	}else if(type == "day"){
		$("#brd_dash_detail").css("display","block");
		
		var page = page;
		var total = parseInt($("#today_board").html());
		
		//page getter_setter
		page_function(page,total);
		
		//page 숫자에 맞는 내용 불러오기
		$.ajax({
			url : "/open_brd_dash_day",
			data : "startnum="+startnum+"&endnum="+endnum,
			dataType : "json",
			contentType : "application/json",
			success : function(data){
				html = "";
				html += "<div class='col-12' style='min-height:350px;'>";
				html += "<table class=\"table small text-center text-muted\">";
				html += "<tr class=\"bg-light\">";
				html += "<td>No.</td><td>문의제목</td><td>문의일</td>";
				html += "</tr>";
				
				$.each(data,function(index,item){
					html += "<tr>";
					html += "<td>"+this.bidx+"</td>";
					html += "<td>"+this.btitle+"</td>";
					html += "<td>"+this.regdate+"</td>";
					html += "</tr>";
				});
				
				html += "</table>";
				html += "</div>";
				html += "<hr>";
				
				// pagination
				html += "<nav aria-label=\"...\" class=\"col-12 text-center\">";
				html += "<ul class=\"pagination justify-content-center\">";
				if(currentPage <= 1){
					html += "<li class=\"page-item disabled\">";	
					html += "<a class=\"page-link\">&lt;&lt;</a>";
				}else{
					html += "<li class=\"page-item\">";
					html += "<a class=\"page-link\" href=\"javascript:open_brd_dash('"+type+"','"+(parseInt(currentPage)-1)+"')\">&lt;&lt;</a>";
				}
				
				html += "</li>";
				
				for(var i = startPage; i<=endPage; i++){
					if(i == currentPage){
						html += "<li class=\"page-item active\" aria-current=\"page\">";
						html += "<a class=\"page-link\">"+i+"</a>";
					}else{
						html += "<li class=\"page-item\" aria-current=\"page\">";
						html += "<a class=\"page-link\" href=\"javascript:open_brd_dash('"+type+"','"+i+"')\">"+i+"</a>";
					}
					html += "</li>";
				}
				
				if(currentPage >= totalPage){
					html += "<li class=\"page-item disabled\">";
					html += "<a class=\"page-link\">&gt;&gt;</a>";
				}else{
					html += "<li class=\"page-item\">";
					html += "<a class=\"page-link\" href=\"javascript:open_brd_dash('"+type+"','"+(parseInt(currentPage)+1)+"')\">&gt;&gt;</a>";
				}
				html += "</li>";
				html += "</ul>";
				html += "</nav>";
				//pagination
				
				html += "<div class=\"p-2 col-12 text-center\">";
				html += "<button type=\"button\" class=\"btn btn-lg btn-secondary rounded font-weight-bold\" style=\"font-size:12px;\" onclick='javascript:close_dash(\"brd\")'><i class=\"ri-logout-box-r-line me-2\"></i>창닫기</button>";
				html += "</div>";
				
				$("#brd_dash_detail").html(html);
				
			},error : function(data){
				console.log(data);
			}
		});
	}
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//open_brd_dash 종료

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//onload
	$(function(){
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//login 완료 메시지
		let login = $("#login").val();
			
		if(login == "admin"){
			toastr.success("관리자로 로그인되었습니다.");	
		}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//초기 ajax 정보
		$.ajax({
			url : "/count_user_total",
			contentType : "application/text",
			success : function(data){
				$("#total_user").html(data);
			},error : function(data){
				console.log(data);
			}
		});
		$.ajax({
			url : "/count_user_month",
			contentType : "application/text",
			success : function(data){
				$("#month_user").html(data);
			},error : function(data){
				console.log(data);
			}
		});
		$.ajax({
			url : "/count_brd_total",
			contentType : "application/text",
			success : function(data){
				$("#total_board").html(data);
			},error : function(data){
				console.log(data);
			}
		});
		$.ajax({
			url : "/count_brd_day",
			contentType : "application/text",
			success : function(data){
				$("#today_board").html(data);
			},error : function(data){
				console.log(data);
			}
		});
		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////		
		
		
	});
	
</script>
	<div class="pt-5 pb-2 section-bg"> </div>
	<section id="services" class="services section-bg">
      <div class="container">
        <div class="section-title" data-aos="flip-left">
          <h2>관리자메뉴</h2>
          <p class="small text-muted">하단의 관리 항목을 눌러 관리할 수 있습니다.</p>
        </div>

        <div class="row" data-aos="fade-up" data-aos-delay="100">
          
          <div class="col-xl-3 col-md-6 align-items-stretch mt-4 mt-xl-0">
           <div class="icon-box col-12  d-flex ps-1 pe-1">
              <div class="col-4 text-center">
	              <div class="icon"><i class="ri-user-5-line"></i></div>
	              <h5><a href="#">회원관리</a></h5>
              </div>
              <div class="col-8 card small border-light">
              		<div class="small" id="user_dash">
              			<p class="btn btn-outline-success btn-block mb-2" onclick="open_user_dash('total','1')">총 사용자수 : <span id="total_user">00</span> 명</p>
              			<p class="btn btn-outline-primary btn-block mb-2" onclick="open_user_dash('month','1')">이 달의 가입자 : <span id="month_user">00</span> 명</p>
              		</div>
              </div>
            </div>
            <!-- icon-box -->
            <div class="icon-box col-12 ps-1 pe-1 detail_box" id="user_dash_detail"  data-aos="fade-up" data-aos-delay="100" style='display:none;'>
            	<!-- user_dash_detail Container -->
            </div>
            <!-- icon-box -->
          </div>

          <div class="col-xl-3 col-md-6 align-items-stretch mt-4 mt-md-0">
            <div class="icon-box col-12  d-flex  ps-1 pe-1">
              <div class="col-4 text-center">
	              <div class="icon"><i class="ri-question-line"></i></div>
	              <h5><a href="#">문의관리</a></h5>
              </div>
              <div class="col-8 card small border-light">
              		<div class="small" id="est_dash">
              			<p class="btn btn-outline-success btn-block mb-2" onclick="open_brd_dash('total','1')">총 문의 : <span id="total_board">00</span> 건</p>
              			<p class="btn btn-outline-primary btn-block mb-2" onclick="open_brd_dash('day','1')">오늘 문의 : <span id="today_board">00</span> 건</p>
              		</div>
              </div>
            </div>
            <!-- icon-box -->
            <div class="icon-box col-12 ps-1 pe-1 detail_box" id="brd_dash_detail"  data-aos="fade-up" data-aos-delay="100" style='display:none;'>
            	<!-- Board_dash_detail Container -->
            </div>
            <!-- icon-box -->
          </div>
		 
          <div class="col-xl-3 col-md-6 d-flex align-items-stretch mt-4 mt-xl-0">
           <div class="icon-box col-12  d-flex  ps-1 pe-1">
              <div class="col-4 text-center">
	              <div class="icon"><i class="ri-gallery-fill"></i></div>
	              <h5><a href="#">사진관리</a></h5>
              </div>
              <div class="col-8 card small border-light">
              		<div class="small text-center" id="pict_dash">
              			<p class="small text-info">[소중한 순간]</p>
              			<p class="small">사진을 수정하시려면</p>
              			<p class="small">클릭하세요.</p>
              		</div>
              </div>
            </div>
          </div>
		  	
        </div>
	  
      </div>
      
    </section>

	 <!-- ======= Footer ======= -->
	  <footer id="footer">
	    <div class="footer-top pt-1">
		    <div class="row">
	      		<h3 class="col-6 btn btn-lg btn-danger mt-4 mx-auto" onclick='javascript:location.href="/logout"'>로그아웃</h3>
	      	</div>
	    </div>
	    <div class="container footer-bottom clearfix">
	      <div class="copyright">
	        &copy; Copyright <strong><span>AMORSTELLA</span></strong>. All Rights Reserved
	      </div>
	      <div class="credits">
			<!-- credit 내용 없음 -->
	      </div>
	    </div>
	  </footer><!-- End Footer -->
	
</body>
</html>