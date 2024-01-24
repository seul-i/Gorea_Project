package com.gorea.controller_contents;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gorea.dto_user.Gorea_JoinTO;
import com.gorea.service_user.Gorea_JoinCheckService;
import com.gorea.service_user.Gorea_UserService_Interface;

@Controller
public class Gorea_Header_Controller {
	
	@Autowired
	private Gorea_UserService_Interface userService;
	
	@Autowired
	private Gorea_JoinCheckService joinCheck;
	
	@Autowired
	private BCryptPasswordEncoder pwdEncoder;
	
	
	@GetMapping("/{language}/login.do")
	public String login(@PathVariable String language, Model model) {
		
		model.addAttribute("language", language);
		
		return "user/login";
	}
	
	@GetMapping("/{language}/join.do")
	public String join(@PathVariable String language, Model model) {
	    
		model.addAttribute("language", language);
		
		return "user/join";
	}
	
	@PostMapping("/{language}/joinOk.do")
	public String joinProc(@PathVariable String language, Gorea_JoinTO gorea_JoinTO, Model model) {
		
		model.addAttribute("language", language);
		
		String encPwd = pwdEncoder.encode(gorea_JoinTO.getPassword());
		gorea_JoinTO.setPassword(encPwd);
		userService.join(gorea_JoinTO);
		
		return "user/login";
	}

	// 비동기식 ajax 값을 return 하기위해 responseBody 어노테이션 사용 
	@RequestMapping("/checkUsername.do")
    @ResponseBody 
    public String checkUsername(@RequestParam("username") String username) {
		
		String result="N";
        
        int flag = joinCheck.checkUsername(username);
        
        // 아이디 있을시 Y 없을시 N 으로 result값 Response 
        if(flag == 1) result ="Y"; 

        
        return result;
    }
	
	@RequestMapping("/checkUserNickname.do")
    @ResponseBody
    public String checkUserNickname(@RequestParam("nickname") String nickname) {
		
		String result="N";	
        
        int flag = joinCheck.checkUserNickname(nickname);
        
        if(flag == 1) result ="Y"; 
        
        
        return result;
    }
	
	// 마이 페이지 이동
	@GetMapping("/{language}/userMypage.do")
	public String mypage(@PathVariable String language, Model model) {
		
		System.out.println(language);
		model.addAttribute("language", language);
		
		if(language.equals("korean")) {
			
		}else if(language.equals("english")) {
			
		}else if(language.equals("japanese")) {
			
		}else if(language.equals("chinese")) {
			
		}else {
			return "gorea_accessdeniedPage";
		}
		
		return "user/mypage/myPage";
	}
	
	// 어드민 페이지 이동
	@GetMapping("/adminpage.do")
	public String admin() {
	    return "admin/gorea_admingPage";
	}
	
}
