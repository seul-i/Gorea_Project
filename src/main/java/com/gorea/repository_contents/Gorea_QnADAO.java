package com.gorea.repository_contents;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gorea.dto_board.Gorea_QnA_BoardTO;
import com.gorea.mapper.QnAMapperInter;

@Repository
public class Gorea_QnADAO {
	
	@Autowired
	private QnAMapperInter mapper;
	
	public ArrayList<Gorea_QnA_BoardTO> qna_List(int offset, int pageSize) {
		ArrayList<Gorea_QnA_BoardTO> lists = new ArrayList<Gorea_QnA_BoardTO>();
		lists = mapper.QnA_List(offset, pageSize);
		
		 return lists;
	}
	public ArrayList<Gorea_QnA_BoardTO> searchQnA(String searchType, String searchKeyword, int offset, int pageSize) {
        return mapper.searchQnA(searchType, searchKeyword, offset, pageSize);
    }

	public void qna_Write() {}
	
	public int qna_Write_Ok(Gorea_QnA_BoardTO to) {
		int flag = 1;
		int result = mapper.QnA_Write_Ok(to);
		
		if( result == 1 ) {
			flag = 0;
		}
		return flag;
		
	}
	
	public Gorea_QnA_BoardTO qna_View(Gorea_QnA_BoardTO to) {
		
		to = mapper.QnA_View(to);
		
		return to;
	}
	
	public Gorea_QnA_BoardTO qna_Modify(Gorea_QnA_BoardTO to) {
		to = mapper.QnA_Modify(to);
		return to;
	}
	
	public int qna_Modify_Ok(Gorea_QnA_BoardTO to) {
		System.out.println("## " + to.toString());
		int flag = 1;
		int result = mapper.QnA_Modify_Ok(to);
		
		if( result == 1 ) {
			flag = 0;
			System.out.println(flag);
		}
		return flag;
	}
	
	public int qna_Delete_Ok(Gorea_QnA_BoardTO to) {
		int flag = 2;
		int result = mapper.QnA_Delete_Ok(to);
			
		if ( result == 1 ) {
			flag = 0;
		} else if ( result == 0 ) {
			flag = 1;
		}
		
		return flag;
	}
	
	public Gorea_QnA_BoardTO getPreviousPost(int qnaSeq) {
	    return mapper.getPreviousPost(qnaSeq);
	}

	public Gorea_QnA_BoardTO getNextPost(int qnaSeq) {
	    return mapper.getNextPost(qnaSeq);
	}
	
	// 페이징
	public int getTotalRowCount() {
	    int totalRowCount = mapper.QnA_TotalCount();
	    System.out.println("토탈" + totalRowCount);
	    return totalRowCount;
	}
	
	// 검색 페이징
	public int getSearchTotalRowCount(String searchType, String searchKeyword) {
	    return mapper.searchTotalCount(searchType, searchKeyword);
	}
	
}
