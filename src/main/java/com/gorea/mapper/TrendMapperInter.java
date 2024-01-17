package com.gorea.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.gorea.dto_board.Gorea_TrendSeoul_BoardTO;
import com.gorea.dto_board.Gorea_TrendSeoul_ListTO;
import com.gorea.dto_reply.Gorea_TrendSeoul_ReplyTO;


@Mapper
public interface TrendMapperInter {
	
	// trend_seoul
	@Select("select ts.userSeq, ts.seoulSeq, ts.seoulTitle, ts.seoulLocGu, ts.seoulContent, ts.seoulScore, cn.mainCategory, cn.subCategory from trendseoul ts JOIN CategoryNo cn ON ts.seoulcategoryNo = cn.categoryNo order by seoulSeq asc LIMIT #{firstRow}, #{pageSize}")
	List<Gorea_TrendSeoul_ListTO> trendSeoul_List(@Param("firstRow") int firstRow, @Param("pageSize") int pageSize);
	
	 @Select("SELECT COUNT(*) FROM trendseoul")
	 int get_trendSeoulTotalCount();
	
	// trend_seoul_WriteOk
	// rank -> 일단 값이 없어서 1로 고정시켜서 넣어놓음
	@Insert("insert into trendseoul values (0, #{userSeq}, 7, #{seoulcategoryNo}, 1, #{seoulTitle}, #{seoulsubTitle}, now(), 0, #{seoulContent}, #{seoulLoc}, #{seoulLocGu}, #{seoulSite}, #{seoulusageTime}, #{seoulusageFee}, #{seoulTrafficinfo}, #{seoulNotice}, 0)")
	int trendSeoul_Write_Ok(Gorea_TrendSeoul_BoardTO to);
	
	// trend_view
	@Update("update trendseoul set seoulHit=seoulHit+1 where seoulSeq=#{seoulSeq}")
	int TrendHit(Gorea_TrendSeoul_BoardTO to);
	
	@Select("SELECT ts.seoulSeq, ts.seoulboardNo, ts.seoulcategoryNo, ts.seoulRank, ts.seoulTitle, ts.seoulsubTitle, ts.seoulpostDate, ts.seoulHit, ts.seoulContent, ts.seoulLoc, ts.seoulLocGu, ts.seoulSite, ts.seoulusageTime, ts.seoulusageFee, ts.seoulTrafficinfo, ts.seoulNotice, ts.seoulScore, bn.goreaboardName, cn.mainCategory, cn.subCategory, date_format(ts.seoulpostDate, '%Y.%m.%d') seoulpostDate, datediff(now(), ts.seoulpostDate) FROM TrendSeoul ts JOIN BoardNo bn ON ts.seoulboardNo = bn.goreaboardNo JOIN CategoryNo cn ON ts.seoulcategoryNo = cn.categoryNo WHERE ts.seoulSeq=#{seoulSeq}")
	Gorea_TrendSeoul_BoardTO trendSeoul_View(Gorea_TrendSeoul_BoardTO to);

	// trend_Modify
	@Select("select seoulTitle, seoulsubTitle, seoulContent, seoulLoc, seoulLocGu, seoulSite, seoulusageTime, seoulusageFee, seoulTrafficinfo, seoulNotice from trendseoul where seoulSeq=#{seoulSeq}")
	Gorea_TrendSeoul_BoardTO trendSeoul_Modify(Gorea_TrendSeoul_BoardTO to);
	
	// trend_modify_ok
	@Update("update trendseoul set seoulTitle=#{seoulTitle}, seoulsubTitle=#{seoulsubTitle}, seoulContent=#{seoulContent}, seoulLoc=#{seoulLoc}, seoulLocGu=#{seoulLocGu}, seoulSite=#{seoulSite}, seoulusageTime=#{seoulusageTime}, seoulusageFee=#{seoulusageFee}, seoulTrafficinfo=#{seoulTrafficinfo}, seoulNotice=#{seoulNotice} where seoulSeq=#{seoulSeq}")
	int trendSeoul_Modify_Ok(Gorea_TrendSeoul_BoardTO to);
	
	// trend_delete_ok
	@Delete("delete from trendseoul where seoulSeq=#{seoulSeq}")
	int trendSeoul_Delete_Ok(Gorea_TrendSeoul_BoardTO to);
	
	// ReviewList
	@Select("SELECT tr.seoulSeq, tr.seoulReviewSeq, tr.userSeq, tr.comment, tr.seoulScore, DATE_FORMAT(tr.reviewDate, '%Y.%m.%d') AS reviewDate, u.userNickname AS userNickname " +
	        "FROM trendreview tr " +
	        "JOIN user u ON tr.userSeq = u.userSeq " +
	        "WHERE tr.seoulSeq=#{seoulSeq} " +
	        "ORDER BY tr.seoulReviewSeq DESC")
	List<Gorea_TrendSeoul_ReplyTO> ReviewList(String seoulSeq);
	
	// ReviewWrite_Ok
	@Insert("insert into trendreview values (0, #{userSeq}, #{seoulSeq}, #{comment}, #{seoulScore}, now() )")
	int trendSeoul_Review(Gorea_TrendSeoul_ReplyTO rto);
	
	// ReviewModify
	@Select("SELECT seoulReviewSeq, userSeq, comment, seoulScore FROM trendreview WHERE seoulReviewSeq = #{seoulReviewSeq} AND userSeq = #{userSeq}")
	Gorea_TrendSeoul_ReplyTO ReviewModify(Gorea_TrendSeoul_ReplyTO rto);

	// RevieqModify_Ok
	@Update("update trendreview set comment=#{comment}, seoulScore=#{seoulScore} where seoulReviewSeq=#{seoulReviewSeq}")
	int ReviewModify_Ok(Gorea_TrendSeoul_ReplyTO rto);
	
	// ReviewDelete
	@Delete("delete from trendreview where seoulReviewSeq=#{seoulReviewSeq}")
	int ReviewDelete(String seoulReviewSeq);
	
}
