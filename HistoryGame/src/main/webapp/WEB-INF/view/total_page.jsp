<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file='header.jsp'%>

<% //scriptlet
	
%>

<script>
//emblem_src_json
var emblem_src = './assets/img/emblems/';
var emblems = {"iron":"","bronze":"","silver":"","gold":"","platinum":"","diamond":"","master":"","grandmaster":"","challenger":""};
emblems.iron = emblem_src+"Emblem_Iron.png";
emblems.bronze = emblem_src+"Emblem_Bronze.png";
emblems.silver = emblem_src+"Emblem_Silver.png";
emblems.gold = emblem_src+"Emblem_Gold.png";
emblems.platinum = emblem_src+"Emblem_Platinum.png";
emblems.diamond = emblem_src+"Emblem_Diamond.png";
emblems.master = emblem_src+"Emblem_Master.png";
emblems.grandmaster = emblem_src+"Emblem_Grandmaster.png";
emblems.challenger = emblem_src+"Emblem_Challenger.png";



function fetch_champ_resource(){
		return fetch('/assets/js/champion.json').then(r => r.json()).then(function(json){
	    var data_str = JSON.stringify(json.data);
		sessionStorage.setItem('champ_data',data_str);
	});		
}

function fetch_item_resource(){
	return fetch('/assets/js/item.json').then(r => r.json()).then(function(json){
    var data_str = JSON.stringify(json.data);
	sessionStorage.setItem('item_data',data_str);
});		
}



