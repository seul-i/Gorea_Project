package com.gorea.service_contents;

import java.util.List;

import com.gorea.dto_board.Gorea_Recommend_BoardTO;

public interface Gorea_Content_ListTranslationG {

	public List<Gorea_Recommend_BoardTO> userRecommend_List_KO( int offset, int pageSize );
	public List<Gorea_Recommend_BoardTO> userRecommend_List_EN( int offset, int pageSize );
	public List<Gorea_Recommend_BoardTO> userRecommend_List_JP( int offset, int pageSize );
	public List<Gorea_Recommend_BoardTO> userRecommend_List_CHN( int offset, int pageSize );
}
