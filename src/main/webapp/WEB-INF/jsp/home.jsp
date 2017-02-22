<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015-06-11
  Time: 16:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>报表系统</title>
<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<!-- Bootstrap 3.3.5 -->
<link rel="stylesheet" href="static/bootstrap/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet"
	href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<!-- jvectormap -->
<link rel="stylesheet"
	href="static/plug-in/jvectormap/jquery-jvectormap-1.2.2.css">
<!-- Theme style -->
<link rel="stylesheet" href="static/adminLTE/css/AdminLTE.min.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet"
	href="static/adminLTE/css/skins/_all-skins.min.css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
<style type="text/css">
div label {
	font-size: 10px;
}

div .input3 {
	border-radius: 6px;
	border-color: #95b8e7;
}
</style>
</head>
<body class="hold-transition skin-green-light sidebar-mini">
	<div class="wrapper">

		<header class="main-header">

			<!-- Logo -->
			<a href="#" class="logo"> <!-- mini logo for sidebar mini 50x50 pixels -->
				<span class="logo-mini"> <span class="logo-mini"><b>B</b>oss</span></span>
				<!-- logo for regular state and mobile devices --> <span
				class="logo-lg"><b>报表系统</b> <!-- &nbsp;<b style="font-size: 12px;">运营管理系统</b>--></span>
			</a>

			<!-- Header Navbar: style can be found in header.less -->
			<nav class="navbar navbar-static-top" role="navigation">
				<!-- Sidebar toggle button-->
				<a href="#" class="sidebar-toggle" data-toggle="offcanvas"
					role="button"> <span class="sr-only">Toggle navigation</span>
				</a>
				<!-- Navbar Right Menu -->
				<div class="navbar-custom-menu">
					<ul class="nav navbar-nav">
						<!-- User Account: style can be found in dropdown.less -->
						<li class="dropdown user user-menu"><a href="#"
							class="dropdown-toggle" data-toggle="dropdown"> <img
								src="static/adminLTE/img/avatar5.png" class="user-image"
								alt="User Image"> <span class="hidden-xs">${userInfo.nickName}</span>
						</a>
							<ul class="dropdown-menu">
								<!-- User image -->
								<li class="user-header"><img
									src="static/adminLTE/img/avatar5.png" class="img-circle"
									alt="User Image">
									<p>
										${userInfo.userName} <small>注册于${userInfo.gmtCreated}</small>
									</p></li>
								<!-- Menu Footer-->
								<li class="user-footer">
									<div class="pull-left">
										<!-- <a href="#" class="btn btn-default btn-flat">Profile</a>-->
									</div>
									<div class="pull-right">
										<button class="btn btn-info" data-target="#modifyModal"
											data-toggle="modal">修改密码</button>
										<a href="/loginOut" class="btn btn-default btn-flat">退出</a>

									</div>
								</li>
							</ul></li>
						<!-- Control Sidebar Toggle Button -->
					</ul>
				</div>

			</nav>
		</header>
		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar">
			<!-- sidebar: style can be found in sidebar.less -->
			<section class="sidebar">
				<!-- Sidebar user panel -->
				<div class="user-panel">
					<div class="pull-left image">
						<img src="static/adminLTE/img/avatar5.png" class="img-circle"
							alt="User Image">
					</div>
					<div class="pull-left info">
						<p>${userInfo.nickName}</p>
						<a href="#"><i class="fa fa-circle text-success"></i> Online</a>
					</div>
				</div>
				<!-- search form
          <form action="#" method="get" class="sidebar-form">
            <div class="input-group">
              <input type="text" name="q" class="form-control" placeholder="Search...">
              <span class="input-group-btn">
                <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i></button>
              </span>
            </div>
          </form> -->
				<!-- /.search form -->
				<!-- sidebar menu: : style can be found in sidebar.less -->
				<ul class="sidebar-menu">
					<li class="header">菜单列表</li>
					<%@ include file="menu/menu.jsp"%>
				</ul>
			</section>
			<!-- /.sidebar -->
		</aside>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header"></section>

			<!-- Main content -->
			<section class="content">
				<div id="lp_content" class="box box-success">
					<div class="box-header">
						<ul id="bizTabs" class="nav nav-tabs" role="tablist">
							<li role="presentation" class="active"><a
								href="#tab_contentArea" id="tab_tab_contentArea"
								name="tab_tab_contentArea" role="tab" data-toggle="tab"
								aria-controls="home" aria-expanded="false">首页</a></li>
							<!-- li id="tab-refresh" class="pull-right" title="刷新"><a href="#" class="text-muted">
                                    <i class="glyphicon glyphicon-refresh"></i>&nbsp;刷新</a>
                                </li -->
						</ul>
						<div id="tabContent" class="tab-content">
							<div role="tabpanel" class="tab-pane active" id="tab_contentArea">
								<iframe name="contentArea" src="welcome"
									style="width: 100%; height: 725px; border: 0"></iframe>
							</div>
						</div>
					</div>
					<div class="box-body"></div>
				</div>
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->
		<!--  
      <footer class="main-footer">
        <div class="pull-right hidden-xs">
         <strong>Copyright &copy; 2014-2015 <a href="http://www.qingjiejia.com">新希望六和</a>.</strong> All rights reserved.
        </div>
        
      </footer>
 -->
		<!-- Add the sidebar's background. This div must be placed
           immediately after the control sidebar -->
		<div class="control-sidebar-bg"></div>

	</div>
	<!-- ./wrapper -->

	<div class="example-modal">
		<div class="modal fade" id="modifyModal">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">修改密码</h4>
					</div>
					<div class="modal-body">
						<form name="" id="" method="post">
							<input type="text" id="systemUserId" class="hidden"
								value="${userInfo.id}" name="systemUserId">
							<div class="form-group">
								<div class="row">
									<label class="col-xs-1 control-label"
										style="padding: 0px; line-height: 30px; margin-left: 15px; text-align: right;">旧密码</label>
									<div class="col-xs-5">
										<input type="password" class="form-control input-sm input3"
											name="oldPassword" id="oldPassword">
									</div>
								</div>
							</div>
							<div class="form-group">
								<div class="row">
									<label class="col-xs-1 control-label"
										style="padding: 0px; line-height: 30px; margin-left: 15px; text-align: right;">新密码</label>
									<div class="col-xs-5">
										<input type="password" class="form-control input-sm input3"
											name="newPassword" id="newPassword">
									</div>
								</div>
							</div>
							<div class="form-group">
								<div class="row">
									<label class="col-xs-1 control-label"
										style="padding: 0px; line-height: 30px; margin-left: 15px; text-align: right;">确认密码</label>
									<div class="col-xs-5">
										<input type="password" class="form-control input-sm input3"
											name="confirmPassword" id="confirmPassword">
									</div>
								</div>
							</div>
						</form>
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">离开</button>
						<button type="button" class="btn btn-primary pull-left"
							id="modify">修改密码</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->
	</div>

	<!-- jQuery 2.1.4 -->
	<script src="static/plug-in/jquery/jquery-2.1.4.min.js"></script>
	<!-- Bootstrap 3.3.5 -->
	<script src="static/bootstrap/js/bootstrap.min.js"></script>
	<!-- AdminLTE App -->
	<script src="static/adminLTE/js/app.min.js"></script>
	<script src="static/js/member/home.js"></script>
	<script src="/static/plug-in/lhgDialog/lhgdialog.min.js"></script>
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>
