package com.gorea.login;

import java.io.IOException;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class LoginSuccess implements AuthenticationSuccessHandler {
 
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		String url = request.getRequestURL().toString();
	    int lastSlashIndex = url.lastIndexOf('/');
        String path = url.substring(lastSlashIndex + 1);
        
        System.out.println("Request Path: " + path);
		
        
        if (path.equals("loginProcKr")) {
    		
        	System.out.println("로그인 성공");
    		response.sendRedirect("/korean/main.do");
		
		} else if(path.equals("loginProcEn")) {
			
			System.out.println("로그인 성공");
			response.sendRedirect("/english/main.do");
        	
        } else if(path.equals("loginProcJp")) {
        	
        	System.out.println("로그인 성공");
    		response.sendRedirect("/japanese/main.do");
        	
        } else if(path.equals("loginProcChn")) {
        	
        	System.out.println("로그인 성공");
    		response.sendRedirect("/chinese/main.do");
        	
        }
	}
}
