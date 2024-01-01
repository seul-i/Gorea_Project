package com.gorea;

import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

public class ServletInitializer extends SpringBootServletInitializer {

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(GoreaProjectApplication.class); 
		// SpringBootServletInitializer를 확장한 클래스로, 
		// 스프링 부트 애플리케이션을 서블릿 컨테이너(예: Tomcat)에서 실행할 수 있도록 도와주는 역할을 하고있다.
	}

}
