<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head lang="en">
<meta charset="UTF-8">
<title>卖猪信息</title>
<style type="text/css">
	*{
		font-size : 1.5rem
	}
</style>
</head>
<body>
  <ul>
   <c:forEach items="${listCircleUser }" var="circleUser">
   <li><a href="/user/applyCircle/toApplyPage?circleId=${circleUser.circleId }">申请入圈${circleUser.name }</a></li>
   </c:forEach>
  </ul>
  <br>
  <br>
<!--   <a href="http://rock.tunnel.qydev.com//user/applyCircle/mineShare.do?circleId=4&userId=25&circleMasterId=999&circleRole=BUYER">分享</a>
 -->
   
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
 </body>
</html>