<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript" src="/static/plug-in/jquery/jquery-1.8.3.min.js"></script>

</head>
<body>
<input type="button" value="test" id="test">
<input type="text" id="btn1">
<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>

<script type="text/javascript">
$("#test").bind("click",function(){
	$.ajax({ 
	    type: "post",
	    url: "/system/usertest/list",
	    data: "a=11111",
	    //contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    success: function (data) { 
		alter(data.userName)
		$("#btn1").val(data.userName);
	    },
	    error: function (XMLHttpReqeust) { alert(XMLHttpReqeust.responseText); },
	    complete: function (XMLHttpReqeust, textStatus) { }
	});
});

</script>
</html>