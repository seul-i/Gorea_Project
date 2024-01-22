package com.gorea.repository_comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gorea.dto_reply.Gorea_EditRecommend_ReplyTO;
import com.gorea.mapper.EditrecoMapperInter;

@Repository
public class Gorea_EditrecoReplyDAO {
	
	@Autowired
	private EditrecoMapperInter replyMapper;
	
    public List<Gorea_EditRecommend_ReplyTO> editReply_List(String editrecoSeq) {
        return replyMapper.editReply_List(editrecoSeq);
    }
    
    public int ReplyWrite_Ok(Gorea_EditRecommend_ReplyTO rto) {
    	int result = replyMapper.EditRecommend_Reply(rto);
    	return result;
    }
    
    public Gorea_EditRecommend_ReplyTO ReplyModify(Gorea_EditRecommend_ReplyTO rto) {
    	rto = replyMapper.ReplyModify(rto);
    	return rto;
    }
    
    public int ReplyModify_Ok(Gorea_EditRecommend_ReplyTO rto) { 	
		int result = replyMapper.ReplyModify_Ok(rto);
		
		return result;
    }
    
    public int ReplyDelete(String editrecoCmtSeq) {	
		return replyMapper.ReplyDelete(editrecoCmtSeq);
	}
}
