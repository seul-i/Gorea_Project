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
public class Gorea_TrendSeoul_SearchTO implements Serializable {
	
	private static final long serialVersionUID = 1L;

	private String seoulLocGu; 
    
    private String mainCategory;
    private String subCategory;

}
