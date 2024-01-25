package com.gorea.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.servlet.util.matcher.MvcRequestMatcher;


import com.gorea.login.CustomAccessDeniedHandler;
import com.gorea.login.LoginDetailService;
import com.gorea.login.LoginFail;
import com.gorea.login.LoginOauthUserService;
import com.gorea.login.LoginSuccess;
import com.gorea.login.LogoutHandler;

@EnableWebSecurity
@Configuration
public class Gorea_LoginSecurity_Config {
	
	// 로그인 성공시
	@Autowired
	private LoginSuccess loginSuccess;
	// 로그인 실패시
	@Autowired
	private LoginFail loginFail;
	@Autowired
	private LogoutHandler logoutSuccess;
	
	@Autowired
	private LoginDetailService loginDetailService;
	@Autowired
	private CustomAccessDeniedHandler customAccessDeniedHandler;
	@Autowired
	private LoginOauthUserService loginOauthUserService; 
	
//	@Bean
//    public HttpFirewall defaultHttpFirewall() {
//        return new DefaultHttpFirewall();
//    }
	
	@Bean
	public BCryptPasswordEncoder encodePwd() {
		return new BCryptPasswordEncoder();
	}
	
	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
		
		
		http.csrf(csrf ->csrf.disable()).cors(cors ->cors.disable());
                
		http.authorizeHttpRequests(request -> request
//				.requestMatchers("/adminpage.do").hasRole("ADMIN")
//              .requestMatchers("/user/**").hasAnyRole("ADMIN, USER")
				.requestMatchers(new MvcRequestMatcher(null, "/admin**")).hasRole("ADMIN")
				.requestMatchers(new MvcRequestMatcher(null, "/korean/user/**")).hasRole("USER")
				.requestMatchers(new MvcRequestMatcher(null, "/english/user/**")).hasRole("USER")
				.requestMatchers(new MvcRequestMatcher(null, "/chinese/user/**")).hasRole("USER")
				.requestMatchers(new MvcRequestMatcher(null, "/japanese/user/**")).hasRole("USER")
				
				.requestMatchers(new MvcRequestMatcher(null, "/korean/editRecommend_write.do")).hasRole("ADMIN")
				.requestMatchers(new MvcRequestMatcher(null, "/korean/editRecommend_write_ok.do")).hasRole("ADMIN")
				.requestMatchers(new MvcRequestMatcher(null, "/korean/editRecommend_modify.do")).hasRole("ADMIN")
				.requestMatchers(new MvcRequestMatcher(null, "/korean/editRecommend_modify_ok.do")).hasRole("ADMIN")
				.requestMatchers(new MvcRequestMatcher(null, "/korean/editRecommend_delete_ok.do")).hasRole("ADMIN")
				
				.requestMatchers(new MvcRequestMatcher(null, "/korean/editTip_write.do")).hasRole("ADMIN")
				.requestMatchers(new MvcRequestMatcher(null, "/korean/editTip_write_ok.do")).hasRole("ADMIN")
				.requestMatchers(new MvcRequestMatcher(null, "/korean/editTip_modify.do")).hasRole("ADMIN")
				.requestMatchers(new MvcRequestMatcher(null, "/korean/editTip_modify_ok.do")).hasRole("ADMIN")
				.requestMatchers(new MvcRequestMatcher(null, "/korean/editTip_delete_ok.do")).hasRole("ADMIN")
				
				.requestMatchers(new MvcRequestMatcher(null, "/korean/**write**")).hasAnyRole("ADMIN","USER")
				.requestMatchers(new MvcRequestMatcher(null, "/english/**write**")).hasAnyRole("ADMIN","USER")
				.requestMatchers(new MvcRequestMatcher(null, "/chinese/**write**")).hasAnyRole("ADMIN","USER")
				.requestMatchers(new MvcRequestMatcher(null, "/japanese/**write**")).hasAnyRole("ADMIN","USER")
				
				.requestMatchers(new MvcRequestMatcher(null, "/korean/**view**")).hasAnyRole("ADMIN","USER")
				.requestMatchers(new MvcRequestMatcher(null, "/english/**view**")).hasAnyRole("ADMIN","USER")
				.requestMatchers(new MvcRequestMatcher(null, "/chinese/**view**")).hasAnyRole("ADMIN","USER")
				.requestMatchers(new MvcRequestMatcher(null, "/japanese/**view**")).hasAnyRole("ADMIN","USER")
				.anyRequest().permitAll()

			)
			.exceptionHandling(handling ->handling
					.accessDeniedHandler(customAccessDeniedHandler)
			)
			
			.formLogin(login -> login
					.loginPage("/korean/login.do")
					.loginProcessingUrl("/loginProc**")
					.successHandler(loginSuccess)
					.failureHandler(loginFail)
			)
            .logout(logout -> logout
            		.invalidateHttpSession(true)
            	    .deleteCookies("JESSIONID")
            	    .logoutUrl("/logout**.do")
            	    .logoutSuccessHandler(logoutSuccess)
           
            )
            .rememberMe(me -> me
                	.key("rememberKey")
            		.rememberMeCookieName("rememberMeCookieName")
            		.rememberMeParameter("remember-me")
            		.tokenValiditySeconds(60 * 60 * 24 * 7)
            		.userDetailsService(loginDetailService)
            );
            
		
		http.oauth2Login(login -> login
			    .userInfoEndpoint()
			        .userService(loginOauthUserService)
			        .and()
			    .defaultSuccessUrl("/korean/main.do")
			);
		
        return http.build();  
    }
}
