package com.gorea.repository_comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gorea.dto_reply.Gorea_ReplyTO;
import com.gorea.mapper.ReplyMapper;
import com.gorea.mapper.UserRecomMapperInter;

import lombok.ToString;

@Repository
@ToString
public class Gorea_ReplyDAO {
	@Autowired
	private ReplyMapper rmapper;
	
	@Autowired
	private UserRecomMapperInter mapper;
	
	public List<Gorea_ReplyTO> reply_list( Gorea_ReplyTO rto ){
		
		List<Gorea_ReplyTO> lists = rmapper.replylist(rto);
		
		System.out.println( "lists는 : " + lists );
		
		return lists;
	}
	
	
	public int reply_writeOk( Gorea_ReplyTO rto ) {
		int flag = 1;
		
		int result = rmapper.replyWriteOk(rto);
		System.out.println( rto.getPseq() );
		
		if( result == 1 ) {
			
			rmapper.replyGrpCheck(rto);
			
			mapper.userRecomCmtUp( rto );
			
			flag = 0;
		}
		
		return flag;
	}
	
	
	public int reply_deleteOk( Gorea_ReplyTO rto ) {
		int flag = 1;
		
		int result = rmapper.replyDeleteOk(rto);
		
		System.out.println( rto.getPseq() );
		
		if( result == 1 ) {
			
			mapper.userRecomCmtDown(rto);
			
			flag = 0;
		}
		
		return flag;
	}
	
	
	public int reply_modifyOk( Gorea_ReplyTO rto ) {
		int flag = 1;
		
		int result = rmapper.replyModifyOk(rto);
		
		if( result == 1 ) {
			flag = 0;
		}
		
		return flag;
	}
	
	public int rereply_WriteOk( Gorea_ReplyTO rto ) {
		int flag = 1;
		
		rto.setGrpl(1);
		
		int result = rmapper.rereplyWriteOk(rto);
		
		if( result == 1 ) {
			mapper.userRecomCmtUp(rto);
			
			flag = 0;
		}
		
		return flag;
	}
	
	
	public int rereply_DeleteOk( Gorea_ReplyTO rto ) {
	
		int flag = 1;
	  
		int result = rmapper.rereplyDeleteOk(rto);
	  
		if( result == 1 ) {
		
			mapper.userRecomCmtDown(rto);
			
			flag = 0; 
			
		}
	  
			return flag;
		}
	 
}
