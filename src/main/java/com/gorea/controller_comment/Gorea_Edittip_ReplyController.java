package com.gorea.controller_comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import com.gorea.dto_reply.Gorea_EditTip_ReplyTO;
import com.gorea.service_comment.Gorea_EditTip_Reply;

@Controller
public class Gorea_Edittip_ReplyController {
	@Autowired
	private Gorea_EditTip_Reply replyService;
	 
	 @GetMapping("/korean/edittip_list/{edittipSeq}")
	 @ResponseBody
	 public List<Gorea_EditTip_ReplyTO> getCommentsByPostId(@PathVariable String edittipSeq) {
		 System.out.println(edittipSeq); 
		 return replyService.editReply_List(edittipSeq);
	 }
	
	@PostMapping("/korean/edittip_reply_Ok")
	@ResponseBody
	public int addEdittipReply(Gorea_EditTip_ReplyTO rto) {
		return replyService.EditTip_Reply_Ok(rto);
		 
	}
	
	// 댓글 수정
	@GetMapping("korean/edittip_modify/{edittipSeq}")
	@ResponseBody
    public String showModifyForm(@PathVariable String edittipCmtSeq, Model model) {
		
		Gorea_EditTip_ReplyTO rto = new Gorea_EditTip_ReplyTO();
        rto.setEdittipCmtSeq(edittipCmtSeq);

        Gorea_EditTip_ReplyTO modifyReply = replyService.ReplyModify(rto);

        model.addAttribute("modifyReply", modifyReply);

        return "contents/contents_edit_tip/edittip_view"; // 수정 양식을 표시하는 View의 이름
    }
	
	@PostMapping("korean/edittip_modify_Ok")
	@ResponseBody
	public int ReplyModifyOk(Gorea_EditTip_ReplyTO rto) {
		
		return replyService.ReplyModify_Ok(rto);
	}
	
	// 댓글 삭제
	@PostMapping("/korean/edittip_delete/{edittipCmtSeq}")
	@ResponseBody
    public int ReplyDelete(@PathVariable String edittipCmtSeq) {
        return replyService.ReplyDelete(edittipCmtSeq);
    }
}
