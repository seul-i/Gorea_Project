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
	@GetMapping( "/{language}/gorea_reply.do" )
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
	@PostMapping( "/korean/gorea_reply_write_ok.do" )
	@ResponseBody
	public ModelAndView replyWriteOk( HttpServletRequest request ) {
		Gorea_ReplyTO rto = new Gorea_ReplyTO();
		
		rto.setPseq( request.getParameter( "pseq" ) );
		rto.setReplyContent( request.getParameter( "replyContent" ) );
		rto.setGoreaboardNo( request.getParameter( "goreaboardNo" ) );
		rto.setUserSeq( request.getParameter( "userSeq" ) );
		
		int flag = rdao.reply_writeOk(rto);
		
		ModelAndView modelAndView = new ModelAndView( "replies/reply_Write_Ok" );
		modelAndView.addObject( "flag", flag );
		
		return modelAndView;
	}
	
	@PostMapping( "/korean/gorea_reply_delete_ok.do" )
	@ResponseBody
	public ModelAndView replyDeleteOk( HttpServletRequest request ) {
		Gorea_ReplyTO rto = new Gorea_ReplyTO();
		
		rto.setGoreaboardNo( request.getParameter( "goreaboardNo" ) );
		rto.setCseq( request.getParameter( "cseq" ) );
		rto.setPseq( request.getParameter( "pseq" ) );
		rto.setGrp( Integer.parseInt( request.getParameter( "grp" ) ) );
		
		System.out.println( "pseq는 : " + rto.getPseq() );
		
		int flag = rdao.reply_deleteOk(rto);
		
		ModelAndView modelAndView = new ModelAndView( "replies/reply_Delete_Ok" );
		modelAndView.addObject( "flag", flag );
		
		return modelAndView;
	}
	
	
	@PostMapping( "/korean/gorea_reply_modify_ok.do" )
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
	
	
	@PostMapping( "/korean/gorea_rereply_wtire_ok.do" )
	@ResponseBody
	public ModelAndView rereplyWriteOk( HttpServletRequest request ) {
		Gorea_ReplyTO rto = new Gorea_ReplyTO();
		
		rto.setPseq( request.getParameter( "pseq" ) );
		rto.setGoreaboardNo( request.getParameter( "goreaboardNo" ) );
		rto.setReplyContent( request.getParameter( "replyContent" ) );
		rto.setGrp( Integer.parseInt(request.getParameter( "grp" ) ) );
		rto.setUserSeq( request.getParameter("userSeq") );
		
		int flag = rdao.rereply_WriteOk(rto);
		
		System.out.println( "grp는 : " + rto.getGrp() );
		
		ModelAndView modelAndView = new ModelAndView( "replies/rereply_Write_Ok" );
		modelAndView.addObject( "flag", flag );
		
		return modelAndView;
	}
	
	
	 @PostMapping( "/korean/gorea_rereply_delete_ok.do" ) 
	 @ResponseBody 
	 public ModelAndView rereplyDeleteOk( HttpServletRequest request) {  
		Gorea_ReplyTO rto = new Gorea_ReplyTO();
	  
		rto.setCseq( request.getParameter( "cseq" ) ); 
		rto.setGoreaboardNo( request.getParameter( "goreaboardNo" ) );
		rto.setPseq( request.getParameter( "pseq" ) );
	  
		int flag = rdao.rereply_DeleteOk(rto);
	  
		ModelAndView modelAndView = new ModelAndView( "replies/rereply_Delete_Ok" );
		modelAndView.addObject( "flag", flag );
	  
		return modelAndView;	
	 }
	 
}
