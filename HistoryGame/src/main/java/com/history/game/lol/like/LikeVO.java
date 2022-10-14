package com.history.game.lol.like;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LikeVO {
	private int lidx;
	private int bidx;
	private String userId;
	private String ldate;
	
	
	@Override
	public String toString() {
		return "LikeVO [lidx=" + lidx + ", bidx=" + bidx + ", userId=" + userId + ", ldate=" + ldate + "]";
	}
	
	
}
