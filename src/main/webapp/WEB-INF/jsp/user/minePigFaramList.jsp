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
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/weui.min.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/jquery-weui.min.css"/>
    <link rel="stylesheet" type="text/css" href="/static/newhope/html/css/common.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/myPigFarms-had.css"/>
</head>
<body>
    <div id="warp">
        <div class="pigFarm-num">
            <p class="pigfarm-num-word">我的所有猪场（${fn:length(pigFaramList) }个）</p>
            <a href="/user/pigFaram/createPage" class="newPigfarm">新建猪场</a>
        </div>
        <c:forEach items="${pigFaramList }" var="pigFaram">
	        <div class="pigfarmInfo">
	            <p class="pigfarmName">猪场名字：${pigFaram.name }</p>
	            <ul class="detailInfo">
	                <li><span class="detail—title">交割地址：</span><span class="detail-content">${pigFaram.mapAddress }</span></li>
	                <li><span class="detail—title">交通情况：</span><span class="detail-content">${pigFaram.otherTrifficInfo } ${pigFaram.limitHeight.displayName } ${pigFaram.limitLength.displayName }</span></li>
	                <li><span class="detail—title">手机号码：</span><span class="detail-content">${pigFaram.mobileStr }</span></li>
	            </ul>
	            <div class="detail-btn">
	                <a class="contactTA" href="tel:${pigFaram.mobile }">联系TA</a>
	                <div class="detail-btn-right">
	                	<c:if test="${pigFaram.source.value=='ZXE' }">
	                    	<button class="del-pigfarm" onclick="deleteFyPigFaram('${pigFaram.id }')">删除</button>
	                	</c:if>
	                	<%-- <c:if test="${pigFaram.source.value=='FY' }">
	                    	<button class="dis-del">删除</button>
	                	</c:if> --%>
	                    <a href="/user/pigFaram/modifyPage?pigFarmId=${pigFaram.id }" class="edit-pigfarm">编辑</a>
	                </div>
	            </div>
	        </div>
        </c:forEach>
    </div>
    <script type="text/javascript" src="/static/newhope/html/js/htmlsize.js"></script>
    <script type="text/javascript" src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="/static/newhope/html/js/jquery-weui.min.js"></script>

    <script type="text/javascript">
        $(".dis-del").click(function () {
            $.toast("放养猪场不可删除", "text");
        });
        
        //删除放养系统的猪场
        function deleteFyPigFaram(pigFaramId){
        	$.ajax({
        		type:"POST",
        		url:"/user/pigFaram/deleteFyPigFaram",
        		data:"pigFaramId="+pigFaramId,
        		dataType:"json",
        		success:function(result){
        			if (result.success){
        				$.toast("已成功删除猪场！", "text");
        				location.reload(true);
        			} else {
        				$.toast(result.msg, "text");
        			}
        		},
        		error:function(){
        			$.toast("操作异常，请联系管理员！", "text");
        		}
        	});
        }

    </script>
    <!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>