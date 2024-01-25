package com.gorea.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.gorea.dto_board.Gorea_EditRecommend_BoardTO;
import com.gorea.dto_board.Gorea_TrendSeoul_BoardTO;
import com.gorea.dto_board.Gorea_TrendSeoul_ListTO;
import com.gorea.dto_reply.Gorea_TrendSeoul_ReplyTO;


@Mapper
public interface TrendMapperInter {
	
	// trend_seoul
	   @Select("select ts.userSeq, ts.seoulSeq, ts.seoulTitle, ts.seoulLocGu, ts.seoulContent, date_format(ts.seoulpostDate, '%Y.%m.%d') as seoulpostDate, ts.seoulScore, cn.mainCategory, cn.subCategory from TrendSeoul ts JOIN CategoryNo cn ON ts.seoulcategoryNo = cn.categoryNo order by seoulSeq asc LIMIT #{firstRow}, #{pageSize}")
	   List<Gorea_TrendSeoul_ListTO> trendSeoul_List(@Param("firstRow") int firstRow, @Param("pageSize") int pageSize);
	
	 @Select("SELECT COUNT(*) FROM TrendSeoul")
	 int get_trendSeoulTotalCount();
	
	// trend_seoul_WriteOk
	// rank -> 일단 값이 없어서 1로 고정시켜서 넣어놓음
	@Insert("insert into TrendSeoul values (0, #{userSeq}, 7, #{seoulcategoryNo}, 1, #{seoulTitle}, #{seoulsubTitle}, now(), 0, #{seoulContent}, #{seoulLoc}, #{seoulLocGu}, #{seoulSite}, #{seoulusageTime}, #{seoulusageFee}, #{seoulTrafficinfo}, #{seoulNotice}, 0)")
	int trendSeoul_Write_Ok(Gorea_TrendSeoul_BoardTO to);
	
	// trend_view
	@Update("update TrendSeoul set seoulHit=seoulHit+1 where seoulSeq=#{seoulSeq}")
	int TrendHit(Gorea_TrendSeoul_BoardTO to);
	
	@Select("SELECT ts.seoulSeq, ts.seoulboardNo, ts.seoulcategoryNo, ts.seoulRank, ts.seoulTitle, ts.seoulsubTitle, ts.seoulpostDate, ts.seoulHit, ts.seoulContent, ts.seoulLoc, ts.seoulLocGu, ts.seoulSite, ts.seoulusageTime, ts.seoulusageFee, ts.seoulTrafficinfo, ts.seoulNotice, ts.seoulScore, bn.goreaboardName, cn.mainCategory, cn.subCategory, date_format(ts.seoulpostDate, '%Y.%m.%d') seoulpostDate, datediff(now(), ts.seoulpostDate) FROM TrendSeoul ts JOIN BoardNo bn ON ts.seoulboardNo = bn.goreaboardNo JOIN CategoryNo cn ON ts.seoulcategoryNo = cn.categoryNo WHERE ts.seoulSeq=#{seoulSeq}")
	Gorea_TrendSeoul_BoardTO trendSeoul_View(Gorea_TrendSeoul_BoardTO to);

	// trend_Modify
	@Select("select seoulTitle, seoulsubTitle, seoulContent, seoulLoc, seoulLocGu, seoulSite, seoulusageTime, seoulusageFee, seoulTrafficinfo, seoulNotice from TrendSeoul where seoulSeq=#{seoulSeq}")
	Gorea_TrendSeoul_BoardTO trendSeoul_Modify(Gorea_TrendSeoul_BoardTO to);
	
	// trend_modify_ok
	@Update("update TrendSeoul set seoulTitle=#{seoulTitle}, seoulsubTitle=#{seoulsubTitle}, seoulContent=#{seoulContent}, seoulLoc=#{seoulLoc}, seoulLocGu=#{seoulLocGu}, seoulSite=#{seoulSite}, seoulusageTime=#{seoulusageTime}, seoulusageFee=#{seoulusageFee}, seoulTrafficinfo=#{seoulTrafficinfo}, seoulNotice=#{seoulNotice} where seoulSeq=#{seoulSeq}")
	int trendSeoul_Modify_Ok(Gorea_TrendSeoul_BoardTO to);
	
