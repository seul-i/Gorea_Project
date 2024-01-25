package com.gorea.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.gorea.dto_board.Gorea_QnA_BoardTO;
import com.gorea.dto_reply.Gorea_QnA_ReplyTO;

@Mapper
public interface QnAMapperInter {

	// QnA
	@Select("SELECT q.qnaSeq, q.qnaCategory, q.qnaCmt,  q.qnaTitle, q.qnaContent, date_format(q.qnapostDate, '%Y.%m.%d') qnapostDate, u.userNickname AS userNickname FROM QnA q JOIN user u ON q.userSeq = u.userSeq LIMIT #{firstRow}, #{pageSize}")
	ArrayList<Gorea_QnA_BoardTO> QnA_List(@Param("firstRow") int firstRow, @Param("pageSize") int pageSize);

	// QnA 카운트
	@Select("SELECT COUNT(*) FROM QnA")
	int QnA_TotalCount();

	// QnA_WriteOk
	@Insert("insert into QnA values (0, #{userSeq}, 9, #{qnaCategory}, #{qnaTitle}, now(), #{qnaContent}, 0 )")
	int QnA_Write_Ok(Gorea_QnA_BoardTO to);

	// QnA_view
	@Select("select q.qnaSeq, q.qnaCategory,  q.qnaTitle, q.userSeq, q.qnaContent, date_format(q.qnapostDate, '%Y.%m.%d') qnapostDate, u.userNickname AS userNickname "
			+ "FROM QnA q " + "JOIN user u ON q.userSeq = u.userSeq " + "where qnaSeq=#{qnaSeq} ")
	Gorea_QnA_BoardTO QnA_View(Gorea_QnA_BoardTO to);
	
	// 이전 글 가져오기
    @Select("SELECT * FROM QnA WHERE qnaSeq < #{qnaSeq} ORDER BY qnaSeq DESC LIMIT 1")
    Gorea_QnA_BoardTO  getPreviousPost(int qnaSeq);

    // 다음 글 가져오기
    @Select("SELECT * FROM QnA WHERE qnaSeq > #{qnaSeq} ORDER BY qnaSeq ASC LIMIT 1")
    Gorea_QnA_BoardTO getNextPost(int qnaSeq);

	// QnA_Modify
	@Select("select qnaTitle, qnaContent from QnA where qnaSeq=#{qnaSeq}")
	Gorea_QnA_BoardTO QnA_Modify(Gorea_QnA_BoardTO to);

	// QnA_modify_ok
	@Update("update QnA set qnaTitle=#{qnaTitle}, qnaCategory=#{qnaCategory}, qnaContent=#{qnaContent} where qnaSeq=#{qnaSeq}")
	int QnA_Modify_Ok(Gorea_QnA_BoardTO to);

	// QnA_delete_ok
	@Delete("delete from QnA where qnaSeq=#{qnaSeq}")
	int QnA_Delete_Ok(Gorea_QnA_BoardTO to);

	// QnA_ 게시판 검색
	@Select("<script>"
			+ "SELECT qnaSeq, qnaCategory, qnaCmt, qnaTitle, qnaContent, date_format(qnapostDate, '%Y.%m.%d') as qnapostDate "
			+ "FROM QnA " + "<where>" + "  <if test='searchType != null and searchKeyword != null'>" + "    <choose>"
			+ "      <when test='searchType.equals(\"title\")'>"
			+ "        AND qnaTitle LIKE CONCAT('%', #{searchKeyword}, '%')" + "      </when>"
			+ "      <when test='searchType.equals(\"titleContent\")'>"
			+ "        AND (qnaTitle LIKE CONCAT('%', #{searchKeyword}, '%') OR qnaContent LIKE CONCAT('%', #{searchKeyword}, '%'))"
			+ "      </when>" + "    </choose>" + "  </if>" + "</where>"
			+ "ORDER BY qnaSeq DESC LIMIT #{firstRow}, #{pageSize}" + "</script>")
	ArrayList<Gorea_QnA_BoardTO> searchQnA(@Param("searchType") String searchType,
			@Param("searchKeyword") String searchKeyword, @Param("firstRow") int firstRow,
			@Param("pageSize") int pageSize);

	@Select("<script>" + "SELECT COUNT(*) " + "FROM QnA " + "<where>"
			+ "  <if test='searchType != null and searchKeyword != null'>" + "    <choose>"
			+ "      <when test='searchType.equals(\"title\")'>"
			+ "        AND qnaTitle LIKE CONCAT('%', #{searchKeyword}, '%')" + "      </when>"
			+ "      <when test='searchType.equals(\"titleContent\")'>"
			+ "        AND (qnaTitle LIKE CONCAT('%', #{searchKeyword}, '%') OR qnaContent LIKE CONCAT('%', #{searchKeyword}, '%'))"
			+ "      </when>" + "    </choose>" + "  </if>" + "</where>" + "</script>")
	int searchTotalCount(@Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);

	// QnAReplyList
	@Select("SELECT q.qnaSeq, q.qnaCmtSeq, q.userSeq, q.qnaCmtContent, DATE_FORMAT(q.qnaCmtWdate, '%Y.%m.%d') AS qnaCmtWdate, u.userNickname AS userNickname, u.userNation AS userNation "
			+ "FROM QnAReply q " + "JOIN user u ON q.userSeq = u.userSeq " + "WHERE q.qnaSeq=#{qnaSeq} "
			+ "ORDER BY q.qnaCmtSeq DESC")
	List<Gorea_QnA_ReplyTO> QnAReplyList(String qnaSeq);

	// QnAReply_Write
	@Insert("insert into QnAReply values (#{qnaSeq}, 0, #{userSeq}, #{qnaCmtContent}, now() )")
	int QnAReply_Write(Gorea_QnA_ReplyTO rto);

	// QnAReply_Modify
	@Select("SELECT qnaCmtSeq, userSeq, qnaCmtContent FROM QnAReply WHERE qnaCmtSeq = #{qnaCmtSeq} AND userSeq = #{userSeq}")
	Gorea_QnA_ReplyTO QnAReply_Modify(Gorea_QnA_ReplyTO rto);

	// QnAReply_Modify_OK
	@Update("update QnAReply set qnaCmtContent=#{qnaCmtContent} where qnaCmtSeq=#{qnaCmtSeq}")
	int QnAReply_Modify_Ok(Gorea_QnA_ReplyTO rto);

	// QnAReply_Delete
	@Delete("delete from QnAReply where qnaCmtSeq=#{qnaCmtSeq}")
	int QnAReply_Delete(String qnaCmtSeq);

	@Update("update QnA set qnaCmt=qnaCmt+1 where qnaSeq=#{qnaSeq}")
	int QnACmtUp(Gorea_QnA_ReplyTO rto);

}