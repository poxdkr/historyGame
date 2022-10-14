<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>
	<script>
	
		//data-aos init
		AOS.init();
		/////////////////////////////////////////////////////////////////////////////////
		
		/////////////////////////////////////////////////////////////////////////////////
		//onload
		$(function(){
			//기본 스타일 조정
			$("#navbar").remove();			
			/////////////////////////////////////////////////////////////////////////////////
			//문의 등록하기
			$("#submit_est").click(function(){
				let valueArr = [];
				valueArr[0] = $("#sch_name").val();
				valueArr[1] = $("#username").val();
				valueArr[2] = $("#phone").val();
				valueArr[3] = $("#btitle").val();
				valueArr[4] = $("#content").val();
				
				for(var i =0; i<valueArr.length; i++){
					if(valueArr[i] == "" | valueArr[i] ==null){
						toastr.error("필수 입력값이 누락되어 있습니다!");
						return;
					} 
				}
				
				$("#est_frm").submit();
				
			});
			//문의 등록하기 종료
			/////////////////////////////////////////////////////////////////////////////////
			//문의조회하기
			$("#search_est_btn").click(function(){
				let username = $("#username_search").val();
				let phone = $("#phone_search").val();
				
				if(username == "" || username == null){
					toastr.error("내역조회에는 담당자명이 필요합니다!");
					$("#username_search").focus();
					return;
				} 
				if(phone == "" || phone == null){
					toastr.error("내역조회에는 연락처가 필요합니다!");
					$("#phone_search").focus();
					return;						
				}
				
				$.ajax({
					url:"/search_est",
					method:"GET",
					data:"username="+username+"&phone="+phone,
					dataType : "json",
					contentType : "application/json",
					success:function(data){
						if(data.length == 0){
							console.log(data);
							toastr.warning("해당 내용으로 등록된 문의가 없습니다.");
						}
						html = "";
						$.each(data,function(index,item){
							let btitle = this.btitle;
							let content = this.content;
							let username = this.username;
							let email = this.email;
							let phone = this.phone;
							let regdate = this.regdate;
							
							html += "<div class=\"card row text-center mt-4 small\">";
							html += "<div class=\"col-12 card-header\"> 문의내역 </div>";
							html += "<div class=\"col-12 d-flex border-bottom p-2\">";
							html += "<div class=\"col-6 text-primary\">"+username+"</div><div class=\"col-6\">"+phone+"</div>";
							html += "</div>";
							html += "<div class=\"col-12 d-flex border-bottom ps-0\">";
							html += "<div class=\"col-3 bg-light text-secondary  p-2\">이메일</div><div class=\"col-9 p-2\">"+email+"</div>";
							html += "</div>";
							html += "<div class=\"col-12 d-flex border-bottom ps-0\">";
							html += "<div class=\"col-3 bg-light text-secondary p-2\">등록일</div><div class=\"col-9 p-2\">"+regdate+"</div>";
							html += "</div>";
							html += "<div class=\"col-12 d-flex p-2\">";
							html += "<div class=\"col-12 card-body text-secondary\" style='min-height:150px;'>"+content+"</div>";
							html += "</div>";
							html += "<div class=\"col-12 card-footer\">";
							html += "</div>";
							html += "</div>";
							
						});
							$("#est_table").html(html);
						
					},error : function(data){
						console.log(data);
						toastr.warning("해당 내용으로 등록된 문의가 없습니다.");
					}
				})
			});
			
			//문의 조회하기
			/////////////////////////////////////////////////////////////////////////////////
		});
		
		
	</script>
	<div class="mt-1" style="height:60px;">
	</div>
	<div class="row m-2"  data-aos="flip-left">
		<nav aria-label="breadcrumb-divider: ">
		  <ol class="breadcrumb">
		    <li class="breadcrumb-item" ><a href="/"  class="small">HOME</a></li>
		    <li class="breadcrumb-item active" aria-current="page" ><span  class="small">문의하기</span></li>
		  </ol>
		</nav>
	</div>
	<div class="col-12"  data-aos="fade-up">
		<div class="col-12">
			<div class="section-title">
	          <h2>문의하기</h2>
	        </div>
		</div>
		<div class="col-12 p-0">
			  <p class="small text-center text-secondary" data-toggle="modal" data-target="#amor_modal" ><i class="bx bx-help-circle icon-help text-info"></i> <small>이미 문의하신 기록이 있나요??</small></p>
		</div>
	</div>
	<div class="" id="est_content" data-aos="fade-up">
		<div class="col-lg-7 mt-5 mb-5 mt-lg-0 d-flex align-items-stretch">
		  <form action="/send_est" method="post" role="form" class="input-frm" id="est_frm">
		    <div class="row">
		      <div class="form-group col-md-6">
		        <label for="name"><small class="text-black">기관명 <strong class="text-danger">*</strong></small></label>
		        <input type="text" name="sch_name" class="form-control" id="sch_name" required placeholder="학교나 기관명을 입력해주세요.">
		      </div>
		      <div class="form-group col-md-6">
		        <label for="name"><small class="text-black">담당자 <strong class="text-danger">*</strong></small></label>
		        <input type="text" name="username" class="form-control" id="username" required placeholder="담당자의 이름을 입력해주세요.">
		      </div>
		      <div class="form-group col-md-6">
		        <label for="name"><small class="text-black">Email. <strong class="text-secondary">(선택)</strong></small></label>
		        <input type="email" class="form-control" name="email" id="email">
		      </div>
		      <div class="form-group col-md-6">
		        <label for="name"><small class="text-black">Mobile. <strong class="text-danger">*</strong></small></label>
		        <input type="number" class="form-control" name="phone" id="phone" required placeholder="연락처를 입력해주세요.('-'제외)">
		      </div>
		    </div>
		    <div class="form-group">
		      <label for="name"><small class="text-black">문의제목 <strong class="text-danger">*</strong></small></label>
		      <input type="text" class="form-control" name="btitle" id="btitle" required>
		    </div>
		    <div class="form-group">
		      <label for="name"><small class="text-black">문의내용 <strong class="text-danger">*</strong></small></label>
		      <textarea class="form-control" rows="10" required name="content" id="content" placeholder="문의 내용을 입력해주세요."></textarea>
		    </div>
		    <div class="text-center">
		    	<button class=" btn btn-block btn-lg btn-success text-white rounded" type="button" id="submit_est"><strong>작성완료</strong></button>
		    </div>
		  </form>
		</div>
	</div>
	<!-- modal start -->
	<div class="modal" id="amor_modal" tabindex="-1" aria-labelledby="sch_modalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		       <div class="col-12">
					<div class="section-title">
			          <h2>내 문의 조회</h2>
			        </div>
				</div>
		      </div>
		      <div class="modal-body">
		      
				  <p><small class="text-black">담당자 <strong class="text-danger">*</strong></small></p>
				  <input type="text" class="form-control" name="username_search" id="username_search" placeholder="문의내역에 입력한 담당자명을 입력해주세요.">
				  <br/>
				  <p><small class="text-black">연락처 <strong class="text-danger">*</strong></small></p>
				  <input type="number" class="form-control" name="phone_search" id="phone_search"  placeholder="연락처를 입력해주세요.('-'제외)">
				  <button type="button" class="btn btn-block btn-lg btn-primary mt-4 mb-4" id="search_est_btn"><strong>조회하기</strong></button>
				  
				  <hr class="mt-2 mb-2"/>
				  
				  <div id="est_table">
				  </div>
				  
						<!-- 문의 내역 DIV -->
						
				  
				  
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">창닫기</button>
		        <!-- <button type="button" class="btn btn-primary">Save changes</button> -->
		      </div>
		    </div>
		  </div>
		</div>
	<!-- modal end -->
</body>
</html>