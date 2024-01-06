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
	@Select("select seoulSeq, seoulTitle, seoulsubTitle, seoulContent from trendseoul order by seoulSeq desc")
	ArrayList<Gorea_TrendSeoul_BoardTO> trendSeoul_List(); 
	
	// trend_seoul_WriteOk
	// rank -> 일단 값이 없어서 1로 고정시켜서 넣어놓음
	// userSeq는 db에서 일단 빼놨음
	@Insert("insert into trendseoul values (0, 7, #{seoulcategoryNo}, 1, #{seoulTitle}, #{seoulsubTitle}, now(), 0, #{seoulContent}, #{seoulLoc}, #{seoulLocGu}, #{seoulSite}, #{seoulusageTime}, #{seoulusageFee}, #{seoulTrafficinfo}, #{seoulNotice}, 0)")
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
}
