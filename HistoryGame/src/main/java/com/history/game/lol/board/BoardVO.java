package com.history.game.lol.board;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardVO {
	private int bidx;
	private String btitle;
	private String bpw;
	private String userid;
	private String username;
	private String phone;
	private String email;
	private int hit;
	private String parent; //코멘트일경우만 값을 가짐.
	private String file1;
	private String file2;
	private String content;
	private String regdate;
	private String sch_name;
	
	@Override
	public String toString() {
		return "BoardVO [bidx=" + bidx + ", btitle=" + btitle + ", bpw=" + bpw + ", userid=" + userid + ", username="
				+ username + ", phone=" + phone + ", email=" + email + ", hit=" + hit + ", parent=" + parent
				+ ", file1=" + file1 + ", file2=" + file2 + ", content=" + content + ", regdate=" + regdate
				+ ", sch_name=" + sch_name + "]";
	}


	
	
	
	
	
	
}
