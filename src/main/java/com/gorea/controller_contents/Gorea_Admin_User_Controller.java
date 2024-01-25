package com.gorea.controller_contents;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gorea.dto_board.Gorea_CumuPagingTO;
import com.gorea.dto_board.Gorea_Notice_BoardTO;
import com.gorea.dto_user.Gorea_UserTO;
import com.gorea.repository_contents.Gorea_AdminDAO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class Gorea_Admin_User_Controller {
	
	@Autowired
	private Gorea_AdminDAO userDao;
	
	@GetMapping("/adminUserList.do")
	public String userList(@RequestParam(value = "searchType", required = false) String searchType,
					            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
					            HttpServletRequest request, Model model, 
					            @RequestParam(defaultValue = "1") int cpage,
					            @RequestParam(defaultValue = "20") int pageSize) {
		
		cpage = (cpage <= 0) ? 1 : cpage;
	    int offset = (cpage - 1) * pageSize;
	    
	    List<Gorea_UserTO> lists = new ArrayList<Gorea_UserTO>();
	    
	    int totalRowCount = 0;
	    
	    if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
    		lists = userDao.adminSearchUserList(searchType, searchKeyword, offset, pageSize);
    		totalRowCount = userDao.adminUserTotalCount(searchType, searchKeyword);
    	} else {
    		lists = userDao.userList(offset, pageSize);
    		totalRowCount = userDao.getTotalRowCount();
    		
    	}
		Gorea_CumuPagingTO paging = createPagingModel(totalRowCount, cpage, pageSize);
    	
	    model.addAttribute("paging", paging);
	    model.addAttribute("lists", lists);

	    List<Integer> pageNumbers = new ArrayList<>();
	    for (int i = paging.getFirstPage(); i <= paging.getLastPage(); i++) {
	        pageNumbers.add(i);
	    }
	    model.addAttribute("pageNumbers", pageNumbers);
	    
		return "admin/userList/gorea_user_List";
	}
	
	@GetMapping("/adminUser_delete_ok.do")
	public String delete_ok(@RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, HttpServletRequest request, Model model) {
		
		int flag = 1;
		
		Gorea_UserTO uto = new Gorea_UserTO();
		
		uto.setUserSeq(Long.parseLong(request.getParameter("userSeq")));
		
		flag = userDao.user_Delete_Ok(uto);
	     
		model.addAttribute("flag", flag);
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "admin/userList/gorea_user_delete_ok";
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
