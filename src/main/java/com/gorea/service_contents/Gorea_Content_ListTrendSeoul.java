package com.gorea.service_contents;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.gorea.dto_board.Gorea_TrendSeoul_ListTO;
import com.gorea.repository_contents.Gorea_TrendSeoulDAO;

@Service
public class Gorea_Content_TrendSeoul implements Gorea_Content_Translation {
	
	@Autowired
	private Gorea_TrendSeoulDAO gorea_TrendSeoulDAO;
	
	@Autowired
    private Gorea_TrendSeoul_Translation translation;
	
	@Override
	public List<Gorea_TrendSeoul_ListTO> trendSeoul_List_EN() {
		
		List<Gorea_TrendSeoul_ListTO> boardList = gorea_TrendSeoulDAO.trendSeoul_List();
		
		List<Gorea_TrendSeoul_ListTO> translatedList = translation.translateBoardList(boardList, "en");

		return translatedList;
	}
	
	@Override
	public List<Gorea_TrendSeoul_ListTO> trendSeoul_List_JP() {
		
		List<Gorea_TrendSeoul_ListTO> boardList_jp = gorea_TrendSeoulDAO.trendSeoul_List();
		
		return null;
	}
	
	@Override
	public List<Gorea_TrendSeoul_ListTO> trendSeoul_List_CHN() {
		
		List<Gorea_TrendSeoul_ListTO> boardList_chn = gorea_TrendSeoulDAO.trendSeoul_List();
		
		return null;
	}

}
