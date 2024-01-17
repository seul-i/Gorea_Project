package com.gorea.dto_reply;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Gorea_TrendSeoul_ReplyTO {

	private String seoulSeq;
	private String userSeq;
	private String seoulReviewSeq;
	private String comment;
	private String seoulScore; // 별점
	private String reviewDate;
	
	// user Table의 nickname
	private String userNickname;
	
}
