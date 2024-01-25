package com.gorea.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.gorea.dto_board.Gorea_EditRecommend_BoardTO;
import com.gorea.dto_board.Gorea_Notice_BoardTO;
import com.gorea.dto_reply.Gorea_EditRecommend_ReplyTO;

@Mapper
public interface EditrecoMapperInter {

	/* editRecommend */
	
	// editrecoList
	@Select("SELECT editrecoSeq, userSeq, editrecoboardNo, editrecoSubject, editrecoSubtitle, editrecoContent, DATE_FORMAT(editrecoWdate, '%Y.%m.%d') AS editrecoWdate FROM editrecommend ORDER BY editrecoSeq DESC LIMIT #{firstRow}, #{pageSize}")
	List<Gorea_EditRecommend_BoardTO> editRecommend_List(@Param("firstRow") int firstRow, @Param("pageSize") int pageSize);

	
    @Select("SELECT COUNT(*) FROM editrecommend")
    int getTotalRowCount();
	
	// editrecoWriteOk
	@Insert("insert into editrecommend values ( 0, #{userSeq}, 4, #{editrecoSubject}, #{editrecoSubtitle}, #{editrecoContent}, 0, now() )")
	int editRecommend_Write_Ok(Gorea_EditRecommend_BoardTO to);

	// editrecoView
	@Select("SELECT editrecoSubject, editrecoSubtitle, editrecoHit, editrecoContent, editrecoWdate, DATE_FORMAT(editrecoWdate, '%Y-%m-%d') AS formattedEditrecoWdate, DATEDIFF(NOW(), editrecoWdate) FROM editrecommend WHERE editrecoSeq=#{editrecoSeq}")
	Gorea_EditRecommend_BoardTO editRecommend_View(Gorea_EditRecommend_BoardTO to);
	
	// editrecoModify
	@Select("select editrecoSubject, editrecoSubtitle, editrecoContent from editrecommend where editrecoSeq=#{editrecoSeq}")
	Gorea_EditRecommend_BoardTO editRecommend_Modify(Gorea_EditRecommend_BoardTO to);
	
	// editrecoDeleteOk
	@Delete("delete from editrecommend where editrecoSeq=#{editrecoSeq}")
	int editRecommend_Delete_Ok(Gorea_EditRecommend_BoardTO to);
	
	// editrecoModifyOk
	@Update("update editrecommend set editrecoSubject=#{editrecoSubject}, editrecoSubtitle=#{editrecoSubtitle}, editrecoContent=#{editrecoContent} where editrecoSeq=#{editrecoSeq}")
	int editRecommend_Modify_Ok(Gorea_EditRecommend_BoardTO to);

	// editrecoViewHit
	@Update("update editrecommend set editrecoHit=editrecoHit+1 where editrecoSeq=#{editrecoSeq}")
	int editRecommend_ViewHit(Gorea_EditRecommend_BoardTO to);
	
	// ReplyList
	@Select("SELECT er.editrecoSeq, er.editrecoCmtSeq, er.userSeq, er.editrecoCmtContent, DATE_FORMAT(er.editrecoCmtWdate, '%Y.%m.%d') AS editrecoCmtWdate, u.userNickname AS userNickname, u.userNation AS userNation " +
	        "FROM editrecommendreply er " +
	        "JOIN user u ON er.userSeq = u.userSeq " +
	        "WHERE er.editrecoSeq=#{editrecoSeq} " +
	        "ORDER BY er.editrecoCmtSeq DESC")
	List<Gorea_EditRecommend_ReplyTO> editReply_List(String editrecoSeq);

		
	// ReplyWrite_Ok
	@Insert("insert into editrecommendreply values (#{editrecoSeq}, 0, #{userSeq},  #{editrecoCmtContent}, now() )")
	int EditRecommend_Reply(Gorea_EditRecommend_ReplyTO rto);
		
	// ReplyModify
	@Select("SELECT editrecoCmtSeq, userSeq, editrecoCmtContent FROM editrecommendreply WHERE editrecoCmtSeq = #{editrecoCmtSeq} AND userSeq = #{userSeq}")
	Gorea_EditRecommend_ReplyTO ReplyModify(Gorea_EditRecommend_ReplyTO rto);

	// ReplyModify_Ok
	@Update("update editrecommendreply set editrecoCmtContent=#{editrecoCmtContent} where editrecoCmtSeq=#{editrecoCmtSeq}")
	int ReplyModify_Ok(Gorea_EditRecommend_ReplyTO rto);
		
	// ReplyDelete
	@Delete("delete from editrecommendreply where editrecoCmtSeq=#{editrecoCmtSeq}")
	int ReplyDelete(String editrecoCmtSeq);
	
	
	// Editrecommend 게시판 검색
		@Select("<script>"
		        + "SELECT editrecoSeq, userSeq, editrecoboardNo, editrecoSubject, editrecoSubtitle, editrecoContent , DATE_FORMAT(editrecoWdate, '%Y.%m.%d') AS editrecoWdate "
		        + "FROM editrecommend "
		        + "<where>"
		        + "  <if test='searchType != null and searchKeyword != null'>"
		        + "    <choose>"
		        + "      <when test='searchType.equals(\"title\")'>"
		        + "        AND editrecoSubject LIKE CONCAT('%', #{searchKeyword}, '%')"
		        + "      </when>"
		        + "      <when test='searchType.equals(\"titleContent\")'>"
		        + "        AND (editrecoSubject LIKE CONCAT('%', #{searchKeyword}, '%') OR editrecoContent LIKE CONCAT('%', #{searchKeyword}, '%'))"
		        + "      </when>"
		        + "    </choose>"
		        + "  </if>"
		        + "</where>"
		        + "ORDER BY editrecoSeq DESC LIMIT #{firstRow}, #{pageSize}"
		        + "</script>")
		List<Gorea_EditRecommend_BoardTO> searchEditreco(@Param("searchType") String searchType, 
		                                              @Param("searchKeyword") String searchKeyword,@Param("firstRow") int firstRow, @Param("pageSize") int pageSize);


	@Select("<script>"
		        + "SELECT COUNT(*) "
		        + "FROM editrecommend "
		        + "<where>"
		        + "  <if test='searchType != null and searchKeyword != null'>"
		        + "    <choose>"
		        + "      <when test='searchType.equals(\"title\")'>"
		        + "        AND editrecoSubject LIKE CONCAT('%', #{searchKeyword}, '%')"
		        + "      </when>"
		        + "      <when test='searchType.equals(\"titleContent\")'>"
		        + "        AND (editrecoSubject LIKE CONCAT('%', #{searchKeyword}, '%') OR editrecoContent LIKE CONCAT('%', #{searchKeyword}, '%'))"
		        + "      </when>"
		        + "    </choose>"
		        + "  </if>"
		        + "</where>"
		        + "</script>")
		int searchTotalCount(@Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);
	
	// 이전 글 가져오기
    @Select("SELECT * FROM editrecommend WHERE editrecoSeq < #{editrecoSeq} ORDER BY editrecoSeq DESC LIMIT 1")
    Gorea_EditRecommend_BoardTO  getPreviousPost(int editrecoSeq);

    // 다음 글 가져오기
    @Select("SELECT * FROM editrecommend WHERE editrecoSeq > #{editrecoSeq} ORDER BY editrecoSeq ASC LIMIT 1")
    Gorea_EditRecommend_BoardTO getNextPost(int editrecoSeq);
	
	
}

