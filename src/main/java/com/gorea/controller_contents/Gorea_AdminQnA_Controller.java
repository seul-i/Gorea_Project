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
import com.gorea.dto_board.Gorea_QnA_BoardTO;
import com.gorea.repository_contents.Gorea_QnADAO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class Gorea_AdminQnA_Controller {

	@Autowired
	private Gorea_QnADAO dao;
	
	@GetMapping("/adminqna.do")
	public String list(@RequestParam(value = "searchType", required = false) String searchType,
	                   @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
	                   HttpServletRequest request, Model model, 
	                   @RequestParam(defaultValue = "1") int cpage,
	                   @RequestParam(defaultValue = "20") int pageSize) {
	    System.out.println("list 호출 성공");

	    cpage = (cpage <= 0) ? 1 : cpage;
	    int offset = (cpage - 1) * pageSize;
	    List<Gorea_QnA_BoardTO> lists = new ArrayList<Gorea_QnA_BoardTO>();
	    int totalRowCount = 0;

	    	if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
	    		lists = dao.searchQnA(searchType, searchKeyword, offset, pageSize);
	    		totalRowCount = dao.getSearchTotalRowCount(searchType, searchKeyword);
	    	} else {
	    		lists = dao.qna_List(offset, pageSize);
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

	    return "admin/QnA/gorea_adminqna"; // 언어에 따른 경로 반환
	}
	
	private Gorea_CumuPagingTO createPagingModel(int totalRowCount, int cpage, int pageSize) {
	    Gorea_CumuPagingTO paging = new Gorea_CumuPagingTO();
	    paging.setTotalRecord(totalRowCount);
	    paging.setCpage(cpage);
	    paging.setPageSize(pageSize);
	    paging.pageSetting();
	    return paging;
	}
	
	@GetMapping("/adminqna_delete_ok.do")
	public String delete_ok(@RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, HttpServletRequest request, Model model) {
		
		int flag = 1;
		
		Gorea_QnA_BoardTO to = new Gorea_QnA_BoardTO();
		
		to.setQnaSeq(request.getParameter("qnaSeq"));
		
			flag = dao.qna_Delete_Ok(to);
	     
		model.addAttribute("flag", flag);
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "admin/QnA/gorea_adminqna_delete_ok";
	}
	@GetMapping("/adminqna_view.do")
	public String view(@RequestParam("qnaSeq") String qnaSeqStr, HttpServletRequest request, @RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model) {
		
		int qnaSeq;
        try {
        	qnaSeq = Integer.parseInt(qnaSeqStr.trim());
        } catch (NumberFormatException e) {
            // noticeSeq 파라미터가 유효하지 않을 때의 처리
            return "errorPage";
        }
		
        Gorea_QnA_BoardTO to = new Gorea_QnA_BoardTO();
		
	    to.setQnaSeq(Integer.toString(qnaSeq));
	    Gorea_QnA_BoardTO prevPost = dao.getPreviousPost(qnaSeq);
	    Gorea_QnA_BoardTO nextPost = dao.getNextPost(qnaSeq);
	    System.out.println("## seq : " + request.getParameter("qnaSeq"));
	    
	    	to = dao.qna_View(to);

	    // 게시글 내용 정화
	    String unsafeContent = to.getQnaContent();

	    //Safelist.basic()에 추가적으로 img, div, span 태그를 허용하고, style 속성도 허용합니다. 
	    Safelist safelist = Safelist.basic()
	    	    .addTags("img", "div", "span") // 이미지 및 스타일 관련 태그 추가
	    	    .addAttributes("img", "src", "alt", "title") // 이미지 태그 속성
	    	    .addAttributes(":all", "style"); // 모든 태그에 대해 'style' 속성 허용

	    	String safeContent = Jsoup.clean(unsafeContent, safelist);
	    	to.setQnaContent(safeContent);
	    model.addAttribute("to", to);
	    model.addAttribute("cpage", cpage);
	    model.addAttribute("searchType", searchType);
	    model.addAttribute("searchKeyword", searchKeyword);
	    model.addAttribute("prevPost", prevPost);
	    model.addAttribute("nextPost", nextPost);
	    
	    return "admin/QnA/gorea_adminqna_view";
	}
	
	@GetMapping("/adminqna_modify.do")
	public String modify(HttpServletRequest request, @RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model) {
		
		Gorea_QnA_BoardTO to = new Gorea_QnA_BoardTO();
	
		to.setQnaSeq( request.getParameter("qnaSeq") );
		System.out.println("## seq : " + request.getParameter("qnaSeq"));
		
			to = dao.qna_Modify(to);
		
		model.addAttribute("to", to);
		model.addAttribute("qnaSeq", to.getQnaSeq());
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "admin/QnA/gorea_adminqna_modify";
	}
	
	@PostMapping("/adminqna_modify_ok.do")
	public String modify_ok(HttpServletRequest request, MultipartFile upload, @RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model) {
		
		Gorea_QnA_BoardTO to = new Gorea_QnA_BoardTO();
		
		int flag = 1;
		to.setQnaSeq( request.getParameter("qnaSeq") );
		to.setQnaTitle(request.getParameter( "qnaTitle" ));
		to.setQnaContent(request.getParameter("qnaContent"));
		to.setQnaCategory(request.getParameter("qnaCategory"));
		
		System.out.println("## seq : " + request.getParameter("qnaSeq"));
		
			flag = dao.qna_Modify_Ok(to);
		
		model.addAttribute("flag", flag);
		model.addAttribute("qnaSeq", to.getQnaSeq());
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "admin/QnA/gorea_adminqna_modify_ok";
	}
}
