<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <meta name="x5-orientation" content="portrait">
    <title>猪小e交易圈</title>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/weui.min.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/jquery-weui.min.css"/>
    <link rel="stylesheet" type="text/css" href="/static/newhope/html/css/common.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/jiaoyiquan.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/font-awesome/css/font-awesome.min.css"/>
    <script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
    <script type="text/javascript" charset="UTF-8" src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>
</head>
<body style="background-color: #fff">
    <div id="warp">
        <div class="GPS">
            
            <a class="GPS-txt" href="#">&emsp;当前城市：<span>${currentCityName }</span><img class="detail-img" src="/static/newhope/html/images/ic_list_detail.png"></a>
            
        </div>
        <div class="currentCity">
            当前定位城市
        </div>
	        <div class="cityName">
        		<c:if test="${!empty currentCityName}">
	            	<div style="width:auto;padding:0.1rem 0.3rem">${currentCityName }</div>
       			 </c:if>
	        </div>
        <div class="currentCity">
            交易已开通城市
        </div>
        <div class="everyCitylist">
            <ul>
                	<%-- <li>
               			<c:forEach items="${openCityList }" var="cityName">
	                    	<div class="everyCity" data-id="${cityName }">${cityName }</div>
               			</c:forEach>
                	</li> --%>
                	<li>
                	<div class="everyCity">三台</div>
                	<div class="everyCity">江油</div>
                	<div class="everyCity">乐山</div>
                	</li>
                	
            </ul>

        </div>
    </div>
    <!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>

</html>