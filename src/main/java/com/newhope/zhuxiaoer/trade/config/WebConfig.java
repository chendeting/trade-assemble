package com.newhope.zhuxiaoer.trade.config;

import org.springframework.boot.context.embedded.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.newhope.kisso.spring.web.RandCodeImageServlet;


@Configuration
public class WebConfig {
	
	/**
	 *  radomServlet config
	 * 
	 * @return
	 */
	@Bean
	public ServletRegistrationBean randCodeImageServlet() {
		ServletRegistrationBean servletRegBean = new ServletRegistrationBean( new RandCodeImageServlet(), "/randCodeImage" );
		servletRegBean.setName( "randCodeImageServlet" );
		return servletRegBean;
	}
}
