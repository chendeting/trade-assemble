<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <title>我的猪场</title>
    <script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/weui.min.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/jquery-weui.min.css"/>
    <link rel="stylesheet" type="text/css" href="/static/newhope/html/css/common.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/myPigFarms-none.css"/>
    <script type="text/javascript" src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>
</head>
<body>
    <div id="warp">
        <div class="new-pic">
            <img src="/static/newhope/html/images/img_myzc_kong.png"/>
        </div>
        <div class="none-word">
           	 您还没有建立猪场信息立刻新建猪场吧
        </div>
        <div class="new-construction">
            <a href="/user/pigFaram/createPage" class="new-pigFarm">新建猪场</a>
        </div>
    </div>
    <!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>