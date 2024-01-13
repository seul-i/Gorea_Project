package com.gorea.dto_board;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Gorea_EditRecommend_BoardTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String editrecoSeq;
    private String userSeq;
    private String editrecoboardNo;
    private String editrecoSubject;
    private String editrecoSubtitle;
    private String editrecoContent;
    private String editrecoHit;
    private String editrecoWdate;
    private String firstImageUrl;
}


