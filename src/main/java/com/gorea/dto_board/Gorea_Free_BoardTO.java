package com.gorea.dto_board;

import org.springframework.stereotype.Repository;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Repository
public class Gorea_Free_BoardTO {
	private String freeSeq;
	private String freeTitle;
	private String freeContent;
	private String freeHit;
	private String freepostDate;
	private String freeRecomcount;
}
