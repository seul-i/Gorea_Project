package com.gorea.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.gorea.dto_board.Gorea_BEST5_BoardTO;
import com.gorea.dto_board.Gorea_BEST5_ListTO;
import com.gorea.dto_board.Gorea_TrendSeoul_ListTO;
import com.gorea.dto_board.Gorea_TrendSeoul_SearchTO;
import com.gorea.dto_like.Gorea_BEST5_LikeTO;

@Mapper
public interface Top5MapperInter {
	
	@Insert("INSERT INTO BoardFavo (boardnoSeq, boardSeq, userSeq) VALUES (#{boardnoSeq}, #{boardSeq}, #{userSeq})")
	@Options(useGeneratedKeys = true, keyProperty = "likeSeq")
	    int addToFavorites(Gorea_BEST5_LikeTO to);
	
	@Select("select boardnoSeq, boardSeq, userSeq from BoardFavo where userSeq = #{userSeq}")
	Gorea_BEST5_LikeTO boardlikeCheck(Gorea_BEST5_LikeTO boardLike);
	
	@Select("select ts.seoulSeq, ts.seoulTitle, ts.seoulLocGu, ts.seoulContent, cn.mainCategory, cn.subCategory from TrendSeoul ts JOIN CategoryNo cn ON ts.seoulcategoryNo = cn.categoryNo order by seoulSeq asc")
	List<Gorea_TrendSeoul_ListTO> trendSeoul_List();
	
	@Select("SELECT ts.seoulSeq, ts.seoulTitle, ts.seoulLocGu, ts.seoulContent, cn.mainCategory, cn.subCategory "
	        + "FROM TrendSeoul ts "
	        + "JOIN CategoryNo cn ON ts.seoulcategoryNo = cn.categoryNo "
	        + "WHERE ts.seoulLocGu LIKE CONCAT('%', #{locGu}, '%') "  // 변경된 부분
	        + "AND cn.mainCategory LIKE CONCAT('%', #{mainCategory}, '%') "  // 변경된 부분
	        + "AND cn.subCategory LIKE CONCAT('%', #{subCategory}, '%') "  // 변경된 부분
	        + "ORDER BY ts.seoulSeq ASC")
	List<Gorea_TrendSeoul_ListTO> trendSeoul_searchList(@Param("locGu") String locGu, 
	                                                    @Param("mainCategory") String mainCategory, 
	                                                    @Param("subCategory") String subCategory);
	
	@Select("select distinct seoulLocGu from TrendSeoul order by seoulSeq asc")
	List<Gorea_TrendSeoul_SearchTO> search_locGu();
	
	@Select("select distinct mainCategory from CategoryNo")
	List<Gorea_TrendSeoul_SearchTO> search_mainCategroy();
	
	@Select("select subCategory from CategoryNo where mainCategory = #{mainCategory}")
	List<Gorea_TrendSeoul_SearchTO> search_subCategroy(String mainCategory);
	
    @Insert("INSERT INTO BestTop5 (userSeq, top5boardNo, seoulSeq1, top5Comment1, seoulSeq2, top5Comment2, " +
            "seoulSeq3, top5Comment3, seoulSeq4, top5Comment4, seoulSeq5, top5Comment5, " +
            "top5Hit) " +
            "VALUES (#{userSeq}, 1, #{seoulSeq1}, #{top5Comment1}, #{seoulSeq2}, #{top5Comment2}, " +
            "#{seoulSeq3}, #{top5Comment3}, #{seoulSeq4}, #{top5Comment4}, #{seoulSeq5}, #{top5Comment5}, " +
            "0)")
    int besttop5_Write_Ok(Gorea_BEST5_BoardTO to);
    
