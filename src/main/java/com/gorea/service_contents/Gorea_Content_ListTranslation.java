package com.gorea.service_contents;

import java.util.List;

import com.gorea.dto_board.Gorea_TrendSeoul_ListTO;

public interface Gorea_Content_ListTranslation {
	
	public List<Gorea_TrendSeoul_ListTO> trendSeoul_List_EN(int offset, int pageSize);
	public List<Gorea_TrendSeoul_ListTO> trendSeoul_List_JP(int offset, int pageSize);
	public List<Gorea_TrendSeoul_ListTO> trendSeoul_List_CHN(int offset, int pageSize);
	
}
