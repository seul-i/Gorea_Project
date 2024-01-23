package com.gorea.service_comment;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gorea.dto_reply.Gorea_QnA_ReplyTO;
import com.gorea.repository_comment.Gorea_QnAReplyDAO;

@Service
public class Gorea_QnA_Repl implements Gorea_QnA_Reply {
	
	@Autowired
	private Gorea_QnAReplyDAO gorea_qnaReplyDAO;
	

	@Override
	public List<Gorea_QnA_ReplyTO> QnAReplyList(String qnaSeq) {
		return gorea_qnaReplyDAO.QnAReplyList(qnaSeq);
	}

	@Override
	public int QnAReply_Write(Gorea_QnA_ReplyTO rto) {

		return gorea_qnaReplyDAO.QnAReply_Write(rto);
	}
	
	@Override
	public Gorea_QnA_ReplyTO QnAReply_Modify(Gorea_QnA_ReplyTO rto) {
		
		return gorea_qnaReplyDAO.QnAReply_Modify(rto);
	}
	
	@Override
	public int QnAReply_Modify_Ok(Gorea_QnA_ReplyTO rto) {

		return gorea_qnaReplyDAO.QnAReply_Modify_Ok(rto);
	}
	
	@Override
	public int QnAReply_Delete(String qnaCmtSeq) {	
		return gorea_qnaReplyDAO.QnAReply_Delete(qnaCmtSeq);
	}


}
