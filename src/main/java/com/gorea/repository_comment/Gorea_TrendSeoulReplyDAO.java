package com.gorea.repository_comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gorea.dto_reply.Gorea_TrendSeoul_ReplyTO;
import com.gorea.mapper.TrendMapperInter;

@Repository
public class Gorea_TrendSeoulReplyDAO {

	@Autowired
	private TrendMapperInter reviewMapper;
	
    public List<Gorea_TrendSeoul_ReplyTO> trendReview_List(String seoulSeq) {
        return reviewMapper.ReviewList(seoulSeq);
    }
    
    public int ReviewWrite_Ok(Gorea_TrendSeoul_ReplyTO rto) {
    	
    	int result = reviewMapper.trendSeoul_Review(rto);
    	
    	reviewMapper.updateScore(rto);
    	
    	return result;
    }
    
    public Gorea_TrendSeoul_ReplyTO ReviewModify(Gorea_TrendSeoul_ReplyTO rto) {
    	
    	rto = reviewMapper.ReviewModify(rto);
    	return rto;
    }
    
    public int ReviewModify_Ok(Gorea_TrendSeoul_ReplyTO rto) {
    	
		int result = reviewMapper.ReviewModify_Ok(rto);

    	reviewMapper.updateScore(rto);
		
		return result;
    }
    
    public int ReviewDelete(Gorea_TrendSeoul_ReplyTO rto) {	
    	
    	int result = reviewMapper.ReviewDelete(rto);
    	
    	reviewMapper.updateScore(rto);
    	
		return result;
	}
    
}
