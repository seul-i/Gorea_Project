package com.gorea.repository_contents;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gorea.dto_board.Gorea_TrendSeoul_ListTO;
import com.gorea.mapper.Top5MapperInter;

@Repository
public class Gorea_Best5DAO {
	
	@Autowired Top5MapperInter mapper;
	
	public List<Gorea_TrendSeoul_ListTO> trendSeoul_List() {
		
		List<Gorea_TrendSeoul_ListTO> boardList = mapper.trendSeoul_List();
		
		for (Gorea_TrendSeoul_ListTO board : boardList) {
			String content = board.getSeoulContent();
			String firstImageUrl = extractFirstImageUrl(content);
			board.setFirstImageUrl(firstImageUrl); // BoardTO에 첫 번째 이미지 URL을 설정
		}
		
		return boardList;
	}
	
    private String extractFirstImageUrl(String content) {
//	    System.out.println("Content: " + content); // 콘텐츠 출력

	    String imageUrl = "";
	    Pattern pattern = Pattern.compile("<img[^>]+src\\s*=\\s*['\"]([^'\"]+)['\"][^>]*>");
	    Matcher matcher = pattern.matcher(content);
	    if (matcher.find()) {
	        imageUrl = matcher.group(1);
//	        System.out.println("Extracted Image URL: " + imageUrl); // 추출된 이미지 URL 출력

	        // URL에서 필요한 부분 추출 및 조정
	        imageUrl = imageUrl.replace("/ckImgSubmit?uid=", "").replace("&amp;fileName=", "_");
//	        System.out.println("Formatted Image URL: " + imageUrl); // 조정된 이미지 URL 출력
	    } else {
	        //System.out.println("No image found"); // 이미지를 찾지 못한 경우
	    }
	    return imageUrl;
	}

}
