package com.gorea.repository_contents;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gorea.dto_board.Gorea_Free_BoardTO;
import com.gorea.mapper.FreeboardMapperInter;

@Repository
public class Gorea_FreeBoardDAO {
	@Autowired
	private FreeboardMapperInter mapper;
	
	public ArrayList<Gorea_Free_BoardTO> free_List(int offset, int pageSize) {
		ArrayList<Gorea_Free_BoardTO> lists = new ArrayList<Gorea_Free_BoardTO>();
		lists = mapper.Free_List(offset, pageSize);
		
		 return lists;
	}
	
	public ArrayList<Gorea_Free_BoardTO> searchFree(String searchType, String searchKeyword, int offset, int pageSize) {
        return mapper.searchFree(searchType, searchKeyword, offset, pageSize);
    }

	public void free_Write() {}
	
	public int free_Write_Ok(Gorea_Free_BoardTO to) {
		int flag = 1;
		int result = mapper.Free_Write_Ok(to);
		
		if( result == 1 ) {
			flag = 0;
		}
		return flag;
		
	}
	
	public Gorea_Free_BoardTO free_View(Gorea_Free_BoardTO to) {
	    int hitResult = mapper.FreeHit(to);
	    
	    to = mapper.Free_View(to);
	    

	    return to;
	}
	
	public void increaseLikes(String freeSeq) {
	    mapper.increaseLikes(freeSeq);
	}
	
	public Gorea_Free_BoardTO free_Modify(Gorea_Free_BoardTO to) {
		to = mapper.Free_Modify(to);
		return to;
	}
	
	public int free_Modify_Ok(Gorea_Free_BoardTO to) {
		int flag = 1;
		int result = mapper.Free_Modify_Ok(to);
		
		if( result == 1 ) {
			flag = 0;
			System.out.println(flag);
		}
		return flag;
	}
	
	public int free_Delete_Ok(Gorea_Free_BoardTO to) {
		int flag = 2;
		int result = mapper.Free_Delete_Ok(to);
			
		if ( result == 1 ) {
			flag = 0;
		} else if ( result == 0 ) {
			flag = 1;
		}
		
		return flag;
	}
	
	public Gorea_Free_BoardTO getPreviousPost(int freeSeq) {
	    return mapper.getPreviousPost(freeSeq);
	}

	public Gorea_Free_BoardTO getNextPost(int freeSeq) {
	    return mapper.getNextPost(freeSeq);
	}
	
	// 페이징
	public int getTotalRowCount() {
	    int totalRowCount = mapper.free_TotalCount();
	    System.out.println("토탈" + totalRowCount);
	    return totalRowCount;
	}
	
	// 검색 페이징
	public int getSearchTotalRowCount(String searchType, String searchKeyword) {
	    return mapper.searchTotalCount(searchType, searchKeyword);
	}

}