	// trend_delete_ok
	@Delete("delete from TrendSeoul where seoulSeq=#{seoulSeq}")
	int trendSeoul_Delete_Ok(Gorea_TrendSeoul_BoardTO to);
	
	// ReviewList
	@Select("SELECT tr.seoulSeq, tr.seoulReviewSeq, tr.userSeq, tr.comment, tr.seoulScore, DATE_FORMAT(tr.reviewDate, '%Y.%m.%d') AS reviewDate, u.userNickname AS userNickname " +
	        "FROM TrendReview tr " +
	        "JOIN User u ON tr.userSeq = u.userSeq " +
	        "WHERE tr.seoulSeq=#{seoulSeq} " +
	        "ORDER BY tr.seoulReviewSeq DESC")
	List<Gorea_TrendSeoul_ReplyTO> ReviewList(String seoulSeq);
	
	// ReviewWrite_Ok
	@Insert("insert into TrendReview values (0, #{userSeq}, #{seoulSeq}, #{comment}, #{seoulScore}, now() )")
	int trendSeoul_Review(Gorea_TrendSeoul_ReplyTO rto);
	
	@Update("UPDATE TrendSeoul "
	        + "SET seoulScore = ("
	        + "    SELECT CASE WHEN COUNT(*) > 0 THEN IFNULL(SUM(seoulScore), 0) / COUNT(*) ELSE 0 END "
	        + "    FROM TrendReview "
	        + "    WHERE seoulSeq = #{rto.seoulSeq})"
	        + "WHERE seoulSeq = #{rto.seoulSeq}")
	int updateScore(@Param("rto") Gorea_TrendSeoul_ReplyTO rto);
	
	// ReviewModify
	@Select("SELECT seoulReviewSeq, userSeq, comment, seoulScore FROM TrendReview WHERE seoulReviewSeq = #{seoulReviewSeq} AND userSeq = #{userSeq}")
	Gorea_TrendSeoul_ReplyTO ReviewModify(Gorea_TrendSeoul_ReplyTO rto);

	// RevieqModify_Ok
	@Update("update TrendReview set comment=#{comment}, seoulScore=#{seoulScore} where seoulReviewSeq=#{seoulReviewSeq}")
	int ReviewModify_Ok(Gorea_TrendSeoul_ReplyTO rto);
	
	// ReviewDelete
	@Delete("delete from TrendReview where seoulReviewSeq=#{seoulReviewSeq}")
	int ReviewDelete(Gorea_TrendSeoul_ReplyTO rto);
	
	@Select("<script>" +
	        "SELECT ts.userSeq, ts.seoulSeq, ts.seoulTitle, ts.seoulLocGu, ts.seoulContent, ts.seoulScore, cn.mainCategory, cn.subCategory " +
	        "FROM TrendSeoul ts " +
	        "JOIN CategoryNo cn ON ts.seoulcategoryNo = cn.categoryNo " +
	        "WHERE " +
	        "<if test='seoulLocGu != null'> ts.seoulLocGu = #{seoulLocGu} </if>" +
	        "<if test='mainCategory != null'> OR cn.mainCategory = #{mainCategory} </if>" +
	        "<if test='subCategory != null'> OR cn.subCategory = #{subCategory} </if>" +
	        "ORDER BY ts.seoulSeq ASC " +
	        "LIMIT #{firstRow}, #{pageSize}" +
	        "</script>")
	List<Gorea_TrendSeoul_ListTO> trendSeoul_searchList(
	        @Param("seoulLocGu") String seoulLocGu,
	        @Param("mainCategory") String mainCategory,
	        @Param("subCategory") String subCategory,
	        @Param("firstRow") int firstRow,
	        @Param("pageSize") int pageSize);

