package com.gorea.dto_board;

import org.springframework.stereotype.Repository;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Repository
public class Gorea_TrendSeoul_BoardTO {

	private String seoulSeq;         // 글 번호
	private String userSeq;          // 글 작성자 정보
	private String seoulboardNo;     // 게시판 분류 
	private String seoulcategoryNo;  // 카테고리 
	private String seoulRank;        // 검색건 수
	private String seoulTitle;       // 제목
	private String seoulsubTitle;    // 서브제목
	private String seoulpostDate;    // 글작성 일자
	private String seoulHit;         // 조회수
	private String seoulContent;     // 내용
	private String seoulLoc;         // 위치(주소)
	private String seoulLocGu;		 // 구 
	private String seoulSite;        // 사이트
	private String seoulusageTime;   // 이용 시간
	private String seoulusageFee;    // 이용 요금
	private String seoulTrafficinfo; // 교통 정보
	private String seoulNotice;      // 알아야할 정보
	private String seoulScore;       // 리뷰 점수
	
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