    @Select("SELECT bt.top5Seq, u.userNickname, u.userNation, bt.top5Hit, bt.top5postDate, bt.top5boardNo, " +
            "ts1.seoulSeq AS seoulSeq1, ts1.seoulTitle AS seoulTitle1, " +
            "ts1.seoulContent AS seoulContent1, ts1.seoulLocGu AS seoulLocGu1, ts1.seoulcategoryNo AS seoulcategoryNo1, " +
            "cn1.mainCategory AS mainCategory1, cn1.subCategory AS subCategory1, bt.top5Comment1, " +
            "ts2.seoulSeq AS seoulSeq2, ts2.seoulTitle AS seoulTitle2, ts2.seoulContent AS seoulContent2, " +
            "ts2.seoulLocGu AS seoulLocGu2, ts2.seoulcategoryNo AS seoulcategoryNo2, cn2.mainCategory AS mainCategory2, " +
            "cn2.subCategory AS subCategory2, bt.top5Comment2, ts3.seoulSeq AS seoulSeq3, ts3.seoulTitle AS seoulTitle3, " +
            "ts3.seoulContent AS seoulContent3, ts3.seoulLocGu AS seoulLocGu3, ts3.seoulcategoryNo AS seoulcategoryNo3, " +
            "cn3.mainCategory AS mainCategory3, cn3.subCategory AS subCategory3, bt.top5Comment3, ts4.seoulSeq AS seoulSeq4, " +
            "ts4.seoulTitle AS seoulTitle4, ts4.seoulContent AS seoulContent4, ts4.seoulLocGu AS seoulLocGu4, " +
            "ts4.seoulcategoryNo AS seoulcategoryNo4, cn4.mainCategory AS mainCategory4, cn4.subCategory AS subCategory4, " +
            "bt.top5Comment4, ts5.seoulSeq AS seoulSeq5, ts5.seoulTitle AS seoulTitle5, ts5.seoulContent AS seoulContent5, " +
            "ts5.seoulLocGu AS seoulLocGu5, ts5.seoulcategoryNo AS seoulcategoryNo5, cn5.mainCategory AS mainCategory5, " +
            "cn5.subCategory AS subCategory5, bt.top5Comment5, bn.goreaboardNo " +
            "FROM BestTop5 bt " +
            "JOIN User u ON bt.userSeq = u.userSeq " +
            "LEFT JOIN TrendSeoul ts1 ON bt.seoulSeq1 = ts1.seoulSeq " +
            "LEFT JOIN TrendSeoul ts2 ON bt.seoulSeq2 = ts2.seoulSeq " +
            "LEFT JOIN TrendSeoul ts3 ON bt.seoulSeq3 = ts3.seoulSeq " +
            "LEFT JOIN TrendSeoul ts4 ON bt.seoulSeq4 = ts4.seoulSeq " +
            "LEFT JOIN TrendSeoul ts5 ON bt.seoulSeq5 = ts5.seoulSeq " +
            "LEFT JOIN CategoryNo cn1 ON ts1.seoulcategoryNo = cn1.categoryNo " +
            "LEFT JOIN CategoryNo cn2 ON ts2.seoulcategoryNo = cn2.categoryNo " +
            "LEFT JOIN CategoryNo cn3 ON ts3.seoulcategoryNo = cn3.categoryNo " +
            "LEFT JOIN CategoryNo cn4 ON ts4.seoulcategoryNo = cn4.categoryNo " +
            "LEFT JOIN CategoryNo cn5 ON ts5.seoulcategoryNo = cn5.categoryNo " +
            "LEFT JOIN BoardNo bn ON bt.top5boardNo = bn.goreaboardNo LIMIT #{firstRow}, #{pageSize}")
    List<Gorea_BEST5_ListTO> best5_top5_boardList(@Param("firstRow") int firstRow, @Param("pageSize") int pageSize);
    
    @Select("SELECT COUNT(*) FROM BestTop5")
	int get_trendSeoulTotalCount();
    
