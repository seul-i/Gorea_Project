package com.gorea.controller_contents;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gorea.dto_board.Gorea_BEST5_BoardTO;
import com.gorea.dto_board.Gorea_BEST5_ListTO;
import com.gorea.dto_board.Gorea_PagingTO;
import com.gorea.dto_board.Gorea_TrendSeoul_ListTO;
import com.gorea.dto_board.Gorea_TrendSeoul_SearchTO;
import com.gorea.dto_like.Gorea_BEST5_LikeTO;
import com.gorea.dto_user.Gorea_UserTO;
import com.gorea.login.LoginService;
import com.gorea.repository_contents.Gorea_Best5DAO;

import jakarta.servlet.http.HttpServletRequest;


@Controller
public class Gorea_Best5_Controller {
	
	@Autowired
	private Gorea_Best5DAO dao;
	
	@Value("${geocoding.api.key}")
	private String googlemap;
	
	@PostMapping("/boardFavo.do")
	public @ResponseBody String addToFavorites(
	        @RequestParam("top5Seq") String top5Seq,
	        @RequestParam("boardNo") String boardNo,
	        @RequestParam("userSeq") String userSeq) {

	    Gorea_BEST5_LikeTO to = new Gorea_BEST5_LikeTO();

	    to.setBoardnoSeq(boardNo);
	    to.setBoardSeq(top5Seq);
	    to.setUserSeq(userSeq);

	    dao.addToFavorites(to);

	    return "즐겨찾기 완료";
	}
	

	@GetMapping("/{language}/bestTop5.do")
	public String best5List(@PathVariable String language, Model model,
			@RequestParam(defaultValue = "1") int cpage,
	        @RequestParam(defaultValue = "8") int pageSize) {
		
		// cpage가 0 이하이면 1로 설정
	    cpage = (cpage <= 0) ? 1 : cpage;
	    
	    if (cpage <= 0) {
	        // cpage가 0 이하인 경우, 1페이지로 리다이렉트
	        return "redirect:/{language}/bestTop5.do?cpage=1";
	    }
	    
	    int offset = (cpage - 1) * pageSize;
		
		model.addAttribute("language",language);

		List<Gorea_BEST5_ListTO> boardList2 = new ArrayList<>();
		Gorea_PagingTO paging = new Gorea_PagingTO();

		if(language.equals("korean")) {
			
 			boardList2 = dao.best5_top5_boardList(offset, pageSize);
 			paging = createPagingModel(boardList2, cpage);

		}else if(language.equals("english")) {
			
			boardList2 = dao.best5_top5_boardList(offset, pageSize);
 			paging = createPagingModel(boardList2, cpage);
			
		}else if(language.equals("japanese")) {
			
			boardList2 = dao.best5_top5_boardList(offset, pageSize);
 			paging = createPagingModel(boardList2, cpage);
			
		}else if(language.equals("chinese")) {
			
			boardList2 = dao.best5_top5_boardList(offset, pageSize);
 			paging = createPagingModel(boardList2, cpage);
		}
		
		model.addAttribute("paging", paging);
		
		List<Integer> pageNumbers = new ArrayList<>();
	    for (int i = paging.getFirstPage(); i <= paging.getLastPage(); i++) {
	        pageNumbers.add(i);
	    }
	    
	    model.addAttribute("pageNumbers", pageNumbers);
		
		
		return "contents/contents_BestTop5/bestTop5_List";
	}
	
	private Gorea_PagingTO createPagingModel(List<Gorea_BEST5_ListTO> boardList2, int cpage) {
	    Gorea_PagingTO paging = new Gorea_PagingTO();
	    paging.setBoardList2(boardList2 != null ? boardList2 : new ArrayList<>());
	    paging.setTotalRecord(dao.getTop5RowCount());
	    paging.setCpage(cpage);  // 추가: cpage 값을 설정

	    // 수정: pageSetting 호출 전에 cpage 값을 확인하고 필요하다면 수정
	    if (cpage > paging.getTotalPage()) {
	        cpage = paging.getTotalPage();
	    }

	    paging.pageSetting();

	    return paging;
	}
	
