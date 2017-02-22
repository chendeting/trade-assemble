
package com.newhope.zhuxiaoer.trade;

import org.springframework.boot.builder.SpringApplicationBuilder;

import com.newhope.BootStrap;

public class TradeDevTest {

	public static void main( String[] args ) throws Exception {
		System.setProperty("spring.cloud.config.label", "RD-DGP1");	
		new SpringApplicationBuilder().sources( BootStrap.class ).profiles( "dev" ).run( args );
	}
}
