package com.gorea.repository_contents;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gorea.dto.mypage.Gorea_BoardListTO;
import com.gorea.dto_board.Gorea_QnA_BoardTO;
import com.gorea.mapper.MypageMapper;

@Repository
public class Gorea_MypageDAO {

	@Autowired
	private MypageMapper mypageMapper;
	
	// 총 게시글 count
	public int getTotalRowCount() {
		int totalRowCount = mypageMapper.mypageBoardList_TotalCount();
		return totalRowCount;
	}
	
	// 총 qna count
	public int QnaTotalRowCount() {
		int totalRowCount = mypageMapper.mypageQnaList_TotalCount();
		return totalRowCount;
	}
	
	// 총 댓글 count
	public int getReplyTotalRowCount() {
		int totalRowCount = mypageMapper.mypageReplyList_TotalCount();
		return totalRowCount;
	}
	
	// 통합 게시글 조회
	public List<Gorea_BoardListTO> boardList(String userSeq, int offset, int pageSize) {
		List<Gorea_BoardListTO> lists = new ArrayList<Gorea_BoardListTO>();
		lists = mypageMapper.boardList(userSeq, offset, pageSize);
		return lists;
	}
	
	// 통합 댓글 조회
	public List<Gorea_BoardListTO> replyList(String userSeq, int offset, int pageSize) {
		List<Gorea_BoardListTO> lists = new ArrayList<Gorea_BoardListTO>();
		lists = mypageMapper.replyList(userSeq, offset, pageSize);
		return lists;
	}
	
	// 문의 조회
	public List<Gorea_QnA_BoardTO> qnaList(String userSeq, int offset, int pageSize) {
		List<Gorea_QnA_BoardTO> lists = new ArrayList<Gorea_QnA_BoardTO>();
		lists = mypageMapper.qnaList(userSeq, offset, pageSize);
		return lists;
	}

	
}
