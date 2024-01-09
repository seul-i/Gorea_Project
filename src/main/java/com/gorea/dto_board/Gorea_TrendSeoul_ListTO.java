package com.gorea.dto_board;

import org.springframework.stereotype.Repository;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Repository
public class Gorea_TrendSeoul_ListTO {

	private String seoulSeq;         // 글 번호
	private String userSeq;          // 글 작성자 정보
	private String seoulRank;        // 검색건 수
	private String seoulTitle;       // 제목
	private String seoulContent;     // 내용
	private String seoulLocGu;		 // 구 
	private String seoulScore;       // 리뷰 점수
	
	// content 사진
	private String firstImageUrl;
    
    // join
    private String mainCategory;
    private String subCategory;

}
