package com.gorea.controller_comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gorea.dto_reply.Gorea_TrendSeoul_ReplyTO;
import com.gorea.service_comment.Gorea_TrendSeoul_Review;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class Gorea_TrendSeoul_ReplyController {

	@Autowired
	private Gorea_TrendSeoul_Review reviewService;
	 
	 @GetMapping("/korean/list/{seoulSeq}")
	 @ResponseBody
	 public List<Gorea_TrendSeoul_ReplyTO> getCommentsByPostId(@PathVariable String seoulSeq) {
		 return reviewService.trendReview_List(seoulSeq);
	 }
	
	@PostMapping("/korean/reviewOk")
	@ResponseBody
	public int addTrendReview(Gorea_TrendSeoul_ReplyTO rto) {
		return reviewService.TrendReview_Ok(rto);
		 
	}
	
	// 리뷰 수정
	@GetMapping("korean/modify/{seoulReviewSeq}")
	@ResponseBody
    public String showModifyForm(@PathVariable String seoulReviewSeq, Model model) {
        Gorea_TrendSeoul_ReplyTO rto = new Gorea_TrendSeoul_ReplyTO();
        rto.setSeoulReviewSeq(seoulReviewSeq);

        Gorea_TrendSeoul_ReplyTO modifyReview = reviewService.ReviewModify(rto);

        model.addAttribute("modifyReview", modifyReview);

        return "contents/contents_trend_seoul/trend_view"; // 수정 양식을 표시하는 View의 이름
    }
	
	@PostMapping("korean/modifyOk")
	@ResponseBody
	public int ReviewModifyOk(Gorea_TrendSeoul_ReplyTO rto) {
		
		return reviewService.ReviewModify_Ok(rto);
	}
	
	// 리뷰 삭제
	@PostMapping("/korean/delete/{seoulReviewSeq}")
	@ResponseBody
    public int ReviewDelete(@PathVariable String seoulReviewSeq) {
        return reviewService.ReviewDelete(seoulReviewSeq);
    }
}
