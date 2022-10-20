package com.history.game.lol.getdata;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.net.ssl.HttpsURLConnection;

import org.springframework.boot.configurationprocessor.json.JSONArray;
import org.springframework.boot.configurationprocessor.json.JSONObject;

public class GetData {
	
	private final String api_key = "RGAPI-6ace45e9-3f6f-4b9b-909e-8f87ffc0bfba";
	private final String base_url = "https://kr.api.riotgames.com";
	
	//api_key getter
	public String get_ak(){
		return this.api_key;
	}
	
	//
	public HashMap<String, String> get_summoner_data(String summoner) {
		
		String base_url = this.base_url;
		String req_url = "";
		String api_key = "?api_key="+this.api_key;
		
		HashMap<String, String> resultMap = new HashMap();
		/*
		 * System.out.println("api_key : " + api_key);
		 * System.out.println("get_summoner_data 클래스 실행");
		 * System.out.println("summoner : " + summoner);
		 */
		
		//summoner name으로 받을수 있는 전적 정보 확인
		try {
			//1. 소환사의 기본정보를 조회
			//주소를 조합하여 url 객체 생성 후 접속 시도
			req_url = "/lol/summoner/v4/summoners/by-name/";
			URL url = new URL(base_url+req_url+summoner+api_key);
			//System.out.println("url : " + url);
			
			HttpsURLConnection conn = (HttpsURLConnection)url.openConnection();
			conn.setRequestMethod("GET"); //https 메소드
			conn.setRequestProperty("Content-Type", "application/json"); //header Content-Type
			conn.setDoOutput(true);
			
			//서버로부터 데이터 읽어오기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			StringBuilder user_info = new StringBuilder();
			String line = null;
			
			while((line = br.readLine()) != null ){
				user_info.append(line);
			}
			
			//System.out.println(user_info);
			resultMap.put("user_info", user_info.toString());
			
			//2. 유저의 최근 entries 정보
			// user_info를 JSON Array 화
			
			String user_info_str = user_info.toString();
			JSONObject j_obj = new JSONObject(user_info_str);
			
			//id, puuid 추출
			String id = j_obj.getString("id");
			String puuid =  j_obj.getString("puuid");
			
			req_url = "/lol/league/v4/entries/by-summoner/"; 
			url = new URL(base_url+req_url+id+api_key);
			  
			conn = (HttpsURLConnection)url.openConnection();
			conn.setRequestMethod("GET"); //https 메소드
			conn.setRequestProperty("Content-Type", "application/json"); //header
			conn.setDoOutput(true);
			  
			//서버로부터 데이터 읽어오기 br = new BufferedReader(new
			br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			StringBuilder entry_info = new StringBuilder();
			line = null;
			  
			while((line = br.readLine()) != null ){
				entry_info.append(line); 
			}
			
			//System.out.println(entry_info);
			resultMap.put("entry_info",entry_info.toString());
			
			//3. 챔피언 숙련도 정보 
			req_url = "/lol/champion-mastery/v4/champion-masteries/by-summoner/"+id+"/top"; 
			url = new URL(base_url+req_url+api_key);
			  
			conn = (HttpsURLConnection)url.openConnection();
			conn.setRequestMethod("GET"); //https 메소드
			conn.setRequestProperty("Content-Type", "application/json"); //header
			conn.setDoOutput(true);
			  
			//서버로부터 데이터 읽어오기 br = new BufferedReader(new
			br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			StringBuilder mastery_info = new StringBuilder();
			line = null;
			  
			while((line = br.readLine()) != null ){
				mastery_info.append(line); 
			}
			
			//System.out.println(entry_info);
			resultMap.put("mastery_info",mastery_info.toString());
			
			  //4. puuid로 matchId 리스트 추출 - > matchId를 통해 인게임 정보 추출 
			//4.1 puuid를 통해 matchId추출 match정보는 asia에서만 불러와진다... 
			
			req_url ="/lol/match/v5/matches/by-puuid/"+puuid+"/ids";
			String base_url_1 = "https://asia.api.riotgames.com";
			String params ="?start=0&count=10";
			url = new URL(base_url_1+req_url+params+"&api_key="+this.api_key);
			
			conn = (HttpsURLConnection)url.openConnection();
			conn.setRequestMethod("GET"); //https 메소드
			conn.setRequestProperty("Content-Type", "application/json"); //header
			conn.setDoOutput(true);
			
			//서버로부터 데이터 읽어오기 br = new BufferedReader(new
			br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			StringBuilder matchId_info = new StringBuilder();
			line = null;
			  
			while((line = br.readLine()) != null ){
				matchId_info.append(line); 
			}
			
			//string bulider를 array로
			//1) 대괄호 제거
			String match_info_str = matchId_info.toString();
			match_info_str = match_info_str.substring(1,match_info_str.length()-1);
			
			System.out.println(match_info_str);
			
			String[] match_info_arr;
			match_info_arr = match_info_str.split(",");
			
			//2) 각 항목의 쌍따옴표 제거
			for(int i =0; i<match_info_arr.length; i++) {
				String thisVal = match_info_arr[i];
				thisVal = thisVal.substring(1,thisVal.length()-1);
				match_info_arr[i] = thisVal;
			}
			String match_str = "";
			for(int i=0; i<match_info_arr.length; i++) {
				String arr_str = match_info_arr[i];
				if(i == 0) {
					match_str += "["+arr_str+",";
				}else if(i == match_info_arr.length-1) {
					match_str += arr_str+"]";
				}else {
					match_str += arr_str+",";
				}
			}
			
			System.out.println(match_str);
			
			resultMap.put("matchId_info", match_str);
			
			return resultMap;
			
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
		
	}
}
