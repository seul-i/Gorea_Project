package com.gorea.dto_reply;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Gorea_QnA_ReplyTO {

	private String qnaSeq;
	private String userSeq;
	private String qnaCmtSeq ;
	private String qnaCmtContent ;
	private String qnaCmtWdate ;
	
	// user Table의 nickname
	private String userNickname;
	
}
