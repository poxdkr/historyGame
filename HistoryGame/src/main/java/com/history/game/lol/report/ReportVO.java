package com.history.game.lol.report;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReportVO {
	private int ridx;
	private int idx;
	private String type; //user인지 board인지 구분
	private String userid;
	private String rdate;
	
	@Override
	public String toString() {
		return "ReportVO [ridx=" + ridx + ", idx=" + idx + ", type=" + type + ", userId=" + userid + ", rdate=" + rdate
				+ "]";
	}
	
	
}
