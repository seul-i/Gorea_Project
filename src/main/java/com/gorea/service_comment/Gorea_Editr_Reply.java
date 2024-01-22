package com.gorea.service_comment;

import java.util.List;

import com.gorea.dto_reply.Gorea_EditRecommend_ReplyTO;
import com.gorea.dto_reply.Gorea_EditTip_ReplyTO;

public interface Gorea_Editr_Reply {
	
	public List<Gorea_EditRecommend_ReplyTO> editReply_List(String editrecoSeq); 	// replyList
	public int EditRecommend_Reply_Ok(Gorea_EditRecommend_ReplyTO rto);  					// replyWrite_Ok
	public Gorea_EditRecommend_ReplyTO ReplyModify(Gorea_EditRecommend_ReplyTO rto);	// replyModify
	public int ReplyModify_Ok(Gorea_EditRecommend_ReplyTO rto); // replyModify_Ok
	public int ReplyDelete(String editrecoSeq);						// replyDelete
	
	
}


