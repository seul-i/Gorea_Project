package com.gorea.dto_board;

import org.springframework.stereotype.Repository;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Repository
public class Gorea_Notice_BoardTO {
	
	private String noticeSeq;
	private String noticeTitle;
	private String noticeContent;
	private String noticeHit;
	private String noticepostDate;
}
