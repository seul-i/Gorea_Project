package com.gorea.service_comment;

import java.util.List;

import com.gorea.dto_reply.Gorea_EditTip_ReplyTO;

public interface Gorea_Editt_Reply {
	
	public List<Gorea_EditTip_ReplyTO> editReply_List(String edittipSeq); 	// replyList
	public int EditTip_Reply_Ok(Gorea_EditTip_ReplyTO rto);  					// replyWrite_Ok
	public Gorea_EditTip_ReplyTO ReplyModify(Gorea_EditTip_ReplyTO rto);	// replyModify
	public int ReplyModify_Ok(Gorea_EditTip_ReplyTO rto); // replyModify_Ok
	public int ReplyDelete(String edittipSeq);						// replyDelete
	
	
}


