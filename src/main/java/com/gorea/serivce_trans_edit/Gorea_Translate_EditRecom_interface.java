package com.gorea.serivce_trans_edit;

import java.util.List;

import com.gorea.dto_board.Gorea_EditRecommend_BoardTO;
import com.gorea.dto_board.Gorea_EditTip_BoardTO;

public interface Gorea_Translate_EditRecom_interface {
	
	public List<Gorea_EditRecommend_BoardTO> editrecom_List_KO(int offset, int pageSize);
	public List<Gorea_EditRecommend_BoardTO> editrecom_List_EN(int offset, int pageSize);
	public List<Gorea_EditRecommend_BoardTO> editrecom_List_JP(int offset, int pageSize);
	public List<Gorea_EditRecommend_BoardTO> editrecom_List_CHN(int offset, int pageSize);
	
	public List<Gorea_EditRecommend_BoardTO> editrecom_List_SearchKO(String searchType, String searchKeyword, int offset, int pageSize);
	public List<Gorea_EditRecommend_BoardTO> editrecom_List_SearchEN(String searchType, String searchKeyword, int offset, int pageSize);
	public List<Gorea_EditRecommend_BoardTO> editrecom_List_SearchJP(String searchType, String searchKeyword, int offset, int pageSize);
	public List<Gorea_EditRecommend_BoardTO> editrecom_List_SearchCHN(String searchType, String searchKeyword, int offset, int pageSize);

	public Gorea_EditRecommend_BoardTO editrecom_View_KO(Gorea_EditRecommend_BoardTO to);
	public Gorea_EditRecommend_BoardTO editrecom_View_EN(Gorea_EditRecommend_BoardTO to);
	public Gorea_EditRecommend_BoardTO editrecom_View_JP(Gorea_EditRecommend_BoardTO to);
	public Gorea_EditRecommend_BoardTO editrecom_View_CHN(Gorea_EditRecommend_BoardTO to);
	
	public List<Gorea_EditTip_BoardTO> editTip_List_KO(int offset, int pageSize);
	public List<Gorea_EditTip_BoardTO> editTip_List_EN(int offset, int pageSize);
	public List<Gorea_EditTip_BoardTO> editTip_List_JP(int offset, int pageSize);
	public List<Gorea_EditTip_BoardTO> editTip_List_CHN(int offset, int pageSize);
	
	public List<Gorea_EditTip_BoardTO> editTip_List_SearchKO(String searchType, String searchKeyword, int offset, int pageSize);
	public List<Gorea_EditTip_BoardTO> editTip_List_SearchEN(String searchType, String searchKeyword, int offset, int pageSize);
	public List<Gorea_EditTip_BoardTO> editTip_List_SearchJP(String searchType, String searchKeyword, int offset, int pageSize);
	public List<Gorea_EditTip_BoardTO> editTip_List_SearchCHN(String searchType, String searchKeyword, int offset, int pageSize);

	public Gorea_EditTip_BoardTO editTip_View_KO(Gorea_EditTip_BoardTO to);
	public Gorea_EditTip_BoardTO editTip_View_EN(Gorea_EditTip_BoardTO to);
	public Gorea_EditTip_BoardTO editTip_View_JP(Gorea_EditTip_BoardTO to);
	public Gorea_EditTip_BoardTO editTip_View_CHN(Gorea_EditTip_BoardTO to);
}