	@GetMapping("/{language}/bestTop5_NS.do")
	public String best5List_Ps(@PathVariable String language, @RequestParam String nation, Model model,
			@RequestParam(defaultValue = "1") int cpage,
	        @RequestParam(defaultValue = "8") int pageSize) {
		
		// cpage가 0 이하이면 1로 설정
	    cpage = (cpage <= 0) ? 1 : cpage;
	    
	    if (cpage <= 0) {
	        // cpage가 0 이하인 경우, 1페이지로 리다이렉트
	        return "redirect:/{language}/bestTop5.do?cpage=1";
	    }
	    
	    int offset = (cpage - 1) * pageSize;
		
		model.addAttribute("language",language);
		
		List<Gorea_BEST5_ListTO> boardList2 = new ArrayList<>();
		Gorea_PagingTO paging = new Gorea_PagingTO();

		if(language.equals("korean")) {
			
			boardList2 = dao.best5_top5_boardList_NS(offset, pageSize, nation);
 			paging = createPagingModel2(boardList2, cpage);

		}else if(language.equals("english")) {
			
			boardList2 = dao.best5_top5_boardList_NS(offset, pageSize, nation);
 			paging = createPagingModel2(boardList2, cpage);
			
		}else if(language.equals("japanese")) {
			
			boardList2 = dao.best5_top5_boardList_NS(offset, pageSize, nation);
 			paging = createPagingModel2(boardList2, cpage);
			
		}else if(language.equals("chinese")) {
			
			boardList2 = dao.best5_top5_boardList_NS(offset, pageSize, nation);
 			paging = createPagingModel2(boardList2, cpage);
		}
		
		model.addAttribute("paging", paging);
		
		List<Integer> pageNumbers = new ArrayList<>();
	    for (int i = paging.getFirstPage(); i <= paging.getLastPage(); i++) {
	        pageNumbers.add(i);
	    }
	    
	    model.addAttribute("pageNumbers", pageNumbers);
		
		return "contents/contents_BestTop5/bestTop5_List";
	}
	
	private Gorea_PagingTO createPagingModel2(List<Gorea_BEST5_ListTO> boardList2, int cpage) {
	    Gorea_PagingTO paging = new Gorea_PagingTO();
	    paging.setBoardList2(boardList2 != null ? boardList2 : new ArrayList<>());
	    paging.setTotalRecord(dao.getsearchTop5RowCount());
	    paging.setCpage(cpage);  // 추가: cpage 값을 설정

	    // 수정: pageSetting 호출 전에 cpage 값을 확인하고 필요하다면 수정
	    if (cpage > paging.getTotalPage()) {
	        cpage = paging.getTotalPage();
	    }

	    paging.pageSetting();

	    return paging;
	}
	
	@GetMapping("/{language}/bestTop5_write.do")
	public String best5write(@PathVariable String language, 
			HttpServletRequest request, Model model) {
		
		model.addAttribute("language",language);
		
		List<Gorea_TrendSeoul_ListTO> boardList = new ArrayList<>();
		
		List<Gorea_TrendSeoul_SearchTO> searchGu = new ArrayList<>();
		List<Gorea_TrendSeoul_SearchTO> searchmianCategroy = new ArrayList<>();
		
		if(language.equals("korean")) {
			
			boardList = dao.trendSeoul_List();
			searchGu = dao.search_locGu();
			
			searchmianCategroy = dao.search_mainCategroy();
			
		}else if(language.equals("english")) {
			
		}else if(language.equals("japanese")) {
			
		}else if(language.equals("chinese")) {
			
		}
		
		model.addAttribute("boardList",boardList);
		model.addAttribute("seoulLocgu",searchGu);
		
		model.addAttribute("searchmianCategroy",searchmianCategroy);
		
		return "contents/contents_BestTop5/bestTop5_write";
	}
	
