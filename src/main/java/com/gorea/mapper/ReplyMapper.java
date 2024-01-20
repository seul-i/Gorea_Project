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
	@Select( "select pseq, goreaboardNo, cseq, userSeq, userNickname, replyContent, date_format(replypostDate, '%Y.%m.%d %H:%i') replypostDate, grp, grpl from reply where goreaboardNo=#{goreaboardNo} and pseq=#{pseq} order by grp desc")
	List<Gorea_ReplyTO> replylist( Gorea_ReplyTO rto );
	
	// UserRecommend 댓글 작성 3.userSeq 일단 1로... userNick 일단 gnuke
	@Insert( "insert into reply values( 0, #{goreaboardNo}, 1, #{replyContent}, now(), 0, 0, #{pseq}, 'Gnuke')" )
	int replyWriteOk( Gorea_ReplyTO rto );
	
	//모댓글 seq와 grp 맞춰주기
	@Update( "update reply set grp=cseq where cseq != grp and grpl = 0" )
	int replyGrpCheck( Gorea_ReplyTO rto );
	
	// 댓글 생성 시 갯수 + 1
	//@Update( "update ")
	
	// 삭제
	//@Delete( "delete from reply where goreaboardNo=#{goreaboardNo} and cseq=#{cseq} and pseq=#{pseq}" )
	@Delete( "delete from reply where goreaboardNo=#{goreaboardNo} and pseq=#{pseq} and grp=#{grp}" )
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
	
	// Userrecommend 댓글 수 증가
	//@Update( "update userrecommend set userRecomCmt=userRecomCmt+1 where userRecomSeq=#{pseq}" )
	//int userRecomCmtUp( Gorea_ReplyTO rto );
	
	
	// 댓글 쓰면 board에서 댓글 수 가져오기
	//@Select( "select count(userRecomCmt) from userRecommend where ")
}
