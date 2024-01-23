package com.gorea.login;

import java.io.IOException;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class LoginFail implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		
		// 로그인 처리 경로 
		String url = request.getRequestURL().toString();
	    int lastSlashIndex = url.lastIndexOf('/');
        String path = url.substring(lastSlashIndex + 1);
        
        System.out.println("Request Path: " + path);
        
        	
        	if (exception instanceof BadCredentialsException
    				|| exception instanceof InternalAuthenticationServiceException) {
        		
        		if (path.equals("loginProcKr")) {
        		
        			request.setAttribute("loginFailMsg", "아이디와 비밀번호를 확인해 주세요");
        			request.setAttribute("loginFailKr", "한국");
    			
        		} else if(path.equals("loginProcEn")) {
        			
        			request.setAttribute("loginFailMsg", "Please check your ID and password");
        			request.setAttribute("loginFailEn", "미국");
                	
                } else if(path.equals("loginProcJp")) {
                	
                	request.setAttribute("loginFailMsg", "IDとパスワードを確認してください");
        			request.setAttribute("loginFailJp", "일본");
                	
                } else if(path.equals("loginProcChn")) {
                	
                	request.setAttribute("loginFailMsg", "请检查您的ID和密码");
        			request.setAttribute("loginFailChn", "중국");
                	
                }
    			
    		}
    		
    		request.getRequestDispatcher("/WEB-INF/views/user/login.jsp").forward(request, response);
        	
        
		
		
	}
}
