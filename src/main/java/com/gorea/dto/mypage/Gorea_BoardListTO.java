package com.gorea.dto.mypage;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Gorea_BoardListTO {

	private String boardType;
    private int id;
    private String title;
    private String recommend;
    private String postDate;
    private int hit;
    
    private String qnaSeq;
    private String qnaContent;
    
    // 댓글 조회 추가
    private int boardID;
    private String comment;
    
    // join
    private String userNickname;
}
