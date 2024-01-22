package com.gorea.service_comment;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gorea.dto_reply.Gorea_EditRecommend_ReplyTO;
import com.gorea.repository_comment.Gorea_EditrecoReplyDAO;

@Service
public class Gorea_EditReco_Reply implements Gorea_Editr_Reply {
	
	@Autowired
	private Gorea_EditrecoReplyDAO gorea_EditrecoReplyDAO;
	

	@Override
	public List<Gorea_EditRecommend_ReplyTO> editReply_List(String editrecoSeq) {
		return gorea_EditrecoReplyDAO.editReply_List(editrecoSeq);
	}

	@Override
	public int EditRecommend_Reply_Ok(Gorea_EditRecommend_ReplyTO rto) {

		return gorea_EditrecoReplyDAO.ReplyWrite_Ok(rto);
	}
	
	@Override
	public Gorea_EditRecommend_ReplyTO ReplyModify(Gorea_EditRecommend_ReplyTO rto) {
		
		return gorea_EditrecoReplyDAO.ReplyModify(rto);
	}
	
	@Override
	public int ReplyModify_Ok(Gorea_EditRecommend_ReplyTO rto) {

		return gorea_EditrecoReplyDAO.ReplyModify_Ok(rto);
	}
	
	@Override
	public int ReplyDelete(String editrecoCmtSeq) {	
		return gorea_EditrecoReplyDAO.ReplyDelete(editrecoCmtSeq);
	}


}