	@PostMapping("/{language}/bestTop5_write_ok.do")
	@Transactional
	public String best5write_ok(@PathVariable String language, 
			HttpServletRequest request, Model model) {
		
		int flag = 2;
		
		Gorea_BEST5_BoardTO to = new Gorea_BEST5_BoardTO();

			to.setUserSeq(request.getParameter("userSeq"));
			to.setSeoulSeq1(request.getParameter("seoulSeq1"));
			to.setTop5Comment1(request.getParameter("comment1"));
			to.setSeoulSeq2(request.getParameter("seoulSeq2"));
			to.setTop5Comment2(request.getParameter("comment2"));
			to.setSeoulSeq3(request.getParameter("seoulSeq3"));
			to.setTop5Comment3(request.getParameter("comment3"));
			to.setSeoulSeq4(request.getParameter("seoulSeq4"));
			to.setTop5Comment4(request.getParameter("comment4"));
			to.setSeoulSeq5(request.getParameter("seoulSeq5"));
			to.setTop5Comment5(request.getParameter("comment5"));
			
			flag = dao.besttop5_Write_Ok(to);

		model.addAttribute("flag", flag);
		
		return "contents/contents_BestTop5/bestTop5_write_ok";
	}
	
	// search box 비동기 항목 출력
	@GetMapping("/{language}/categorySearch.do")
	@ResponseBody 
	public List<Gorea_TrendSeoul_SearchTO> best5subCategory(
	        @PathVariable String language,
	        @RequestParam(name = "mainCategory") String mainCategory) {

	    List<Gorea_TrendSeoul_SearchTO> searchsubCategroy = new ArrayList<>();

	    if (language.equals("korean")) {
	    	
	        searchsubCategroy = dao.search_subCategroy(mainCategory);
	        
	    } else if (language.equals("english")) {
	        // 처리
	    } else if (language.equals("japanese")) {
	        // 처리
	    } else if (language.equals("chinese")) {
	        // 처리
	    }

	    return searchsubCategroy;
	}
	
	@GetMapping("/{language}/listSearch.do")
	@ResponseBody 
	public List<Gorea_TrendSeoul_ListTO> best5List_search(
	        @PathVariable String language,
	        @RequestParam(name = "locGu") String locGu,
	        @RequestParam(name = "mainCategory") String mainCategory,
	        @RequestParam(name = "subCategory") String subCategory) {
		
			if(subCategory.equals("#")) {
				subCategory = "";
			}

			List<Gorea_TrendSeoul_ListTO> searchboardList = new ArrayList<>();
	
		    if (language.equals("korean")) {

		    } else if (language.equals("english")) {
		        // 처리
		    } else if (language.equals("japanese")) {
		        // 처리
		    } else if (language.equals("chinese")) {
		        // 처리
		    }

		    searchboardList = dao.trendSeoul_searchList(locGu,mainCategory,subCategory);
		    
	    return searchboardList;
	}
	
	@GetMapping("/{language}/bestTop5_view.do")
	public String bestTop5_View(@PathVariable String language, HttpServletRequest request, Model model) {
		
		Gorea_BEST5_ListTO to = new Gorea_BEST5_ListTO();
		
		to.setTop5Seq(request.getParameter("top5Seq"));
		
		System.out.println(to.getTop5Seq());
		
		model.addAttribute("language", language);
		model.addAttribute("googlemap",googlemap);

		if(language.equals("korean")) {
			to = dao.bestTop5_View(to);
			System.out.println(to);
		}else if(language.equals("english")) {
			
		}else if(language.equals("japanese")) {
			
		}else if(language.equals("chinese")) {
			
		}
		
		model.addAttribute("to", to);
		
		return "contents/contents_BestTop5/bestTop5_view";
	}
	
	
	
	
	
	
	
	
//	@GetMapping("/{language}/BestTop5_modal.do")
//	public String best5modal(@PathVariable String language, HttpServletRequest request, Model model) {
//		
//		model.addAttribute("language",language);
//		
//		List<Gorea_TrendSeoul_ListTO> boardList = new ArrayList<Gorea_TrendSeoul_ListTO>();
//		
//		if(language.equals("korean")) {
//			
//			boardList = dao.trendSeoul_List();
//			
//		}else if(language.equals("english")) {
//			
//		}else if(language.equals("japanese")) {
//			
//		}else if(language.equals("chinese")) {
//			
//		}
//		
//		model.addAttribute("boardList",boardList);
//		
//		return "contents/contents_BestTop5/bestTop5_modal";
//	}
}
