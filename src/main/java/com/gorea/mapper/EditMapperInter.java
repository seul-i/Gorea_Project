package com.gorea.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.gorea.dto_board.Gorea_EditRecommend_BoardTO;
import com.gorea.dto_board.Gorea_EditTip_BoardTO;

@Mapper
public interface EditMapperInter {

/* editRecommend */
	
	// editrecoList
	@Select("SELECT editrecoSeq, editrecoSubject, editrecoSubtitle, editrecoContent FROM editrecommend ORDER BY editrecoSeq DESC LIMIT #{firstRow}, #{pageSize}")
	List<Gorea_EditRecommend_BoardTO> editRecommend_List(@Param("firstRow") int firstRow, @Param("pageSize") int pageSize);

    @Select("SELECT COUNT(*) FROM editrecommend")
    int getTotalRowCount();
	
	// editrecoWriteOk
	@Insert("insert into editrecommend values ( 0, #{editrecoSubject}, #{editrecoSubtitle}, #{editrecoContent}, 0, #{editrecoWdate} )")
	int editRecommend_Write_Ok(Gorea_EditRecommend_BoardTO to);

	// editrecoView
	@Select("select editrecoSubject, editrecoSubtitle, editrecoHit, editrecoContent, editrecoWdate from editrecommend where editrecoSeq=#{editrecoSeq}")
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
}

