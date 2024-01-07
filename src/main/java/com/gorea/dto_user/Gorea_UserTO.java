package com.gorea.dto_user;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Gorea_UserTO {
	private Long userSeq;
	// go_user_id
	private String username;
	// go_user_ps
	private String password;
	
	private String userLastname;
	private String userFirstname;
	
	private String userNickname;
	
	private String userMail;
	private String userJoindate;
	private int userPpoint;
	private String userNation;
	private String userRating;
	private String userRole;
	
	public Gorea_UserTO(String username, String password, String userNickname, String userMail) {
		this.username = username;
		this.password = password;
		this.userNickname = userNickname;
		this.userMail = userMail;
	}
}
