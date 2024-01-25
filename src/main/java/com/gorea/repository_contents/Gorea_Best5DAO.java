package com.gorea.repository_contents;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gorea.dto_board.Gorea_BEST5_BoardTO;
import com.gorea.dto_board.Gorea_BEST5_ListTO;
import com.gorea.dto_board.Gorea_TrendSeoul_BoardTO;
import com.gorea.dto_board.Gorea_TrendSeoul_ListTO;
import com.gorea.dto_board.Gorea_TrendSeoul_SearchTO;
import com.gorea.dto_like.Gorea_BEST5_LikeTO;
import com.gorea.mapper.Top5MapperInter;

@Repository
public class Gorea_Best5DAO {
	
	@Autowired Top5MapperInter mapper;
	
	public Gorea_BEST5_LikeTO boardlikeCheck(Gorea_BEST5_LikeTO boardLike) {
		
		Gorea_BEST5_LikeTO boardList = mapper.boardlikeCheck(boardLike);
		
		System.out.println(boardList);
		
		return boardList;
	}
	
	// TrendSeoul 전체 데이터 출력
	public List<Gorea_TrendSeoul_ListTO> trendSeoul_List() {
		
		List<Gorea_TrendSeoul_ListTO> boardList = mapper.trendSeoul_List();
		
		for (Gorea_TrendSeoul_ListTO board : boardList) {
			String content = board.getSeoulContent();
			String firstImageUrl = extractFirstImageUrl(content);
			board.setFirstImageUrl(firstImageUrl); // BoardTO에 첫 번째 이미지 URL을 설정
		}
		return boardList;
	}
	
	
	// TrendSeoul 검색 데이터 출력
	public List<Gorea_TrendSeoul_ListTO> trendSeoul_searchList(String locGu, String mainCategory, String subCategory) {
		
		List<Gorea_TrendSeoul_ListTO> boardList = mapper.trendSeoul_searchList(locGu,mainCategory,subCategory);
		
		for (Gorea_TrendSeoul_ListTO board : boardList) {
			String content = board.getSeoulContent();
			String firstImageUrl = extractFirstImageUrl(content);
			board.setFirstImageUrl(firstImageUrl); // BoardTO에 첫 번째 이미지 URL을 설정
		}
		
		return boardList;
	}
	
	// 검색 목록 제공을위해 현재 데이터 Gu를 중복 제거하고 출력
	public List<Gorea_TrendSeoul_SearchTO> search_locGu() {
		
		List<Gorea_TrendSeoul_SearchTO> searchGu = mapper.search_locGu();
		
		return searchGu;
	}
	
	// 검색 목록 제공을위해 categoryNo 에서 데이터 출력
	public List<Gorea_TrendSeoul_SearchTO> search_mainCategroy() {
		
		List<Gorea_TrendSeoul_SearchTO> searchmainCategory = mapper.search_mainCategroy();
		
		return searchmainCategory;
	}
	
	// 검색 목록 제공을위해 categoryNo 에서 main 카테고리에 대한 서브 카테고리 데이터만 출력
	public List<Gorea_TrendSeoul_SearchTO> search_subCategroy(String mainCategory) {
		
		List<Gorea_TrendSeoul_SearchTO> searchsubCategory = mapper.search_subCategroy(mainCategory);
		
		return searchsubCategory;
	}
	
	
	public int besttop5_Write_Ok(Gorea_BEST5_BoardTO to) {
		
		int flag = 1;
		
		int result = mapper.besttop5_Write_Ok(to);
		
		if( result == 1 ) {
			flag = 0;
		}
		
		return flag;
	}
	
	public int addToFavorites(Gorea_BEST5_LikeTO to) {
		
		int flag = 1;
		
		int result = mapper.addToFavorites(to);
		
		if( result == 1 ) {
			flag = 0;
		}
		
		return flag;
	}
	
