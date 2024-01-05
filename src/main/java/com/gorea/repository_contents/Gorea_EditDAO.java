package com.gorea.repository_contents;

import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gorea.mapper.UserMapper;
import com.gorea.dto_board.Gorea_EditRecommendListTO;
import com.gorea.dto_board.Gorea_EditRecommend_BoardTO;
import com.gorea.dto_board.Gorea_EditTip_BoardTO;

@Repository
public class Gorea_EditDAO {
	@Autowired
	private UserMapper mapper;
	
	public List<Gorea_EditRecommend_BoardTO> editRecommend_List(int offset, int pageSize) {
	    List<Gorea_EditRecommend_BoardTO> lists = mapper.editRecommend_List(offset, pageSize);

	    for (Gorea_EditRecommend_BoardTO to : lists) {
	        String subtitle = to.getEditrecoSubtitle();
	        // Document document = Jsoup.parse(subtitle);
	        // String textContent = document.text();
	        // to.setGo_editreco_subtitle(textContent);
	        
	    }

	    return lists;
	}

	public int getTotalRowCount() {
	    int totalRowCount = mapper.getTotalRowCount();
	    System.out.println("getTotalRowCount returned: " + totalRowCount);
	    return totalRowCount;
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
	    return to;
	}
	
	public Gorea_EditRecommend_BoardTO editRecommend_Modify(Gorea_EditRecommend_BoardTO to) {
		return mapper.editRecommend_Modify(to);
	}
	
	public int editRecommend_Modify_Ok(Gorea_EditRecommend_BoardTO to) {
		System.out.println("## " + to.toString());
		int flag = 1;
		int result = mapper.editRecommend_Modify_Ok(to);
		
		if( result == 1 ) {
			flag = 0;
			System.out.println(flag);
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
}