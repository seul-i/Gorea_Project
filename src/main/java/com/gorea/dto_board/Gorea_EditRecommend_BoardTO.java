package com.gorea.dto_board;

import java.io.Serializable;

import org.springframework.stereotype.Repository;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Repository
public class Gorea_EditRecommend_BoardTO implements Serializable{
	private String editrecoSeq;
	private String editrecoSubject;
	private String editrecoSubtitle;
	private String editrecoContent;
	private String editrecoHit;
	private String editrecoWdate;
	private String uid;
    private String filename;
    private String firstImageUrl;
}
