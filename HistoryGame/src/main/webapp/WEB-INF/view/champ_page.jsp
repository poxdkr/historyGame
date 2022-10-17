<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file='header.jsp'%>

<% 
	
%>

<script>
function open_champInfo(){
	return fetch('/assets/js/champion.json').then(r => r.json()).then(function(json){
		var data_str = JSON.stringify(json.data);
		console.log(json.data);
		let champ_data = json.data;
		
		html = "";
		let imgSrc = 'assets/img/champion/';
		let index = 1;
		let length = Object.keys(champ_data).length;
		
		for(key in champ_data){
			
			champ_name = champ_data[key].name;
			let image = champ_data[key].image.full;
			
			//첫줄일 경우
			if(index == 1){
				html += "<tr>";	
			}
    		
    		html += "<td class='p-0 text-center small' style = 'width:25%'><img src='"+imgSrc+image+"' class='img' style = 'width:100%'><span id='champ_name' class='mx-auto small'>"+champ_name+"</span></td>";
			
    		//4개 td 출력후
    		if(index %4 == 0){
    			html += "</tr>";
    			html += "<tr>";
    			
    		//length만큼 index가 되었다면
    		}else if(index == length){
    			html += "</tr>";
    		}
			
			index++; //index 증가
		}
		
		$("#champ_table").html(html);
		$("#champ_table").css("overflow-y",'scroll');
	});
}

open_champInfo();

//onload function
$(function(){

});
</script>
<!-- 서버에서 전달받은 정보 -->

<!-- section_1 -->
 <section id="" class="d-flex align-items-center" data-aos="zoom-in" data-aos-delay="200" >
 	<div class="container m-1 pt-0 mx-auto">
      <div class="row">
        	<div class='col-12 align-items-center'>
        		<input type="text" name='champ_name' id='champ_name' class='form-control mx-auto mt-3 mb-3' placeholder='이름을 입력' style='width:50%;'>
        	</div>
        	<div class="card-header text-center">
        		<h6 class='lead fw_bolder'>챔피언 정보</h6>
        	</div>
        	<table class='table' id='champ_table'>
        	<!--  -->

        	</table>
        
      </div>
    </div>
 	
	<!-- Modal -->
	<form id='search_frm' method='post' action='/summoner'>
		<div class="modal fade align-middle" id="main_btn_modal" tabindex="-1" aria-labelledby="main_btn_modalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-dialog centered bg-transparent">
		    <div class="modal-content bg-transparent  border border-0">
		      
		      <div class="modal-body d-flex flex-column">
		      	<div class='col-12 border border-white rounded p-2 bg-white'>
		      		<h2>롤 전적을 확인하려고?</h2>
		      		<input type='text' name ='lol_id' id='lol_id' class='form-control mt-5' placeholder='아이디 입력'/>
		        	<button type="submit" class='btn rounded btn-primary mt-2 mb-5' id='total_search_btn'>전적검색</button>
		        </div>
		        <div class='col-12 border border-white rounded p-2 bg-white mt-2'>
		        	<h2>챔피언 정보를 확인하려고?</h2>
		        	<button type="button" class='btn rounded btn-primary mt-5 mb-5' id='champ_search_btn' onclick="javascript:location.href='go_champ_page'">챔피언 전체보기</button>
		        </div>
		      </div>
		      
		    </div>
		  </div>
		</div>
	</form>
	<!-- Modal -->
  </section>
  <!-- section_1 -->

<!-- footer -->  
  <footer id='footer' class='position-fixed bottom-0 col-12 pb-2 pt-1'>
  		<div class="d-flex justify-content-center justify-content-lg-start footer-top pt-0 pb-0 bg-transparent">
          	<!-- modal trigger -->
            <a href="#" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#main_btn_modal"><i class="ri-menu-line fw-bolder"></i></i></a>
            <!-- modal trigger -->
        </div>
  </footer>
	
</body>
  
  <div id="preloader"></div>
  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>	
   
  <!-- Vendor JS Files -->
  <script src="assets/vendor/aos/aos.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="assets/vendor/waypoints/noframework.waypoints.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>
</html>