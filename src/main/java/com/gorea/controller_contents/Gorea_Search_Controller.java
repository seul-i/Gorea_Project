package com.gorea.controller_contents;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.gorea.repository_contents.Gorea_SearchDAO;

@Controller
public class Gorea_Search_Controller {

    @Autowired
    private Gorea_SearchDAO searchDAO;

    @GetMapping("/{language}/totalsearch.do")
    public String search(@PathVariable String language, @RequestParam(required = false) String keyword, 
                         @RequestParam(required = false) String boardType, Model model) {

        // 모든 게시판에 대한 검색 결과
        if (boardType == null || boardType.equals("AllBoards")) {
            model.addAttribute("boards", searchDAO.searchAllBoards(keyword));
            model.addAttribute("boardType", "AllBoards");
        }
        // 자유게시판 검색 결과
        else if (boardType.equals("FreeBoard")) {
            model.addAttribute("boards", searchDAO.searchFreeBoard(keyword));
            model.addAttribute("boardType", "FreeBoard");
        }
        // 공지사항 검색 결과
        else if (boardType.equals("Notice")) {
            model.addAttribute("boards", searchDAO.searchNotice(keyword));
            model.addAttribute("boardType", "Notice");
        }
        // 에디터 팁 검색 결과
        else if (boardType.equals("EditTip")) {
            model.addAttribute("boards", searchDAO.searchEditTip(keyword));
            model.addAttribute("boardType", "EditTip");
        }
        // 에디터 추천 검색 결과
        else if (boardType.equals("EditRecommend")) {
            model.addAttribute("boards", searchDAO.searchEditRecommend(keyword));
            model.addAttribute("boardType", "EditRecommend");
        }
        else if (boardType.equals("TrendSeoul")) {
            model.addAttribute("boards", searchDAO.searchTrendSeoul(keyword));
            model.addAttribute("boardType", "TrendSeoul");
        }
        // 기타 게시판에 대한 검색 처리 (예: EditTip, EditRecommend, TrendSeoul 등)

        model.addAttribute("totalCount", searchDAO.countTotalSearchResults(keyword));
        model.addAttribute("freeBoardCount", searchDAO.countFreeBoard(keyword));
        model.addAttribute("noticeCount", searchDAO.countNotice(keyword));
        model.addAttribute("editTipCount", searchDAO.countEditTip(keyword));
        model.addAttribute("editRecommendCount", searchDAO.countEditRecommend(keyword));
        model.addAttribute("trendSeoulCount", searchDAO.countTrendSeoul(keyword));
        model.addAttribute("language", language);

        return "contents/contents_search/search_list";
    }
}