    @Select("SELECT bt.top5Seq, u.userNickname, u.userNation, bt.top5Hit, bt.top5postDate, bt.top5boardNo, " +
            "ts1.seoulSeq AS seoulSeq1, ts1.seoulTitle AS seoulTitle1, " +
            "ts1.seoulContent AS seoulContent1, ts1.seoulLocGu AS seoulLocGu1, ts1.seoulcategoryNo AS seoulcategoryNo1, " +
            "cn1.mainCategory AS mainCategory1, cn1.subCategory AS subCategory1, bt.top5Comment1, " +
            "ts2.seoulSeq AS seoulSeq2, ts2.seoulTitle AS seoulTitle2, ts2.seoulContent AS seoulContent2, " +
            "ts2.seoulLocGu AS seoulLocGu2, ts2.seoulcategoryNo AS seoulcategoryNo2, cn2.mainCategory AS mainCategory2, " +
            "cn2.subCategory AS subCategory2, bt.top5Comment2, ts3.seoulSeq AS seoulSeq3, ts3.seoulTitle AS seoulTitle3, " +
            "ts3.seoulContent AS seoulContent3, ts3.seoulLocGu AS seoulLocGu3, ts3.seoulcategoryNo AS seoulcategoryNo3, " +
            "cn3.mainCategory AS mainCategory3, cn3.subCategory AS subCategory3, bt.top5Comment3, ts4.seoulSeq AS seoulSeq4, " +
            "ts4.seoulTitle AS seoulTitle4, ts4.seoulContent AS seoulContent4, ts4.seoulLocGu AS seoulLocGu4, " +
            "ts4.seoulcategoryNo AS seoulcategoryNo4, cn4.mainCategory AS mainCategory4, cn4.subCategory AS subCategory4, " +
            "bt.top5Comment4, ts5.seoulSeq AS seoulSeq5, ts5.seoulTitle AS seoulTitle5, ts5.seoulContent AS seoulContent5, " +
            "ts5.seoulLocGu AS seoulLocGu5, ts5.seoulcategoryNo AS seoulcategoryNo5, cn5.mainCategory AS mainCategory5, " +
            "cn5.subCategory AS subCategory5, bt.top5Comment5, bn.goreaboardNo " +
            "FROM BestTop5 bt " +
            "JOIN User u ON bt.userSeq = u.userSeq " +
            "LEFT JOIN TrendSeoul ts1 ON bt.seoulSeq1 = ts1.seoulSeq " +
            "LEFT JOIN TrendSeoul ts2 ON bt.seoulSeq2 = ts2.seoulSeq " +
            "LEFT JOIN TrendSeoul ts3 ON bt.seoulSeq3 = ts3.seoulSeq " +
            "LEFT JOIN TrendSeoul ts4 ON bt.seoulSeq4 = ts4.seoulSeq " +
            "LEFT JOIN TrendSeoul ts5 ON bt.seoulSeq5 = ts5.seoulSeq " +
            "LEFT JOIN CategoryNo cn1 ON ts1.seoulcategoryNo = cn1.categoryNo " +
            "LEFT JOIN CategoryNo cn2 ON ts2.seoulcategoryNo = cn2.categoryNo " +
            "LEFT JOIN CategoryNo cn3 ON ts3.seoulcategoryNo = cn3.categoryNo " +
            "LEFT JOIN CategoryNo cn4 ON ts4.seoulcategoryNo = cn4.categoryNo " +
            "LEFT JOIN CategoryNo cn5 ON ts5.seoulcategoryNo = cn5.categoryNo " +
            "LEFT JOIN BoardNo bn ON bt.top5boardNo = bn.goreaboardNo " +
            "WHERE u.userNation = #{nation}  LIMIT #{firstRow}, #{pageSize}")
    List<Gorea_BEST5_ListTO> best5_top5_boardList_NS(String nation, @Param("firstRow") int firstRow, @Param("pageSize") int pageSize);
    
    @Select("SELECT COUNT(*) FROM BestTop5")
	int get_searchtrendSeoulTotalCount();
    
    @Update("update BestTop5 set top5Hit=top5Hit+1 where top5Seq=#{top5Seq}")
	int TrendHit(Gorea_BEST5_ListTO to);
    