	public List<Gorea_BEST5_ListTO> best5_top5_boardList(int offset, int pageSize) {
			
		List<Gorea_BEST5_ListTO> boardList = mapper.best5_top5_boardList(offset, pageSize);
		
		for (Gorea_BEST5_ListTO board : boardList) {
			String content1 = board.getSeoulContent1();
			String firstImageUrl1 = extractFirstImageUrl(content1);
			board.setFirstImageUrl1(firstImageUrl1);
			
			String content2 = board.getSeoulContent2();
			String firstImageUrl2 = extractFirstImageUrl(content2);
			board.setFirstImageUrl2(firstImageUrl2);
			
			String content3 = board.getSeoulContent3();
			String firstImageUrl3 = extractFirstImageUrl(content3);
			board.setFirstImageUrl3(firstImageUrl3);
			
			String content4 = board.getSeoulContent4();
			String firstImageUrl4 = extractFirstImageUrl(content4);
			board.setFirstImageUrl4(firstImageUrl4);
			
			String content5 = board.getSeoulContent5();
			String firstImageUrl5 = extractFirstImageUrl(content5);
			board.setFirstImageUrl5(firstImageUrl5);
		}	
		return boardList;
	}
	
	public int getTop5RowCount() {
	    int totalRowCount = mapper.get_trendSeoulTotalCount();
	    System.out.println("토탈" + totalRowCount);
	    return totalRowCount;
	}
	
	public List<Gorea_BEST5_ListTO> best5_top5_boardList_NS(int offset, int pageSize, String nation) {
		
		List<Gorea_BEST5_ListTO> boardList = mapper.best5_top5_boardList_NS(nation,offset,pageSize);
		
		for (Gorea_BEST5_ListTO board : boardList) {
			String content1 = board.getSeoulContent1();
			String firstImageUrl1 = extractFirstImageUrl(content1);
			board.setFirstImageUrl1(firstImageUrl1);
			
			String content2 = board.getSeoulContent2();
			String firstImageUrl2 = extractFirstImageUrl(content2);
			board.setFirstImageUrl2(firstImageUrl2);
			
			String content3 = board.getSeoulContent3();
			String firstImageUrl3 = extractFirstImageUrl(content3);
			board.setFirstImageUrl3(firstImageUrl3);
			
			String content4 = board.getSeoulContent4();
			String firstImageUrl4 = extractFirstImageUrl(content4);
			board.setFirstImageUrl4(firstImageUrl4);
			
			String content5 = board.getSeoulContent5();
			String firstImageUrl5 = extractFirstImageUrl(content5);
			board.setFirstImageUrl5(firstImageUrl5);
		}	
		return boardList;
	}
	
	public int getsearchTop5RowCount() {
	    int totalRowCount = mapper.get_searchtrendSeoulTotalCount();
	    System.out.println("토탈" + totalRowCount);
	    return totalRowCount;
	}
	
	public Gorea_BEST5_ListTO bestTop5_View(Gorea_BEST5_ListTO to) {
		
		int hitResult = mapper.TrendHit(to);
		to = mapper.bestTop5_View(to);
		
		// 이미지 URL 추출
		String content1 = to.getSeoulContent1();
		String firstImageUrl1 = extractFirstImageUrl(content1);
		to.setFirstImageUrl1(firstImageUrl1);
		
		String content2 = to.getSeoulContent2();
		String firstImageUrl2 = extractFirstImageUrl(content2);
		to.setFirstImageUrl2(firstImageUrl2);
		
		String content3 = to.getSeoulContent3();
		String firstImageUrl3 = extractFirstImageUrl(content3);
		to.setFirstImageUrl3(firstImageUrl3);
		
		String content4 = to.getSeoulContent4();
		String firstImageUrl4 = extractFirstImageUrl(content4);
		to.setFirstImageUrl4(firstImageUrl4);
		
		String content5 = to.getSeoulContent5();
		String firstImageUrl5 = extractFirstImageUrl(content5);
		to.setFirstImageUrl5(firstImageUrl5);

		return to;
	}
	
    private String extractFirstImageUrl(String content) {
    	// System.out.println("Content: " + content); // 콘텐츠 출력

	    String imageUrl = "";
	    Pattern pattern = Pattern.compile("<img[^>]+src\\s*=\\s*['\"]([^'\"]+)['\"][^>]*>");
	    Matcher matcher = pattern.matcher(content);
	    if (matcher.find()) {
	        imageUrl = matcher.group(1);
	        // System.out.println("Extracted Image URL: " + imageUrl); // 추출된 이미지 URL 출력

	        // URL에서 필요한 부분 추출 및 조정
	        imageUrl = imageUrl.replace("/ckImgSubmit?uid=", "").replace("&amp;fileName=", "_");
	        // System.out.println("Formatted Image URL: " + imageUrl); // 조정된 이미지 URL 출력
	    } else {
	        // System.out.println("No image found"); // 이미지를 찾지 못한 경우
	    }
	    return imageUrl;
	}

}
