package com.gorea.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.gorea.dto_board.Gorea_QnA_BoardTO;
import com.gorea.dto_reply.Gorea_QnA_ReplyTO;
import com.gorea.dto_reply.Gorea_TrendSeoul_ReplyTO;

@Mapper
public interface QnAMapperInter {
	
	// QnA
	@Select("select qnaSeq, qnaTitle, qnaContent, qnapostDate from QnA order by qnaSeq desc")
	ArrayList<Gorea_QnA_BoardTO> QnA_List(); 
	
	// QnA_WriteOk
	@Insert("insert into QnA values (0, #{userSeq}, 9, #{qnaCategory}, #{qnaTitle}, now(), #{qnaContent}, 0 )")
	int QnA_Write_Ok(Gorea_QnA_BoardTO to);
	
	// QnA_view
	@Select("select qnaTitle, qnaContent, date_format(qnapostDate, '%Y.%m.%d') qnapostDate from QnA where qnaSeq=#{qnaSeq} ")
	Gorea_QnA_BoardTO QnA_View(Gorea_QnA_BoardTO to);
	
	// QnA_Modify
	@Select("select qnaTitle, qnaContent from QnA where qnaSeq=#{qnaSeq}")
	Gorea_QnA_BoardTO QnA_Modify(Gorea_QnA_BoardTO to);
	
	// QnA_modify_ok
	@Update("update QnA set qnaTitle=#{qnaTitle}, qnaContent=#{qnaContent} where qnaSeq=#{qnaSeq}")
	int QnA_Modify_Ok(Gorea_QnA_BoardTO to);
	
	// QnA_delete_ok
	@Delete("delete from QnA where qnaSeq=#{qnaSeq}")
	int QnA_Delete_Ok(Gorea_QnA_BoardTO to);
	
	// QnAReplyList
		@Select("SELECT q.qnaSeq, q.qnaCmtSeq, q.userSeq, q.qnaCmtContent, DATE_FORMAT(q.qnaCmtWdate, '%Y.%m.%d') AS qnaCmtWdate, u.userNickname AS userNickname " +
		        "FROM QnAReply q " +
		        "JOIN user u ON q.userSeq = u.userSeq " +
		        "WHERE q.qnaSeq=#{qnaSeq} " +
		        "ORDER BY Q.qnaCmtSeq DESC")
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
	
}