	@Select("<script>" +
	        "SELECT COUNT(*) FROM TrendSeoul ts " +
	        "JOIN CategoryNo cn ON ts.seoulcategoryNo = cn.categoryNo " +
	        "WHERE " +
	        "<if test='seoulLocGu != null'> ts.seoulLocGu = #{seoulLocGu} </if>" +
	        "<if test='mainCategory != null'> OR cn.mainCategory = #{mainCategory} </if>" +
	        "<if test='subCategory != null'> OR cn.subCategory = #{subCategory} </if>" +
	        "</script>")
	int trendSeoul_searchListCount(
	        @Param("seoulLocGu") String seoulLocGu,
	        @Param("mainCategory") String mainCategory,
	        @Param("subCategory") String subCategory);


	// Admin List
	   @Select("<script>"
	           + "SELECT ts.userSeq, ts.seoulSeq, ts.seoulTitle, date_format(seoulpostDate, '%Y.%m.%d') as seoulpostDate, ts.seoulLocGu, ts.seoulContent, ts.seoulScore, cn.mainCategory, cn.subCategory "
	           + "FROM TrendSeoul ts JOIN CategoryNo cn ON ts.seoulcategoryNo = cn.categoryNo "
	           + "<where>"
	           + "  <if test='searchType != null and searchKeyword != null'>"
	           + "    <choose>"
	           + "      <when test='searchType.equals(\"title\")'>"
	           + "        AND ts.seoulTitle LIKE CONCAT('%', #{searchKeyword}, '%')"
	           + "      </when>"
	           + "      <when test='searchType.equals(\"titleContent\")'>"
	           + "        AND (ts.seoulTitle LIKE CONCAT('%', #{searchKeyword}, '%') OR ts.seoulContent LIKE CONCAT('%', #{searchKeyword}, '%'))"
	           + "      </when>"
	           + "    </choose>"
	           + "  </if>"
	           + "</where>"
	           + "ORDER BY ts.seoulSeq ASC LIMIT #{firstRow}, #{pageSize}"
	           + "</script>")
	   List<Gorea_TrendSeoul_ListTO> adminSearchTrend_List(@Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword,
	                                                  @Param("firstRow") int firstRow, @Param("pageSize") int pageSize);
	   
	   @Select("<script>"
	           + "SELECT COUNT(*) "
	           + "FROM TrendSeoul ts JOIN CategoryNo cn ON ts.seoulcategoryNo = cn.categoryNo "
	           + "<where>"
	           + "  <if test='searchType != null and searchKeyword != null'>"
	           + "    <choose>"
	           + "      <when test='searchType.equals(\"title\")'>"
	           + "        AND ts.seoulTitle LIKE CONCAT('%', #{searchKeyword}, '%')"
	           + "      </when>"
	           + "      <when test='searchType.equals(\"titleContent\")'>"
	           + "        AND (ts.seoulTitle LIKE CONCAT('%', #{searchKeyword}, '%') OR ts.seoulContent LIKE CONCAT('%', #{searchKeyword}, '%'))"
	           + "      </when>"
	           + "    </choose>"
	           + "  </if>"
	           + "</where>"
	           + "</script>")
	   int adminSearchTotalCount(@Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);
	   
	   // 이전 글 가져오기
	    @Select("SELECT * FROM TrendSeoul WHERE seoulSeq < #{seoulSeq} ORDER BY seoulSeq DESC LIMIT 1")
	    Gorea_TrendSeoul_BoardTO  getPreviousPost(int seoulSeq);

	    // 다음 글 가져오기
	    @Select("SELECT * FROM TrendSeoul WHERE seoulSeq > #{seoulSeq} ORDER BY seoulSeq ASC LIMIT 1")
	    Gorea_TrendSeoul_BoardTO getNextPost(int seoulSeq);
	
}
