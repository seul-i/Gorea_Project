package com.gorea.controller_contents;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.gorea.dto_board.Gorea_CumuPagingTO;
import com.gorea.dto_board.Gorea_EditRecommend_BoardTO;
import com.gorea.dto_board.Gorea_TrendSeoul_BoardTO;
import com.gorea.repository_contents.Gorea_EditrecoDAO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class Gorea_Admin_EditRecomend_Controller {

	@Autowired
	private Gorea_EditrecoDAO editDao;
	
	@GetMapping("adminEditReco.do")
	public String list(@RequestParam(value = "searchType", required = false) String searchType,
				            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
				            HttpServletRequest request, Model model, 
				            @RequestParam(defaultValue = "1") int cpage,
				            @RequestParam(defaultValue = "20") int pageSize) {
		
		cpage = (cpage <= 0) ? 1 : cpage;
	    int offset = (cpage - 1) * pageSize;
	    
	    List<Gorea_EditRecommend_BoardTO> lists = new ArrayList<Gorea_EditRecommend_BoardTO>();
	    
	    int totalRowCount = 0;

    	if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
    		lists = editDao.editRecommend_serachList(searchType, searchKeyword, offset, pageSize);
    		totalRowCount = editDao.getSearchTotalRowCount(searchType, searchKeyword);
    	} else {
    		lists = editDao.editRecommend_List(offset, pageSize);
    		totalRowCount = editDao.getTotalRowCount();
    	}
    	
    	Gorea_CumuPagingTO paging = createPagingModel(totalRowCount, cpage, pageSize);
	    
	    model.addAttribute("paging", paging);
	    model.addAttribute("lists", lists);

	    List<Integer> pageNumbers = new ArrayList<>();
	    for (int i = paging.getFirstPage(); i <= paging.getLastPage(); i++) {
	        pageNumbers.add(i);
	    }
	    model.addAttribute("pageNumbers", pageNumbers);	
		
	    return "admin/editrecom/gorea_adminEditRecommend";
	}
	
	@GetMapping("/adminEditReco_write.do")
    public String gowrite(HttpServletRequest request, Model model) {
		return "admin/editrecom/gorea_adminEditRecommend_write";
    }
	
	@PostMapping("/adminEditReco_write_ok.do")
	public String write_ok(HttpServletRequest request, MultipartFile upload, Model model) {
		int flag = 2;
		
		Gorea_EditRecommend_BoardTO to = new Gorea_EditRecommend_BoardTO();
		
		to.setUserSeq(request.getParameter("userSeq"));
		to.setEditrecoSubject(request.getParameter("editrecoSubject"));
		to.setEditrecoSubtitle(request.getParameter("editrecoSubtitle"));
		to.setEditrecoContent(request.getParameter("editrecoContent"));
		to.setEditrecoWdate(request.getParameter("editrecoWdate"));
		
		flag = editDao.editRecommend_Write_Ok(to);
		
		model.addAttribute("flag", flag);
		
		return "admin/editrecom/gorea_adminEditRecommend_write_ok";
	}
	
	@GetMapping("/adminEditreco_view.do")
	public String view(@RequestParam("editrecoSeq") String editrecoSeqStr,
								@RequestParam(value = "cpage", required = false) String cpage,
								@RequestParam(value = "searchType", required = false) String searchType,
								@RequestParam(value = "searchKeyword", required = false) String searchKeyword,
								HttpServletRequest request, 
								Model model) {

			int editrecoSeq;
			try {
				editrecoSeq = Integer.parseInt(editrecoSeqStr.trim());
			} catch (NumberFormatException e) {
			// noticeSeq 파라미터가 유효하지 않을 때의 처리
			return "errorPage";
			}
			
			Gorea_EditRecommend_BoardTO to = new Gorea_EditRecommend_BoardTO();
			to.setEditrecoSeq(Integer.toString(editrecoSeq));
			
			Gorea_EditRecommend_BoardTO prevPost = editDao.getPreviousPost(editrecoSeq);
			Gorea_EditRecommend_BoardTO nextPost = editDao.getNextPost(editrecoSeq);

			
			to = editDao.editRecommend_View(to);
			
			model.addAttribute("to", to);
			to.setEditrecoSeq(request.getParameter("editrecoSeq"));
			
			return "admin/editrecom/gorea_adminEditRecommend_view";
		}
	
	@GetMapping("adminEditReco_modify.do")
	public String modiify(HttpServletRequest request, 
							@RequestParam(value = "cpage", required = false) String cpage,
				            @RequestParam(value = "searchType", required = false) String searchType,
				            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model) {
		
		Gorea_EditRecommend_BoardTO to = new Gorea_EditRecommend_BoardTO();
		to.setEditrecoSeq(request.getParameter("editrecoSeq"));
		to = editDao.editRecommend_Modify(to);
		
		
		model.addAttribute("to", to);
		model.addAttribute("editrecoSeq", to.getEditrecoSeq());
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "admin/editrecom/gorea_adminEditRecommend_modify";
	}
	
	@PostMapping("/adminEditReco_modify_ok.do")
	public String modify_ok(HttpServletRequest request, MultipartFile upload, 
								@RequestParam(value = "cpage", required = false) String cpage,
					            @RequestParam(value = "searchType", required = false) String searchType,
					            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model) {
		
		Gorea_EditRecommend_BoardTO to = new Gorea_EditRecommend_BoardTO();
		
		int flag = 1;
		to.setEditrecoSeq(request.getParameter("editrecoSeq"));
		to.setEditrecoSubject(request.getParameter("editrecoSubject"));
		to.setEditrecoSubtitle(request.getParameter("editrecoSubtitle"));
		to.setEditrecoContent(request.getParameter("editrecoContent"));
		
		flag = editDao.editRecommend_Modify_Ok(to);
		
		model.addAttribute("flag", flag);
		model.addAttribute("editrecoSeq", to.getEditrecoSeq());
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "admin/editrecom/gorea_adminEditRecommend_modify_ok";
	}
	
	@GetMapping("/adminEditReco_delete_ok.do")
	public String delete_ok(@RequestParam(value = "cpage", required = false) String cpage,
					            @RequestParam(value = "searchType", required = false) String searchType,
					            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, 
					            HttpServletRequest request, Model model) {
		
		int flag = 1;
		
		Gorea_EditRecommend_BoardTO to = new Gorea_EditRecommend_BoardTO();
		to.setEditrecoSeq(request.getParameter("editrecoSeq"));
		
		flag = editDao.editRecommend_Delete_Ok(to);
		
		model.addAttribute("flag", flag);
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "admin/editrecom/gorea_adminEditRecommend_delete_ok";
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
