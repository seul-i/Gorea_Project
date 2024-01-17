package com.gorea.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.gorea.dto_board.Gorea_BEST5_WriteTO;
import com.gorea.dto_board.Gorea_BEST5_BoardTO;
import com.gorea.dto_board.Gorea_BEST5_CommentTO;
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
	
	@Insert("INSERT INTO BestTop5 (userSeq) VALUES (#{userSeq})")
	int best5_Write_Ok(Gorea_BEST5_WriteTO bto);
	
	@Select("select top5Seq from BestTop5 where userSeq = #{userSeq}")
	Gorea_BEST5_WriteTO best5_top5Seq(Gorea_BEST5_WriteTO bto);
	
	@Insert("insert into BestTop5comment (top5Seq, seoulSeq, top5Comment, top5Hit) values (#{top5Seq}, #{seoulSeq}, #{top5Comment}, 0)")
	int best5_WriteComment_Ok(Gorea_BEST5_CommentTO Cto);
	
    @Select("SELECT " +
            "bt.top5Seq, " +
            "bt.userSeq, " +
            "ts.seoulSeq, " +
            "ts.seoulcategoryNo, " +
            "ts.seoulTitle, " +
            "ts.seoulContent, " +
            "ts.seoulLoc, " +
            "ts.seoulLocGu, " +
            "btc.top5Comment, " +
            "btc.top5Hit, " +
            "btc.top5postDate " +
            "FROM BestTop5 bt " +
            "JOIN BestTop5comment btc ON bt.top5Seq = btc.top5Seq " +
            "LEFT JOIN TrendSeoul ts ON btc.seoulSeq = ts.seoulSeq " +
            "ORDER BY bt.top5Seq, btc.top5postDate " +
            "LIMIT 5")
    List<Gorea_BEST5_BoardTO> best5_top5_boardList();

}
