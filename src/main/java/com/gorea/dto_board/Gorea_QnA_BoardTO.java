package com.gorea.dto_board;

import org.springframework.stereotype.Repository;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Repository
public class Gorea_QnA_BoardTO {
	
	private String qnaSeq;
	private String userSeq;
	private String qnaboardNo;
	private String qnaCategory;
	private String qnaTitle;
	private String qnapostDate;
	private String qnaContent;
	private String qnaCmt;
	
	private String userNickname;
}
