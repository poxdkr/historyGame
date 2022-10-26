<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file='header.jsp'%>

<% 
	
%>
<style>
	#champ_mov {
		width : 100%;
	} 
	#mov_result_div{
		min-height : 150px;
	}
	
	#champ_mov div{
		font-size : 12px;
		overflow : hidden;
	}
</style>
<script>
var skill_set = {"passive":{},"spell_0":{},"spell_1":{},"spell_2":{},"spell_3":{}};
var g_api_key = $("#g_ak").val();

function open_champ(champ_name){
	return fetch('/assets/js/champion_json/'+champ_name+".json").then(result => result.json()).then(function(json){
		var champ_data = json.data;
		for(key in champ_data){
			let c_data = champ_data[key];
			//console.log(c_data);	
			//챔피언 이미지
			let imgSrc = 'assets/img/'
			let image = c_data.image.full;
			$("#champ_img").prop("src",imgSrc+"champion/"+image);
			//챔피언 이름
			$("#champ_nm").html(c_data.name);
			//챔피언 설명
			$("#champ_desc").html(c_data.blurb);
			//패시브 및 스킬 이미지
			$("#passive_img").prop("src",imgSrc+"passive/"+c_data.passive.image.full);
			skill_set.passive.name = c_data.passive.name;
			skill_set.passive.description = c_data.passive.description;
			var spells = c_data.spells;
			//console.log("spells",spells);
			for(var i=0; i < spells.length; i++){
				$("#skill_"+i+"_img").prop("src",imgSrc+"spell/"+spells[i].image.full);
				//console.log("spells",spells[i]);
				if(i == 0){
					skill_set.spell_0.name = spells[i].name;
					skill_set.spell_0.description = spells[i].description;
				}else if(i == 1){
					skill_set.spell_1.name = spells[i].name;
					skill_set.spell_1.description = spells[i].description;
				}else if(i == 2){
					skill_set.spell_2.name = spells[i].name;
					skill_set.spell_2.description = spells[i].description;
				}else if(i == 3){
					skill_set.spell_3.name = spells[i].name;
					skill_set.spell_3.description = spells[i].description;
				}
			}// spells for 종료
			
			//관련 유투브 영상 확인
			let keyword = c_data.name+" 강의";
			let search_data = {};
			search_data.part =  "id, snippet";
			search_data.maxResults =  "10";
			search_data.order = "viewCount";
			search_data.q = keyword;
			search_data.type = "video";
			search_data.key = g_api_key;
			
			// 1) youtube api search list (id, snippet를 part로 가져올 것)
			 $.ajax({
				url : "https://www.googleapis.com/youtube/v3/search",
				data : search_data,
				dataType : "json",
				contentType : "application/json",
				async : false,
				success : function(data){
					console.log(data);
					$("#champ_mov").html("");
					var result_list = data.items;
					for(var i = 0; i < result_list.length; i++){
						var result = {};
						result.index = i; //index
						result.videoId = result_list[i].id.videoId; //videoId
						result.videoSrc ="https://www.youtube.com/embed/"+result_list[i].id.videoId; //embed할 비디오의 주소
						let title = result_list[i].snippet.title; //title 최대 12자
						let description = result_list[i].snippet.description; //description 최대 20자
						result.title = title.length > 20 ? title.substring(0,20)+"..." : title;
						result.description = description.length > 40 ? description.substring(0,40)+"..." : description;
						result.thumbnails = result_list[i].snippet.thumbnails.default.url; // thumbnail img src
						result.channelTitle = result_list[i].snippet.channelTitle;
						
						let mov_html = "";
						mov_html += "<div id='mov_result_div' class='col-12 d-flex p-0 m-0 border-bottom border-secondary' data-bs-toggle='modal' data-bs-target='#video_modal' onclick='open_video(\""+result.videoSrc+"\")'>";
							mov_html += "<div class='col-3 p-1 border border-light bg-white d-flex align-items-center'>";
								mov_html += "<img src='"+result.thumbnails+"' class='rounded' style='width:100%;'>";
							mov_html += "</div>";
							mov_html += "<div class='col-9 p-0'>";
								mov_html += "<div class='p-2 border border-light bg-danger bg-opacity-10 bg-gradient text-dark fw-bolder'><span id='mov_title' class='align-middle'>"+result.title+"</span></div>";
								mov_html += "<div id='mov_desc' class='p-2 border border-light bg-light bg-opacity-10 text-secondary small align-middle text-break'>"+result.description+"</div>";
								mov_html += "<div id='mov_chanTitle' class='p-2 pt-0 pb-0 border border-light bg-light bg-opacity-10 text-secondary small align-middle'><i class=\"ri-youtube-fill\" style='color:#c4302b; font-size : 17px;'></i>  "+result.channelTitle+"</div>";
							mov_html += "</div>";
						mov_html += "</div>";
						
	      				$("#champ_mov").append(mov_html);
					}
				},error : function(data){
					console.log(data);
				}
			}); 
			
			
			
		} // champ_data for 종료
		
	}); //fetch then 종료
}

