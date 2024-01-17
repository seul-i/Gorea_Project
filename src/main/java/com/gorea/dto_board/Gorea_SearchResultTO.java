package com.gorea.dto_board;

import org.springframework.stereotype.Repository;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Repository
public class Gorea_SearchResultTO {
	
	private String boardType;
    private int id;
    private String title;
    private String content;
    private String postDate;
    private int hit;
}
