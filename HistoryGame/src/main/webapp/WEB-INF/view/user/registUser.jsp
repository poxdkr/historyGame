
<%@page import="com.history.game.lol.AES256Cipher"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="../common.jsp" %>    
<title>어서와요!</title>
<script>

$(function(){
	
});
</script>
</head>
<body>
	<p>가입입니다.</p>
	
	<form action = "/registUser" method="post">
		<table class="col-12">
			<tr>
				<td class="col-3">아이디</td><td colspan="2" class="col-9"><input class= "col-12" type="text" name = "userId" id="userId"></td>
			</tr>
			<tr>
				<td class="col-3">비밀번호</td><td colspan="2"  class="col-9"><input  class= "col-12" type="password" name = "pw" id="pw"></td>
			</tr>
			<!-- <tr>
				<td class="col-3">학교검색</td>
				<td class="col-6"><input class= "col-12" type="text" name="aff_sch" id="aff_sch"/></td>
				<td class="col-3"><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#sch_modal"  class= "col-12" >학교검색</button></td>
			</tr> -->
			<tr>
				<td colspan="2">
					<input type="hidden" name="grade" value="1">
					<input type="hidden" name="upoint" value = "0">
					<input type="hidden" name="cert" value= "none">
					<input type="hidden" name="role" value="friend">
					
					<button type="submit">등록</button>
				</td>
			</tr>
		</table>
		<div class="modal" id="sch_modal" tabindex="-1" aria-labelledby="sch_modalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title">학교검색</h5>
		        <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close">X</button>
		      </div>
		      <div class="modal-body">
		        <p>학교명을 입력해주세요</p>
		        <input type="text" onkeyup="sch_search_ajax(this.value)"/>
				<table id="sch_table">		        		
		        </table>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button type="button" class="btn btn-primary">Save changes</button>
		      </div>
		    </div>
		  </div>
		</div>
		<p><a href='/aesCheck?info=testId'>user정보 확인해보기 (info=testId)</a></p>
	</form>
</body>
</html>