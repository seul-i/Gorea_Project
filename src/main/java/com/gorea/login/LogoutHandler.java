package com.gorea.login;

import java.io.IOException;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class LogoutHandler implements LogoutSuccessHandler {

	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {

		String url = request.getRequestURL().toString();
	    int lastSlashIndex = url.lastIndexOf('/');
        String path = url.substring(lastSlashIndex + 1);
        
        System.out.println("Request Path: " + path);
		
        if (path.equals("logoutKr.do")) {
    		
        	System.out.println("로그아웃 성공");
    		response.sendRedirect("/korean/main.do");
		
		} else if(path.equals("logoutEn.do")) {
			
			System.out.println("로그아웃 성공");
			response.sendRedirect("/english/main.do");
        	
        } else if(path.equals("logoutJp.do")) {
        	
        	System.out.println("로그아웃 성공");
    		response.sendRedirect("/japanese/main.do");
        	
        } else if(path.equals("logoutChn.do")) {
        	
        	System.out.println("로그아웃 성공");
    		response.sendRedirect("/chinese/main.do");
        	
        }
	}
}
