package com.gorea.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.gorea.dto_board.Gorea_TrendSeoul_ListTO;
import com.gorea.dto_board.Gorea_TrendSeoul_SearchTO;

@Mapper
public interface Top5MapperInter {
	
	@Select("select ts.seoulSeq, ts.seoulTitle, ts.seoulLocGu, ts.seoulContent, cn.mainCategory, cn.subCategory from trendseoul ts JOIN CategoryNo cn ON ts.seoulcategoryNo = cn.categoryNo order by seoulSeq asc")
	List<Gorea_TrendSeoul_ListTO> trendSeoul_List();
	
	@Select("select ts.seoulSeq, ts.seoulTitle, ts.seoulLocGu, ts.seoulContent, cn.mainCategory, cn.subCategory " +
	        "from trendseoul ts " +
	        "join CategoryNo cn on ts.seoulcategoryNo = cn.categoryNo " +
	        "where ts.seoulLocGu = #{locGu} and cn.mainCategory = #{mainCategory} and cn.subCategory = #{subCategory} " +
	        "order by ts.seoulSeq asc")
	List<Gorea_TrendSeoul_ListTO> trendSeoul_searchList(String locGu, String mainCategory, String subCategory);

	
	@Select("select distinct seoulLocGu from trendseoul order by seoulSeq asc")
	List<Gorea_TrendSeoul_SearchTO> search_locGu();
	
	@Select("select distinct mainCategory from CategoryNo")
	List<Gorea_TrendSeoul_SearchTO> search_mainCategroy();
	
	@Select("select subCategory from CategoryNo where mainCategory = #{mainCategory}")
	List<Gorea_TrendSeoul_SearchTO> search_subCategroy(String mainCategory);

}
