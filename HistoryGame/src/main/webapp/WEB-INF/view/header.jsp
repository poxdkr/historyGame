 <%@page import="com.history.game.lol.getdata.GetData"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
GetData getData = new GetData();
String ak = (String)getData.get_ak();
String g_ak = (String)getData.get_g_ak();
%>    
 <!DOCTYPE html>
 <html>
<head>
<meta charset="UTF-8">
<%@include file="common.jsp" %>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
 
  <title>Untitled _ LoL</title>
<!--   <meta content="" name="description"> -->
  <meta content="" name="keywords">
  <script>
  $(function(){
	  //시계 만들기
	  function get_time(){
		  let now = new Date();
		  let year = now.getFullYear().toString().substring(2,4);
		  
		  let month = now.getMonth() < 10 ? "0"+now.getMonth() : now.getMonth();
		  let date = now.getDate() < 10 ? "0" + now.getDate() : now.getDate();
		  let day = now.getDay();
		  switch(day){
			  case 0 : day = "Sun"; break;
			  case 1 : day = "Mon"; break;
			  case 2 : day = "Tue"; break;
			  case 3 : day = "Wed"; break;
			  case 4 : day = "Thu"; break;
			  case 5 : day = "Fri"; break;
			  case 6 : day = "Sat"; break;
		  }
		  let hours = now.getHours() < 10 ? "0" + now.getHours() : now.getHours();
		  let minutes = now.getMinutes() < 10 ? "0" + now.getMinutes() : now.getMinutes();
		  let seconds = now.getSeconds() < 10 ? "0" + now.getSeconds() : now.getSeconds();
		  
		  let time = month +"/"+ date +" ("+ day +") "+ hours +":"+ minutes +":"+ seconds;
		  return time;
	  }
	  
	  function set_time(){
		  //시간 입력
		  $("#digit_clock").html(get_time());
		  //초마다 반복
		  setTimeout(set_time,1000);
	  }
	  //시계 시작
	  set_time();
  });
  </script>
</head>

<body>
	<input type='hidden' name='ak' id='ak' value=<%=ak %> >
	<input type='hidden' name='g_ak' id='g_ak' value=<%=g_ak %> >
  <!-- ======= Header ======= -->
  <header id="header" class="fixed-top ">
    <div class="container d-flex align-items-center">
      <h2 class="logo me-auto"><a href="/"><small class='fw-bolder'>Untitled<!-- <span class='text-muted small'>(made by. WG)</span> --></small></a></h2>
      <div id='digit_clock' class='badge bg-success bg-gradient'></div>
    </div>
  </header><!-- End Header -->