package com.gorea.service_comment;

import java.util.List;

import com.gorea.dto_reply.Gorea_TrendSeoul_ReplyTO;

public interface Gorea_Content_Review {
	
	public List<Gorea_TrendSeoul_ReplyTO> trendReview_List(String seoulSeq); 	// reviewList
	public int TrendReview_Ok(Gorea_TrendSeoul_ReplyTO rto);  					// reviewWrite_Ok
	public Gorea_TrendSeoul_ReplyTO ReviewModify(Gorea_TrendSeoul_ReplyTO rto);	// reviewModify
	public int ReviewModify_Ok(Gorea_TrendSeoul_ReplyTO rto);
	public int ReviewDelete(String seoulReviewSeq);						// reviewDelete
}


