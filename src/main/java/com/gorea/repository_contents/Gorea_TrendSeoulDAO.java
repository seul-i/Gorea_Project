package com.gorea.repository_contents;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gorea.dto_board.Gorea_TrendSeoul_BoardTO;
import com.gorea.dto_board.Gorea_TrendSeoul_ListTO;
import com.gorea.mapper.TrendMapperInter;

@Repository
public class Gorea_TrendSeoulDAO {

	@Autowired
	private TrendMapperInter mapper;
	
	public List<Gorea_TrendSeoul_ListTO> trendSeoul_List(int offset, int pageSize) {
		
		List<Gorea_TrendSeoul_ListTO> boardList = mapper.trendSeoul_List(offset, pageSize);
		
		for (Gorea_TrendSeoul_ListTO board : boardList) {
			String content = board.getSeoulContent();
			String firstImageUrl = extractFirstImageUrl(content);
			board.setFirstImageUrl(firstImageUrl); // BoardTO에 첫 번째 이미지 URL을 설정
		}
		
		return boardList;
	}
	
	public List<Gorea_TrendSeoul_ListTO> trendSeoul_searchList(int offset, int pageSize , String seoulLocGu, String mainCategory, String subCategory) {
		
		List<Gorea_TrendSeoul_ListTO> boardList = mapper.trendSeoul_searchList(seoulLocGu,mainCategory,subCategory,offset,pageSize);
		
		for (Gorea_TrendSeoul_ListTO board : boardList) {
			String content = board.getSeoulContent();
			String firstImageUrl = extractFirstImageUrl(content);
			board.setFirstImageUrl(firstImageUrl); // BoardTO에 첫 번째 이미지 URL을 설정
		}
		
		return boardList;
	}
	
	public int getTotalRowCount() {
	    int totalRowCount = mapper.get_trendSeoulTotalCount();
	    System.out.println("토탈" + totalRowCount);
	    return totalRowCount;
	}
	
	public int trendSeoul_searchListCount(String seoulLocGu, String mainCategory, String subCategory) {
	    int totalRowCount = mapper.trendSeoul_searchListCount(seoulLocGu,mainCategory,subCategory);
	    System.out.println("토탈" + totalRowCount);
	    return totalRowCount;
	}
	
	public void trendSeoul_Write() {}
	
	public int trendSeoul_Write_Ok(Gorea_TrendSeoul_BoardTO to) {
		int flag = 1;
		int result = mapper.trendSeoul_Write_Ok(to);
		
		if( result == 1 ) {
			flag = 0;
		}
		return flag;
		
	}
	
	public Gorea_TrendSeoul_BoardTO trendSeoul_View(Gorea_TrendSeoul_BoardTO to) {
		
		int hitResult = mapper.TrendHit(to);
		to = mapper.trendSeoul_View(to);
		
		// 이미지 URL 추출
	    String content = to.getSeoulContent();
	    String firstImageUrl = extractFirstImageUrl(content);
	    to.setFirstImageUrl(firstImageUrl);
	    
		Document document = Jsoup.parse(content);
		String textContent = document.text();
		to.setSeoulContent(textContent);
		
		 // 주소 정보 추출
//        String address = to.getSeoulLoc();
//        
//        // 주소를 이용하여 지오코딩 수행
//        Map<String, Double> coordinates = geocoding.getLatLongByAddress(address);
//
//        // 위도와 경도 추출
//        Double latitude = coordinates.get("lat");
//        Double longitude = coordinates.get("lng");
//
//        // 위도와 경도를 TO 객체에 추가
//        to.setLatitude(latitude);
//        to.setLongitude(longitude);

		return to;
	}
	
	public Gorea_TrendSeoul_BoardTO trendSeoul_Modify(Gorea_TrendSeoul_BoardTO to) {
		to = mapper.trendSeoul_Modify(to);
		return to;
	}
	
	public int trendSeoul_Modify_Ok(Gorea_TrendSeoul_BoardTO to) {
		System.out.println("## " + to.toString());
		int flag = 1;
		int result = mapper.trendSeoul_Modify_Ok(to);
		
		if( result == 1 ) {
			flag = 0;
			System.out.println(flag);
		}
		return flag;
	}
	
	public int trendSeoul_Delete_Ok(Gorea_TrendSeoul_BoardTO to) {
		int flag = 2;
		int result = mapper.trendSeoul_Delete_Ok(to);
			
		if ( result == 1 ) {
			flag = 0;
		} else if ( result == 0 ) {
			flag = 1;
		}
		
		return flag;
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