    @Select("SELECT bt.top5Seq, u.userNickname, u.userNation, bt.top5Hit, bt.top5postDate, bt.top5boardNo, " +
            "ts1.seoulSeq AS seoulSeq1, ts1.seoulTitle AS seoulTitle1, " +
            "ts1.seoulContent AS seoulContent1, ts1.seoulLoc As seoulLoc1,ts1.seoulLocGu AS seoulLocGu1, ts1.seoulcategoryNo AS seoulcategoryNo1, " +
            "cn1.mainCategory AS mainCategory1, cn1.subCategory AS subCategory1, bt.top5Comment1, " +
            "ts2.seoulSeq AS seoulSeq2, ts2.seoulTitle AS seoulTitle2, ts2.seoulContent AS seoulContent2, " +
            "ts2.seoulLoc As seoulLoc2, ts2.seoulLocGu AS seoulLocGu2, ts2.seoulcategoryNo AS seoulcategoryNo2, cn2.mainCategory AS mainCategory2, " +
            "cn2.subCategory AS subCategory2, bt.top5Comment2, ts3.seoulSeq AS seoulSeq3, ts3.seoulTitle AS seoulTitle3, " +
            "ts3.seoulContent AS seoulContent3, ts3.seoulLoc As seoulLoc3, ts3.seoulLocGu AS seoulLocGu3, ts3.seoulcategoryNo AS seoulcategoryNo3, " +
            "cn3.mainCategory AS mainCategory3, cn3.subCategory AS subCategory3, bt.top5Comment3, ts4.seoulSeq AS seoulSeq4, " +
            "ts4.seoulTitle AS seoulTitle4, ts4.seoulContent AS seoulContent4,ts4.seoulLoc As seoulLoc4 ,ts4.seoulLocGu AS seoulLocGu4, " +
            "ts4.seoulcategoryNo AS seoulcategoryNo4, cn4.mainCategory AS mainCategory4, cn4.subCategory AS subCategory4, " +
            "bt.top5Comment4, ts5.seoulSeq AS seoulSeq5, ts5.seoulTitle AS seoulTitle5, ts5.seoulContent AS seoulContent5, " +
            "ts5.seoulLoc As seoulLoc5, ts5.seoulLocGu AS seoulLocGu5, ts5.seoulcategoryNo AS seoulcategoryNo5, cn5.mainCategory AS mainCategory5, " +
            "cn5.subCategory AS subCategory5, bt.top5Comment5, bn.goreaboardNo " +
            "FROM BestTop5 bt " +
            "JOIN User u ON bt.userSeq = u.userSeq " +
            "LEFT JOIN TrendSeoul ts1 ON bt.seoulSeq1 = ts1.seoulSeq " +
            "LEFT JOIN TrendSeoul ts2 ON bt.seoulSeq2 = ts2.seoulSeq " +
            "LEFT JOIN TrendSeoul ts3 ON bt.seoulSeq3 = ts3.seoulSeq " +
            "LEFT JOIN TrendSeoul ts4 ON bt.seoulSeq4 = ts4.seoulSeq " +
            "LEFT JOIN TrendSeoul ts5 ON bt.seoulSeq5 = ts5.seoulSeq " +
            "LEFT JOIN CategoryNo cn1 ON ts1.seoulcategoryNo = cn1.categoryNo " +
            "LEFT JOIN CategoryNo cn2 ON ts2.seoulcategoryNo = cn2.categoryNo " +
            "LEFT JOIN CategoryNo cn3 ON ts3.seoulcategoryNo = cn3.categoryNo " +
            "LEFT JOIN CategoryNo cn4 ON ts4.seoulcategoryNo = cn4.categoryNo " +
            "LEFT JOIN CategoryNo cn5 ON ts5.seoulcategoryNo = cn5.categoryNo " +
            "LEFT JOIN BoardNo bn ON bt.top5boardNo = bn.goreaboardNo " +
            "WHERE top5Seq = #{top5Seq}")
    Gorea_BEST5_ListTO bestTop5_View(Gorea_BEST5_ListTO to);
    
}
