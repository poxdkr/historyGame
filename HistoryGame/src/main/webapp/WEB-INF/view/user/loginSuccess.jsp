<%@page import="java.security.Principal"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common.jsp" %>
<% 
	String userid = (String)session.getAttribute("userid");
	String role = (String)session.getAttribute("role");
	/* System.out.println("userid : " + userid);
	System.out.println("role : " + role); */
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 성공</title>
<script>
$(function(){
	let role = $("#role").val();
/* 	alert(role); */
	if(role == "admin"){
		location.href="/admin?login=admin";
	}else{
		location.href="/";
	}
});	
</script>
</head>
<body>
	<input type="hidden" name="role" id="role" value=<%=role%>>
</body>
</html>