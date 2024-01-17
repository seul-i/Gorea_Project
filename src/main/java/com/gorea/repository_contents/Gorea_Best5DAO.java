package com.gorea.repository_contents;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gorea.dto_board.Gorea_BEST5_WriteTO;
import com.gorea.dto_board.Gorea_BEST5_BoardTO;
import com.gorea.dto_board.Gorea_BEST5_CommentTO;
import com.gorea.dto_board.Gorea_TrendSeoul_ListTO;
import com.gorea.dto_board.Gorea_TrendSeoul_SearchTO;
import com.gorea.mapper.Top5MapperInter;

@Repository
public class Gorea_Best5DAO {
	
	@Autowired Top5MapperInter mapper;
	
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
	
	// BestTop5 어떤 사용자가 어떤 글을 작성했는지 insert 
	public Gorea_BEST5_WriteTO best5_write_ok(Gorea_BEST5_WriteTO bto) {
		
		mapper.best5_Write_Ok(bto);
		
		bto = mapper.best5_top5Seq(bto);
		
		return bto;
	}
	
	public int best5_writeComment_ok(Gorea_BEST5_CommentTO cto) {
		
		int flag = 1;
		
		int result = mapper.best5_WriteComment_Ok(cto);
		
		if( result == 1 ) {
			flag = 0;
		}
		
		return flag;
	}
	
	

	public List<Gorea_BEST5_BoardTO> best5_top5_boardList() {
			
		List<Gorea_BEST5_BoardTO> boardList = mapper.best5_top5_boardList();
		
		System.out.println(boardList);
		
		for (Gorea_BEST5_BoardTO board : boardList) {
			String content = board.getSeoulContent();
			String firstImageUrl = extractFirstImageUrl(content);
			board.setFirstImageUrl(firstImageUrl); // BoardTO에 첫 번째 이미지 URL을 설정
		}	
		return boardList;
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
