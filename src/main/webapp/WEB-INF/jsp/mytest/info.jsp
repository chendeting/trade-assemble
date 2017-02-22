<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script type="text/javascript" src="http://api.map.baidu.com?v=1.4"></script>
<script type="text/javascript">

</script>
</head>
<body>
<input type="button" value="请求" id="input1">
<div id="div1" style="width: 100px;height: 100px;"></div>

	<br>
	<h1>没有分配圈子，角色</h1>
	
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>