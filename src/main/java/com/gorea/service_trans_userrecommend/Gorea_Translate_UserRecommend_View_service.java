package com.gorea.service_contents;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gorea.dto_board.Gorea_Recommend_BoardTO;
import com.gorea.repository_contents.Gorea_RecommendDAO;

@Service
public class Gorea_Content_ViewUserRecommend implements Gorea_Content_ViewTranslationG {

	@Autowired
	private Gorea_RecommendDAO gorea_UserRecomDAO;
	
	@Autowired
	private Gorea_UserRecommend_ViewTranslation translation;
	
	@Override
	public Gorea_Recommend_BoardTO userRecommend_View_EN(Gorea_Recommend_BoardTO to) {
		// TODO Auto-generated method stub
		
		Gorea_Recommend_BoardTO boardView_en = gorea_UserRecomDAO.userRecom_view(to);
		
		Gorea_Recommend_BoardTO translatedView = translation.translateBoardView(boardView_en, "en");
		
		return translatedView;
	}

	@Override
	public Gorea_Recommend_BoardTO userRecommend_View_JP(Gorea_Recommend_BoardTO to) {
		// TODO Auto-generated method stub
		Gorea_Recommend_BoardTO boardView_jp = gorea_UserRecomDAO.userRecom_view(to);
		
		Gorea_Recommend_BoardTO translatedView = translation.translateBoardView(boardView_jp, "ja");
		
		return translatedView;
	}

	@Override
	public Gorea_Recommend_BoardTO userRecommend_View_CHN(Gorea_Recommend_BoardTO to) {
		// TODO Auto-generated method stub
		Gorea_Recommend_BoardTO boardView_chn = gorea_UserRecomDAO.userRecom_view(to);
		
		Gorea_Recommend_BoardTO translatedView = translation.translateBoardView(boardView_chn, "zh-CN");
		
		return translatedView;
	}

}
