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

import com.gorea.dto_reply.Gorea_QnA_ReplyTO;
import com.gorea.service_comment.Gorea_QnA_Repl;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class Gorea_QnA_ReplyController {

	@Autowired
	private Gorea_QnA_Repl reviewService;
	 
	 @GetMapping("/korean/qnAReplylist/{qnaSeq}")
	 @ResponseBody
	 public List<Gorea_QnA_ReplyTO> qnarepl_list(@PathVariable String qnaSeq) {
		 return reviewService.QnAReplyList(qnaSeq);
	 }
	
	 @PostMapping("/korean/qnareply_write")
	 @ResponseBody
	 public int addTrendReview(@RequestBody Gorea_QnA_ReplyTO rto) {
	     return reviewService.QnAReply_Write(rto);
	 }
	
	// 리뷰 수정
	@GetMapping("korean/qnareplmodify/{qnaCmtSeq}")
	@ResponseBody
    public String qnareplModify(@PathVariable String qnaCmtSeq, Model model) {
		Gorea_QnA_ReplyTO rto = new Gorea_QnA_ReplyTO();
        
		rto.setQnaCmtSeq(qnaCmtSeq);

		Gorea_QnA_ReplyTO modifyReview = reviewService.QnAReply_Modify(rto);

        model.addAttribute("modifyReview", modifyReview);

        return "contents/contents_trend_seoul/trend_view"; // 수정 양식을 표시하는 View의 이름
    }
	
	@PostMapping("/korean/qnareplmodifyok")
	@ResponseBody
	public int qnareplModifyOk(@RequestBody Gorea_QnA_ReplyTO rto) {
	    return reviewService.QnAReply_Modify_Ok(rto);
	}
	
	// 리뷰 삭제
	@PostMapping("/korean/qnadelete/{qnaCmtSeq}")
	@ResponseBody
    public int qnaDelete(@PathVariable String qnaCmtSeq) {
        return reviewService.QnAReply_Delete(qnaCmtSeq);
	}
}
