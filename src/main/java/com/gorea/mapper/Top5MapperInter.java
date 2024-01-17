package com.gorea.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.gorea.dto_board.Gorea_BEST5_BoardTO;
import com.gorea.dto_board.Gorea_TrendSeoul_ListTO;
import com.gorea.dto_board.Gorea_TrendSeoul_SearchTO;

@Mapper
public interface Top5MapperInter {
	
	@Select("select ts.seoulSeq, ts.seoulTitle, ts.seoulLocGu, ts.seoulContent, cn.mainCategory, cn.subCategory from trendseoul ts JOIN CategoryNo cn ON ts.seoulcategoryNo = cn.categoryNo order by seoulSeq asc")
	List<Gorea_TrendSeoul_ListTO> trendSeoul_List();
	
	@Select("SELECT ts.seoulSeq, ts.seoulTitle, ts.seoulLocGu, ts.seoulContent, cn.mainCategory, cn.subCategory "
	        + "FROM trendseoul ts "
	        + "JOIN CategoryNo cn ON ts.seoulcategoryNo = cn.categoryNo "
	        + "WHERE ts.seoulLocGu LIKE CONCAT('%', #{locGu}, '%') "  // 변경된 부분
	        + "AND cn.mainCategory LIKE CONCAT('%', #{mainCategory}, '%') "  // 변경된 부분
	        + "AND cn.subCategory LIKE CONCAT('%', #{subCategory}, '%') "  // 변경된 부분
	        + "ORDER BY ts.seoulSeq ASC")
	List<Gorea_TrendSeoul_ListTO> trendSeoul_searchList(@Param("locGu") String locGu, 
	                                                    @Param("mainCategory") String mainCategory, 
	                                                    @Param("subCategory") String subCategory);
	
	@Select("select distinct seoulLocGu from trendseoul order by seoulSeq asc")
	List<Gorea_TrendSeoul_SearchTO> search_locGu();
	
	@Select("select distinct mainCategory from CategoryNo")
	List<Gorea_TrendSeoul_SearchTO> search_mainCategroy();
	
	@Select("select subCategory from CategoryNo where mainCategory = #{mainCategory}")
	List<Gorea_TrendSeoul_SearchTO> search_subCategroy(String mainCategory);
	
    @Insert("INSERT INTO BestTop5 (userSeq, seoulSeq1, top5Comment1, seoulSeq2, top5Comment2, " +
            "seoulSeq3, top5Comment3, seoulSeq4, top5Comment4, seoulSeq5, top5Comment5, " +
            "top5Hit) " +
            "VALUES (#{userSeq}, #{seoulSeq1}, #{top5Comment1}, #{seoulSeq2}, #{top5Comment2}, " +
            "#{seoulSeq3}, #{top5Comment3}, #{seoulSeq4}, #{top5Comment4}, #{seoulSeq5}, #{top5Comment5}, " +
            "0)")
    int besttop5_Write_Ok(Gorea_BEST5_BoardTO to);

}
