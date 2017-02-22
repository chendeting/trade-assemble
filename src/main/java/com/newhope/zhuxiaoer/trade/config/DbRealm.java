//package com.newhope.bps.pietrion.config;
//
//import org.apache.shiro.authc.*;
//import org.apache.shiro.authz.AuthorizationInfo;
//import org.apache.shiro.realm.AuthorizingRealm;
//import org.apache.shiro.subject.PrincipalCollection;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import com.newhope.bps.pietrion.biz.system.SystemServiceImpl;
//
//
///**
// * Created by liubin on 2015-06-11.
// */
//
//public class DbRealm extends AuthorizingRealm {
//
//	private Logger logger = LoggerFactory.getLogger( DbRealm.class ); 
//
////	@Autowired
////	private SystemServiceImpl systemServiceImpl;
////	
//	@Override
//	protected AuthorizationInfo doGetAuthorizationInfo( PrincipalCollection principals ) {
//		return null;
//	}
//
//	@Override
//	protected AuthenticationInfo doGetAuthenticationInfo( AuthenticationToken token ) throws AuthenticationException {
//
//		UsernamePasswordToken captchaToken = ( UsernamePasswordToken ) token;
//		String username = captchaToken.getUsername();
//		String password = String.valueOf( captchaToken.getPassword() );
//		String pwd = "123";// EncryptionUtil.encodeWithHexStr(password,
//							// EncryptionUtil.DigestALGEnum.SHA);
//		captchaToken.setPassword( pwd.toCharArray() );
//
//		// SystemUser user = systemUserService.get(username, pwd);
//		Object user = new Object();
//		if ( user != null ) {
//			return new SimpleAuthenticationInfo( username, "123", getName() );
//		} else {
//			return null;
//		}
//	}
//}
