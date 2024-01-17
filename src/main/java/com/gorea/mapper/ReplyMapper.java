package com.gorea.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.gorea.dto_reply.Gorea_ReplyTO;

@Mapper
public interface ReplyMapper {
	@Select( "select pseq, goreaboardNo, cseq, userNickname, replyContent, date_format(replypostDate, '%Y.%m.%d %H:%i') replypostDate, grp, grpl from reply where goreaboardNo=#{goreaboardNo} and pseq=#{pseq} order by grp asc")
	List<Gorea_ReplyTO> replylist( Gorea_ReplyTO rto );
	
	// UserRecommend 댓글 작성 3.userSeq 일단 1로... userNick 일단 gnuke
	@Insert( "insert into reply values( 0, #{goreaboardNo}, 1, #{replyContent}, now(), #{grp}, 0, #{pseq}, 'Gnuke')" )
	int replyWriteOk( Gorea_ReplyTO rto );
	
	// grp 세팅
	@Select( "select max(cseq) from reply where goreaboardNo=#{goreaboardNo}" )
	int grpSetting( Gorea_ReplyTO rto );
	
	// 삭제
	@Delete( "delete from reply where goreaboardNo=#{goreaboardNo} and grp=#{grp}" )
	int replyDeleteOk( Gorea_ReplyTO rto );
	
	// 수정
	@Update( "update reply set replyContent=#{replyContent} where goreaboardNo=#{goreaboardNo} and cseq=#{cseq}")
	int replyModifyOk( Gorea_ReplyTO rto );
	
	// 대댓글 작성 3.userSeq 일단 1로... userNick 일단 gnuke
	@Insert( "insert into reply values(0, #{goreaboardNo}, 1, #{replyContent}, now(), #{grp}, #{grpl}, #{pseq}, 'Gnuke' )" )
	int rereplyWriteOk( Gorea_ReplyTO rto );
	
	// 대댓글 삭제
	@Delete( "delete from reply where goreaboardNo=#{goreaboardNo} and cseq=#{cseq}" )
	int rereplyDeleteOk( Gorea_ReplyTO rto );
}
