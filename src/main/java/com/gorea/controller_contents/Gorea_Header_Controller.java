package com.gorea.controller_contents;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.gorea.dto_user.Gorea_JoinTO;
import com.gorea.service_user.Gorea_UserService_Interface;

@Controller
public class Gorea_Header_Controller {
	
	@Autowired
	private Gorea_UserService_Interface userService;
	
	@Autowired
	private BCryptPasswordEncoder pwdEncoder;
	
	@GetMapping("/{language}/login.do")
	public String login(@PathVariable String language, Model model) {
		
		model.addAttribute("language", language);
		
		if(language.equals("korean")) {
			
		}else if(language.equals("english")) {
			
		}else if(language.equals("japanese")) {
			
		}else if(language.equals("chinese")) {
			
		}
		
		return "user/login";
	}
	
	@GetMapping("/{language}/join.do")
	public String join(@PathVariable String language, Model model) {
	    
		model.addAttribute("language", language);
		
		if(language.equals("korean")) {
			
		}else if(language.equals("english")) {
			
		}else if(language.equals("japanese")) {
			
		}else if(language.equals("chinese")) {
			
		}
		
		return "user/join";
	}
	
	@PostMapping("/joinOk.do")
	public String joinProc(Gorea_JoinTO gorea_JoinTO) {
		String encPwd = pwdEncoder.encode(gorea_JoinTO.getPassword());
		gorea_JoinTO.setPassword(encPwd);
		userService.join(gorea_JoinTO);
		return "user/login";
	}
	
	// 마이 페이지 이동
	@GetMapping("/user/{language}/mypage.do")
	public String mypage(@PathVariable String language, Model model) {
		
		model.addAttribute("language", language);
		
		if(language.equals("korean")) {
			
		}else if(language.equals("english")) {
			
		}else if(language.equals("japanese")) {
			
		}else if(language.equals("chinese")) {
			
		}
		
		return "user/myPage";
	}
	
	// 어드민 페이지 이동
	@GetMapping("/admin/adminpage.do")
	public String admin() {
	    return "gorea_admingPage";
	}
	
}
