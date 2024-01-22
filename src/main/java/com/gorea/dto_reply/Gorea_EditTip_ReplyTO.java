package com.gorea.dto_reply;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Gorea_EditTip_ReplyTO {
	private String edittipSeq;
    private String userSeq;
    private String edittipCmtSeq;
    private String edittipCmtContent;
    private String edittipCmtWdate;
    private String userNickname;
    
    // user Table의 nation
    private String userNation;
}
