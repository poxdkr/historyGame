<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 하단 control_modal -->
<form id='search_frm' method='post' action='/summoner'>
	<div class="modal fade align-middle" id="main_btn_modal" tabindex="-1" aria-labelledby="main_btn_modalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog centered bg-transparent m-3">
	    <div class="modal-content bg-transparent  border border-0">
	      <div class="modal-body d-flex flex-column">
	      	<div class='col-12 border border-dark rounded p-2 bg-white  d-flex flex-column justify-content-center'>
	      		<h2 class='alert alert-light fw-bolder text-center m-0 pb-0'>소환사 전적 검색</h2>
	      		<hr class='divider'>
	      		<input type='text' name ='lol_id' id='lol_id' class='form-control mt-5 mb-5 mx-auto text-center' placeholder='소환사명 입력' style='width:50%;'/>
	        	<button type="submit" class='btn btn-sm rounded btn-primary mt-2 mb-5 mx-auto' id='total_search_btn' style='width:50%;'><i class="ri-search-line"></i> 검색</button>
	        </div>
	        <div class='col-12 border border-dark rounded p-2 bg-white mt-2 d-flex flex-column justify-content-center'>
	        	<h2 class='alert alert-light fw-bolder text-center m-0 pb-0'>챔피언 정보</h2>
	        	<hr class='divider'>
	        	<button type="button" class='btn btn-sm rounded btn-primary mt-5 mb-5 mx-auto' id='champ_search_btn' onclick="javascript:location.href='go_champ_page'"  style='width:50%;'><i class="ri-list-check"></i> 챔피언 전체보기</button>
	        </div>
	      </div>
	      
	    </div>
	  </div>
	</div>
</form>
<!-- 하단 control_modal -->