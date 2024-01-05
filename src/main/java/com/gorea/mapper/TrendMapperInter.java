package com.gorea.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.gorea.dto_board.Gorea_TrendSeoul_BoardTO;

@Mapper
public interface TrendMapperInter {
	
	// trend_seoul
		@Select("select go_seoul_seq, go_seoul_subject, go_seoul_subtitle, go_seoul_content from trendseoul order by go_seoul_seq desc")
		ArrayList<Gorea_TrendSeoul_BoardTO> trendSeoul_List(); 
		
		// trend_seoul_WriteOk
		@Insert("insert into trendseoul values (0, #{go_seoul_subject}, #{go_seoul_subtitle}, #{go_seoul_content}, 0, now(), #{go_seoul_loc}, #{tel}, #{address}, #{facilities}, #{traffic_info})")
		int trendSeoul_Write_Ok(Gorea_TrendSeoul_BoardTO to);
		
		// trend_view
		@Update("update trendseoul set go_seoul_hit=go_seoul_hit+1 where go_seoul_seq=#{go_seoul_seq}")
		int TrendHit(Gorea_TrendSeoul_BoardTO to);
		
		@Select("select go_seoul_subject, go_seoul_subtitle, go_seoul_content, go_seoul_hit, date_format(go_seoul_wdate, '%Y.%m.%d') go_seoul_wdate, tel, address, facilities, traffic_info, datediff(now(), go_seoul_wdate) from trendseoul where go_seoul_seq=#{go_seoul_seq} ")
		Gorea_TrendSeoul_BoardTO trendSeoul_View(Gorea_TrendSeoul_BoardTO to);
		
		// trend_Modify
		@Select("select go_seoul_subject, go_seoul_subtitle, go_seoul_content, tel, address, facilities, traffic_info from trendseoul where go_seoul_seq=#{go_seoul_seq}")
		Gorea_TrendSeoul_BoardTO trendSeoul_Modify(Gorea_TrendSeoul_BoardTO to);
		
		// trend_modify_ok
		@Update("update trendseoul set go_seoul_subject=#{go_seoul_subject}, go_seoul_subtitle=#{go_seoul_subtitle}, go_seoul_content=#{go_seoul_content}, go_seoul_loc=#{go_seoul_loc}, tel=#{tel}, address=#{address}, facilities=#{facilities}, traffic_info=#{traffic_info} where go_seoul_seq=#{go_seoul_seq}")
		int trendSeoul_Modify_Ok(Gorea_TrendSeoul_BoardTO to);
		
		// trend_delete_ok
		@Delete("delete from trendseoul where go_seoul_seq=#{go_seoul_seq}")
		int trendSeoul_Delete_Ok(Gorea_TrendSeoul_BoardTO to);
}
