 <%@page import="com.history.game.lol.getdata.GetData"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
GetData getData = new GetData();
String ak = (String)getData.get_ak();
%>    
 <!DOCTYPE html>
 <html>
<head>
<meta charset="UTF-8">
<%@include file="common.jsp" %>
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>HistoryGame</title>
<!--   <meta content="" name="description"> -->
  <meta content="" name="keywords">
</head>

<body>
	<input type='hidden' name='ak' id='ak' value=<%=ak %> >
  <!-- ======= Header ======= -->
  <header id="header" class="fixed-top ">
    <div class="container d-flex align-items-center">
      <h1 class="logo me-auto"><a href="/"><small>No Name</small></a></h1>
      <!-- Uncomment below if you prefer to use an image logo -->
      <!-- <a href="index.html" class="logo me-auto"><img src="assets/img/logo.png" alt="" class="img-fluid"></a>-->

      <!-- <nav id="navbar" class="navbar">
        <ul>
          <li><a class="nav-link scrollto active" href="#hero">처음으로</a></li>
          <li><a class="nav-link scrollto" href="#about">우리는?</a></li>
          <li><a class="nav-link scrollto" href="#services">교육 서비스</a></li>
          <li><a class="nav-link scrollto" href="#cta">교육 문의</a></li>
          <li><a class="nav-link scrollto" href="#portfolio">소중한 순간</a></li>
          <li><a class="nav-link scrollto" href="#team">팀메이트</a></li>
          <li><a class="nav-link scrollto" href="#contact">어디에 있나요?</a></li>
        </ul>
        <i class="bi bi-list mobile-nav-toggle"></i>
      </nav> -->
      <!-- .navbar -->

    </div>
  </header><!-- End Header -->