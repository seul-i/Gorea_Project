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
import com.gorea.repository_contents.Gorea_FreeBoardDAO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class Gorea_Admin_FreeBoard_Controller {
	
	@Autowired
	private Gorea_FreeBoardDAO dao;
	
	@GetMapping("/adminfreeboard.do")
	public String list(@PathVariable String language, 
			           @RequestParam(value = "searchType", required = false) String searchType,
			           @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
			           HttpServletRequest request, Model model, 
			           @RequestParam(defaultValue = "1") int cpage,
			           @RequestParam(defaultValue = "20") int pageSize) {
		System.out.println("list 호출 성공");
		
		cpage = (cpage <= 0) ? 1 : cpage;
	    int offset = (cpage - 1) * pageSize;
	    List<Gorea_Free_BoardTO> lists = new ArrayList<Gorea_Free_BoardTO>();
	    int totalRowCount = 0;

	    if(language.equals("korean")) {
	    	if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
	    		lists = dao.searchFree(searchType, searchKeyword, offset, pageSize);
	    		totalRowCount = dao.getSearchTotalRowCount(searchType, searchKeyword);
	    	} else {
	    		lists = dao.free_List(offset, pageSize);
	    		totalRowCount = dao.getTotalRowCount();
	    	}
	    }else if(language.equals("english")) {
	    	if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
		        lists = dao.searchFree(searchType, searchKeyword, offset, pageSize);
		        totalRowCount = dao.getSearchTotalRowCount(searchType, searchKeyword);
		    } else {
		        lists = dao.free_List(offset, pageSize);
		        totalRowCount = dao.getTotalRowCount();
		    }
	    }else if(language.equals("japanese")) {
	    	if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
		        lists = dao.searchFree(searchType, searchKeyword, offset, pageSize);
		        totalRowCount = dao.getSearchTotalRowCount(searchType, searchKeyword);
		    } else {
		        lists = dao.free_List(offset, pageSize);
		        totalRowCount = dao.getTotalRowCount();
		    }
	    }else if(language.equals("chinese")) {
	    	if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
		        lists = dao.searchFree(searchType, searchKeyword, offset, pageSize);
		        totalRowCount = dao.getSearchTotalRowCount(searchType, searchKeyword);
		    } else {
		        lists = dao.free_List(offset, pageSize);
		        totalRowCount = dao.getTotalRowCount();
		    }
	    }
	    
	    Gorea_CumuPagingTO paging = createPagingModel(totalRowCount, cpage, pageSize);
	    
	    model.addAttribute("paging", paging);
	    model.addAttribute("lists", lists);
	    model.addAttribute("language", language);

	    List<Integer> pageNumbers = new ArrayList<>();
	    for (int i = paging.getFirstPage(); i <= paging.getLastPage(); i++) {
	        pageNumbers.add(i);
	    }
	    model.addAttribute("pageNumbers", pageNumbers);
			
		return null;
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
