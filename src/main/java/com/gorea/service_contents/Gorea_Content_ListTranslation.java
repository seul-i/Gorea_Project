package com.gorea.service_contents;

import java.util.List;

import com.gorea.dto_board.Gorea_TrendSeoul_ListTO;

public interface Gorea_Content_Translation {
	
	public List<Gorea_TrendSeoul_ListTO> trendSeoul_List_EN();
	public List<Gorea_TrendSeoul_ListTO> trendSeoul_List_JP();
	public List<Gorea_TrendSeoul_ListTO> trendSeoul_List_CHN();
	
}
