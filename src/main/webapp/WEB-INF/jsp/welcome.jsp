<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015-06-11
  Time: 16:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title></title>
<%@ include file="/context/common.jsp"%>
<style type="text/css">
i {
	margin-top: 20px
}

;
div {
	font-size: 12px;
}
</style>
</head>
<body>
<h1>welcome</h1>
<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>
