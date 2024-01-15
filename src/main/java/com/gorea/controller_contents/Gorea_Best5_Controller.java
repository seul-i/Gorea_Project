package com.gorea.controller_contents;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gorea.dto_board.Gorea_EditTip_BoardTO;
import com.gorea.dto_board.Gorea_TrendSeoul_ListTO;
import com.gorea.dto_board.Gorea_TrendSeoul_SearchTO;
import com.gorea.repository_contents.Gorea_Best5DAO;

import jakarta.servlet.http.HttpServletRequest;

import org.json.JSONObject;

@Controller
public class Gorea_Best5_Controller {
	
	@Autowired
	private Gorea_Best5DAO dao;

	@GetMapping("/{language}/BestTop5.do")
	public String best5List(@PathVariable String language, Model model) {
		
		model.addAttribute("language",language);
		
		if(language.equals("korean")) {

		}else if(language.equals("english")) {
			
		}else if(language.equals("japanese")) {
			
		}else if(language.equals("chinese")) {
			
		}
		
		return "contents/contents_BestTop5/bestTop5_List";
	}
	
	@GetMapping("/{language}/BestTop5_write.do")
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
	
	
	@GetMapping("/{language}/BestTop5_modal.do")
	public String best5modal(@PathVariable String language, HttpServletRequest request, Model model) {
		
		model.addAttribute("language",language);
		
		List<Gorea_TrendSeoul_ListTO> boardList = new ArrayList<Gorea_TrendSeoul_ListTO>();
		
		if(language.equals("korean")) {
			
			boardList = dao.trendSeoul_List();
			
		}else if(language.equals("english")) {
			
		}else if(language.equals("japanese")) {
			
		}else if(language.equals("chinese")) {
			
		}
		
		model.addAttribute("boardList",boardList);
		
		return "contents/contents_BestTop5/bestTop5_modal";
	}
}
