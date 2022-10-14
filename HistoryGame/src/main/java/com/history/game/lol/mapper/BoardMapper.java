package com.history.game.lol.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.history.game.lol.board.BoardVO;

@Mapper
public interface BoardMapper {
	//게시글 및 댓글 생성
	public void insertBoard(BoardVO bvo);
	
	///게시글 찾기
	public ArrayList<BoardVO> search_est(BoardVO bvo);
	
	//전체 문의글의 숫자 카운트
	public int count_brd_total();
	
	// 전체 문의의 명세 리스트
	public ArrayList<BoardVO> get_brd_total(HashMap<String, String> brdMap);

	//오늘의 문의글 수 카운트
	public int count_brd_day();
		
	//오늘의 문의글 명세 리스트
	public ArrayList<BoardVO> get_brd_day(HashMap<String, String> brdMap);

	//문의글 삭제
	public void delete_brd(int bidx);
}
