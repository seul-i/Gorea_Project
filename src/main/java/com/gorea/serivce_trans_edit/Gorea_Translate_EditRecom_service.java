package com.gorea.serivce_trans_edit;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gorea.dto_board.Gorea_EditRecommend_BoardTO;
import com.gorea.repository_contents.Gorea_EditrecoDAO;

@Service
public class Gorea_Translate_EditRecom_service implements Gorea_Translate_EditRecom_interface {
	
	@Autowired
	private Gorea_EditrecoDAO dao;
	
	@Autowired
    private Gorea_Translate_EditRecom translation;
	
	
	////////////////////////////////////////////////////////////////////////////////
	//	EditRecommed List //////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////
	@Override
	public List<Gorea_EditRecommend_BoardTO> editrecom_List_KO(int offset, int pageSize){
		
		List<Gorea_EditRecommend_BoardTO> boardList = dao.editRecommend_List(offset, pageSize);

		return boardList;
	}
	
	@Override
	public List<Gorea_EditRecommend_BoardTO> editrecom_List_EN(int offset, int pageSize){
		
		List<Gorea_EditRecommend_BoardTO> boardList_en = dao.editRecommend_List(offset, pageSize);
		
		List<Gorea_EditRecommend_BoardTO> translatedList = translation.translateBoardList(boardList_en, "en");

		return translatedList;
	}
	
	@Override
	public List<Gorea_EditRecommend_BoardTO> editrecom_List_JP(int offset, int pageSize){
		
		List<Gorea_EditRecommend_BoardTO> boardList_jp = dao.editRecommend_List(offset, pageSize);
		
		List<Gorea_EditRecommend_BoardTO> translatedList = translation.translateBoardList(boardList_jp, "ja");
		
		return translatedList;
	}
	
	@Override
	public List<Gorea_EditRecommend_BoardTO> editrecom_List_CHN(int offset, int pageSize){
		
		List<Gorea_EditRecommend_BoardTO> boardList_chn = dao.editRecommend_List(offset, pageSize);
		
		List<Gorea_EditRecommend_BoardTO> translatedList = translation.translateBoardList(boardList_chn, "zh-CN");
		
		return translatedList;
	}
	
	////////////////////////////////////////////////////////////////////////////////
	//	EditRecommed Search List ///////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////
	@Override
	public List<Gorea_EditRecommend_BoardTO> editrecom_List_SearchKO(String searchType, String searchKeyword, int offset, int pageSize){
		
		List<Gorea_EditRecommend_BoardTO> boardList = dao.editRecommend_serachList(searchType,searchKeyword,offset,pageSize);

		return boardList;
	}
	
	@Override
	public List<Gorea_EditRecommend_BoardTO> editrecom_List_SearchEN(String searchType, String searchKeyword, int offset, int pageSize){
		
		List<Gorea_EditRecommend_BoardTO> boardList_en = dao.editRecommend_serachList(searchType,searchKeyword,offset,pageSize);
		
		List<Gorea_EditRecommend_BoardTO> translatedList = translation.translateBoardList(boardList_en, "en");

		return translatedList;
	}
	
	@Override
	public List<Gorea_EditRecommend_BoardTO> editrecom_List_SearchJP(String searchType, String searchKeyword, int offset, int pageSize){
		
		List<Gorea_EditRecommend_BoardTO> boardList_jp = dao.editRecommend_serachList(searchType,searchKeyword,offset,pageSize);
		
		List<Gorea_EditRecommend_BoardTO> translatedList = translation.translateBoardList(boardList_jp, "ja");
		
		return translatedList;
	}
	
	@Override
	public List<Gorea_EditRecommend_BoardTO> editrecom_List_SearchCHN(String searchType, String searchKeyword, int offset, int pageSize){
		
		List<Gorea_EditRecommend_BoardTO> boardList_chn = dao.editRecommend_serachList(searchType,searchKeyword,offset,pageSize);
		
		List<Gorea_EditRecommend_BoardTO> translatedList = translation.translateBoardList(boardList_chn, "zh-CN");
		
		return translatedList;
	}
	
	////////////////////////////////////////////////////////////////////////////////
	//	EditRecommed List //////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////
	@Override
	public Gorea_EditRecommend_BoardTO editrecom_View_KO(Gorea_EditRecommend_BoardTO to){
	
		to = dao.editRecommend_View(to);
		
		return to;
	}
	
	@Override
	public Gorea_EditRecommend_BoardTO editrecom_View_EN(Gorea_EditRecommend_BoardTO to){
	
		Gorea_EditRecommend_BoardTO to_en = dao.editRecommend_View(to);
		
		Gorea_EditRecommend_BoardTO translatedTo = translation.translateBoardView(to_en, "en");
		
		return translatedTo;
	}
	
	@Override
	public Gorea_EditRecommend_BoardTO editrecom_View_JP(Gorea_EditRecommend_BoardTO to){
	
		Gorea_EditRecommend_BoardTO to_jp = dao.editRecommend_View(to);
		
		Gorea_EditRecommend_BoardTO translatedTo = translation.translateBoardView(to_jp, "ja");
		
		return translatedTo;
	}
	
	@Override
	public Gorea_EditRecommend_BoardTO editrecom_View_CHN(Gorea_EditRecommend_BoardTO to){
	
		Gorea_EditRecommend_BoardTO to_chn = dao.editRecommend_View(to);
		
		Gorea_EditRecommend_BoardTO translatedTo = translation.translateBoardView(to_chn, "zh-CN");
		
		return translatedTo;
	}

}
