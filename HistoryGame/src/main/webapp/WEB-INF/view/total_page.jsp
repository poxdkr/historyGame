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

const firtsLoad = true;

function fetch_champ_resource(){
		return fetch('/assets/js/champion.json').then(r => r.json()).then(function(json){
	    var data_str0 = JSON.stringify(json.data);
		sessionStorage.setItem('champ_data',data_str0);
	});		
}

function fetch_item_resource(){
	return fetch('/assets/js/item.json').then(r => r.json()).then(function(json){
    var data_str1 = JSON.stringify(json.data);
	sessionStorage.setItem('item_data',data_str1);
});		
}

function fetch_summoner_resource(){
	return fetch('/assets/js/summoner.json').then(r => r.json()).then(function(json){
    var data_str2 = JSON.stringify(json.data);
	sessionStorage.setItem('summoner_data',data_str2);
});		
}

function fetch_rune_resource(){
	return fetch('/assets/js/runesReforged.json').then(r => r.json()).then(function(json){
    var data_str3 = JSON.stringify(json);
	sessionStorage.setItem('rune_data',data_str3);
});		
}

//룬 설명창 확인
function show_tooltip(name, desc){
	$("#perk_div").css("width","300px");
	$("#perk_div").css("display","block");
	$("#perk_name").html("["+name+"]");
	if(desc != "none"){
		$("#perk_desc").html(desc);
	}else{
		$("#perk_desc").html("");
	}
}
//룬설명창 d-none;
function no_tooltip(){
	$("#perk_div").css("width","0px");
	$("#perk_div").css("display","none");
	$("#perk_name").html("");
	$("#perk_desc").html("");
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
	
	//처음 로드시에 static한 데이터를 fetch하고 이후부터는 로드된 데이터들을 이용한다.
	if(firtsLoad == true){
		//챔피언의 정보 fetch
		fetch_champ_resource();
		//아이템 정보 fetch
		fetch_item_resource();
		//서머너스펠 정보 fetch
		fetch_summoner_resource();
		//룬 정보 fetch
		fetch_rune_resource();
	}
	
	//static data 확인
	var champ_data = JSON.parse(sessionStorage.getItem('champ_data'));
	var item_data = JSON.parse(sessionStorage.getItem('item_data'));
	var summoner_data = JSON.parse(sessionStorage.getItem('summoner_data'));
	var rune_data = JSON.parse(sessionStorage.getItem('rune_data'));
	console.log(summoner_data);
	
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
						
						myMatch.assists =  participants[i].assists; //어시스트
						myMatch.championId =  participants[i].championId; //챔피언 픽
						myMatch.deaths =  participants[i].deaths;// 데스
						myMatch.item0 =  participants[i].item0;// 아이템 1
						myMatch.item1 =  participants[i].item1;// 아이템 2
						myMatch.item2 =  participants[i].item2;// 아이템 3
						myMatch.item3 =  participants[i].item3;// 아이템 4
						myMatch.item4 =  participants[i].item4;// 아이템 5
						myMatch.item5 =  participants[i].item5;// 아이템 6
						myMatch.item6 =  participants[i].item6; // 와드
						myMatch.kills =  participants[i].kills; // 킬수
						myMatch.lane =  participants[i].lane; // 라인
						myMatch.win =  participants[i].win; //승패 여부
						myMatch.rune_1_id = participants[i].perks.styles[0].selections[0].perk; //주요 룬확인
						myMatch.rune_2_id = participants[i].perks.styles[1].style; // 서브룬 확인
						
						myMatch.spell_d = participants[i].summoner1Id;
						myMatch.spell_f = participants[i].summoner2Id;
						
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
						
						//스펠 확인
						
						//룬 확인

						let rune_1_substr = (myMatch.rune_1_id).toString().substring(0,2);
						let rune_2_substr = myMatch.rune_2_id;
						console.log(myMatch.rune_1_id);
						console.log(myMatch.rune_2_id);
						
						for(key in rune_data){
							if(rune_data[key].id.toString().substring(0,2) == rune_1_substr){ //1번룬 확인
								myMatch.rune_1_icon = "https://ddragon.leagueoflegends.com/cdn/img/"+rune_data[key].slots[0].runes[0].icon;
								myMatch.rune_1_name = rune_data[key].slots[0].runes[0].name;
								myMatch.rune_1_shortDesc = rune_data[key].slots[0].runes[0].shortDesc;
							}
							
							if(rune_data[key].id == rune_2_substr){
								myMatch.rune_2_name = rune_data[key].name;
								myMatch.rune_2_icon = "https://ddragon.leagueoflegends.com/cdn/img/"+rune_data[key].icon;
							}
						}
						
						for(key in summoner_data){
							var imgSrc = "assets/img/spell/";
							if(summoner_data[key].key == myMatch.spell_d){
								myMatch.spell_d_name = summoner_data[key].name;
								myMatch.spell_d_desc = summoner_data[key].description;
								myMatch.spell_d_img = imgSrc+summoner_data[key].image.full;
								
							}else if(summoner_data[key].key == myMatch.spell_f){
								myMatch.spell_f_name = summoner_data[key].name;
								myMatch.spell_f_desc = summoner_data[key].description;
								myMatch.spell_f_img = imgSrc+summoner_data[key].image.full;
							}
						}
					}
				}
				console.log(myMatch);
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
				html += "<td class='align-middle p-1' rowspan='3' style='width:14%; border-bottom : 3px solid lightgrey'>";
				html += "<img src='"+myMatch.champ_src+"' class='img rounded border border-secondary p-0' style='width:75px; height:75px'>";
				html += "</td>";
				html += "<td class='align-middle p-0 text-center' rowspan='3' style='width:5%; border-bottom : 3px solid lightgrey'>";
				/* 룬이랑 스펠 넣을 자리 */
				html += "<span class='p-0 text-center' id='spell_d' onmouseenter='show_tooltip(\""+myMatch.spell_d_name+"\", \""+myMatch.spell_d_desc+"\");' onmouseout='no_tooltip();'><img class='img rounded' src='"+myMatch.spell_d_img+"' style='width:100%;'></span><br>";
				html += "<span class='p-0 text-center' id='spell_f' onmouseenter='show_tooltip(\""+myMatch.spell_f_name+"\", \""+myMatch.spell_f_name+"\");' onmouseout='no_tooltip();'><img class='img rounded' src='"+myMatch.spell_f_img+"' style='width:100%;'></span><br><hr class='mt-1 mb-1 p-0'>";
				html += "<span class='p-0 text-center' id='rune_1' onmouseenter='show_tooltip(\""+myMatch.rune_1_name+"\", \""+myMatch.rune_1_shortDesc+"\");' onmouseout='no_tooltip();'><img class='img rounded' src='"+myMatch.rune_1_icon+"' style='width:100%;'></span><br>";
				html += "<span class='p-0 text-center' id='rune_2' onmouseenter='show_tooltip(\""+myMatch.rune_2_name+"\", \"none\");' onmouseout='no_tooltip();'><img class='img rounded'src='"+myMatch.rune_2_icon+"' style='width:80%;'></span><br>";
				html += "</td>";
				html += "<td class='align-middle text-center' style='width:25%'>";
				html += "<span id='qtype' class='p-0 text-muted fw-bolder'>"+myMatch.queueType+"</span>";
				html += "</td>";
				html += "<td class='align-middle text-center small fw-bold text-dark bg-warning bg-gradient bg-opacity-10' style='border-left:1.5px solid #f8f8f8'>평점</td>";
				html += "<td class='align-middle text-center '>";
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
				html += "<td class='align-middle text-center small fw-bold text-dark bg-warning bg-gradient bg-opacity-10' style='border-left:1.5px solid #f8f8f8'>KDA</td>";
				html += "<td class='align-middle text-center'>";
				html += "<span class='p-0 text-muted fw-bolder' id='kda'><span class='text-danger'> "+myMatch.kills+" </span> / <span class='text-secondary'>"+myMatch.deaths+"</span> / <span class='text-primary'>"+myMatch.assists+"</span> </span>";
				html += "</td>";
				html += "</tr>";
				html += "<tr class='"+bg_color+"'>";
				html += "<td class='align-middle text-center' style='border-bottom : 3px solid lightgrey'>";
				html += "<span class='p-0 text-muted fw-bolder' id='duration'>"+myMatch.gameDuration+"</span>";
				html += "</td>";
				html += "<td colspan ='2' class='align-middle text-center p-0' style='border-bottom : 3px solid lightgrey; border-left: 2px solid #f8f8f8;'>";
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
	var summon_lv = user_info.summonerLevel;
	$("#summon_lv").html("lv. "+summon_lv);
	var lp = rank_info.leaguePoints;
	$("#lp").html(lp);
	var wins = rank_info.wins;
	$("#wins").html(wins);
	var losses = rank_info.losses;
	$("#losses").html(losses);
	var winRate = ((wins / (wins+losses))*100).toFixed(0);
	$("#winRate").html(winRate);
	
	//winrate_chart 그리기
	//chart canvas초기화
	$("#chart_div").html("");
	let chart_html = '<canvas id="chart_canvas" width="400" height="400"></canvas>';
	$("#chart_div").html(chart_html);
	//canvas 설정 및 로드
	const ctx = document.getElementById('chart_canvas').getContext('2d');
	const myChart = new Chart(ctx, {
	    type: 'doughnut',
	    data: {
	         labels: [rank_info.wins+'승', rank_info.losses+'패'],
	        datasets: [{
	            label: '',
	            data: [rank_info.wins, rank_info.losses],
	            backgroundColor: ['rgba(54, 162, 235, 0.2)','rgba(255, 99, 132, 0.2)'],
	            hoverBorderColor: ['rgba(54, 162, 235, 1)','rgba(255, 99, 132, 1)'],
	            borderWidth: 1,
	            rotation : 180
	        }]
	    },
	    options: {
	        /* scales: {y: {beginAtZero: false}} */
	    }
	});
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
 <section id="hero" class="d-flex flex-column align-items-center">
    <div class="">
      <div class="row m-3 pt-0">
        <div class="col-lg-6 order-1 order-lg-2 bg-white ps-0 pe-0 rounded border border-0 card align-items-center" data-aos="zoom-in" data-aos-delay="200" style='height:700px;'>
        	<!-- <div class="card-header text-center col-12">
        		<h6 class='lead fw_bolder'>나의 전적</h6>
        	</div> -->
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
	          	
	          	<div class='col-10 mx-auto mt-4 mb-4 p-1 d-flex flex-column justify-content-center border border-dark rounded'>
	          		<img id='rank_emblem' src="assets/img/lol_white.png" class="img-fluid animated mx-auto" alt="" style='width:150px; height:150px;'>
		          	<div class='col-12 mt-2 mb-2 d-flex justify-content-center'>
		          		<h6 class='col-4 ps-0 pe-0 pt-2 pb-2'><span id='tier'><!-- SILVER --></span><span class='ms-2' id='rank'><!-- III --></span></h6>
		          		<h5 class='col-4 ps-0 pe-0 text-muted  pt-2 pb-2'><span class='me-2' id='lp'><!-- LP --></span>LP</h5>
		          	</div>
	          		<h6 class='col-8 fw-bolder mx-auto'><span  class='btn btn-dark btn-sm ' id='summon_lv'><!-- 소환사레벨 --></span></h6>
	          		<h5 class='col-8 fw-bolder mx-auto'><span id='user_name'><!-- 소환사이름 --></span></h5> 
	          	</div>
	          	
	          	<!-- winrate_div -->
          		<div class='col-12 d-flex justify-content-center'>
          			<div class="col-4 d-flex flex-column">
	          			<h5 class='btn btn-success btn-sm'>승리</h5>
		          		<h5 class='btn btn-outline-success' id='wins'><!-- 승 --></h5>
	          		</div>
	          		<div class="col-4 d-flex flex-column">
		          		<h5 class='btn btn-danger btn-sm'>패배</h5>
		          		<h5 class='btn btn-outline-danger' id='losses'><!-- 패 --></h5>
	          		</div>
	          		<div class="col-4 d-flex flex-column">
		         		<h5 class='btn btn-secondary btn-sm'>승률(%) </h5>
		         		<h5 class='btn btn-outline-secondary' id='winRate'><!-- 승률 --></h5>
	          		</div>
          		</div>
          		<!-- winrate_div -->
	          	<!-- chart_div -->	
	          	<div class='col-12 d-flex mt-2 mb-2 small justify-content-center'>
	          		<div class='col-9' id='chart_div'><!--  --></div>
	          	</div>
	          	<!-- chart_div -->
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
    <div class='position-fixed border border-white rounded bg-dark bg-opacity-15 p-3 small text-secondary' style='top:150px; left:100px; display:none;' id='perk_div'>
    	<span class='fw-bolder text-white' id='perk_name'><!--  --></span></br>
    	<span id='perk_desc'><!--  --></span>
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