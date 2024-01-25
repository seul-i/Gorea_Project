package com.gorea.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.gorea.dto_board.Gorea_EditTip_BoardTO;
import com.gorea.dto_reply.Gorea_EditTip_ReplyTO;

@Mapper
public interface EdittipMapperInter {
	
	/* editTip */
		    
	// edittipList
	@Select("SELECT edittipSeq, userSeq, edittipSubject, edittipSubtitle, DATE_FORMAT(edittipWdate, '%Y-%m-%d') AS edittipWdate, edittipContent FROM edittip ORDER BY edittipSeq DESC LIMIT #{firstRow}, #{pageSize}")
	List<Gorea_EditTip_BoardTO> editTip_List(@Param("firstRow") int firstRow, @Param("pageSize") int pageSize);
	
	@Select("SELECT COUNT(*) FROM edittip")
	int getTotalRowCount();
	
	// edittipWriteOk
	@Insert("insert into edittip values ( 0, #{userSeq}, 5, #{edittipSubject}, #{edittipSubtitle}, #{edittipContent}, 0, now() )")
	int editTip_Write_Ok(Gorea_EditTip_BoardTO eto);

	// edittipView
	@Select("select edittipSubject, edittipSubtitle, edittipHit, edittipContent, edittipWdate, DATE_FORMAT(edittipWdate, '%Y-%m-%d') AS formattedEdittipWdate, DATEDIFF(NOW(), edittipWdate) from edittip where edittipSeq=#{edittipSeq}")
	Gorea_EditTip_BoardTO editTip_View(Gorea_EditTip_BoardTO eto);
	
	// edittipModify
	@Select("select edittipSubject, edittipSubtitle, edittipContent from edittip where edittipSeq=#{edittipSeq}")
	Gorea_EditTip_BoardTO editTip_Modify(Gorea_EditTip_BoardTO eto);
	
	// edittipDeleteOk
	@Delete("delete from edittip where edittipSeq=#{edittipSeq}")
	int editTip_Delete_Ok(Gorea_EditTip_BoardTO eto);
	
	// edittipModifyOk
	@Update("update edittip set edittipSubject=#{edittipSubject}, edittipSubtitle=#{edittipSubtitle}, edittipContent=#{edittipContent} where edittipSeq=#{edittipSeq}")
	int editTip_Modify_Ok(Gorea_EditTip_BoardTO eto);

	
	// edittipViewHit
	@Update("update edittip set edittipHit=edittipHit+1 where edittipSeq=#{edittipSeq}")
	int editTip_ViewHit(Gorea_EditTip_BoardTO eto);
	
	// ReplyList
	@Select("SELECT et.edittipSeq, et.edittipCmtSeq, et.userSeq, et.edittipCmtContent, DATE_FORMAT(et.edittipCmtWdate, '%Y.%m.%d') AS edittipCmtWdate, u.userNickname AS userNickname, u.userNation AS userNation " +
		    "FROM edittipReply et " +
		    "JOIN User u ON et.userSeq = u.userSeq " +
		    "WHERE et.edittipSeq=#{edittipSeq} " +
		    "ORDER BY et.edittipCmtSeq DESC")
	List<Gorea_EditTip_ReplyTO> editReply_List(String edittipSeq);

			
	// ReplyWrite_Ok
	@Insert("insert into edittipReply values (#{edittipSeq}, 0, #{userSeq}, #{edittipCmtContent}, now() )")
	int Edittip_Reply(Gorea_EditTip_ReplyTO rto);
			
	// ReplyModify
	@Select("SELECT edittipCmtSeq, userSeq, edittipCmtContent FROM edittipReply WHERE edittipCmtSeq = #{edittipCmtSeq} AND userSeq = #{userSeq}")
	Gorea_EditTip_ReplyTO ReplyModify(Gorea_EditTip_ReplyTO rto);

	// ReplyModify_Ok
	@Update("update edittipReply set edittipCmtContent=#{edittipCmtContent} where edittipCmtSeq=#{edittipCmtSeq}")
	int ReplyModify_Ok(Gorea_EditTip_ReplyTO rto);
			
	// ReplyDelete
	@Delete("delete from edittipReply where edittipCmtSeq=#{edittipCmtSeq}")
	int ReplyDelete(String edittipCmtSeq);
	
	// Edittip 게시판 검색
			@Select("<script>"
			        + "SELECT edittipSeq, userSeq, edittipSubject, edittipSubtitle, edittipContent "
			        + "FROM edittip "
			        + "<where>"
			        + "  <if test='searchType != null and searchKeyword != null'>"
			        + "    <choose>"
			        + "      <when test='searchType.equals(\"title\")'>"
			        + "        AND edittipSubject LIKE CONCAT('%', #{searchKeyword}, '%')"
			        + "      </when>"
			        + "      <when test='searchType.equals(\"titleContent\")'>"
			        + "        AND (edittipSubject LIKE CONCAT('%', #{searchKeyword}, '%') OR edittipContent LIKE CONCAT('%', #{searchKeyword}, '%'))"
			        + "      </when>"
			        + "    </choose>"
			        + "  </if>"
			        + "</where>"
			        + "ORDER BY edittipSeq DESC LIMIT #{firstRow}, #{pageSize}"
			        + "</script>")
			List<Gorea_EditTip_BoardTO> searchEdittip(@Param("searchType") String searchType, 
			                                              @Param("searchKeyword") String searchKeyword,@Param("firstRow") int firstRow, @Param("pageSize") int pageSize);


		@Select("<script>"
			        + "SELECT COUNT(*) "
			        + "FROM edittip "
			        + "<where>"
			        + "  <if test='searchType != null and searchKeyword != null'>"
			        + "    <choose>"
			        + "      <when test='searchType.equals(\"title\")'>"
			        + "        AND edittipSubject LIKE CONCAT('%', #{searchKeyword}, '%')"
			        + "      </when>"
			        + "      <when test='searchType.equals(\"titleContent\")'>"
			        + "        AND (edittipSubject LIKE CONCAT('%', #{searchKeyword}, '%') OR edittipContent LIKE CONCAT('%', #{searchKeyword}, '%'))"
			        + "      </when>"
			        + "    </choose>"
			        + "  </if>"
			        + "</where>"
			        + "</script>")
			int searchTotalCount(@Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);
	
	
}

