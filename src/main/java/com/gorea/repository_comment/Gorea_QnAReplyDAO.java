package com.gorea.repository_comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gorea.dto_reply.Gorea_QnA_ReplyTO;
import com.gorea.dto_reply.Gorea_TrendSeoul_ReplyTO;
import com.gorea.mapper.QnAMapperInter;
import com.gorea.mapper.TrendMapperInter;

@Repository
public class Gorea_QnAReplyDAO {

	@Autowired
	private QnAMapperInter reviewMapper;
	
    public List<Gorea_QnA_ReplyTO> QnAReplyList(String qnaSeq) {
        return reviewMapper.QnAReplyList(qnaSeq);
    }
    
    public int QnAReply_Write(Gorea_QnA_ReplyTO rto) {
    	int result = reviewMapper.QnAReply_Write(rto);
    	result = reviewMapper.QnACmtUp(rto);
    	return result;
    }
    
    public Gorea_QnA_ReplyTO QnAReply_Modify(Gorea_QnA_ReplyTO rto) {
    	rto = reviewMapper.QnAReply_Modify(rto);
    	return rto;
    }
    
    public int QnAReply_Modify_Ok(Gorea_QnA_ReplyTO rto) { 	
		int result = reviewMapper.QnAReply_Modify_Ok(rto);
		
		return result;
    }
    
    public int QnAReply_Delete(String qnaCmtSeq) {	
		return reviewMapper.QnAReply_Delete(qnaCmtSeq);
	}
    
}
