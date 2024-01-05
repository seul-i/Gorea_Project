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

	private String go_seoul_seq;
	private String go_seoul_subject;
	private String go_seoul_subtitle;
	private String go_seoul_content;
	private String go_seoul_hit;
	private String go_seoul_wdate;
	private String go_seoul_loc;
	private String uid;
	private String filename;
	private String tel;
	private String address;
	private String facilities;
	private String traffic_info;
	
    private Double latitude;
    private Double longitude;
    
    private String firstImageUrl;
    
}
