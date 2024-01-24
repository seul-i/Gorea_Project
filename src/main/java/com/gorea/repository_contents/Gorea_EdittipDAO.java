package com.gorea.repository_contents;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.gorea.mapper.EdittipMapperInter;
import com.gorea.dto_board.Gorea_EditTip_BoardTO;

@Repository
public class Gorea_EdittipDAO {
	@Autowired
	private EdittipMapperInter mapper;
	
	
	/* editTip */
	
	public List<Gorea_EditTip_BoardTO> editTip_List(int offset, int pageSize) {
		
	    List<Gorea_EditTip_BoardTO> boardList = mapper.editTip_List(offset, pageSize);
	    
	    for (Gorea_EditTip_BoardTO board : boardList) {
	 		   String content = board.getEdittipContent();
	 		   String firstImageUrl = extractFirstImageUrl(content);
	 		   board.setFirstImageUrl(firstImageUrl); // BoardTO에 첫 번째 이미지 URL을 설정
	 	}	

	    return boardList;
	}
	
	public List<Gorea_EditTip_BoardTO> editTip_serachList(String searchType, String searchKeyword, int offset, int pageSize) {
		
		List<Gorea_EditTip_BoardTO> boardList = mapper.searchEdittip(searchType, searchKeyword, offset, pageSize);
    
		for (Gorea_EditTip_BoardTO board : boardList) {
	 		   String content = board.getEdittipContent();
	 		   String firstImageUrl = extractFirstImageUrl(content);
	 		   board.setFirstImageUrl(firstImageUrl); // BoardTO에 첫 번째 이미지 URL을 설정
	 	}	

	    return boardList;
	}

	public int getTotalRowCount() {
	    int totalCount = mapper.getTotalRowCount();
	    return totalCount;
	    
	}
	
	// 검색 페이징
		public int getSearchTotalRowCount(String searchType, String searchKeyword) {
			return mapper.searchTotalCount(searchType, searchKeyword);
		}

	
	public void editTip_Write() {}
	
	public int editTip_Write_Ok(Gorea_EditTip_BoardTO eto) {	
		int flag = 1;
		int result = mapper.editTip_Write_Ok(eto);
			
		if( result == 1 ) {
			flag = 0;
		}
		return flag;
	}
	
	public Gorea_EditTip_BoardTO editTip_View(Gorea_EditTip_BoardTO eto) {
	    // 조회수 증가 메서드 호출
	    int hitResult = mapper.editTip_ViewHit(eto);
	    // 상세 정보 조회
	    eto = mapper.editTip_View(eto);
	    
	    return eto;
	}
	
	public Gorea_EditTip_BoardTO editTip_Modify(Gorea_EditTip_BoardTO eto) {
		return mapper.editTip_Modify(eto);
	}
	
	public int editTip_Modify_Ok(Gorea_EditTip_BoardTO eto) {
		int flag = 1;
		int result = mapper.editTip_Modify_Ok(eto);
		
		if( result == 1 ) {
			flag = 0;
		}
		return flag;
	}
	
	public int editTip_Delete_Ok(Gorea_EditTip_BoardTO eto) {
		int flag = 2;
		int result = mapper.editTip_Delete_Ok(eto);
			
		if ( result == 1 ) {
			flag = 0;
		} else if ( result == 0 ) {
			flag = 1;
		}
		
		return flag;
	}

	// extractFirstImageUrl 메서드
	private String extractFirstImageUrl(String content) {

		String imageUrl = "";
		Pattern pattern = Pattern.compile("<img[^>]+src\\s*=\\s*['\"]([^'\"]+)['\"][^>]*>");
		Matcher matcher = pattern.matcher(content);
		if (matcher.find()) {
			imageUrl = matcher.group(1);
			imageUrl = imageUrl.replace("/ckImgSubmitForEditTip?uid=", "").replace("&amp;fileName=", "_");

		} else {
			System.out.println("No image found");
		}
		return imageUrl;
	}

}