function change_mode(type){
	
	////////////////////////////////////////////////////////////////////////////////
	//유저 기본정보
	let user_info_str = $("#user_info").val();
	let user_info = JSON.parse(user_info_str);
	console.log("user_info",user_info);
	
	//유저의 entry 정보
	let entry_info_str = $("#entry_info").val();
	let entry_info = JSON.parse(entry_info_str);
	console.log("entry_info",entry_info);
	
	//마스터리 정보
	let mastery_info_str = $("#mastery_info").val();
	let mastery_info = JSON.parse(mastery_info_str);
	console.log("mastery_info",mastery_info);
	
	//matchId 정보
	let matchId_info_str = $("#matchId_info").val();
	matchId_info_str = matchId_info_str.substring(1,matchId_info_str.length-1);
	var matchId_arr = matchId_info_str.split(",");
	
	//챔피언의 정보 fetch
	fetch_champ_resource();
	var champ_data = JSON.parse(sessionStorage.getItem('champ_data'));
	
	//아이템 정보 fetch
	fetch_item_resource();
	var item_data = JSON.parse(sessionStorage.getItem('item_data'));
	
	// queue Type 선언
	const QUEUETYPE = {
    400: '일반게임', //Normal Draft Pick
    420: '솔로랭크',
    430: '일반게임',
    440: '자유랭크',
    450: '칼바람',
    700: '격전',
    800: 'AI대전',  // Deprecated
    810: 'AI대전',  // Deprecated
    820: 'AI대전',  // Deprecated
    830: 'AI대전',
    840: 'AI대전',
    850: 'AI대전',
    900: '우르프',
    920: '포로왕',
    1020: '단일',
    1300: '돌넥',
    1400: '궁주문서', // Ultimate Spellbook
    2000: '튜토리얼',
    2010: '튜토리얼',
    2020: '튜토리얼',
	}
	
	//match_detail 정보를 받아옴
	let ak = $("#ak").val();
	let myMatch = {"assists":"","championId":"","champ_src":"","deaths":"","item0":"","item1":"","item2":"","item3":"","item4":"","item5":"","item6":"","kills":"","lane":"","win":""};
	
	//전적테이블 초기화
	$("#match_table").html("");
	
	for(var i=0; i<matchId_arr.length; i++){
		//모든 matchId를 조회한다.
		$.ajax({
			url : "https://asia.api.riotgames.com/lol/match/v5/matches/"+matchId_arr[i],
			data : "api_key="+ak,
			dataType : "json",
			async:false,
			contentType : "appication/json",
			success : function(data){
				console.log(data);
				
				//본인의 MATCH정보 JSONObject로 저장
				let participants = data.info.participants;
				for(var i=0; i<participants.length; i++){
					if(participants[i].summonerName == user_info.name){
						myMatch.assists =  participants[i].assists;
						myMatch.championId =  participants[i].championId;
						myMatch.deaths =  participants[i].deaths;
						myMatch.item0 =  participants[i].item0;
						myMatch.item1 =  participants[i].item1;
						myMatch.item2 =  participants[i].item2;
						myMatch.item3 =  participants[i].item3;
						myMatch.item4 =  participants[i].item4;
						myMatch.item5 =  participants[i].item5;
						myMatch.item6 =  participants[i].item6;
						myMatch.kills =  participants[i].kills;
						myMatch.lane =  participants[i].lane;
						myMatch.win =  participants[i].win;
						
						//챔피언 이미지 매칭
						for(key in champ_data){
							var champId = champ_data[key].key;
							var imgSrc = "assets/img/champion/";
							var image = champ_data[key].image.full;
							if(myMatch.championId == champId){
								myMatch.champ_src = imgSrc+image;
							}
						}
						
						//아이템 이미지 매칭
						for(key in item_data){
							var itemId = key;
							var imgSrc = "assets/img/item/";
							var image = item_data[key].image.full;
							
							if(myMatch.item0 == itemId){
								myMatch.item0 = imgSrc+image;
							}
							if(myMatch.item1 == itemId){
								myMatch.item1 = imgSrc+image;
							}
							if(myMatch.item2 == itemId){
								myMatch.item2 = imgSrc+image;
							}
							if(myMatch.item3 == itemId){
								myMatch.item3 = imgSrc+image;
							}
							if(myMatch.item4 == itemId){
								myMatch.item4 = imgSrc+image;
							}
							if(myMatch.item5 == itemId){
								myMatch.item5 = imgSrc+image;
							}
							if(myMatch.item6 == itemId){
								myMatch.item6 = imgSrc+image;
							}
						}
						
						if(myMatch.item0 == 0){
							myMatch.item0 = imgSrc+"noItem.png";
						}
						if(myMatch.item1 == 0){
							myMatch.item1 = imgSrc+"noItem.png";
						}
						if(myMatch.item2 == 0){
							myMatch.item2 = imgSrc+"noItem.png";
						}
						if(myMatch.item3 == 0){
							myMatch.item3 = imgSrc+"noItem.png";
						}
						if(myMatch.item4 == 0){
							myMatch.item4 = imgSrc+"noItem.png";
						}
						if(myMatch.item5 == 0){
							myMatch.item5 = imgSrc+"noItem.png";
						}
						if(myMatch.item6 == 0){
							myMatch.item6 = imgSrc+"noItem.png";
						}
						
					}
				}
				//게임시간 확인
				let gameDuration = data.info.gameDuration;
				var hour = parseInt(gameDuration/3600) < 10 ? '0'+ parseInt(gameDuration/3600) : parseInt(gameDuration/3600);
				var min = parseInt((gameDuration%3600)/60) < 10 ? '0'+ parseInt((gameDuration%3600)/60) : parseInt((gameDuration%3600)/60);
			    var sec = gameDuration % 60 < 10 ? '0'+gameDuration % 60 : gameDuration % 60;
				gameDuration =  min+":"+sec; 
							
				myMatch.gameDuration = gameDuration;
				//게임 모드 확인
				let gameMode = data.info.gameMode; //게임모드 ARAM : 칼바람 CLASSIC : 클래식
				
				//큐타입 확인
				let queueId = data.info.queueId; //게임 종류
				for(key in QUEUETYPE){
					if(queueId == key){
						myMatch.queueType = QUEUETYPE[key];
					}
				}
				
				let bg_color;
				let winOrLose;
				let winColor;
				
				if(myMatch.win == true){
					winOrLose = "승리";
					winColor = "fw-bolder text-primary";
					bg_color = "bg-primary bg-opacity-10";
				}else{
					winOrLose = "패배";
					winColor = "fw-bolder text-danger";
					bg_color = "bg-danger bg-opacity-10";
				}
				
				html ="";
				html += "<tr class='"+bg_color+"'>";
				html += "<td class='align-middle p-1' rowspan='3' style='width:20%;'>";
				html += "<img src='"+myMatch.champ_src+"' class='img rounded border border-secondary p-0' style='width:75px; height:75px'>";
				html += "</td>";
				html += "<td class='align-middle text-center' style='width:25%'>";
				html += "<span id='qtype' class='p-0 text-muted fw-bolder'>"+myMatch.queueType+"</span>";
				html += "</td>";
				html += "<td class='align-middle text-center'>";
				let avg = ((parseInt(myMatch.kills) + parseInt(myMatch.assists)) / parseInt(myMatch.deaths)).toFixed(2);
				let avgColor;
				if(avg >= 5.00){
					avgColor = "fw-bolder text-warning";
				}else if(avg >= 3.00){
					avgColor = "fw-bolder text-success";
				}else if(avg <= 1.00){
					avgColor = "fw-bolder text-danger";
				}else{
					avgColor = "fw-bolder text-black";
				}
				html += "<span id='kdaAvg' class='p-0 "+avgColor+"'>"+avg+"</span>";
				html += "</td>";
				html += "</tr>";
				html += "<tr class='"+bg_color+"'>";
				html += "<td class='align-middle text-center'>";
				html += "<span class='p-0 "+winColor+"' id='win'>"+winOrLose+"</span>";
				html += "</td>";
				html += "<td class='align-middle text-center'>";
				html += "<span class='p-0 text-muted fw-bolder' id='kda'><span class='text-danger'> "+myMatch.kills+" </span> / <span class='text-secondary'>"+myMatch.deaths+"</span> / <span class='text-primary'>"+myMatch.assists+"</span> </span>";
				html += "</td>";
				html += "</tr>";
				html += "<tr class='"+bg_color+"'>";
				html += "<td class='align-middle text-center'>";
				html += "<span class='p-0 text-muted fw-bolder' id='duration'>"+myMatch.gameDuration+"</span>";
				html += "</td>";
				html += "<td class='align-middle text-center'>";
				html += "<img src='"+myMatch.item0+"' class='img p-0 rounded border border-white' id='item0_img' style='width:13%;'>";
				html += "<img src='"+myMatch.item1+"' class='img p-0 rounded border border-white' id='item1_img' style='width:13%;'>";
				html += "<img src='"+myMatch.item2+"' class='img p-0 rounded border border-white' id='item2_img' style='width:13%;'>";
				html += "<img src='"+myMatch.item3+"' class='img p-0 rounded border border-white' id='item3_img' style='width:13%;'>";
				html += "<img src='"+myMatch.item4+"' class='img p-0 rounded border border-white' id='item4_img' style='width:13%;'>";
				html += "<img src='"+myMatch.item5+"' class='img p-0 rounded border border-white' id='item5_img' style='width:13%;'>";
				html += "<img src='"+myMatch.item6+"' class='img p-0 rounded border border-white' id='item6_img' style='width:13%;'>";
				html += "</td>";
				html += "</tr>";
				
				$("#match_table").append(html);
			},error : function(data){
				console.log(data);
			}
		});
		
	}
	
	
	
	
	//모스트 챔피언 확인
	var idx=1;
	for(key in champ_data){
		var champId = champ_data[key].key;
		var name = champ_data[key].name;
		var imgSrc = "assets/img/champion/";
		var image = champ_data[key].image.full;
		//console.log(champId +"/"+name);
		//console.log(mastery_info);
		mastery_info.forEach(function(champ){
			if(champ.championId == champId){
				//console.log(champId + " / " + name + ' / ' + imgSrc+image);
				$("#most_"+idx).prop('src',imgSrc+image);
				$("#most_"+idx).attr('data-val',champId);
				$("#most_name_"+idx).html(name);
				idx++;
			}
		});
	// 모스트 챔피언 확인	
	}
	
	/////////////////////////////////////////////////
	var free_rank;
	var solo_rank;
	
	for(var i=0; i<entry_info.length; i++){
		if(entry_info[i].queueType == "RANKED_FLEX_SR"){
			free_rank = entry_info[i];
		}else if(entry_info[i].queueType == "RANKED_SOLO_5x5"){
			solo_rank = entry_info[i];
		}
	}
	////////////////////////////////////////////////////////////////////////////////
	var rank_info;
	
	if(type == 'solo'){
		rank_info = solo_rank;
	}else if(type == 'free'){
		rank_info = free_rank;
	}
	
	//emblem 처리
	var tier = rank_info.tier;
	if(tier == 'IRON'){
		$("#rank_emblem").prop("src",emblems.iron);
	}else if(tier == 'SILVER'){
		$("#rank_emblem").prop("src",emblems.silver);
	}else if(tier == 'BRONZE'){
		$("#rank_emblem").prop("src",emblems.bronze);
	}else if(tier == 'GOLD'){
		$("#rank_emblem").prop("src",emblems.gold);
	}else if(tier == 'PLATINUM'){
		$("#rank_emblem").prop("src",emblems.platinum);
	}else if(tier == 'DIAMOND'){
		$("#rank_emblem").prop("src",emblems.diamond);
	}else if(tier == 'MASTER'){
		$("#rank_emblem").prop("src",emblems.master);
	}else if(tier == 'GRANDMASTER'){
		$("#rank_emblem").prop("src",emblems.grandmaster);
	}else if(tier == 'CHALLENGER'){
		$("#rank_emblem").prop("src",emblems.challenger);
	}
	
	//사용자의 랭크 정보 처리
	var tier = rank_info.tier;
	$("#tier").html(tier);
	var rank = rank_info.rank;
	$("#rank").html(rank);
	var user_name = rank_info.summonerName;
	$("#user_name").html(user_name);
	var lp = rank_info.leaguePoints;
	$("#lp").html(lp);
	var wins = rank_info.wins;
	$("#wins").html(wins);
	var losses = rank_info.losses;
	$("#losses").html(losses);
	var winRate = ((wins / (wins+losses))*100).toFixed(0);
	$("#winRate").html(winRate);
	
	
}
 


