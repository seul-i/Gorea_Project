package com.gorea.dto_user;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Gorea_JoinTO {
	
	// 유저 고유 번호
	private Long userSeq;
	// 유저 ID 
	private String username;
	// 유저 PS
	private String password;
	
	private String userLastname;
	private String userFirstname;
	
	private String userNickname;
	private String userMail;
	private String userNation;
	
	private int userPoint;
	private String userRating;

	// userJoindate / userRole 은 들어갈필요없음 

}
