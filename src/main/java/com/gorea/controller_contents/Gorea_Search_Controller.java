package com.gorea.controller_contents;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.gorea.dto_board.Gorea_CumuPagingTO;
import com.gorea.dto_board.Gorea_Free_BoardTO;
import com.gorea.dto_board.Gorea_SearchResultTO;
import com.gorea.repository_contents.Gorea_SearchDAO;

@Controller
public class Gorea_Search_Controller {

    @Autowired
    private Gorea_SearchDAO searchDAO;

    @GetMapping("/{language}/totalsearch.do")
    public String search(@PathVariable String language, @RequestParam(required = false) String keyword, 
                         @RequestParam(required = false) String boardType, Model model, @RequestParam(defaultValue = "1") int cpage,
  	                   @RequestParam(defaultValue = "20") int pageSize) {

    	cpage = (cpage <= 0) ? 1 : cpage;
	    int offset = (cpage - 1) * pageSize;
	    List<Gorea_SearchResultTO> lists = new ArrayList<Gorea_SearchResultTO>();
	    int totalRowCount = 0;
    	
        // 모든 게시판에 대한 검색 결과
	    if (boardType == null || boardType.equals("AllBoards")) {
	        totalRowCount = searchDAO.countTotalSearchResults(keyword);
	        lists = searchDAO.searchAllBoards(keyword, offset, pageSize);
	        model.addAttribute("boards", lists);
	        model.addAttribute("boardType", "AllBoards");
	    }
        // 자유게시판 검색 결과
        else if (boardType.equals("FreeBoard")) {
            totalRowCount = searchDAO.countFreeBoard(keyword);
            lists = searchDAO.searchFreeBoard(keyword, offset, pageSize);
            model.addAttribute("boards", lists);
            model.addAttribute("boardType", "FreeBoard");
        }
	 // 공지사항 검색 결과
        else if (boardType.equals("Notice")) {
            totalRowCount = searchDAO.countNotice(keyword);
            lists = searchDAO.searchNotice(keyword, offset, pageSize);
            model.addAttribute("boards", lists);
            model.addAttribute("boardType", "Notice");
        }
        // 에디터 팁 검색 결과
        else if (boardType.equals("EditTip")) {
            totalRowCount = searchDAO.countEditTip(keyword);
            lists = searchDAO.searchEditTip(keyword, offset, pageSize);
            model.addAttribute("boards", lists);
            model.addAttribute("boardType", "EditTip");
        }
        // 에디터 추천 검색 결과
        else if (boardType.equals("EditRecommend")) {
            totalRowCount = searchDAO.countEditRecommend(keyword);
            lists = searchDAO.searchEditRecommend(keyword, offset, pageSize);
            model.addAttribute("boards", lists);
            model.addAttribute("boardType", "EditRecommend");
        }
        // 트렌드 서울 검색 결과
        else if (boardType.equals("TrendSeoul")) {
            totalRowCount = searchDAO.countTrendSeoul(keyword);
            lists = searchDAO.searchTrendSeoul(keyword, offset, pageSize);
            model.addAttribute("boards", lists);
            model.addAttribute("boardType", "TrendSeoul");
        }
        // 기타 게시판에 대한 검색 처리 (예: EditTip, EditRecommend, TrendSeoul 등)
        
        Gorea_CumuPagingTO paging = createPagingModel(totalRowCount, cpage, pageSize);

        model.addAttribute("totalCount", searchDAO.countTotalSearchResults(keyword));
        model.addAttribute("freeBoardCount", searchDAO.countFreeBoard(keyword));
        model.addAttribute("noticeCount", searchDAO.countNotice(keyword));
        model.addAttribute("editTipCount", searchDAO.countEditTip(keyword));
        model.addAttribute("editRecommendCount", searchDAO.countEditRecommend(keyword));
        model.addAttribute("trendSeoulCount", searchDAO.countTrendSeoul(keyword));
        model.addAttribute("language", language);
        model.addAttribute("paging", paging);
        
        List<Integer> pageNumbers = new ArrayList<>();
	    for (int i = paging.getFirstPage(); i <= paging.getLastPage(); i++) {
	        pageNumbers.add(i);
	    }
	    model.addAttribute("pageNumbers", pageNumbers);

        return "contents/contents_search/search_list";
    }
    
 // 리스트 페이지 페이징 처리
 	private Gorea_CumuPagingTO createPagingModel(int totalRowCount, int cpage, int pageSize) {
 	    Gorea_CumuPagingTO paging = new Gorea_CumuPagingTO();
 	    paging.setTotalRecord(totalRowCount);
 	    paging.setCpage(cpage);
 	    paging.setPageSize(pageSize);
 	    paging.pageSetting();
 	    return paging;
 	}
}