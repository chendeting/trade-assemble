<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>firstTest</title>
</head>
<body>
	<br>
	手机号<input type="text" id="mobile">
	<br>
	类型	
	<input type="radio" name="opType" value="NORMAL">外部用户
	<input type="radio" name="opType" value="ADMIN">销售员
	<input type="radio" name="opType" value="CREATOR">销售经理
	<br>
	交易圈
	<input type="radio" name="circleStr" value="江油">江油
	<input type="radio" name="circleStr" value="乐山">乐山
	<input type="radio" name="circleStr" value="三台">三台
	<br>
	<input type="button" value="发送" onclick="send()">
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
<script src="/static/plug-in/jquery/jquery-1.8.3.min.js"></script>
<script type="text/javascript">
	
	function send(){
		$.ajax({
			url : "/wechat/sendMsg.do",
			type : "POST",
			data : {
				mobile : $("#mobile").val(),
				opType : $("input[name='opType']:checked").val(),
				circleStr : $("input[name='circleStr']:checked").val() 
			},
			cache : false,
			success : function(data) {
				alert(JSON.stringify(data));
			},
			error : function() {
				alert('error');
			}
		});
	}
	
</script>
</html>
