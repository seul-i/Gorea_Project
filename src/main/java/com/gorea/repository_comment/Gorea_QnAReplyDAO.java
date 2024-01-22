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
	
    public List<Gorea_QnA_ReplyTO> trendReview_List(String qnaSeq) {
        return reviewMapper.QnAReplyList(qnaSeq);
    }
    
    public int ReviewWrite_Ok(Gorea_QnA_ReplyTO rto) {
    	int result = reviewMapper.QnAReply_Write(rto);
    	return result;
    }
    
    public Gorea_QnA_ReplyTO ReviewModify(Gorea_QnA_ReplyTO rto) {
    	rto = reviewMapper.QnAReply_Modify(rto);
    	return rto;
    }
    
    public int ReviewModify_Ok(Gorea_QnA_ReplyTO rto) { 	
		int result = reviewMapper.QnAReply_Modify_Ok(rto);
		
		return result;
    }
    
    public int ReviewDelete(String seoulReviewSeq) {	
		return reviewMapper.QnAReply_Delete(seoulReviewSeq);
	}
    
}
