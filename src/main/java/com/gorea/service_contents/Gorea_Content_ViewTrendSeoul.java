package com.gorea.service_contents;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gorea.dto_board.Gorea_TrendSeoul_BoardTO;
import com.gorea.dto_board.Gorea_TrendSeoul_ListTO;
import com.gorea.repository_contents.Gorea_TrendSeoulDAO;

@Service
public class Gorea_Content_ViewTrendSeoul implements Gorea_Content_ViewTranslation {
	
	@Autowired
	private Gorea_TrendSeoulDAO gorea_TrendSeoulDAO;
	
	@Autowired
    private Gorea_TrendSeoul_ViewTranslation translation;

	@Override
	public Gorea_TrendSeoul_BoardTO trendSeoul_View_EN(Gorea_TrendSeoul_BoardTO to) {
		
		Gorea_TrendSeoul_BoardTO boardView_en = gorea_TrendSeoulDAO.trendSeoul_View(to);
		
		Gorea_TrendSeoul_BoardTO translatedView = translation.translateBoardView(boardView_en, "en");

		return translatedView;
	}

	@Override
	public Gorea_TrendSeoul_BoardTO trendSeoul_View_JP(Gorea_TrendSeoul_BoardTO to) {
		
		Gorea_TrendSeoul_BoardTO boardView_jp = gorea_TrendSeoulDAO.trendSeoul_View(to);
		
		Gorea_TrendSeoul_BoardTO translatedView = translation.translateBoardView(boardView_jp, "ja");

		return translatedView;
	}

	@Override
	public Gorea_TrendSeoul_BoardTO trendSeoul_View_CHN(Gorea_TrendSeoul_BoardTO to) {
		
		Gorea_TrendSeoul_BoardTO boardView_chn = gorea_TrendSeoulDAO.trendSeoul_View(to);
		
		Gorea_TrendSeoul_BoardTO translatedView = translation.translateBoardView(boardView_chn, "zh-CN");

		return translatedView;
	}

}
