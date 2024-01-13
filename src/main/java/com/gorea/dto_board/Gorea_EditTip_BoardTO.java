package com.gorea.dto_board;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Gorea_EditTip_BoardTO implements Serializable{	
	private String edittipSeq;
	private String userSeq;
	private String edittipboardNo;
	private String edittipSubject;
	private String edittipSubtitle;
	private String edittipContent;
	private String edittipHit;
	private String edittipWdate;
    private String firstImageUrl;
}
