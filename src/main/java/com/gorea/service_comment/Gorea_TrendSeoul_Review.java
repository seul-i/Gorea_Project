package com.gorea.service_comment;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gorea.dto_reply.Gorea_TrendSeoul_ReplyTO;
import com.gorea.repository_comment.Gorea_TrendSeoulReplyDAO;

@Service
public class Gorea_TrendSeoul_Review implements Gorea_Content_Review {
	
	@Autowired
	private Gorea_TrendSeoulReplyDAO gorea_TrendSeoulReplyDAO;
	

	@Override
	public List<Gorea_TrendSeoul_ReplyTO> trendReview_List(String seoulSeq) {
		return gorea_TrendSeoulReplyDAO.trendReview_List(seoulSeq);
	}

	@Override
	public int TrendReview_Ok(Gorea_TrendSeoul_ReplyTO rto) {

		return gorea_TrendSeoulReplyDAO.ReviewWrite_Ok(rto);
	}
	
	@Override
	public Gorea_TrendSeoul_ReplyTO ReviewModify(Gorea_TrendSeoul_ReplyTO rto) {
		
		return gorea_TrendSeoulReplyDAO.ReviewModify(rto);
	}
	
	@Override
	public int ReviewModify_Ok(Gorea_TrendSeoul_ReplyTO rto) {

		return gorea_TrendSeoulReplyDAO.ReviewModify_Ok(rto);
	}
	
	@Override
	public int ReviewDelete(String seoulReviewSeq) {	
		return gorea_TrendSeoulReplyDAO.ReviewDelete(seoulReviewSeq);
	}


}
