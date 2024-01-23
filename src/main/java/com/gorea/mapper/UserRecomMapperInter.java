package com.gorea.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.gorea.dto_board.Gorea_Free_BoardTO;
import com.gorea.dto_board.Gorea_Recommend_BoardTO;
import com.gorea.dto_reply.Gorea_ReplyTO;

@Mapper
public interface UserRecomMapperInter {
	// list
	//@Select( "select us.userRecomSeq, us.userSeq , us.userRecomboardNo, us.userRecomTitle, date_format( us.userRecompostDate, '%Y /%m /%d') userRecompostDate, us.userRecomHit , us.userRecomContent ,  us.userRecomCmt, us.userRecomRecomcount, u.userNickname from UserRecommend us join user u on us.userSeq = u.userSeq" )
	@Select( "select us.userRecomSeq, us.userSeq , us.userRecomboardNo, us.userRecomTitle, date_format( us.userRecompostDate, '%Y /%m /%d') userRecompostDate, us.userRecomHit , us.userRecomContent ,  us.userRecomCmt, us.userRecomcount, u.userNickname from UserRecommend us join user u on us.userSeq = u.userSeq order by us.userRecomSeq desc" )
	List<Gorea_Recommend_BoardTO> userRecom_list(@Param("firstRow") int firstRow, @Param("pageSize") int pageSize);
	
	@Select( "select count(*) from UserRecommend" )
	int get_userRecommentTotalCount();
	
	// writeOk
	@Insert( "insert into UserRecommend values (0, #{userSeq}, 2, #{userRecomTitle}, now(), 0, #{userRecomContent}, 0, 0)" )
	int userRecom_WriteOk( Gorea_Recommend_BoardTO to );
		
	// view
	@Select( "select us.userRecomSeq, us.userSeq, us.userRecomboardNo, us.userRecomTitle, date_format(us.userRecompostDate, '%Y.%m.%d') userRecompostDate, us.userRecomHit, us.userRecomContent, us.userRecomCmt, u.userNickname "
			+ "from UserRecommend us join user u on us.userSeq = u.userSeq where us.userRecomSeq=#{userRecomSeq}")
	Gorea_Recommend_BoardTO userRecom_View( Gorea_Recommend_BoardTO to );
	
	// 이전 글 가져오기
    @Select("SELECT * FROM userrecommend WHERE userRecomSeq < #{seq} ORDER BY userRecomSeq DESC LIMIT 1")
    Gorea_Recommend_BoardTO  getPreviousPost(int userRecomSeq);

    // 다음 글 가져오기
    @Select("SELECT * FROM userrecommend WHERE userRecomSeq > #{seq} ORDER BY userRecomSeq ASC LIMIT 1")
    Gorea_Recommend_BoardTO getNextPost(int userRecomSeq);
		
	//viewuserRecomHit
	@Update("update UserRecommend set userRecomHit=userRecomHit+1 where userRecomSeq=#{userRecomSeq}")
	int userRecom_Hit(Gorea_Recommend_BoardTO to);
		
	// deleteOk
	@Delete( "delete from UserRecommend where userRecomSeq=#{userRecomSeq}" )
	int userRecom_deleteOk( Gorea_Recommend_BoardTO to );
		
	// modify
	@Select( "select userRecomTitle, userRecomContent from UserRecommend where userRecomSeq=#{userRecomSeq}" )
	Gorea_Recommend_BoardTO userRecom_modify( Gorea_Recommend_BoardTO to );
		
	// modifyOk
	@Update( "update UserRecommend set userRecomTitle=#{userRecomTitle}, userRecomContent=#{userRecomContent} where userRecomSeq=#{userRecomSeq}")
	int userRecom_modifyOk( Gorea_Recommend_BoardTO to );
	
	// 댓글 수 증가
	@Update( "update UserRecommend set userRecomCmt=userRecomCmt+1 where userRecomSeq=#{pseq}" )
	int userRecomCmtUp( Gorea_ReplyTO rto );
	
	// 댓글 수 감소
	@Update( "update UserRecommend set userRecomCmt=userRecomCmt-1 where userRecomSeq=#{pseq}" )
	int userRecomCmtDown( Gorea_ReplyTO rto );
	
	// 댓글 수
	@Select( "select userRecomCmt from UserRecommend where userRecomSeq=#{userRecomSeq}" )
	Gorea_Recommend_BoardTO replyCount( Gorea_Recommend_BoardTO to );
	
	@Select("<script>"
	        + "SELECT COUNT(*) "
	        + "FROM UserRecommend "
	        + "<where>"
	        + "  <if test='searchType != null and searchKeyword != null'>"
	        + "    <choose>"
	        + "      <when test='searchType.equals(\"title\")'>"
	        + "        AND userRecomTitle LIKE CONCAT('%', #{searchKeyword}, '%')"
	        + "      </when>"
	        + "      <when test='searchType.equals(\"titleContent\")'>"
	        + "        AND (userRecomTitle LIKE CONCAT('%', #{searchKeyword}, '%') OR userRecomContent LIKE CONCAT('%', #{searchKeyword}, '%'))"
	        + "      </when>"
	        + "    </choose>"
	        + "  </if>"
	        + "</where>"
	        + "</script>")
	int searchTotalCount(@Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);
}
