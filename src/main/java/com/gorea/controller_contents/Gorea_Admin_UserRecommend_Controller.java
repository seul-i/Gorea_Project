package com.gorea.controller_contents;

import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.safety.Safelist;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.gorea.dto_board.Gorea_PagingTO;
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
	    
	    Gorea_PagingTO paging = createPagingModel(totalRowCount, cpage, pageSize);
	    
	    model.addAttribute("paging", paging);
	    model.addAttribute("lists", lists);

	    List<Integer> pageNumbers = new ArrayList<>();
	    for (int i = paging.getFirstPage(); i <= paging.getLastPage(); i++) {
	        pageNumbers.add(i);
	    }
	    model.addAttribute("pageNumbers", pageNumbers);
			
		return "admin/userRecommend/gorea_adminuserRecom";
	}
	
	private Gorea_PagingTO createPagingModel(int totalRowCount, int cpage, int pageSize) {
	    Gorea_PagingTO paging = new Gorea_PagingTO();
	    paging.setTotalRecord(totalRowCount);
	    paging.setCpage(cpage);
	    paging.setPageSize(pageSize);
	    paging.pageSetting();
	    return paging;
	}
	
	@GetMapping("/admin/adminuserRecom_view.do")
	public String view(@RequestParam("seq") String userRecomSeqStr, HttpServletRequest request, @RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model) {
		
		int userRecomSeq;
        try {
        	userRecomSeq = Integer.parseInt(userRecomSeqStr.trim());
        } catch (NumberFormatException e) {
            // noticeSeq 파라미터가 유효하지 않을 때의 처리
            return "errorPage";
        }
		
		Gorea_Recommend_BoardTO to = new Gorea_Recommend_BoardTO();
		
	    to.setUserRecomSeq(Integer.toString(userRecomSeq));
	    Gorea_Recommend_BoardTO prevPost = dao.getPreviousPost(userRecomSeq);
	    Gorea_Recommend_BoardTO nextPost = dao.getNextPost(userRecomSeq);
	    System.out.println("## seq : " + request.getParameter("seq"));
	    
	    	to = dao.userRecom_view(to);

	    // 게시글 내용 정화
	    String unsafeContent = to.getUserRecomContent();

	    //Safelist.basic()에 추가적으로 img, div, span 태그를 허용하고, style 속성도 허용합니다. 
	    Safelist safelist = Safelist.basic()
	    	    .addTags("img", "div", "span") // 이미지 및 스타일 관련 태그 추가
	    	    .addAttributes("img", "src", "alt", "title") // 이미지 태그 속성
	    	    .addAttributes(":all", "style"); // 모든 태그에 대해 'style' 속성 허용

	    	String safeContent = Jsoup.clean(unsafeContent, safelist);
	    	to.setUserRecomContent(safeContent);
	    model.addAttribute("to", to);
	    model.addAttribute("cpage", cpage);
	    model.addAttribute("searchType", searchType);
	    model.addAttribute("searchKeyword", searchKeyword);
	    model.addAttribute("prevPost", prevPost);
	    model.addAttribute("nextPost", nextPost);
	    
	    return "admin/userRecommend/gorea_adminuserRecom_view";
	}
	
	
	@GetMapping("/admin/adminuserRecom_delete_ok.do")
	public String delete_ok(@RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, HttpServletRequest request, Model model) {
		
		int flag = 1;
		
		Gorea_Recommend_BoardTO to = new Gorea_Recommend_BoardTO();
		
		to.setUserRecomSeq(request.getParameter("userRecomSeq"));
		
		flag = dao.userRecom_deleteOk(to);
	     
		model.addAttribute("flag", flag);
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "admin/userRecommend/gorea_adminuserRecom_delete_ok";
	}
	
	@GetMapping("/admin/adminuserRecom_modify.do")
	public String modify(HttpServletRequest request, @RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model) {
		
		Gorea_Recommend_BoardTO to = new Gorea_Recommend_BoardTO();
	
		to.setUserRecomSeq( request.getParameter("userRecomSeq") );
		System.out.println("## seq : " + request.getParameter("userRecomSeq"));
		
		to = dao.userRecom_modify(to);
		
		model.addAttribute("to", to);
		model.addAttribute("userRecomSeq", to.getUserRecomSeq());
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "admin/userRecommend/gorea_adminuserRecom_modify";
	}
	
	
	@PostMapping("/admin/adminuserRecom_modify_ok.do")
	public String modify_ok(HttpServletRequest request, MultipartFile upload, @RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model) {
		//String seq = request.getParameter( "userRecomSeq" );
		//System.out.println( seq );
		
		Gorea_Recommend_BoardTO to = new Gorea_Recommend_BoardTO();
		
		int flag = 1;
		to.setUserRecomSeq( request.getParameter("userRecomSeq") );
		to.setUserRecomTitle(request.getParameter( "userRecomTitle" ));
		to.setUserRecomContent(request.getParameter("userRecomContent"));
		
		System.out.println("## seq : " + request.getParameter("userRecomSeq") );
		
		flag = dao.userRecom_modifyOk(to);
		
		model.addAttribute("flag", flag);
		model.addAttribute("userRecomSeq", to.getUserRecomSeq());
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "admin/userRecommend/gorea_adminuserRecom_modify_ok";
	}
}
