package com.gorea.repository_comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gorea.dto_reply.Gorea_EditRecommend_ReplyTO;
import com.gorea.dto_reply.Gorea_EditTip_ReplyTO;
import com.gorea.mapper.EditrecoMapperInter;
import com.gorea.mapper.EdittipMapperInter;

@Repository
public class Gorea_EdittipReplyDAO {
	
	@Autowired
	private EdittipMapperInter replyMapper;
	
    public List<Gorea_EditTip_ReplyTO> editReply_List(String edittipSeq) {
        return replyMapper.editReply_List(edittipSeq);
    }
    
    public int ReplyWrite_Ok(Gorea_EditTip_ReplyTO rto) {
    	int result = replyMapper.Edittip_Reply(rto);
    	return result;
    }
    
    public Gorea_EditTip_ReplyTO ReplyModify(Gorea_EditTip_ReplyTO rto) {
    	rto = replyMapper.ReplyModify(rto);
    	return rto;
    }
    
    public int ReplyModify_Ok(Gorea_EditTip_ReplyTO rto) { 	
		int result = replyMapper.ReplyModify_Ok(rto);
		
		return result;
    }
    
    public int ReplyDelete(String edittipCmtSeq) {	
		return replyMapper.ReplyDelete(edittipCmtSeq);
	}
}