function show_desc(value){
	$("#skill_desc").css("display","block");
	var this_id = $(value).prop("id");
	switch (this_id){
		case("passive_img") : 
			$("#skill_desc_name").html(skill_set.passive.name);
			$("#skill_desc_span").html(skill_set.passive.description);
			break;
		case("skill_0_img") :
			$("#skill_desc_name").html(skill_set.spell_0.name);
			$("#skill_desc_span").html(skill_set.spell_0.description);
			break;
		case("skill_1_img") :
			$("#skill_desc_name").html(skill_set.spell_1.name);
			$("#skill_desc_span").html(skill_set.spell_1.description);
			break;
		case("skill_2_img") :
			$("#skill_desc_name").html(skill_set.spell_2.name);
			$("#skill_desc_span").html(skill_set.spell_2.description);
			break;
		case("skill_3_img") :
			$("#skill_desc_name").html(skill_set.spell_3.name);
			$("#skill_desc_span").html(skill_set.spell_3.description);
			break;
	}
}

function no_desc(){
	$("#skill_desc").css("display","none");
	$("#skill_desc_name").html("");
	$("#skill_desc_span").html("");
}

function open_champInfo(type, keyword){
	return fetch('/assets/js/championFull.json').then(r => r.json()).then(function(json){
		var data_str = JSON.stringify(json.data);
		console.log(json.data);
		let champ_data = json.data;
		
		html = "";
		let imgSrc = 'assets/img/champion/';
		let index = 1;
		let length = Object.keys(champ_data).length;
		$("#champ_table").html("");
		
		if(type == "all"){ //전체 검색일 경우
			for(key in champ_data){
				
				champ_name = champ_data[key].name;
				let image = champ_data[key].image.full;
				
				//첫줄일 경우
				if(index == 1){
					html += "<tr>";	
				}
	    		
	    		html += "<td class='p-2 text-center small' style = 'width:100px'>";
	    		html += "<a href='#' class='btn btn-light p-0' data-bs-toggle='modal' data-bs-target='#champ_detail_modal' onclick='open_champ(\""+key+"\");'>";
	    		html += "<img src='"+imgSrc+image+"' class='img rounded border border-light' style = 'width:100%'><span id='champ_name' class='mx-auto small text-dark fw-bold'><small>"+champ_name+"</small></span></a>";
	    		html += "</td>";
				
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
		}else if(type == "search"){ //검색일 경우
			for(key in champ_data){
				
				champ_name = champ_data[key].name;
				let image = champ_data[key].image.full;
				
				if(champ_name.search(keyword) != -1){
					
					//첫줄일 경우
					if(index == 1){
						html += "<tr>";	
					}
		    		
		    		html += "<td class='p-2 text-center small' style = 'width:100px;'>";
		    		html += "<a href='#' class='btn btn-light p-0' data-bs-toggle='modal' data-bs-target='#champ_detail_modal' onclick='open_champ(\""+key+"\");'>";
		    		html += "<img src='"+imgSrc+image+"' class='img rounded border border-light' style = 'width:100%'><span id='champ_name' class='mx-auto small text-dark fw-bold'><small>"+champ_name+"</small></span></a>";
		    		html += "</td>";
					
		    		//4개 td 출력후
		    		if(index %4 == 0){
		    			html += "</tr>";
		    			html += "<tr>";
					
		    		//length만큼 index가 되었다면
		    		}else if(index >= 4 && index == length){
		    			html += "</tr>";
		    		}
					
					index++; //index 증가
				}
			}
			
		}
		//테이블에 입력
		$("#champ_table").html(html);
		$("#champ_table").css("overflow-y",'scroll');
		$("td").css("border","none");
	});
	
}

function open_video(video_src){
	//video 초기화
	$("#champ_video").attr("src","");
	
	//video 주소 넣기
	$("#champ_video").attr("src",video_src);
}

function close_video(){
	//video 초기화
	$("#champ_video").attr("src","");
}

//첫 로드시 모두 나오도록 함
let type="all";
let keyword = "";
open_champInfo(type, keyword);

//onload function
$(function(){
	$("#champ_name").keyup(function(){
		keyword = $("#champ_name").val();
		type = "search";
		open_champInfo(type, keyword);
	});
});
</script>
<!-- 서버에서 전달받은 정보 -->

<!-- section_1 -->
 <section id="" class="d-flex align-items-center" data-aos="zoom-in" data-aos-delay="200" >
 	<div class="container m-1 pt-0 mx-auto">
      <div class="row">
      		<!-- 챔피언 검색창 -->
        	<div class='col-12 align-items-center'>
        		<input type="text" name='champ_name' id='champ_name' class='form-control mx-auto mt-3 mb-3' placeholder='챔피언 검색' style='width:50%;'>
        	</div>
        	<!-- header -->
        	<!-- <div class="card-header text-center">
        		<h6 class='lead fw_bolder'>챔피언 정보</h6>
        	</div> -->
        	<!-- 챔피언 리스트 -->
        	<table class='table' id='champ_table'>
        	<!-- table content -->
        	</table>
        
      </div>
    </div>
 	
	
	
  </section>
  <!-- section_1 -->
  	
	<!-- control_modal -->
	<%@include file='./control_modal.jsp' %>
	<!-- control_modal -->
	
	<!-- Modal_2 -->
	
 	<div class="modal fade align-middle" id="champ_detail_modal" tabindex="-1" aria-labelledby="champ_detail_modalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog centered bg-transparent">
	    <div class="modal-content bg-transparent  border border-0">
	      <div class="modal-body d-flex flex-column bg-white">
	      	<div class='col-12 p-0'>
	      		<h3>챔피언 정보</h3>
	      		<button type="button" class="btn btn-danger position-fixed ps-3 pe-3" data-bs-dismiss="modal" style='top : 15px; right : 20px; z-index:9999;'> X </button>
	      		<hr>
	      		<div class='col-12 d-flex'>
	      			<div class='col-3 p-0 d-flex flex-column justify-content-center'>
	      				<img src='' id='champ_img' class='img rounded border border-secondary' style='width:100%'>
	      				<div class='title text-dark fw-bold small text-center'>
	      					<small  id='champ_nm'><!-- 챔피언 이름 --></small>
	      				</div>
	      			</div>
	      			<div class='col-9 d-flex flex-column'>
	      				<div class='col-12 d-flex justify-content-between p-0'>
	      					<div class='col-12 p-3 m-1 position-absolute border border-secondary bg-light bg-gradient' style='top:50px; left:0px; display:none;' id='skill_desc'>
	      						<small class='text-dark col-12 p-0' style='font-size:10px;'> [ <span id='skill_desc_name'>스킬명</span> ]</small><br/>
	      						<small class='text-muted' id='skill_desc_span' style='font-size:8px;'>스킬설명</small>
	      					</div>
		      				<div class='col-2 p-0 d-flex flex-column justify-content-center' id='passive_img_div'>
		      					<span class='badge bg-info badge-sm fw-bolder text-center'>P</span>
		      					<img src='' id='passive_img' class="img rounded border border-dark" style='width:100%' onmouseenter='show_desc(this);' onmouseout = 'no_desc();'>
		      				</div>
		      				<div class='col-2 p-0 d-flex flex-column justify-content-center' id='skill_1_img_div'>
		      					<span class='badge bg-dark badge-sm fw-bolder text-center'>Q</span>
		      					<img src='' id='skill_0_img' class="img rounded border border-dark" style='width:100%' onmouseenter='show_desc(this);' onmouseout = 'no_desc();'>
		      				</div>
		      				<div class='col-2 p-0 d-flex flex-column justify-content-center' id='skill_2_img_div'>
		      					<span class='badge bg-dark badge-sm fw-bolder text-center'>W</span>
		      					<img src='' id='skill_1_img' class="img rounded border border-dark" style='width:100%' onmouseenter='show_desc(this);' onmouseout = 'no_desc();'>
		      				</div>
		      				<div class='col-2 p-0 d-flex flex-column justify-content-center' id='skill_3_img_div'>
		      					<span class='badge bg-dark badge-sm fw-bolder text-center'>E</span>
		      					<img src='' id='skill_2_img' class="img rounded border border-dark" style='width:100%' onmouseenter='show_desc(this);' onmouseout = 'no_desc();'>
		      				</div>
		      				<div class='col-2 p-0 d-flex flex-column justify-content-center' id='skill_4_img_div'>
		      					<span class='badge bg-warning badge-sm fw-bolder text-center'>R</span>
		      					<img src='' id='skill_3_img' class="img rounded border border-dark" style='width:100%' onmouseenter='show_desc(this);' onmouseout = 'no_desc();'>
		      				</div>
			      		</div>
	      				
	      				<div class='text-muted small overflow-scroll rounded border border-light mt-3' id='champ_desc' style="max-height:100px; font-size:11px;">
	      					<!-- 챔피언 설명 -->
	      				</div>
	      			</div>
	      		</div>
	      		
	      		<hr>
	      		<div class="col-12 bg-opacity-10 fw-bolder rounded p-3 text-white mb-2" style='background-color:#c4302b;'>YOUTUBE 강의영상</div>
	      		<div class='row m-0' id='champ_mov'>
	      			<!-- 관련 youtube영상 -->
	      		</div>
	      	</div>
	      </div>
	    </div>
	  </div>
	</div>

	<!-- Modal_2 -->
	
	<!-- video player modal -->
 	<div class="modal fade align-middle" id="video_modal" tabindex="-1" aria-labelledby="video_modalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog centered bg-transparent">
	    <div class="modal-content bg-transparent  border border-0">
	      <div class="modal-body bg-transparent">
	      	<div class='col-12 p-0 d-flex justify-content-center align-items-center' style="height:450px;">
	      		<button type="button" class="btn btn-danger position-fixed mx-auto ps-3 pe-3" data-bs-dismiss="modal" style='top : 15px; z-index:9999;' onclick="close_video();"> X </button>
				<iframe class='p-0' id='champ_video' width="350" height="250" src=""></iframe>
	      	</div>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- video player modal -->
	
<!-- footer -->  
  <footer id='footer' class='position-fixed bottom-0 col-12 pb-2 pt-1'>
  		<div class="d-flex justify-content-center justify-content-lg-start footer-top pt-0 pb-0 bg-transparent">
          	<!-- Modal_1 trigger -->
            <a href="#" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#main_btn_modal"><i class="ri-menu-line fw-bolder"></i></a>
            <!-- Modal_1 trigger -->
        </div>
  </footer>
<!-- footer -->  
  
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