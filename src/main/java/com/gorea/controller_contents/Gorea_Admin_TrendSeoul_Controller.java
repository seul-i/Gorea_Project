package com.gorea.controller_contents;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.gorea.dto_board.Gorea_CumuPagingTO;
import com.gorea.dto_board.Gorea_Notice_BoardTO;
import com.gorea.dto_board.Gorea_TrendSeoul_BoardTO;
import com.gorea.dto_board.Gorea_TrendSeoul_ListTO;
import com.gorea.repository_contents.Gorea_TrendSeoulDAO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class Gorea_Admin_TrendSeoul_Controller {
	
	@Value("${spring.servlet.multipart.location}")
    private String uploadDir;
	
	@Autowired
	private Gorea_TrendSeoulDAO trendDao;
	
	@Value("${geocoding.api.key}")
	private String googlemap;
	
	@GetMapping("adminTrendseoul.do")
	public String list(@RequestParam(value = "searchType", required = false) String searchType,
			            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
			            HttpServletRequest request, Model model, 
			            @RequestParam(defaultValue = "1") int cpage,
			            @RequestParam(defaultValue = "20") int pageSize) {
		
		cpage = (cpage <= 0) ? 1 : cpage;
	    int offset = (cpage - 1) * pageSize;
	    
	    List<Gorea_TrendSeoul_ListTO> lists = new ArrayList<Gorea_TrendSeoul_ListTO>();
	    
	    int totalRowCount = 0;

    	if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
    		lists = trendDao.adminSearchTrend_List(searchType, searchKeyword, offset, pageSize);
    		totalRowCount = trendDao.adminTrendTotalCount(searchType, searchKeyword);
    	} else {
    		lists = trendDao.trendSeoul_List(offset, pageSize);
    		totalRowCount = trendDao.getTotalRowCount();
    	}
    	
    	Gorea_CumuPagingTO paging = createPagingModel(totalRowCount, cpage, pageSize);
	    
	    model.addAttribute("paging", paging);
	    model.addAttribute("lists", lists);

	    List<Integer> pageNumbers = new ArrayList<>();
	    for (int i = paging.getFirstPage(); i <= paging.getLastPage(); i++) {
	        pageNumbers.add(i);
	    }
	    model.addAttribute("pageNumbers", pageNumbers);
    	
		return "admin/trendseoul/gorea_adminTrendseoul";
	}
	
	@GetMapping("/adminTrend_write.do")
    public String gowrite(HttpServletRequest request, Model model) {
		return "admin/trendseoul/gorea_adminTrendseoul_write";
    }
	
	@PostMapping("/adminTrend_write_ok.do")
	public String write_ok(HttpServletRequest request, MultipartFile upload, Model model) {
		int flag = 2;
		
		Gorea_TrendSeoul_BoardTO to = new Gorea_TrendSeoul_BoardTO();
		
		 to.setUserSeq(request.getParameter("userSeq"));
       to.setSeoulcategoryNo(request.getParameter("seoulcategoryNo"));
       to.setSeoulTitle(request.getParameter("seoulTitle"));
       to.setSeoulsubTitle(request.getParameter("seoulsubTitle"));
       to.setSeoulContent(request.getParameter("seoulContent"));
       to.setSeoulLoc(request.getParameter("seoulLoc"));
       to.setSeoulLocGu(request.getParameter("seoulLocGu"));
       to.setSeoulSite(request.getParameter("seoulSite"));
       to.setSeoulusageTime(request.getParameter("seoulusageTime"));
       to.setSeoulusageFee(request.getParameter("seoulusageFee"));
       to.setSeoulTrafficinfo(request.getParameter("seoulTrafficinfo"));
       to.setSeoulNotice(request.getParameter("seoulNotice"));

		flag = trendDao.trendSeoul_Write_Ok(to);
		
		model.addAttribute("flag", flag);

		return "admin/trendseoul/gorea_adminTrendseoul_write_ok";
	}
	
	@GetMapping("adminTrendseoul_view.do")
	public String view(@RequestParam("seoulSeq") String seoulSeqStr,
							@RequestParam(value = "cpage", required = false) String cpage,
							@RequestParam(value = "searchType", required = false) String searchType,
							@RequestParam(value = "searchKeyword", required = false) String searchKeyword,
							HttpServletRequest request, 
							Model model) {
		
		int seoulSeq;
        try {
        	seoulSeq = Integer.parseInt(seoulSeqStr.trim());
        } catch (NumberFormatException e) {
            // noticeSeq 파라미터가 유효하지 않을 때의 처리
            return "errorPage";
        }
		
		Gorea_TrendSeoul_BoardTO to = new Gorea_TrendSeoul_BoardTO();
		to.setSeoulSeq(Integer.toString(seoulSeq));
		
		Gorea_TrendSeoul_BoardTO prevPost = trendDao.getPreviousPost(seoulSeq);
		Gorea_TrendSeoul_BoardTO nextPost = trendDao.getNextPost(seoulSeq);
		
		to = trendDao.trendSeoul_View(to);
		
		model.addAttribute("to", to);
		model.addAttribute("seoulSeq", to.getSeoulSeq());
		model.addAttribute("googlemap",googlemap);
		model.addAttribute("cpage", cpage);
	    model.addAttribute("searchType", searchType);
	    model.addAttribute("searchKeyword", searchKeyword);
	    model.addAttribute("prevPost", prevPost);
	    model.addAttribute("nextPost", nextPost);
		
		return "admin/trendseoul/gorea_adminTrendseoul_view";
	}
	
	@GetMapping("adminTrend_modify.do")
	public String adminTrend_Modify(HttpServletRequest request, 
										@RequestParam(value = "cpage", required = false) String cpage,
							            @RequestParam(value = "searchType", required = false) String searchType,
							            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model) {
		
		Gorea_TrendSeoul_BoardTO to = new Gorea_TrendSeoul_BoardTO();
		to.setSeoulSeq( request.getParameter("seoulSeq") );
		to = trendDao.trendSeoul_Modify(to);
		
		model.addAttribute("to", to);
		model.addAttribute("seoulSeq", to.getSeoulSeq());
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "admin/trendseoul/gorea_adminTrendseoul_modify";
	}
	
	@PostMapping("/adminTrend_modify_ok.do")
	public String modify_ok(HttpServletRequest request, MultipartFile upload, 
								@RequestParam(value = "cpage", required = false) String cpage,
					            @RequestParam(value = "searchType", required = false) String searchType,
					            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model) {
		
		Gorea_TrendSeoul_BoardTO to = new Gorea_TrendSeoul_BoardTO();
		
		int flag = 1;
		to.setSeoulSeq( request.getParameter("seoulSeq") );
		to.setSeoulTitle(request.getParameter( "seoulTitle" ));
		to.setSeoulContent(request.getParameter("seoulContent"));
		to.setSeoulsubTitle(request.getParameter("seoulsubTitle"));
//		to.setSeoulboardNo(request.getParameter("seoulboardNo"));
//      to.setSeoulcategoryNo(request.getParameter("seoulcategoryNo"));
		to.setSeoulLoc(request.getParameter("seoulLoc"));
		to.setSeoulLocGu(request.getParameter("seoulLocGu"));
		to.setSeoulSite(request.getParameter("seoulSite"));
		to.setSeoulusageTime(request.getParameter("seoulusageTime"));
		to.setSeoulusageFee(request.getParameter("seoulusageFee"));
		to.setSeoulTrafficinfo(request.getParameter("seoulTrafficinfo"));
		to.setSeoulNotice(request.getParameter("seoulNotice"));
		
		flag = trendDao.trendSeoul_Modify_Ok(to);
		
		model.addAttribute("flag", flag);
		model.addAttribute("seoulSeq", to.getSeoulSeq());
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "admin/trendseoul/gorea_adminTrendseoul_modify_ok";
	}
	
	@GetMapping("/adminTrend_delete_ok.do")
	public String delete_ok(@RequestParam(value = "cpage", required = false) String cpage,
									            @RequestParam(value = "searchType", required = false) String searchType,
									            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, 
									            HttpServletRequest request, Model model) {
		
		int flag = 1;
		
		Gorea_TrendSeoul_BoardTO to = new Gorea_TrendSeoul_BoardTO();
		
		to.setSeoulSeq(request.getParameter("seoulSeq"));
		
		flag = trendDao.trendSeoul_Delete_Ok(to);
	     
		model.addAttribute("flag", flag);
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "admin/trendseoul/gorea_adminTrendseoul_delete_ok";
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
