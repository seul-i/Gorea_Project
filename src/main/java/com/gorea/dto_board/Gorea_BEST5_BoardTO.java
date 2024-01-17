package com.gorea.dto_board;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Gorea_BEST5_BoardTO {
	private String top5Seq;
    private String userSeq;
    private String seoulSeq;
    private String seoulcategoryNo;
    private String seoulTitle;
    private String seoulContent;
    private String seoulLoc;
    private String seoulLocGu;
    private String top5Comment;
    private int top5Hit;
    private String top5postDate;
    
    // content 사진
 	private String uid;
 	private String filename;
 	private String firstImageUrl;
 	
 	// 주소 -> 위도, 경도 변환
     private Double latitude;
     private Double longitude;
     
     // join
     private String mainCategory;
     private String subCategory;
}
