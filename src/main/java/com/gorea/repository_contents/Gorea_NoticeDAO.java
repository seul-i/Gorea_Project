package com.gorea.repository_contents;

import java.util.ArrayList;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.gorea.dto_board.Gorea_Free_BoardTO;
import com.gorea.dto_board.Gorea_Notice_BoardTO;
import com.gorea.mapper.NoticeMapperInter;

@Repository
public class Gorea_NoticeDAO {
	
	@Autowired
	private NoticeMapperInter mapper;
	
	public ArrayList<Gorea_Notice_BoardTO> notice_List(int offset, int pageSize) {
		ArrayList<Gorea_Notice_BoardTO> lists = new ArrayList<Gorea_Notice_BoardTO>();
		lists = mapper.Notice_List(offset, pageSize);
		
		 return lists;
	}
	
	public ArrayList<Gorea_Notice_BoardTO> searchNotices(String searchType, String searchKeyword, int offset, int pageSize) {
        return mapper.searchNotice(searchType, searchKeyword, offset, pageSize);
    }

	public void notice_Write() {}
	
	public int notice_Write_Ok(Gorea_Notice_BoardTO to) {
		int flag = 1;
		int result = mapper.Notice_Write_Ok(to);
		
		if( result == 1 ) {
			flag = 0;
		}
		return flag;
		
	}
	
	public Gorea_Notice_BoardTO notice_View(Gorea_Notice_BoardTO to) {
	    int hitResult = mapper.NoticeHit(to);
	    
	    to = mapper.Notice_View(to);
	    

	    return to;
	}
	
	public Gorea_Notice_BoardTO notice_Modify(Gorea_Notice_BoardTO to) {
		to = mapper.Notice_Modify(to);
		return to;
	}
	
	public int notice_Modify_Ok(Gorea_Notice_BoardTO to) {
		System.out.println("## " + to.toString());
		int flag = 1;
		int result = mapper.Notice_Modify_Ok(to);
		
		if( result == 1 ) {
			flag = 0;
			System.out.println(flag);
		}
		return flag;
	}
	
	public int notice_Delete_Ok(Gorea_Notice_BoardTO to) {
		int flag = 2;
		int result = mapper.Notice_Delete_Ok(to);
			
		if ( result == 1 ) {
			flag = 0;
		} else if ( result == 0 ) {
			flag = 1;
		}
		
		return flag;
	}
	
	public Gorea_Notice_BoardTO getPreviousPost(int noticeSeq) {
	    return mapper.getPreviousPost(noticeSeq);
	}

	public Gorea_Notice_BoardTO getNextPost(int noticeSeq) {
	    return mapper.getNextPost(noticeSeq);
	}
	
	// 페이징
	public int getTotalRowCount() {
	    int totalRowCount = mapper.Notice_TotalCount();
	    System.out.println("토탈" + totalRowCount);
	    return totalRowCount;
	}
	
	// 검색 페이징
	public int getSearchTotalRowCount(String searchType, String searchKeyword) {
	    return mapper.searchTotalCount(searchType, searchKeyword);
	}
	
}
