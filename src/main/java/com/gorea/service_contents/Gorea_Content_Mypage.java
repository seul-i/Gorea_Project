package com.gorea.service_contents;

import java.util.List;

import com.gorea.dto.mypage.Gorea_BoardListTO;
import com.gorea.dto_board.Gorea_QnA_BoardTO;

public interface Gorea_Content_Mypage {
	
	public List<Gorea_BoardListTO> boardList(String userSeq, int offset, int pageSize);
	public List<Gorea_QnA_BoardTO> qnaList(String userSeq, int offset, int pageSize);
	public List<Gorea_BoardListTO> replyList(String userSeq, int offset, int pageSize);

}