//onload
$(function(){
	
	//처음 결과 load
	change_mode('solo');
	
});


</script>
<!-- 서버에서 전달받은 정보 -->
<input type = "hidden" name = "user_info" id= "user_info" value=${user_info } >
<input type = "hidden" name = "entry_info" id= "entry_info" value=${entry_info } >
<input type = "hidden" name = "mastery_info" id= "mastery_info" value=${mastery_info } >
<input type = "hidden" name = "matchId_info" id= "matchId_info" value=${matchId_info } >
<input type = "hidden" name = "match_info_detail" id= "match_info_detail" value=${match_info_detail } >

<!-- section_1 -->
 <section id="hero" class="d-flex align-items-center">
    <div class="container">
      <div class="row m-3 pt-0">
        <div class="col-lg-6 order-1 order-lg-2 bg-white ps-0 pe-0 rounded border border-0 card align-items-center" data-aos="zoom-in" data-aos-delay="200" style='height:700px;'>
        	<div class="card-header text-center col-12">
        		<h6 class='lead fw_bolder'>나의 전적</h6>
        	</div>
        	<div class='col-12 align-items-center d-flex mt-2 mb-2'>
        		<div class='col-6 align-items-center'>
	          		<input class='btn-check me-2' type='radio' name='sel_rank' id='solo_rank' value='solo_rank' onclick='change_mode("solo");' checked>
	          		<label class = 'btn btn-outline-secondary' for='solo_rank'>SOLO</label>
          		</div>
          		<div class='col-6'>
	          		<input class='btn-check me-2'  type='radio' name='sel_rank' id='free_rank' value='free_rank' onclick='change_mode("free");'>
	          		<label class = 'btn btn-outline-secondary' for='free_rank'>FREE</label>
          		</div>
          	</div>
          	
          	<div class='row align-items-center mt-2 mb-2 pt-0 pb-2 border border-secondary rounded'>
	        	<div class='col-12 bg-secondary bg-opacity-10 pt-2'>
	          		<h6 class='lead small fw-bold'>랭크 정보</h6>
	          	</div>
	          	
	          	<img id='rank_emblem' src="assets/img/lol_white.png" class="img-fluid animated mx-auto" alt="" style='width:150px; height:150px;'>
	          	
	          	<div class='col-12 d-flex mt-2 mb-2'>
	          		<h6 class='col-4 ps-0 pe-0 pt-2 pb-2'><span id='tier'><!-- SILVER --></span><span class='ms-2' id='rank'><!-- III --></span></h6>
	          		<h5 class='col-8 fw-bolder pt-1 pb-1'><span id='user_name'><!-- 소환사이름 --></span></h5>
	          	</div>
	          	<!-- LP, 승, 패 -->
	          	<div class='col-12 d-flex mt-2 mb-2 small'>
	          		<h5 class='col-4 ps-0 pe-0 text-muted'><span class='me-2' id='lp'><!-- LP --></span>LP</h5>
	          		<h5 class='col-3 ps-0 pe-0 text-success'><span class='me-2' id='wins'><!-- 승 --></span>W</h5>
	          		<h5 class='col-3 ps-0 pe-0 text-danger'><span class='me-2' id='losses'><!-- 패 --></span>L</h5>
	          		<h5 class='col-2 ps-0 pe-0 text-secondary '><span class='me-2' id='winRate'><!-- 패 --></span>%</h5>
	          	</div>
          	</div>
          	
          	<div class='row align-items-center mt-2 mb-2 pt-0 pb-2 border border-secondary rounded'>
	          	<div class='col-12 bg-secondary bg-opacity-10 pt-2'>
	          		<h6 class='lead small fw-bold'>모스트 챔피언</h6>
	          	</div>
	          	<!-- 모스트 챔프 -->
	          	<div class='col-12 d-flex mt-1 mb-2'>
	          		<div class='col-4 align-items-center'>
	          			<img src='assets/img/medal_gold.png' class='img-fluid animated mt-1 mb-1 ' style='width:15px; height:15px;'>
	          			<img id= 'most_1' src='' class='img-fluid animated mt-1 mb-2 border border-primary rounded' style='width:60px; height:60px;'>
	          			<h5 class='small fw-bolder text-muted'><span id= 'most_name_1'>챔피언 이름</span></h5>
	          		</div>
	          		<div class='col-4 align-items-center'>
	          			<img src='assets/img/medal_silver.png' class='img-fluid animated mt-1 mb-1 ' style='width:15px; height:15px;'>
	          			<img id= 'most_2' src='' class='img-fluid animated mt-1 mb-2 border border-primary rounded' style='width:60px; height:60px;'>
	          			<h5 class='small fw-bolder text-muted'><span id= 'most_name_2'>챔피언 이름</span></h5>
	          		</div>
	          		<div class='col-4 align-items-center'>
	          			<img src='assets/img/medal_bronze.png' class='img-fluid animated mt-1 mb-1 ' style='width:15px; height:15px;'>
	          			<img id= 'most_3' src='' class='img-fluid animated mt-1 mb-2 border border-primary rounded' style='width:60px; height:60px;'>
	          			<h5 class='small fw-bolder text-muted'><span id= 'most_name_3'>챔피언 이름</span></h5>
	          		</div>
	          	</div>
          	</div>
        </div>
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
  
  <!-- section_2 -->
  <section id="" class="d-flex align-items-center">
    <div class="container m-1 pt-0 mx-auto">
      <div class="row">
        <div class="col-lg-6 order-1 order-lg-2 bg-white border border-0 card" data-aos="zoom-in" data-aos-delay="200">
        	<div class="card-header text-center">
        		<h6 class='lead fw_bolder'>최근 전적</h6>
        	</div>
        	<table class='table' id='match_table'>
        	<!--  -->
        	
        	</table>
        </div>
      </div>
    </div>
    
  </section><!-- End Hero -->
  

  
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