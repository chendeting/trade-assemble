<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<html>
<head>
<style type="text/css">
.btn1 {
	width: 100px;
	font-family: 微软雅黑;
}

.btn2 {
	width: 60px;
	height: 30px;
	font-family: 微软雅黑;
	box-shadow: 1px, 1px, 1px, 1px;
	border-radius: 5px;
}

.btn3 {
	width: 80px;
	height: 30px;
	font-family: 微软雅黑;
	box-shadow: 1px, 1px, 1px, 1px;
	border-radius: 5px;
}
div .input3{
border-radius: 6px; 
border-color: #95b8e7;
}
</style>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>用户管理</title>
<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<%@ include file="/context/common.jsp"%>
<script src="/static/plug-in/lhgDialog/lhgdialog.min.js"></script>
</head>
<body>
	<div class="box">
		<div class="box-header">
			<form id="queryForm" name="queryForm" action="/member/querAll"
				method="post">
				<div class="box-body">
					<div class="row">
						<div class="form-group text-right" style="line-height: 30px;">
							<label for="name" class="col-xs-1 control-label"
								style="padding: 0px; width: 40px;">姓名:</label>
							<div class="col-xs-3 ">
								<input type="text" value="${nickName}"
									style="border-radius: 6px; border-color: #95b8e7;"
									class="form-control input-sm" id="nickName" name="nickName">
							</div>
							<label for="phone" class="col-xs-1 control-label"
								style="padding-right: 0px;">手机号:</label>
							<div class="col-xs-3 ">
								<input type="text" value="${mobile }"
									style="border-radius: 6px; border-color: #95b8e7;"
									class="form-control input-sm" id="mobile" name="mobile">
							</div>
						</div>
					</div>
				</div>
			</form>
			<div class="btn-toolbar" role="toolbar">
				<div class="btn-group" role="group">
					<button class="btn btn-primary btn1" id="find">查询</button>
				</div>
				<div class="btn-group" role="group">
					<button class="btn btn-default btn1">重置</button>
				</div>
			</div>
		</div>
	</div>
	<!-- /.box-header -->
	<div class="box-body table-bordered container" style="width: 100%">
		<table id="example2" class="qt" style="width: 100%">

			<thead>
				<tr>
					<th>帐号名称</th>
					<th>呢称</th>
					<th>操作</th>

				</tr>
			</thead>
			<tbody>

				<c:forEach items="${systemUsers}" var="sysuser">
					<tr>
						<td>${sysuser.userName}</td>
						<td>${sysuser.nickName}</td>

						<td>
								<button class="btn btn-primary btn3 passwordModify"
									data-target="#modifyPassword" data-toggle="modal"
									value="${member.id}">修改密码</button>
								
						</td>
					</tr>
				</c:forEach>
			<c:forEach items="${systemConfigs}" var="config">
			    ${config.name }
			</c:forEach>
		</table>
		<c:if test="${systemUsers != null }">
			<tags:pagination paginationSize="5"
				pageUrl="/system/user/list?nickName=${nickName}&mobile=${mobile}&page=" 
				page="${systemUsers }" />
		</c:if>
	</div>
	<!-- /.box-body -->

	<script type="text/javascript" src="/static/newhope/table/table.js"></script>
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>