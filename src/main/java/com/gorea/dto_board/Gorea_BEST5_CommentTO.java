package com.gorea.dto_board;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Gorea_BEST5_CommentTO {
	private String top5Seq;
    private String seoulSeq;
    private String popularSeq; 
    private String top5Comment;
}
