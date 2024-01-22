package com.gorea.service_comment;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gorea.dto_reply.Gorea_EditTip_ReplyTO;
import com.gorea.repository_comment.Gorea_EdittipReplyDAO;

@Service
public class Gorea_EditTip_Reply implements Gorea_Editt_Reply {
	
	@Autowired
	private Gorea_EdittipReplyDAO gorea_EdittipReplyDAO;
	

	@Override
	public List<Gorea_EditTip_ReplyTO> editReply_List(String edittipSeq) {
		return gorea_EdittipReplyDAO.editReply_List(edittipSeq);
	}

	@Override
	public int EditTip_Reply_Ok(Gorea_EditTip_ReplyTO rto) {

		return gorea_EdittipReplyDAO.ReplyWrite_Ok(rto);
	}
	
	@Override
	public Gorea_EditTip_ReplyTO ReplyModify(Gorea_EditTip_ReplyTO rto) {
		
		return gorea_EdittipReplyDAO.ReplyModify(rto);
	}
	
	@Override
	public int ReplyModify_Ok(Gorea_EditTip_ReplyTO rto) {

		return gorea_EdittipReplyDAO.ReplyModify_Ok(rto);
	}
	
	@Override
	public int ReplyDelete(String edittipCmtSeq) {	
		return gorea_EdittipReplyDAO.ReplyDelete(edittipCmtSeq);
	}


}
