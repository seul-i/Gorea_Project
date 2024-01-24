package com.gorea.controller_contents;

import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.safety.Safelist;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.gorea.dto_board.Gorea_CumuPagingTO;
import com.gorea.dto_board.Gorea_Free_BoardTO;
import com.gorea.dto_board.Gorea_Notice_BoardTO;
import com.gorea.repository_contents.Gorea_FreeBoardDAO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class Gorea_Admin_FreeBoard_Controller {
	
	@Autowired
	private Gorea_FreeBoardDAO dao;
	
	@GetMapping("/admin/adminfreeboard.do")
	public String list(@RequestParam(value = "searchType", required = false) String searchType,
			           @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
			           HttpServletRequest request, Model model, 
			           @RequestParam(defaultValue = "1") int cpage,
			           @RequestParam(defaultValue = "20") int pageSize) {
		System.out.println("list 호출 성공");
		
		cpage = (cpage <= 0) ? 1 : cpage;
	    int offset = (cpage - 1) * pageSize;
	    List<Gorea_Free_BoardTO> lists = new ArrayList<Gorea_Free_BoardTO>();
	    int totalRowCount = 0;

	    if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
    		lists = dao.searchFree(searchType, searchKeyword, offset, pageSize);
    		totalRowCount = dao.getSearchTotalRowCount(searchType, searchKeyword);
    	} else {
    		lists = dao.free_List(offset, pageSize);
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
			
		return "admin/freeboard/gorea_adminfreeboard";
	}
	
	private Gorea_CumuPagingTO createPagingModel(int totalRowCount, int cpage, int pageSize) {
	    Gorea_CumuPagingTO paging = new Gorea_CumuPagingTO();
	    paging.setTotalRecord(totalRowCount);
	    paging.setCpage(cpage);
	    paging.setPageSize(pageSize);
	    paging.pageSetting();
	    return paging;
	}
	
	@GetMapping("/admin/adminfreeboard_delete_ok.do")
	public String delete_ok(@RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, HttpServletRequest request, Model model) {
		
		int flag = 1;
		
		Gorea_Free_BoardTO to = new Gorea_Free_BoardTO();
		
		to.setFreeSeq(request.getParameter("freeSeq"));
		
		flag = dao.free_Delete_Ok(to);
	     
		model.addAttribute("flag", flag);
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "admin/freeboard/gorea_adminfreeboard_delete_ok";
	}
	
	@GetMapping("/admin/adminfreeboard_view.do")
	public String view(@RequestParam("freeSeq") String freeSeqStr, HttpServletRequest request, @RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model) {
		
		int freeSeq;
        try {
        	freeSeq = Integer.parseInt(freeSeqStr.trim());
        } catch (NumberFormatException e) {
            // noticeSeq 파라미터가 유효하지 않을 때의 처리
            return "errorPage";
        }
		
		Gorea_Free_BoardTO to = new Gorea_Free_BoardTO();
		
	    to.setFreeSeq(Integer.toString(freeSeq));
	    Gorea_Free_BoardTO prevPost = dao.getPreviousPost(freeSeq);
	    Gorea_Free_BoardTO nextPost = dao.getNextPost(freeSeq);
	    System.out.println("## seq : " + request.getParameter("freeSeq"));
	    
	    	to = dao.free_View(to);

	    // 게시글 내용 정화
	    String unsafeContent = to.getFreeContent();

	    //Safelist.basic()에 추가적으로 img, div, span 태그를 허용하고, style 속성도 허용합니다. 
	    Safelist safelist = Safelist.basic()
	    	    .addTags("img", "div", "span") // 이미지 및 스타일 관련 태그 추가
	    	    .addAttributes("img", "src", "alt", "title") // 이미지 태그 속성
	    	    .addAttributes(":all", "style"); // 모든 태그에 대해 'style' 속성 허용

	    	String safeContent = Jsoup.clean(unsafeContent, safelist);
	    	to.setFreeContent(safeContent);
	    model.addAttribute("to", to);
	    model.addAttribute("cpage", cpage);
	    model.addAttribute("searchType", searchType);
	    model.addAttribute("searchKeyword", searchKeyword);
	    model.addAttribute("prevPost", prevPost);
	    model.addAttribute("nextPost", nextPost);
	    
	    return "admin/freeboard/gorea_adminfreeboard_view";
	}
	
	@GetMapping("/admin/adminfreeboard_modify.do")
	public String modify(HttpServletRequest request, @RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model) {
		
		Gorea_Free_BoardTO to = new Gorea_Free_BoardTO();
	
		to.setFreeSeq( request.getParameter("freeSeq") );
		System.out.println("## seq : " + request.getParameter("freeSeq"));
		
			to = dao.free_Modify(to);
		
		model.addAttribute("to", to);
		model.addAttribute("freeSeq", to.getFreeSeq());
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "admin/freeboard/gorea_adminfreeboard_modify";
	}
	
	@PostMapping("/admin/adminfreeboard_modify_ok.do")
	public String modify_ok(HttpServletRequest request, MultipartFile upload, @RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model) {
		
		Gorea_Free_BoardTO to = new Gorea_Free_BoardTO();
		
		int flag = 1;
		to.setFreeSeq( request.getParameter("freeSeq") );
		to.setFreeTitle(request.getParameter( "freeTitle" ));
		to.setFreeContent(request.getParameter("freeContent"));
		
		System.out.println("## seq : " + request.getParameter("freeSeq"));
		
			flag = dao.free_Modify_Ok(to);
		
		model.addAttribute("flag", flag);
		model.addAttribute("freeSeq", to.getFreeSeq());
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "admin/freeboard/gorea_adminfreeboard_modify_ok";
	}
}
