package com.history.game.lol.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.Principal;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.configurationprocessor.json.JSONArray;
import org.springframework.boot.configurationprocessor.json.JSONException;
import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.history.game.lol.board.BoardVO;
import com.history.game.lol.getdata.GetData;
import com.history.game.lol.mapper.BoardMapper;
import com.history.game.lol.mapper.UserMapper;
import com.history.game.lol.user.UserVO;

@Controller
public class pageController {
	
	@Autowired
	UserMapper userMapper;
	
	@Autowired
	BoardMapper boardMapper;
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	
	@GetMapping("/")
	public String goIndex(){
		System.out.println("index로 이동");
		return "index";
	}
	
	@GetMapping("/login")
	public String goLogin() {
		System.out.println("로그인페이지로 이동");
		return "user/login";
	}
	
	@GetMapping("/loginFail")
	public String loginFail() {
		System.out.println("로그인 실패");
		return "user/loginFail";
	}
	@GetMapping("/registPage")
	public String registPage() {
		System.out.println("가입 페이지로 이동");
		return "user/registUser";
	}
	
	
	
	@RequestMapping("/registUser")
	public String goLogin(HttpServletRequest request) {
		
		System.out.println("user를 등록합니다");
		String userId = request.getParameter("userId");
		String pw = request.getParameter("pw");
		String grade =request.getParameter("grade");
		String upoint=request.getParameter("upoint");
		String cert=request.getParameter("cert");
		String role=request.getParameter("role");
		
		pw = passwordEncoder.encode(pw);
		
		UserVO uvo = new UserVO();
		uvo.setUserid(userId);
		uvo.setPw(pw);
		uvo.setGrade(grade);
		uvo.setUpoint(upoint);
		uvo.setCert(cert);
		uvo.setRole(role);
		
		System.out.println("request User정보" + uvo);
		try {
			userMapper.registUser(uvo);
		}catch (Exception e) {
			System.out.println(e);
		}
		return "user/login";
	}
	
	@GetMapping("/loginSuccess")
	public String loginOk(HttpSession session, Principal principal){
		System.out.println("로그인 성공");
		String userid = principal.getName();
		UserVO user =  userMapper.checkUser(userid);
		session.setAttribute("userid", user.getUserid());
		session.setAttribute("role", user.getRole());
		return "user/loginSuccess";
	}
	
	
	@GetMapping("/loginFailure")
	public String loginFailed(){
		System.out.println("로그인 실패");
		return "user/login.jsp?error=fail";
	}
	@RequestMapping("/get_estimate")
	  public String get_estimate() {
		  return "est_page";
	  }
	  
	  @RequestMapping("/send_est")
	  public String send_estimate(HttpServletResponse response, BoardVO bvo) throws IOException {
		  
		  response.setCharacterEncoding("UTF-8");
		  PrintWriter out = response.getWriter();
		  
		  System.out.println(bvo);
		
		  try {
			  boardMapper.insertBoard(bvo);
		  }catch(Exception e) {
			 System.out.println(e);
			 out.print("<script>"); 
			 out.print("alert('문의 등록에 실패했습니다....')");
			 out.print("</script>");
			 out.flush();
		  }
			 
		  return "index";
	  }
	  
	  @RequestMapping("/admin")
	  public String go_admin_page(HttpServletRequest req){
		  String login = req.getParameter("login");
		  if(login == "admin") {
			  return "admin/index.jsp?login=admin";
		  }else {
			  return "admin/index";
		  }
	  }
	  
	  @RequestMapping("/error/403")
	  public String accessDeniedpage() {
		  return "/error/403";
	  }
	  
	  @PostMapping("/summoner")
	  public String go_summoner(HttpServletRequest req, Model model){
		  
		  //전달받은 소환사 이름
		  String name = req.getParameter("lol_id");
		  
		  //getData 클래스내부 get_summner_data 메소드를 통해 유저 정보를 리턴함
		  GetData getData = new GetData();
		  HashMap<String, String> resultMap = getData.get_summoner_data(name);
		  
		  //리턴된 String(json.toString())을 모델에 담아 뷰로 전달
		  System.out.println("summoner 요청중 ---");
		  
		  //resultMap에서 String으로 저장한 JSOn
		  String user_info = resultMap.get("user_info");
		  String entry_info = resultMap.get("entry_info");
		  String mastery_info = resultMap.get("mastery_info");
		  String matchId_info = resultMap.get("matchId_info");
		  //String match_info_detail = resultMap.get("match_info_detail");
		  
		  //model에 담기
		  model.addAttribute("user_info",user_info);
		  model.addAttribute("entry_info",entry_info);
		  model.addAttribute("mastery_info",mastery_info);
		  model.addAttribute("matchId_info",matchId_info);
		  
		  //model.addAttribute("match_info_detail",match_info_detail);
		  return "/total_page";
	  }
	  
	  @RequestMapping("/go_champ_page")
	  public String go_champ_page() {
		  System.out.println("champ_page로 이동");
		  return "champ_page";
	  }
	  
	  
}
