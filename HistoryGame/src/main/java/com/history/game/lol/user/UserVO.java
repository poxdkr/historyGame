package com.history.game.lol.user;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserVO {
	private int uidx;
	private String userid;
	private String pw;
	private String grade;
	private String upoint;
	private String cert;
	private String regdate;
	private String role;
	private String aff_sch;
	
	
	public UserVO(){}

	@Override
	public String toString() {
		return "UserVO [uidx=" + uidx + ", userid=" + userid + ", pw=" + pw + ", grade=" + grade + ", upoint=" + upoint
				+ ", cert=" + cert + ", regdate=" + regdate + ", role=" + role + ", aff_sch=" + aff_sch + "]";
	}




}


