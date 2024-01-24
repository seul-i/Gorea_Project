package com.gorea.repository_contents;

import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gorea.dto.mypage.Gorea_BoardListTO;
import com.gorea.dto_board.Gorea_QnA_BoardTO;
import com.gorea.dto_board.Gorea_SearchResultTO;
import com.gorea.dto_user.Gorea_UserTO;
import com.gorea.mapper.MypageMapper;

@Repository
public class Gorea_MypageDAO {

	@Autowired
	private MypageMapper mypageMapper;
	
	// ============================== 회원 정보 =====================================
	// 회원 정보 조회
	public Gorea_UserTO userInfoModify(Gorea_UserTO uto) {
		uto = mypageMapper.userInfoModify(uto);
		return uto;
	}
	
	// 회원 정보 수정
	public int userInfoModify_Ok(Gorea_UserTO uto) {
		return mypageMapper.userInfoModify_Ok(uto);
	}
	
	// ============================== 게시글 관리 ====================================
	// 통합 게시글 조회
	public List<Gorea_BoardListTO> boardList(String userSeq, int offset, int pageSize) {
		List<Gorea_BoardListTO> lists = new ArrayList<Gorea_BoardListTO>();
		lists = mypageMapper.boardList(userSeq, offset, pageSize);
		return lists;
	}
	
	// 게시글 키워드 검색
	public List<Gorea_BoardListTO> searchBoardList(String userSeq, String keyword, int offset, int pageSize) {
		return mypageMapper.searchBoardList(userSeq, keyword, offset, pageSize);
	}
	
	// 총 게시글 count
	public int getTotalRowCount() {
		int totalRowCount = mypageMapper.mypageBoardList_TotalCount();
		return totalRowCount;
	}
	
	// 검색 페이징
    public int countTotalSearchResults(String keyword) {
        return mypageMapper.countTotalSearchResults(keyword);
    }
    
    // ========================== 댓글 관리 =========================== //

	// 통합 댓글 조회
	public List<Gorea_BoardListTO> replyList(String userSeq, int offset, int pageSize) {
		List<Gorea_BoardListTO> lists = new ArrayList<Gorea_BoardListTO>();
		lists = mypageMapper.replyList(userSeq, offset, pageSize);
		return lists;
	}
	
	// 댓글 키워드 검색
	public List<Gorea_BoardListTO> searchReplyList(String userSeq, String keyword, int offset, int pageSize) {
		return mypageMapper.searchReplyList(userSeq, keyword, offset, pageSize);
	}
	
	// 총 댓글 count
	public int getReplyTotalRowCount() {
		int totalRowCount = mypageMapper.mypageReplyList_TotalCount();
		return totalRowCount;
	}
	
	// 검색 페이징
	public int countSearchReplyLish(String userSeq, String keyword) {
		return mypageMapper.countSearchReplyList(userSeq, keyword);
	}
	
	// =============================== 1:1 문의 내역
	// 문의 조회
	public List<Gorea_QnA_BoardTO> qnaList(String userSeq, int offset, int pageSize) {
		List<Gorea_QnA_BoardTO> lists = new ArrayList<Gorea_QnA_BoardTO>();
		lists = mypageMapper.qnaList(userSeq, offset, pageSize);
		return lists;
	}
	
	// 총 qna count
	public int QnaTotalRowCount() {
		int totalRowCount = mypageMapper.mypageQnaList_TotalCount();
		return totalRowCount;
	}

}
