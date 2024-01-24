package com.gorea.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.gorea.dto_board.Gorea_Free_BoardTO;
import com.gorea.dto_board.Gorea_Notice_BoardTO;
import com.gorea.dto_reply.Gorea_ReplyTO;

@Mapper
public interface FreeboardMapperInter {
	
	// Free_seoul
	@Select("select fr.freeSeq, fr.freeTitle, fr.freeContent, fr.freeHit, date_format(fr.freepostDate, '%Y.%m.%d') freepostDate, fr.freeRecomcount, u.userNickname from FreeBoard fr join User u on fr.userSeq = u.userSeq order by fr.freeSeq desc LIMIT #{firstRow}, #{pageSize}")
	ArrayList<Gorea_Free_BoardTO> Free_List(@Param("firstRow") int firstRow, @Param("pageSize") int pageSize); 
	
	@Select("SELECT COUNT(*) FROM Freeboard")
	 int free_TotalCount();
	
	// Free_WriteOk
	@Insert("insert into FreeBoard values (0, #{userSeq}, 3, #{freeTitle}, now(), 0, #{freeContent}, 0,  0 )")
	int Free_Write_Ok(Gorea_Free_BoardTO to);
	
	// Free_view_hit
	@Update("update Freeboard set freeHit=freeHit+1 where freeSeq=#{freeSeq}")
	int FreeHit(Gorea_Free_BoardTO to);
	
	// Free_view
	@Select("select fr.freeSeq, fr.userSeq, fr.freeboardNo, fr.freeTitle, fr.freeContent, fr.freeHit, date_format(fr.freepostDate, '%Y.%m.%d') freepostDate, fr.freeRecomcount, fr.freeCmt,u.userNickname "
			+ "from FreeBoard fr join user u on fr.userSeq=u.userSeq where fr.freeSeq=#{freeSeq} ")
	Gorea_Free_BoardTO Free_View(Gorea_Free_BoardTO to);
	
	// 이전 글 가져오기
    @Select("SELECT * FROM FreeBoard WHERE freeSeq < #{freeSeq} ORDER BY freeSeq DESC LIMIT 1")
    Gorea_Free_BoardTO  getPreviousPost(int freeSeq);

    // 다음 글 가져오기
    @Select("SELECT * FROM FreeBoard WHERE freeSeq > #{freeSeq} ORDER BY freeSeq ASC LIMIT 1")
    Gorea_Free_BoardTO getNextPost(int freeSeq);
	
	// Free_Modify
	@Select("select freeTitle, freeContent from FreeBoard where freeSeq=#{freeSeq}")
	Gorea_Free_BoardTO Free_Modify(Gorea_Free_BoardTO to);
	
	// Free_modify_ok
	@Update("update FreeBoard set freeTitle=#{freeTitle}, freeContent=#{freeContent} where freeSeq=#{freeSeq}")
	int Free_Modify_Ok(Gorea_Free_BoardTO to);
	
	// Free_delete_ok
	@Delete("delete from FreeBoard where freeSeq=#{freeSeq}")
	int Free_Delete_Ok(Gorea_Free_BoardTO to);
	
	// free 
	@Update("UPDATE FreeBoard SET freeRecomcount = freeRecomcount + 1 WHERE freeSeq = #{freeSeq}")
    int increaseLikes(String freeSeq);
	
	// 댓글 수 증가
	@Update( "update FreeBoard set freeCmt=freeCmt+1 where freeSeq=#{pseq}" )
	int FreeCmtUp( Gorea_ReplyTO rto );
		
	// 댓글 수 감소
	@Update( "update FreeBoard set freeCmt=freeCmt-1 where freeSeq=#{pseq}" )
	int FreeCmtDown( Gorea_ReplyTO rto );
	
	// Free 게시판 검색
	@Select("<script>"
	        + "SELECT freeSeq, freeTitle, freeContent, freeHit, date_format(freepostDate, '%Y.%m.%d') as freepostDate, freeRecomcount "
	        + "FROM FreeBoard "
	        + "<where>"
	        + "  <if test='searchType != null and searchKeyword != null'>"
	        + "    <choose>"
	        + "      <when test='searchType.equals(\"title\")'>"
	        + "        AND freeTitle LIKE CONCAT('%', #{searchKeyword}, '%')"
	        + "      </when>"
	        + "      <when test='searchType.equals(\"titleContent\")'>"
	        + "        AND (freeTitle LIKE CONCAT('%', #{searchKeyword}, '%') OR freeContent LIKE CONCAT('%', #{searchKeyword}, '%'))"
	        + "      </when>"
	        + "    </choose>"
	        + "  </if>"
	        + "</where>"
	        + "ORDER BY freeSeq DESC LIMIT #{firstRow}, #{pageSize}"
	        + "</script>")
	ArrayList<Gorea_Free_BoardTO> searchFree(@Param("searchType") String searchType, 
	                                              @Param("searchKeyword") String searchKeyword,@Param("firstRow") int firstRow, @Param("pageSize") int pageSize);
	
	@Select("<script>"
	        + "SELECT COUNT(*) "
	        + "FROM FreeBoard "
	        + "<where>"
	        + "  <if test='searchType != null and searchKeyword != null'>"
	        + "    <choose>"
	        + "      <when test='searchType.equals(\"title\")'>"
	        + "        AND freeTitle LIKE CONCAT('%', #{searchKeyword}, '%')"
	        + "      </when>"
	        + "      <when test='searchType.equals(\"titleContent\")'>"
	        + "        AND (freeTitle LIKE CONCAT('%', #{searchKeyword}, '%') OR freeContent LIKE CONCAT('%', #{searchKeyword}, '%'))"
	        + "      </when>"
	        + "    </choose>"
	        + "  </if>"
	        + "</where>"
	        + "</script>")
	int searchTotalCount(@Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);
}