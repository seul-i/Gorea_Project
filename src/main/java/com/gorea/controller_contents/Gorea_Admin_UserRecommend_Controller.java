package com.gorea.controller_contents;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gorea.dto_board.Gorea_CumuPagingTO;
import com.gorea.dto_board.Gorea_Recommend_BoardTO;
import com.gorea.repository_contents.Gorea_RecommendDAO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class Gorea_Admin_UserRecommend_Controller {

	@Autowired
	Gorea_RecommendDAO dao;
	
	@GetMapping("/admin/adminuserRecom.do")
	public String list(@RequestParam(value = "searchType", required = false) String searchType,
	           @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
	           HttpServletRequest request, Model model, 
	           @RequestParam(defaultValue = "1") int cpage,
	           @RequestParam(defaultValue = "20") int pageSize) {
		System.out.println("list 호출 성공");
		
		cpage = (cpage <= 0) ? 1 : cpage;
	    int offset = (cpage - 1) * pageSize;
	    List<Gorea_Recommend_BoardTO> lists = new ArrayList<Gorea_Recommend_BoardTO>();
	    int totalRowCount = 0;

	    if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
    		lists = dao.searchUserRecom(searchType, searchKeyword, offset, pageSize);
    		totalRowCount = dao.getSearchTotalRowCount(searchType, searchKeyword);
    	} else {
    		lists = dao.userRecom_list(offset, pageSize);
    		totalRowCount = dao.getTotalRowCount();
    	}
	    
	    Gorea_CumuPagingTO paging = createPagingModel(totalRowCount, cpage, pageSize);
	    
	    model.addAttribute("paging", paging);
	    model.addAttribute("lists", lists);

	    List<Integer> pageNumbers = new ArrayList<>();
	    for (int i = paging.getFirstPage(); i <= paging.getLastPage(); i++) {
	        pageNumbers.add(i);
	    }
	    model.addAttribute("pageNumbers", pageNumbers);
			
		return "admin/userRecommend/gorea_adminuserRecom";
	}
	
	private Gorea_CumuPagingTO createPagingModel(int totalRowCount, int cpage, int pageSize) {
	    Gorea_CumuPagingTO paging = new Gorea_CumuPagingTO();
	    paging.setTotalRecord(totalRowCount);
	    paging.setCpage(cpage);
	    paging.setPageSize(pageSize);
	    paging.pageSetting();
	    return paging;
	}
}
