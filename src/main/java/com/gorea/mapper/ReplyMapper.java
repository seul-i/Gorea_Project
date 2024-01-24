package com.gorea.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.gorea.dto_board.Gorea_Recommend_BoardTO;
import com.gorea.dto_reply.Gorea_ReplyTO;

@Mapper
public interface ReplyMapper {
	@Select( "select re.pseq, re.goreaboardNo, re.cseq, re.userSeq, re.replyContent, date_format(re.replypostDate, '%Y.%m.%d %H:%i') replypostDate, re.grp, re.grpl, u.userNickname"
			+ " from reply re "
			+ "Join user u ON re.userSeq = u.userSeq "
			+ "where re.goreaboardNo=#{goreaboardNo} and re.pseq=#{pseq}"
			+ " order by re.grp desc")
	List<Gorea_ReplyTO> replylist( Gorea_ReplyTO rto );
	
	//댓글 작성
	@Insert( "insert into reply values( 0, #{goreaboardNo}, #{userSeq}, #{replyContent}, now(), 0, 0, #{pseq})" )
	int replyWriteOk( Gorea_ReplyTO rto );
	
	//모댓글 seq와 grp 맞춰주기
	@Update( "update reply set grp=cseq where cseq != grp and grpl = 0" )
	int replyGrpCheck( Gorea_ReplyTO rto );
	
	// 삭제
	//@Delete( "delete from reply where goreaboardNo=#{goreaboardNo} and cseq=#{cseq} and pseq=#{pseq}" )
	@Delete( "delete from reply where goreaboardNo=#{goreaboardNo} and pseq=#{pseq} and grp=#{grp}" )
	int replyDeleteOk( Gorea_ReplyTO rto );
	
	// 수정
	@Update( "update reply set replyContent=#{replyContent} where goreaboardNo=#{goreaboardNo} and cseq=#{cseq}")
	int replyModifyOk( Gorea_ReplyTO rto );
	
	// 대댓글 작성
	@Insert( "insert into reply values( 0, #{goreaboardNo}, #{userSeq}, #{replyContent}, now(), #{grp}, #{grpl}, #{pseq} )" )
	int rereplyWriteOk( Gorea_ReplyTO rto );
	
	// 대댓글 삭제
	@Delete( "delete from reply where goreaboardNo=#{goreaboardNo} and cseq=#{cseq}" )
	int rereplyDeleteOk( Gorea_ReplyTO rto );
	
}
