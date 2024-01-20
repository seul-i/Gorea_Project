package com.gorea.dto_board;

import org.springframework.stereotype.Repository;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Repository
public class Gorea_Free_BoardTO {
	private String freeSeq; // 게시글 번호
	private String freeTitle;
	private String freeContent;
	private String freeHit;
	private String freepostDate;
	private String freeRecomcount; // 추천수
	private String freeCmt; // 댓글 수
	
	//board분류
	private String freeboardNo;
	
	//user
	private String userSeq;
	private String userNickname;
}
