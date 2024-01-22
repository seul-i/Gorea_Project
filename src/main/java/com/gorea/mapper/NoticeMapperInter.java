package com.gorea.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import com.gorea.dto_board.Gorea_Notice_BoardTO;

@Mapper
public interface NoticeMapperInter {
	
	// Notice
	@Select("select noticeSeq, noticeTitle, noticeContent, noticeHit, date_format(noticepostDate, '%Y.%m.%d') noticepostDate from Notice order by noticeSeq desc LIMIT #{firstRow}, #{pageSize}")
	ArrayList<Gorea_Notice_BoardTO> Notice_List(@Param("firstRow") int firstRow, @Param("pageSize") int pageSize); 
	
	@Select("SELECT COUNT(*) FROM Notice")
	 int Notice_TotalCount();
	
	// Notice_WriteOk
	@Insert("insert into Notice values (0, #{userSeq}, 8, #{noticeTitle}, now(), 0, #{noticeContent} )")
	int Notice_Write_Ok(Gorea_Notice_BoardTO to);
	
	// Notice_view_hit
	@Update("update Notice set noticeHit=noticeHit+1 where noticeSeq=#{noticeSeq}")
	int NoticeHit(Gorea_Notice_BoardTO to);
	
	// Notice_view
	@Select("select noticeTitle, noticeContent, noticeHit, date_format(noticepostDate, '%Y.%m.%d') noticepostDate from Notice where noticeSeq=#{noticeSeq} ")
	Gorea_Notice_BoardTO Notice_View(Gorea_Notice_BoardTO to);
	
	// 이전 글 가져오기
    @Select("SELECT * FROM Notice WHERE noticeSeq < #{noticeSeq} ORDER BY noticeSeq DESC LIMIT 1")
    Gorea_Notice_BoardTO  getPreviousPost(int noticeSeq);

    // 다음 글 가져오기
    @Select("SELECT * FROM Notice WHERE noticeSeq > #{noticeSeq} ORDER BY noticeSeq ASC LIMIT 1")
    Gorea_Notice_BoardTO getNextPost(int noticeSeq);
	
	// Notice_Modify
	@Select("select noticeTitle, noticeContent from Notice where noticeSeq=#{noticeSeq}")
	Gorea_Notice_BoardTO Notice_Modify(Gorea_Notice_BoardTO to);
	
	// Notice_modify_ok
	@Update("update Notice set noticeTitle=#{noticeTitle}, noticeContent=#{noticeContent} where noticeSeq=#{noticeSeq}")
	int Notice_Modify_Ok(Gorea_Notice_BoardTO to);
	
	// Notice_delete_ok
	@Delete("delete from Notice where noticeSeq=#{noticeSeq}")
	int Notice_Delete_Ok(Gorea_Notice_BoardTO to);
	
	// Notice 게시판 검색
		@Select("<script>"
		        + "SELECT noticeSeq, noticeTitle, noticeContent, noticeHit, date_format(noticepostDate, '%Y.%m.%d') as noticepostDate "
		        + "FROM Notice "
		        + "<where>"
		        + "  <if test='searchType != null and searchKeyword != null'>"
		        + "    <choose>"
		        + "      <when test='searchType.equals(\"title\")'>"
		        + "        AND noticeTitle LIKE CONCAT('%', #{searchKeyword}, '%')"
		        + "      </when>"
		        + "      <when test='searchType.equals(\"titleContent\")'>"
		        + "        AND (noticeTitle LIKE CONCAT('%', #{searchKeyword}, '%') OR noticeContent LIKE CONCAT('%', #{searchKeyword}, '%'))"
		        + "      </when>"
		        + "    </choose>"
		        + "  </if>"
		        + "</where>"
		        + "ORDER BY noticeSeq DESC LIMIT #{firstRow}, #{pageSize}"
		        + "</script>")
		ArrayList<Gorea_Notice_BoardTO> searchNotice(@Param("searchType") String searchType, 
		                                              @Param("searchKeyword") String searchKeyword,@Param("firstRow") int firstRow, @Param("pageSize") int pageSize);
		
		@Select("<script>"
		        + "SELECT COUNT(*) "
		        + "FROM Notice "
		        + "<where>"
		        + "  <if test='searchType != null and searchKeyword != null'>"
		        + "    <choose>"
		        + "      <when test='searchType.equals(\"title\")'>"
		        + "        AND noticeTitle LIKE CONCAT('%', #{searchKeyword}, '%')"
		        + "      </when>"
		        + "      <when test='searchType.equals(\"titleContent\")'>"
		        + "        AND (noticeTitle LIKE CONCAT('%', #{searchKeyword}, '%') OR noticeContent LIKE CONCAT('%', #{searchKeyword}, '%'))"
		        + "      </when>"
		        + "    </choose>"
		        + "  </if>"
		        + "</where>"
		        + "</script>")
		int searchTotalCount(@Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);
}