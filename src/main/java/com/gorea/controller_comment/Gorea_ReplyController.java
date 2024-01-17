package com.gorea.controller_comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gorea.dto_reply.Gorea_ReplyTO;
import com.gorea.repository_comment.Gorea_ReplyDAO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class Gorea_ReplyController {
	
	@Autowired
	private Gorea_ReplyDAO rdao;
	
	// 댓글리스트
	@GetMapping( "/gorea_replyList.do" )
	@ResponseBody
	public ModelAndView replyList( HttpServletRequest request ) {
		Gorea_ReplyTO rto = new Gorea_ReplyTO();
		
		rto.setPseq( request.getParameter( "pseq" ) );
		rto.setGoreaboardNo( request.getParameter( "goreaboardNo" ) );
		
		List<Gorea_ReplyTO> lists = rdao.reply_list(rto);
		
		ModelAndView modelAndView = new ModelAndView( "replies/reply_List" );
		modelAndView.addObject( "lists", lists );
		
		return modelAndView;
	}
	
	// 작성
	@PostMapping( "/gorea_replyWriteOk.do" )
	@ResponseBody
	public ModelAndView replyWriteOk( HttpServletRequest request ) {
		Gorea_ReplyTO rto = new Gorea_ReplyTO();
		
		rto.setPseq( request.getParameter( "pseq" ) );
		rto.setReplyContent( request.getParameter( "replyContent" ) );
		rto.setGoreaboardNo( request.getParameter( "goreaboardNo" ) );
		
		System.out.println( "writeOk dao로 pseq : " + rto.getPseq() );
		System.out.println( "writeOk dao로 content : " + rto.getReplyContent() );
		System.out.println( "writeOk dao로 boardNo : " + rto.getGoreaboardNo() );
		
		int flag = rdao.reply_writeOk(rto);
		
		ModelAndView modelAndView = new ModelAndView( "replies/reply_Write_Ok" );
		modelAndView.addObject( "flag", flag );
		
		return modelAndView;
	}
	
	@PostMapping( "/gorea_replyDeleteOk.do" )
	@ResponseBody
	public ModelAndView replyDeleteOk( HttpServletRequest request ) {
		Gorea_ReplyTO rto = new Gorea_ReplyTO();
		
		rto.setGoreaboardNo( request.getParameter( "goreaboardNo" ) );
		rto.setGrp( Integer.parseInt( request.getParameter( "grp" ) ) );
		
		int flag = rdao.reply_deleteOk(rto);
		
		ModelAndView modelAndView = new ModelAndView( "replies/reply_Delete_Ok" );
		modelAndView.addObject( "flag", flag );
		
		return modelAndView;
	}
	
	
	@PostMapping( "/gorea_replyModifyOk.do" )
	@ResponseBody
	public ModelAndView replyModifyOk( HttpServletRequest request ) {
		Gorea_ReplyTO rto = new Gorea_ReplyTO();
		
		rto.setGoreaboardNo( request.getParameter( "goreaboardNo" ) );
		rto.setCseq( request.getParameter( "cseq" ) );
		rto.setReplyContent( request.getParameter( "replyContent" ) );
		
		int flag = rdao.reply_modifyOk(rto);
		
		ModelAndView modelAndView = new ModelAndView( "replies/reply_Modify_Ok" );
		modelAndView.addObject( "flag" , flag );
		
		return modelAndView;
	}
	
	
	@PostMapping( "/gorea_rereply_Wtire_Ok.do" )
	@ResponseBody
	public ModelAndView rereplyWriteOk( HttpServletRequest request ) {
		Gorea_ReplyTO rto = new Gorea_ReplyTO();
		
		rto.setPseq( request.getParameter( "pseq" ) );
		rto.setGoreaboardNo( request.getParameter( "goreaboardNo" ) );
		rto.setReplyContent( request.getParameter( "replyContent" ) );
		rto.setGrp( Integer.parseInt( request.getParameter( "grp" ) ) );
		
		int flag = rdao.rereply_WriteOk(rto);
		
		ModelAndView modelAndView = new ModelAndView( "replies/rereply_Write_Ok" );
		modelAndView.addObject( "flag", flag );
		
		return modelAndView;
	}
	
	@PostMapping( "/gorea_rereply_Delete_Ok.do" )
	@ResponseBody
	public ModelAndView rereplyDeleteOk( HttpServletRequest request ) {
		Gorea_ReplyTO rto = new Gorea_ReplyTO();
		
		rto.setCseq( request.getParameter( "cseq" ) );
		rto.setGoreaboardNo( request.getParameter( "goreaboardNo" ) );
		
		int flag = rdao.rereply_DeleteOk(rto);
		
		ModelAndView modelAndView = new ModelAndView( "replies/rereply_Delete_Ok" );
		modelAndView.addObject( "flag", flag );
		
		return modelAndView;
	}
}
