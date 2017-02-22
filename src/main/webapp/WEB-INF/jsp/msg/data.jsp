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
	姓名<input type="text" id="name">
	<br>
	机构
	<input type="radio" name="organize" value="test-zhuxiaoer-1">测试放养服务部
	<input type="radio" name="organize" value="01918ff4-540c-478b-b417-76fac36d2086">乐山农牧放养服务部
	<input type="radio" name="organize" value="85fa34cc-225b-4f3c-953f-28cdd4fdc11d">江油服务部
	<input type="radio" name="organize" value="cb2add9f-7f69-4f52-99a5-90d99a2ae96e">绵竹服务部
	<input type="radio" name="organize" value="4125bdec-0eee-4a3a-acef-881ee3e9e92e">三台农牧放养部
	<br>
	交易圈
	<input type="radio" name="circle" value="1">TEST1拍卖圈
	<input type="radio" name="circle" value="2">TEST2拍卖圈
	<input type="radio" name="circle" value="3">乐山放养拍卖圈
	<input type="radio" name="circle" value="4">江油放养拍卖圈
	<input type="radio" name="circle" value="5">三台放养拍卖圈
	<br>
	角色
	<input type="radio" name="role" value="NORMAL">外部用户
	<input type="radio" name="role" value="ADMIN">销售员
	<input type="radio" name="role" value="CREATOR">销售经理
	<br>
	等级
	<input type="radio" name="level" value="V0">V0
	<input type="radio" name="level" value="V1">V1
	<br>
	<input type="radio" name="insertType" value="1">圈子用户表
	<input type="radio" name="insertType" value="2">全部
	<br>
	<input type="button" value="加入" onclick="add()">
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
<script src="/static/plug-in/jquery/jquery-1.8.3.min.js"></script>
<script type="text/javascript">
	
	function add(){
		$.ajax({
			url : "/wechat/addTheData.do",
			type : "POST",
			data : {
				mobile : $("#mobile").val().trim(),
				name : $("#name").val().trim(),
				organize : $("input[name='organize']:checked").val(),
				circle : $("input[name='circle']:checked").val(),
				role : $("input[name='role']:checked").val(),
				level : $("input[name='level']:checked").val(),
				insertType : $("input[name='insertType']:checked").val()
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
