package com.gorea.controller_contents;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gorea.dto_board.Gorea_BEST5_WriteTO;
import com.gorea.dto_board.Gorea_BEST5_BoardTO;
import com.gorea.dto_board.Gorea_BEST5_CommentTO;
import com.gorea.dto_board.Gorea_TrendSeoul_ListTO;
import com.gorea.dto_board.Gorea_TrendSeoul_SearchTO;
import com.gorea.repository_contents.Gorea_Best5DAO;

import jakarta.servlet.http.HttpServletRequest;


@Controller
public class Gorea_Best5_Controller {
	
	@Autowired
	private Gorea_Best5DAO dao;

	@GetMapping("/{language}/BestTop5.do")
	public String best5List(@PathVariable String language, Model model) {
		
		model.addAttribute("language",language);
		
		List<Gorea_BEST5_BoardTO> boardList = new ArrayList<>();

		if(language.equals("korean")) {
			
			boardList = dao.best5_top5_boardList();

		}else if(language.equals("english")) {
			
		}else if(language.equals("japanese")) {
			
		}else if(language.equals("chinese")) {
			
		}
		
		model.addAttribute("boardList",boardList);
		
		return "contents/contents_BestTop5/bestTop5_List";
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
			
			System.out.println(subCategory);

			List<Gorea_TrendSeoul_ListTO> searchboardList = new ArrayList<>();
	
		    if (language.equals("korean")) {
		    	
		    	System.out.println(locGu+mainCategory+subCategory);
		    	
		    	searchboardList = dao.trendSeoul_searchList(locGu,mainCategory,subCategory);
		    	
		    	System.out.println(searchboardList);
		        
		    } else if (language.equals("english")) {
		        // 처리
		    } else if (language.equals("japanese")) {
		        // 처리
		    } else if (language.equals("chinese")) {
		        // 처리
		    }

	    return searchboardList;
	}
	
	@PostMapping("/{language}/bestTop5_write_ok.do")
	@Transactional
	public String best5write_ok(@PathVariable String language, 
			HttpServletRequest request, Model model) {
		
		int flag = 2;
		
		Gorea_BEST5_WriteTO bto = new Gorea_BEST5_WriteTO();
		Gorea_BEST5_CommentTO cto = new Gorea_BEST5_CommentTO();
		
		bto.setUserSeq(request.getParameter("userSeq"));
		
		bto = dao.best5_write_ok(bto);
		String top5Seq = bto.getTop5Seq();


		for (int i = 1; i <= 5; i++) {
			cto.setTop5Seq(top5Seq);
			cto.setSeoulSeq(request.getParameter("seoulSeq"+i));
			cto.setTop5Comment(request.getParameter("comment"+i));
			
			flag = dao.best5_writeComment_ok(cto);
		}
		
		model.addAttribute("flag", flag);
		
		return "contents/contents_BestTop5/bestTop5_write_ok";
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
