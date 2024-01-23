package com.gorea.service_comment;

import java.util.List;

import com.gorea.dto_reply.Gorea_QnA_ReplyTO;

public interface Gorea_QnA_Reply {
	
	public List<Gorea_QnA_ReplyTO> QnAReplyList(String qnaSeq); 	// replyList
	public int QnAReply_Write(Gorea_QnA_ReplyTO rto);  					// replyWrite_Ok
	public Gorea_QnA_ReplyTO QnAReply_Modify(Gorea_QnA_ReplyTO rto);	// replyModify
	public int QnAReply_Modify_Ok(Gorea_QnA_ReplyTO rto); 				// replyModify_Ok
	public int QnAReply_Delete(String qnaSeq);						// replyDelete
		
}