<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>
<%
String error = request.getParameter("error");
/* System.out.println("error : " + error); */

%>
<script>
AOS.init();
$(function(){
	let error = $("#error").val();
	if(error == "fail.jsp"){
		toastr.error("ID 혹은 PW를 확인해주세요.");
		$("#userid").focus();
	}
	$("#navbar").remove();
});
</script>
<div class="container pt-5 pb-5">  </div>


<div class="container ms-0 me-0 row text-center text-muted">
		
		<div class="col-6 mx-auto"  data-aos='flip-left' data-aos-delay='500'>
			<img src="assets/img/lock.png" class="img col-12">
		</div>
	
		<form action="/loginProc" method="post"  class="row p-2 col-md-6 mx-auto mt-5"  data-aos='zoom-in'>
			<div class="form-group mt-2 mb-2">
				<label for='userid'>ID</label>
				<input type='text' name="userid" id="userid" class="form-control"/>
			</div>
			<div class="form-group mt-2 mb-2">
				<label for='pw'>PASSWORD</label>
				<input type='password' name="pw" id="pw"  class="form-control"/>
			</div>
			<div class="col-12 mt-5 mb-5"><button class="btn btn-block btn-lg btn-primary" type="submit">로그인</button></div>
		</form>
</div>
<input type="hidden" name="error" id="error" value=<%=error %>>
</body>
</html>