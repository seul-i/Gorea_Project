package com.gorea.repository_contents;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.gorea.mapper.EditrecoMapperInter;
import com.gorea.dto_board.Gorea_EditRecommend_BoardTO;
import com.gorea.dto_board.Gorea_EditTip_BoardTO;
import com.gorea.dto_board.Gorea_TrendSeoul_ListTO;

@Repository
public class Gorea_EditrecoDAO {
	@Autowired
	private EditrecoMapperInter mapper;
	
	/**
	 * 에디터 추천 목록을 가져오는 메소드
	 *
	 * @param offset   가져올 목록의 시작 위치
	 * @param pageSize 페이지당 표시할 항목 수
	 * @return 에디터 추천 목록
	 */
	public List<Gorea_EditRecommend_BoardTO> editRecommend_List(int offset, int pageSize) {
	    
		List<Gorea_EditRecommend_BoardTO> boardList = mapper.editRecommend_List(offset, pageSize);
	    
		for (Gorea_EditRecommend_BoardTO board : boardList) {
			String content = board.getEditrecoContent();
			String firstImageUrl = extractFirstImageUrl(content);
			board.setFirstImageUrl(firstImageUrl);
			
		}
	    return boardList;
	}
	
	public List<Gorea_EditRecommend_BoardTO> editRecommend_serachList(String searchType, String searchKeyword, int offset, int pageSize) {
		List<Gorea_EditRecommend_BoardTO> boardList =  mapper.searchEditreco(searchType, searchKeyword, offset, pageSize);
    
		for (Gorea_EditRecommend_BoardTO board : boardList) {
			String content = board.getEditrecoContent();
			String firstImageUrl = extractFirstImageUrl(content);
			board.setFirstImageUrl(firstImageUrl); // BoardTO에 첫 번째 이미지 URL을 설정
		}

	    return boardList;
	}
	
	

	/**
	 * 전체 레코드(데이터 항목)의 수를 가져오는 메소드
	 * @return 전체 레코드 수
	 */
	public int getTotalRowCount() {
	    int totalRowCount = mapper.getTotalRowCount();
	    return totalRowCount;
	}
	
	// 검색 페이징
	public int getSearchTotalRowCount(String searchType, String searchKeyword) {
		return mapper.searchTotalCount(searchType, searchKeyword);
	}



	public void editRecommend_Write() {}

	
	public int editRecommend_Write_Ok(Gorea_EditRecommend_BoardTO to) {	
		int flag = 1;
		int result = mapper.editRecommend_Write_Ok(to);
			
		if( result == 1 ) {
			flag = 0;
		}
		return flag;
	}
	
	public Gorea_EditRecommend_BoardTO editRecommend_View(Gorea_EditRecommend_BoardTO to) {
	    // 조회수 증가 메서드 호출
	    int hitResult = mapper.editRecommend_ViewHit(to);
	    // 상세 정보 조회
	    to = mapper.editRecommend_View(to);
	    
	    System.out.println(to.getEditrecoContent());
		
	    return to;
	}
	
	public Gorea_EditRecommend_BoardTO editRecommend_Modify(Gorea_EditRecommend_BoardTO to) {
		return mapper.editRecommend_Modify(to);
	}
	
	public int editRecommend_Modify_Ok(Gorea_EditRecommend_BoardTO to) {
		int flag = 1;
		int result = mapper.editRecommend_Modify_Ok(to);
		
		if( result == 1 ) {
			flag = 0;
			
		}
		return flag;
	}
	
	public int editRecommend_Delete_Ok(Gorea_EditRecommend_BoardTO to) {
		int flag = 2;
		int result = mapper.editRecommend_Delete_Ok(to);
			
		if ( result == 1 ) {
			flag = 0;
		} else if ( result == 0 ) {
			flag = 1;
		}
		
		return flag;
	}

	private String extractFirstImageUrl(String content) {

	      String imageUrl = "";
	      Pattern pattern = Pattern.compile("<img[^>]+src\\s*=\\s*['\"]([^'\"]+)['\"][^>]*>");
	      Matcher matcher = pattern.matcher(content);

	      if (matcher.find()) {
	         imageUrl = matcher.group(1);
	         imageUrl = imageUrl.replace("/ckImgSubmitForEditRecommend?uid=", "").replace("&amp;fileName=", "_");
	         

	      } else {
	         System.out.println("No image found");
	      }
	      return imageUrl;
	   }
	
}

