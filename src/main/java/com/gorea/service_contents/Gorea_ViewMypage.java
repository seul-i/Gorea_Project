package com.gorea.service_contents;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gorea.dto.mypage.Gorea_BoardListTO;
import com.gorea.dto_board.Gorea_QnA_BoardTO;
import com.gorea.dto_board.Gorea_SearchResultTO;
import com.gorea.dto_user.Gorea_UserTO;
import com.gorea.repository_contents.Gorea_AdminDAO;
import com.gorea.repository_contents.Gorea_MypageDAO;

@Service
public class Gorea_ViewMypage implements Gorea_Content_Mypage {
	
	@Autowired
	private Gorea_MypageDAO mypageDao;
	
	@Autowired
	private Gorea_AdminDAO adminDao;
	
	// ================ 회원 정보 ===================
	@Override
	public int userInfoModify_Ok(Gorea_UserTO uto) {
		return mypageDao.userInfoModify_Ok(uto);
	}
	
	// ================= 게시글 관리 ==================
	
	// 통합 게시글 조회
	@Override
	public List<Gorea_BoardListTO> boardList(String userSeq, int offset, int pageSize) {
		return mypageDao.boardList(userSeq, offset, pageSize);
	}
	
	// 통합 게시글 검색
	@Override
	public List<Gorea_BoardListTO> searchBoardList(String userSeq, String keyword, int offset, int pageSize) {
		return mypageDao.searchBoardList(userSeq, keyword, offset, pageSize);
	}
	
	// ================= 댓글 관리 ====================
	// 통합 댓글 조회
	@Override
	public List<Gorea_BoardListTO> replyList(String userSeq, int offset, int pageSize) {
		return mypageDao.replyList(userSeq, offset, pageSize);
	}
	
	// 통합 댓글 검색
	public List<Gorea_BoardListTO> searchReplyList(String userSeq, String keyword, int offset, int pageSize) {
		return mypageDao.searchReplyList(userSeq, keyword, offset, pageSize);
	}
	
	// ================ 1:1 문의내역 ==================
	// 마이페이지 - 회원 문의 조회
	@Override
	public List<Gorea_QnA_BoardTO> qnaList(String userSeq, int offset, int pageSize) {
		return mypageDao.qnaList(userSeq, offset, pageSize);
	}
}
