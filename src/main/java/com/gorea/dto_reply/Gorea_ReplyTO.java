package com.gorea.dto_reply;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Gorea_ReplyTO {
	private String cseq; // 댓글번호
	private String goreaboardNo; // 게시판 분류
	private String pseq; // 게시글 번호
	
	private String userSeq;
	
	private String replyContent; // 댓글 내용
	private String replypostDate; // 작성날짜
	
	private int wgap;
	
	private int grp; // 댓글그룹 => 댓글 번호
	private int grpl; // 댓글 깊이( 댓글이면 0, 대댓글이면 1 )
	
	//Join
	private String userNickname; // 작성자 -> user의 nickname
}
