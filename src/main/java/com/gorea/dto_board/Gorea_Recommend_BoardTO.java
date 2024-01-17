package com.gorea.dto_board;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Gorea_Recommend_BoardTO implements Serializable {
	
	private static final long serialVesionUID = 1L;
	
	private String userRecomSeq; //게시글 번호
	private String userSeq;
	private String userRecomboardNo;
	private String userRecomTitle;
	private String userRecomContent;
	private String userRecomHit; // 조회수
	private String userRecomCmt; // 댓글수
	private String userRecompostDate; // 작성일자
	private String userRecomRecomcount; // 추천수
	
	private int wgap;
	
	// content 사진
	private String uid;
	private String filename;
	private String firstImageUrl;
	
	//join to
	private String userNickname;
}
