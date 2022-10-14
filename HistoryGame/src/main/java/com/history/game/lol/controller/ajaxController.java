package com.history.game.lol.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.history.game.lol.board.BoardVO;
import com.history.game.lol.mapper.BoardMapper;
import com.history.game.lol.mapper.UserMapper;
import com.history.game.lol.user.UserVO;

@Controller
public class ajaxController {
	
	@Autowired
	BoardMapper boardMapper;
	
	@Autowired
	UserMapper userMapper;
	
	@GetMapping("/search_est")
	@ResponseBody
	public ArrayList<BoardVO> search_est(BoardVO bvo, ArrayList<BoardVO> boardlist) {
		//System.out.println(bvo);
		boardlist = boardMapper.search_est(bvo);
		//System.out.println(boardlist);
		return boardlist;
	}
	
	@GetMapping("/count_user_total")
	@ResponseBody
	public int count_user_total() {
		int result = userMapper.count_user_total();
		return result;
	}
	
	@GetMapping("/count_user_month")
	@ResponseBody
	public int count_user_month() {
		int result = userMapper.count_user_month();
		return result;
	}
	
	@RequestMapping("/open_user_dash")
	@ResponseBody
	public ArrayList<UserVO> open_user_dash(HttpServletRequest req){
		HashMap<String, String> userMap= new HashMap<String,String>();
		userMap.put("startnum", req.getParameter("startnum"));
		userMap.put("endnum", req.getParameter("endnum"));
		
		ArrayList<UserVO> ulist = userMapper.get_user_total(userMap);
		//System.out.println(ulist);
		return ulist;
	}
	
	@RequestMapping("/open_user_dash_month")
	@ResponseBody
	public ArrayList<UserVO> open_user_dash_month(HttpServletRequest req){
		HashMap<String, String> userMap= new HashMap<String,String>();
		userMap.put("startnum", req.getParameter("startnum"));
		userMap.put("endnum", req.getParameter("endnum"));
		
		ArrayList<UserVO> ulist = userMapper.get_user_month(userMap);
		//System.out.println(ulist);
		return ulist;
	}
	
	@RequestMapping("/delete_user")
	@ResponseBody
	public void delete_user(HttpServletRequest req) {
		userMapper.delete_user(Integer.parseInt(req.getParameter("uidx")));
	}
	
	
	@RequestMapping("/count_brd_total")
	@ResponseBody
	public int count_brd_total() {
		return boardMapper.count_brd_total();
	}
	
	@RequestMapping("/count_brd_day")
	@ResponseBody
	public int count_brd_day() {
		return boardMapper.count_brd_day();
	}
	
	
	@RequestMapping("/open_brd_dash")
	@ResponseBody
	public ArrayList<BoardVO> open_brd_dash(HttpServletRequest req){
		HashMap<String, String> boardMap= new HashMap<String,String>();
		boardMap.put("startnum", req.getParameter("startnum"));
		boardMap.put("endnum", req.getParameter("endnum"));
		
		ArrayList<BoardVO> blist = boardMapper.get_brd_total(boardMap);
		//System.out.println(blist);
		return blist;
	}
	
	@RequestMapping("/open_brd_dash_day")
	@ResponseBody
	public ArrayList<BoardVO> open_brd_dash_day(HttpServletRequest req){
		HashMap<String, String> boardMap= new HashMap<String,String>();
		boardMap.put("startnum", req.getParameter("startnum"));
		boardMap.put("endnum", req.getParameter("endnum"));
		
		ArrayList<BoardVO> blist = boardMapper.get_brd_day(boardMap);
		//System.out.println(blist);
		return blist;
	}
	
}
