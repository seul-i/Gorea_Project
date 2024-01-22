package com.gorea.dto_reply;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Gorea_EditRecommend_ReplyTO {
    private String editrecoSeq;
    private String userSeq;
    private String editrecoCmtSeq;
    private String editrecoCmtContent;
    private String editrecoCmtWdate;
    private String userNickname;
    
    // user Table의 nation
    private String userNation;
}
