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
import com.gorea.dto_board.Gorea_Notice_BoardTO;
import com.gorea.repository_contents.Gorea_NoticeDAO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class Gorea_Admin_Controller {

	@Autowired
	private Gorea_NoticeDAO dao;
	
	@GetMapping("/adminnotice.do")
	public String list(@RequestParam(value = "searchType", required = false) String searchType,
	                   @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
	                   HttpServletRequest request, Model model, 
	                   @RequestParam(defaultValue = "1") int cpage,
	                   @RequestParam(defaultValue = "20") int pageSize) {
	    System.out.println("list 호출 성공");

	    cpage = (cpage <= 0) ? 1 : cpage;
	    int offset = (cpage - 1) * pageSize;
	    List<Gorea_Notice_BoardTO> lists = new ArrayList<Gorea_Notice_BoardTO>();
	    int totalRowCount = 0;

	    	if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
	    		lists = dao.searchNotices(searchType, searchKeyword, offset, pageSize);
	    		totalRowCount = dao.getSearchTotalRowCount(searchType, searchKeyword);
	    	} else {
	    		lists = dao.notice_List(offset, pageSize);
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

	    return "admin/gorea_adminnotice"; // 언어에 따른 경로 반환
	}
	
	private Gorea_CumuPagingTO createPagingModel(int totalRowCount, int cpage, int pageSize) {
	    Gorea_CumuPagingTO paging = new Gorea_CumuPagingTO();
	    paging.setTotalRecord(totalRowCount);
	    paging.setCpage(cpage);
	    paging.setPageSize(pageSize);
	    paging.pageSetting();
	    return paging;
	}
	
	@GetMapping("/adminnotice_delete_ok.do")
	public String delete_ok(@RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, HttpServletRequest request, Model model) {
		
		int flag = 1;
		
		Gorea_Notice_BoardTO to = new Gorea_Notice_BoardTO();
		
		to.setNoticeSeq(request.getParameter("noticeSeq"));
		
			flag = dao.notice_Delete_Ok(to);
	     
		model.addAttribute("flag", flag);
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "admin/gorea_adminnotice_delete_ok";
	}
	
	@GetMapping("/adminnotice_write.do")
    public String gowrite(HttpServletRequest request, Model model) {
		return "admin/gorea_adminnotice_write";
    }
	
	@PostMapping("/adminnotice_write_ok.do")
	public String write_ok(HttpServletRequest request, MultipartFile upload, Model model) {
		int flag = 2;
		
		Gorea_Notice_BoardTO to = new Gorea_Notice_BoardTO();
		
		to.setNoticeTitle(request.getParameter( "noticeTitle" ));
		to.setNoticeContent(request.getParameter("noticeContent"));
		to.setUserSeq(request.getParameter("userSeq"));
		
			flag = dao.notice_Write_Ok(to);
		
		model.addAttribute("flag", flag);

		return "admin/gorea_adminnotice_write_ok";
	}
	
	@GetMapping("/adminnotice_view.do")
	public String view(@RequestParam("noticeSeq") String noticeSeqStr, HttpServletRequest request, @RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model) {
		
		int noticeSeq;
        try {
        	noticeSeq = Integer.parseInt(noticeSeqStr.trim());
        } catch (NumberFormatException e) {
            // noticeSeq 파라미터가 유효하지 않을 때의 처리
            return "errorPage";
        }
		
		Gorea_Notice_BoardTO to = new Gorea_Notice_BoardTO();
		
	    to.setNoticeSeq(Integer.toString(noticeSeq));
	    Gorea_Notice_BoardTO prevPost = dao.getPreviousPost(noticeSeq);
	    Gorea_Notice_BoardTO nextPost = dao.getNextPost(noticeSeq);
	    System.out.println("## seq : " + request.getParameter("noticeSeq"));
	    
	    	to = dao.notice_View(to);

	    // 게시글 내용 정화
	    String unsafeContent = to.getNoticeContent();

	    //Safelist.basic()에 추가적으로 img, div, span 태그를 허용하고, style 속성도 허용합니다. 
	    Safelist safelist = Safelist.basic()
	    	    .addTags("img", "div", "span") // 이미지 및 스타일 관련 태그 추가
	    	    .addAttributes("img", "src", "alt", "title") // 이미지 태그 속성
	    	    .addAttributes(":all", "style"); // 모든 태그에 대해 'style' 속성 허용

	    	String safeContent = Jsoup.clean(unsafeContent, safelist);
	    	to.setNoticeContent(safeContent);
	    model.addAttribute("to", to);
	    model.addAttribute("cpage", cpage);
	    model.addAttribute("searchType", searchType);
	    model.addAttribute("searchKeyword", searchKeyword);
	    model.addAttribute("prevPost", prevPost);
	    model.addAttribute("nextPost", nextPost);
	    
	    return "admin/gorea_adminnotice_view";
	}
	
	@GetMapping("/adminnotice_modify.do")
	public String modify(HttpServletRequest request, @RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model) {
		
		Gorea_Notice_BoardTO to = new Gorea_Notice_BoardTO();
	
		to.setNoticeSeq( request.getParameter("noticeSeq") );
		System.out.println("## seq : " + request.getParameter("noticeSeq"));
		
			to = dao.notice_Modify(to);
		
		model.addAttribute("to", to);
		model.addAttribute("noticeSeq", to.getNoticeSeq());
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "admin/gorea_adminnotice_modify";
	}
	
	@PostMapping("/adminnotice_modify_ok.do")
	public String modify_ok(HttpServletRequest request, MultipartFile upload, @RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model) {
		
		Gorea_Notice_BoardTO to = new Gorea_Notice_BoardTO();
		
		int flag = 1;
		to.setNoticeSeq( request.getParameter("noticeSeq") );
		to.setNoticeTitle(request.getParameter( "noticeTitle" ));
		to.setNoticeContent(request.getParameter("noticeContent"));
		
		System.out.println("## seq : " + request.getParameter("noticeSeq"));
		
			flag = dao.notice_Modify_Ok(to);
		
		model.addAttribute("flag", flag);
		model.addAttribute("noticeSeq", to.getNoticeSeq());
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "admin/gorea_adminnotice_modify_ok";
	}
}
