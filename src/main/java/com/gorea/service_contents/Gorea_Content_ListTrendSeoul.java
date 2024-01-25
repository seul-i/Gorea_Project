package com.gorea.service_contents;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.gorea.dto_board.Gorea_TrendSeoul_ListTO;
import com.gorea.repository_contents.Gorea_TrendSeoulDAO;

@Service
public class Gorea_Content_ListTrendSeoul implements Gorea_Content_ListTranslation {
	
	@Autowired
	private Gorea_TrendSeoulDAO gorea_TrendSeoulDAO;
	
	@Autowired
    private Gorea_TrendSeoul_ListTranslation translation;
	
	@Override
	public List<Gorea_TrendSeoul_ListTO> trendSeoul_List_KO(int offset, int pageSize) {
		
		List<Gorea_TrendSeoul_ListTO> boardList = gorea_TrendSeoulDAO.trendSeoul_List(offset, pageSize);

		return boardList;
	}
	
	@Override
	public List<Gorea_TrendSeoul_ListTO> trendSeoul_List_EN(int offset, int pageSize) {
		
		List<Gorea_TrendSeoul_ListTO> boardList = gorea_TrendSeoulDAO.trendSeoul_List(offset, pageSize);
		
		List<Gorea_TrendSeoul_ListTO> translatedList = translation.translateBoardList(boardList, "en");

		return translatedList;
	}
	
	@Override
	public List<Gorea_TrendSeoul_ListTO> trendSeoul_List_JP(int offset, int pageSize) {
		
		List<Gorea_TrendSeoul_ListTO> boardList_jp = gorea_TrendSeoulDAO.trendSeoul_List(offset, pageSize);
		
		List<Gorea_TrendSeoul_ListTO> translatedList = translation.translateBoardList(boardList_jp, "ja");
		
		return translatedList;
	}
	
	@Override
	public List<Gorea_TrendSeoul_ListTO> trendSeoul_List_CHN(int offset, int pageSize) {
		
		List<Gorea_TrendSeoul_ListTO> boardList_chn = gorea_TrendSeoulDAO.trendSeoul_List(offset, pageSize);
		
		List<Gorea_TrendSeoul_ListTO> translatedList = translation.translateBoardList(boardList_chn, "zh-CN");
		
		return translatedList;
	}
	
	@Override
	public List<Gorea_TrendSeoul_ListTO> trendSeoul_SearchList_KO(int offset, int pageSize , String seoulLocGu, String mainCategory, String subCategory){
		
		List<Gorea_TrendSeoul_ListTO> boardList = gorea_TrendSeoulDAO.trendSeoul_searchList(offset,pageSize,seoulLocGu,mainCategory,subCategory);

		return boardList;
	}
	
	@Override
	public List<Gorea_TrendSeoul_ListTO> trendSeoul_SearchList_EN(int offset, int pageSize , String seoulLocGu, String mainCategory, String subCategory){
		
		List<Gorea_TrendSeoul_ListTO> boardList = gorea_TrendSeoulDAO.trendSeoul_searchList(offset,pageSize,seoulLocGu,mainCategory,subCategory);
		
		List<Gorea_TrendSeoul_ListTO> translatedList = translation.translateBoardList(boardList, "en");

		return translatedList;
	}
	
	@Override
	public List<Gorea_TrendSeoul_ListTO> trendSeoul_SearchList_JP(int offset, int pageSize , String seoulLocGu, String mainCategory, String subCategory){
		
		List<Gorea_TrendSeoul_ListTO> boardList_jp = gorea_TrendSeoulDAO.trendSeoul_searchList(offset,pageSize,seoulLocGu,mainCategory,subCategory);
		
		List<Gorea_TrendSeoul_ListTO> translatedList = translation.translateBoardList(boardList_jp, "ja");
		
		return translatedList;
	}
	
	@Override
	public List<Gorea_TrendSeoul_ListTO> trendSeoul_SearchList_CHN(int offset, int pageSize , String seoulLocGu, String mainCategory, String subCategory){
		
		List<Gorea_TrendSeoul_ListTO> boardList_chn = gorea_TrendSeoulDAO.trendSeoul_searchList(offset,pageSize,seoulLocGu,mainCategory,subCategory);
		
		List<Gorea_TrendSeoul_ListTO> translatedList = translation.translateBoardList(boardList_chn, "zh-CN");
		
		return translatedList;
	}

}
