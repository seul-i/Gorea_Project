package com.gorea.service_contents;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gorea.dto.mypage.Gorea_BoardListTO;
import com.gorea.dto_board.Gorea_QnA_BoardTO;
import com.gorea.repository_contents.Gorea_AdminDAO;
import com.gorea.repository_contents.Gorea_MypageDAO;

@Service
public class Gorea_ViewMypage implements Gorea_Content_Mypage {
	
	@Autowired
	private Gorea_MypageDAO mypageDao;
	
	@Autowired
	private Gorea_AdminDAO adminDao;
	
	@Override
	public List<Gorea_BoardListTO> boardList(String userSeq, int offset, int pageSize) {

		return mypageDao.boardList(userSeq, offset, pageSize);
	}
	
	// 마이페이지 - 댓글 조회
	@Override
	public List<Gorea_BoardListTO> replyList(String userSeq, int offset, int pageSize) {
		return mypageDao.replyList(userSeq, offset, pageSize);
	}
	
	// 마이페이지 - 회원 문의 조회
	@Override
	public List<Gorea_QnA_BoardTO> qnaList(String userSeq, int offset, int pageSize) {
		return mypageDao.qnaList(userSeq, offset, pageSize);
	}
}
