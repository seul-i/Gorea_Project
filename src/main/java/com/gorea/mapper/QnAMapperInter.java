package com.gorea.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.gorea.dto_board.Gorea_QnA_BoardTO;

@Mapper
public interface QnAMapperInter {
	
	// QnA
	@Select("select qnaSeq, qnaTitle, qnaContent, qnaHit, qnapostDate from QnA order by qnaSeq desc")
	ArrayList<Gorea_QnA_BoardTO> QnA_List(); 
	
	// QnA_WriteOk
	@Insert("insert into QnA values (0, #{qnaTitle}, #{qnaContent}, 0, now() )")
	int QnA_Write_Ok(Gorea_QnA_BoardTO to);
	
	// QnA_view_hit
	@Update("update QnA set qnaHit=qnaHit+1 where qnaSeq=#{qnaSeq}")
	int QnAHit(Gorea_QnA_BoardTO to);
	
	// QnA_view
	@Select("select qnaTitle, qnaContent, qnaHit, date_format(qnapostDate, '%Y.%m.%d') qnapostDate from QnA where qnaSeq=#{qnaSeq} ")
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
	
}