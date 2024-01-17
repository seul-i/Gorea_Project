package com.gorea.service_contents;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gorea.dto_board.Gorea_Recommend_BoardTO;
import com.gorea.repository_contents.Gorea_RecommendDAO;

@Service
public class Gorea_Content_ListUserRecommend implements Gorea_Content_ListTranslationG {
	
	@Autowired
	private Gorea_RecommendDAO gorea_UserRecomDAO;
	
	@Autowired
	private  Gorea_UserRecommend_ListTranslation translation;
	
	@Override
	public List<Gorea_Recommend_BoardTO> userRecommend_List_KO(int offset, int pageSize){
		
		List<Gorea_Recommend_BoardTO> boardList = gorea_UserRecomDAO.userRecom_list(offset, pageSize);
		
		return boardList;
	}
	
	@Override
	public List<Gorea_Recommend_BoardTO> userRecommend_List_EN(int offset, int pageSize){
		
		List<Gorea_Recommend_BoardTO> boardList = gorea_UserRecomDAO.userRecom_list(offset, pageSize);
		
		List<Gorea_Recommend_BoardTO> translatedList = translation.translateBoardList(boardList, "en");
		
		return translatedList;
	}
	
	@Override
	public List<Gorea_Recommend_BoardTO> userRecommend_List_JP(int offset, int pageSize){
		
		List<Gorea_Recommend_BoardTO> boardList_jp = gorea_UserRecomDAO.userRecom_list(offset, pageSize);
		
		List<Gorea_Recommend_BoardTO> translatedList = translation.translateBoardList(boardList_jp, "ja");
		
		return translatedList;
	}
	
	@Override
	public List<Gorea_Recommend_BoardTO> userRecommend_List_CHN(int offset, int pageSize){
		
		List<Gorea_Recommend_BoardTO> boardList_chn = gorea_UserRecomDAO.userRecom_list(offset, pageSize);
		
		List<Gorea_Recommend_BoardTO> translatedList = translation.translateBoardList(boardList_chn, "zh-CN");
		
		return translatedList;
	}
}
