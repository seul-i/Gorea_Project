package com.gorea.controller_comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gorea.dto_reply.Gorea_EditRecommend_ReplyTO;
import com.gorea.repository_comment.Gorea_EditrecoReplyDAO;
import com.gorea.service_comment.Gorea_EditReco_Reply;

@Controller
public class Gorea_Editreco_ReplyController {
	@Autowired
	private Gorea_EditReco_Reply replyService;
	 
	 @GetMapping("/korean/edit_list/{editrecoSeq}")
	 @ResponseBody
	 public List<Gorea_EditRecommend_ReplyTO> getCommentsByPostId(@PathVariable String editrecoSeq) {
		 System.out.println(editrecoSeq); 
		 return replyService.editReply_List(editrecoSeq);
	 }
	
	@PostMapping("/korean/edit_reply_Ok")
	@ResponseBody
	public int addEditrecoReply(Gorea_EditRecommend_ReplyTO rto) {
		return replyService.EditRecommend_Reply_Ok(rto);
		 
	}
	
	// 댓글 수정
	@GetMapping("korean/edit_modify/{editrecoSeq}")
	@ResponseBody
    public String showModifyForm(@PathVariable String editrecoCmtSeq, Model model) {
		
		Gorea_EditRecommend_ReplyTO rto = new Gorea_EditRecommend_ReplyTO();
        rto.setEditrecoCmtSeq(editrecoCmtSeq);

        Gorea_EditRecommend_ReplyTO modifyReply = replyService.ReplyModify(rto);

        model.addAttribute("modifyReply", modifyReply);

        return "contents/contents_edit_recommend/editreco_view"; // 수정 양식을 표시하는 View의 이름
    }
	
	@PostMapping("korean/edit_modify_Ok")
	@ResponseBody
	public int ReplyModifyOk(Gorea_EditRecommend_ReplyTO rto) {
		
		return replyService.ReplyModify_Ok(rto);
	}
	
	// 댓글 삭제
	@PostMapping("/korean/edit_delete/{editrecoCmtSeq}")
	@ResponseBody
    public int ReplyDelete(@PathVariable String editrecoCmtSeq) {
        return replyService.ReplyDelete(editrecoCmtSeq);
    }
}
