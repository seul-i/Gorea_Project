package com.gorea.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.gorea.dto_board.Gorea_TrendSeoul_ListTO;

@Mapper
public interface Top5MapperInter {
	
	@Select("select ts.userSeq, ts.seoulSeq, ts.seoulTitle, ts.seoulLocGu, ts.seoulContent, ts.seoulScore, cn.mainCategory, cn.subCategory from trendseoul ts JOIN CategoryNo cn ON ts.seoulcategoryNo = cn.categoryNo order by seoulSeq asc")
	List<Gorea_TrendSeoul_ListTO> trendSeoul_List();

}
