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
	@Select("SELECT editrecoSeq, userSeq, editrecoboardNo, editrecoSubject, editrecoSubtitle, editrecoContent FROM editrecommend ORDER BY editrecoSeq DESC LIMIT #{firstRow}, #{pageSize}")
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

	
	/* editTip */
		    
	// edittipList
	@Select("SELECT edittipSeq, userSeq, edittipSubject, edittipSubtitle, edittipContent FROM edittip ORDER BY edittipSeq DESC LIMIT #{firstRow}, #{pageSize}")
	List<Gorea_EditTip_BoardTO> editTip_List(@Param("firstRow") int firstRow, @Param("pageSize") int pageSize);
	
	@Select("SELECT COUNT(*) FROM edittip")
    int getTotalCount();
	
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
	
}

