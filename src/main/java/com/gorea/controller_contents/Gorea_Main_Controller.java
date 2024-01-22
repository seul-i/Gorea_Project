package com.gorea.controller_contents;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;


import jakarta.servlet.http.HttpServletRequest;

@Controller
public class Gorea_Main_Controller {
	
	// 인트로 페이지 이동
	@GetMapping("intro.do")
	public String intro(HttpServletRequest request, Model model) {
		return "gorea_introPage";
	}
	
	// 각나라 언어 페이지로 이동
	@GetMapping("/{language}/main.do")
	public String korean_main(@PathVariable String language, HttpServletRequest request, Model model) {
		
		model.addAttribute("language", language);
		
		if(language.equals("korean")) {
			
		}else if(language.equals("english")) {
			
		}else if(language.equals("japanese")) {
			
		}else if(language.equals("chinese")) {
			
		}else {
			return "gorea_accessdeniedPage";
		}
		
		return "gorea_mainPage";
	}
	
	@GetMapping("/errorPage.do")
	public String errorPage(HttpServletRequest request, Model model) {
		return "gorea_accessdeniedPage";
	}

}
