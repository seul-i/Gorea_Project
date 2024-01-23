package com.gorea.repository_contents;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gorea.dto_board.Gorea_Free_BoardTO;
import com.gorea.dto_board.Gorea_Recommend_BoardTO;
import com.gorea.mapper.UserRecomMapperInter;

@Repository
public class Gorea_RecommendDAO {

	@Autowired
	private UserRecomMapperInter mapper;
	
	public List<Gorea_Recommend_BoardTO> userRecom_list(int offset, int pageSize){
		List<Gorea_Recommend_BoardTO> lists = mapper.userRecom_list( offset, pageSize );
		
		for ( Gorea_Recommend_BoardTO board : lists ) {
			String content =  board.getUserRecomContent();
			String firstImageUrl = extractFirstImageUrl( content );
			board.setFirstImageUrl(firstImageUrl);
		}
		
		//System.out.println( "lists : " + lists );
		return lists;
	}
	
	
	// 페이징
	public Gorea_Recommend_BoardTO getPreviousPost(int userRecomSeq) {
	    return mapper.getPreviousPost(userRecomSeq);
	}

	public Gorea_Recommend_BoardTO getNextPost(int userRecomSeq) {
	    return mapper.getNextPost(userRecomSeq);
	}
	
	
	public int getTotalRowCount() {
		int totalRowCount = mapper.get_userRecommentTotalCount();
		
		System.out.println( "총 게시물 수 : " + totalRowCount );
		
		return totalRowCount;
	}
	
	public int getSearchTotalRowCount(String searchType, String searchKeyword) {
	    return mapper.searchTotalCount(searchType, searchKeyword);
	}
	
	
	
	public void userRecom_write() {}
	
	public int userRecom_writeOk( Gorea_Recommend_BoardTO to ) {
		int flag = 1;
		int result = mapper.userRecom_WriteOk(to);
		
		if( result == 1 ) {
			flag = 0;
		}
		
		return flag;
	}
	
	
	public Gorea_Recommend_BoardTO userRecom_view( Gorea_Recommend_BoardTO to ){
		mapper.userRecom_Hit(to);
		
		to = mapper.userRecom_View(to);
		
		System.out.println( "userView에서 댓글수 : " + to.getUserRecomCmt() );
		
		// 이미지 URL 추출
	    String content = to.getUserRecomContent();
	    String firstImageUrl = extractFirstImageUrl(content);
	    to.setFirstImageUrl(firstImageUrl);
		
		return to;
	}
	
	
	public int userRecom_deleteOk( Gorea_Recommend_BoardTO to ) {
		int flag = 2;
		int result = mapper.userRecom_deleteOk(to);
		
		if ( result == 1 ) {
			flag = 0;
		} else if ( result == 0 ) {
			flag = 1;
		}
		
		return flag;
	}
	
	
	public Gorea_Recommend_BoardTO userRecom_modify(Gorea_Recommend_BoardTO to) {
		return mapper.userRecom_modify(to);
	}
	
	
	public int userRecom_modifyOk(Gorea_Recommend_BoardTO to) {
		int flag = 1;
		
		int result = mapper.userRecom_modifyOk(to);
		
		if( result == 1 ) {
			flag = 0;
			System.out.println(flag);
		}
		
		return flag;
	}
	
	public Gorea_Recommend_BoardTO replyCount( Gorea_Recommend_BoardTO to ) {
		return mapper.replyCount(to);
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
	        imageUrl = imageUrl.replace("/ckImgSubmitForUserRecom?uid=", "/upload/").replace("&amp;fileName=", "_");
//	        System.out.println("Formatted Image URL: " + imageUrl); // 조정된 이미지 URL 출력
	    } else {
	        //System.out.println("No image found"); // 이미지를 찾지 못한 경우
	    }
	    return imageUrl;
	}
}
