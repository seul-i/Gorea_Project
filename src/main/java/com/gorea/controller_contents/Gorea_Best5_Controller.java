package com.gorea.controller_contents;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.gorea.dto_board.Gorea_TrendSeoul_ListTO;
import com.gorea.repository_contents.Gorea_Best5DAO;

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
	public String best5write(@PathVariable String language, Model model) {
		
		model.addAttribute("language",language);
		
		List<Gorea_TrendSeoul_ListTO> boardList = new ArrayList<Gorea_TrendSeoul_ListTO>();
		
		if(language.equals("korean")) {
			
			boardList = dao.trendSeoul_List();
			
		}else if(language.equals("english")) {
			
		}else if(language.equals("japanese")) {
			
		}else if(language.equals("chinese")) {
			
		}
		
		model.addAttribute("boardList",boardList);
		
		return "contents/contents_BestTop5/bestTop5_write";
	}
	
}
