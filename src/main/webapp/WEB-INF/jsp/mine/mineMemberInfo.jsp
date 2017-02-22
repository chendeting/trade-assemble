<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <title>成员信息</title>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/bootstrap.min.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/weui.min.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/huadongjiazai.min.css"/>
    <link rel="stylesheet" type="text/css" href="/static/newhope/html/css/common.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/memberInfo.css"/>
</head>
<body>

    <div id="warp">
        <div class="member-info">
            <div class="headImg">
            	<c:choose>
           			<c:when test="${fn:startsWith(circleUserEx.headImg,'http') }">
	             		<img src="${circleUserEx.headImg }"/>
           			</c:when>
           			<c:otherwise>
	             		<img src="${imgServer }${circleUserEx.headImg }"/>
           			</c:otherwise>
           		 </c:choose>
            </div>
            <div class="member-message">
            	<input type="hidden" id="circleUserId" value="${circleUserEx.id }"/>
            	<input type="hidden" id="circleId" value="${circleUserEx.circleId }"/>
                <p class="memberName">${circleUserEx.name }</p>
                <p>手机：${circleUserEx.mobileStr }</p>
                <p>入圈时间：<fmt:formatDate value="${circleUserEx.gmtCreated }" pattern="yyyy-MM-dd"/></p>
            </div>
        </div>
        <div class="volume">
        	<input id="trading" type="hidden" value="${empty circleUserEx.trading ? '0' : circleUserEx.trading}"/>
            <p class="all-volume">总交易量：<span>${empty circleUserEx.totalTrade ? '0' : circleUserEx.totalTrade}头</span></p>
            <p class="being-volume">正在交易：<span>${empty circleUserEx.trading ? '0' : circleUserEx.trading}头</span></p>
        </div>
        <div class="line"></div>
        <div class="TA-label">
            <p class="hisLabel">给TA打个标签吧</p>
            <ul class="all-label">
                <li>
                	<img src="/static/newhope/html/images/ic_bao_big.png"/><p>保证金</p>
                	<img class="checked" style="display:${empty userTagTypesMap['CASH_DEPOSIT'] ? 'none' : 'block'}" userTagType="CASH_DEPOSIT" src="/static/newhope/html/images/ic_bao_big_selected.png"/>
                </li>
                <li>
                	<img src="/static/newhope/html/images/ic_yang_big.png"/><p>养殖户</p>
                	<img class="checked" style="display:${empty userTagTypesMap['FARMER'] ? 'none' : 'block'}" userTagType="FARMER" src="/static/newhope/html/images/ic_bao_big_selected.png"/>
                </li>
                <li>
                	<img src="/static/newhope/html/images/ic_fan_big.png"/><p>猪贩子</p>
                	<img class="checked" style="display:${empty userTagTypesMap['PIG_DEALER'] ? 'none' : 'block'}" userTagType="PIG_DEALER" src="/static/newhope/html/images/ic_bao_big_selected.png"/>
                </li>
                <%-- <li>
                	<img src="/static/newhope/html/images/ic_tu_big.png"/><p>屠宰场</p>
                	<img class="checked" style="display:${empty userTagTypesMap['SLAUGHTERHOUSES'] ? 'none' : 'block'}" userTagType="SLAUGHTERHOUSES" src="/static/newhope/html/images/ic_bao_big_selected.png"/>
                </li> --%>
                <li>
                    <img src="/static/newhope/html/images/icon_sell@2x.png"/><p>销售员</p>
                    <img class="checked" style="display:${empty userTagTypesMap['SALES_PERSON'] ? 'none' : 'block'}" userTagType="SALES_PERSON" src="/static/newhope/html/images/ic_bao_big_selected.png"/>
                </li>
                <li>
                	<img src="/static/newhope/html/images/ic_jing_big.png"/><p>猪经济</p>
                	<img class="checked" style="display:${empty userTagTypesMap['PIG_AGENT'] ? 'none' : 'block'}" userTagType="PIG_AGENT" src="/static/newhope/html/images/ic_bao_big_selected.png"/>
                </li>
            </ul>
        </div>
        <div class="member-role">
            <span>成员角色：</span>
            <input type="hidden" id="isBuyer" name="isBuyer" value="${circleUserEx.isBuyer}"/>
            <input type="hidden" id="isSaler" name="isSaler" value="${circleUserEx.isSaler}"/>
            <input type="button" value="买家" name="buyer" class="buyer ${circleUserEx.isBuyer ? 'active' : '' }"/>
            <input type="button" value="卖家" name="seller" class="seller ${circleUserEx.isSaler ? 'active' : '' }"/>
        </div>
        <div class="save-exit">
        	<c:if test="${!circleUserEx.isMaster}">
            	<button class="exit" onclick="submitData('kickOut')">踢出去</button>
        	</c:if>
            <button class="save" onclick="submitData('save')">保存</button>
        </div>
    </div>
    
    <script type="text/javascript" charset="utf-8" src="/static/trade/js/tradeCommon.js"></script>
    <script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
    <script type="text/javascript" src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="/static/newhope/html/js/jquery-weui.min.js"></script>
    <script type="text/javascript">
    	var oldIsBuyer = '${circleUserEx.isBuyer}';
    	var oldIsSaler = '${circleUserEx.isSaler}';
    	
        $(".all-label li").click(function () {
            var checked=$(this).find(".checked");
            if(checked.css("display")=="none"){
                checked.show();
            }else{
                checked.hide();
            }
        });
        $(".buyer").click(function () {
        	$("#isBuyer").val(true);
        	$("#isSaler").val(false);
            $(this).addClass("active");
            $(".seller").removeClass("active");
        });
        $(".seller").click(function () {
        	$("#isBuyer").val(false);
        	$("#isSaler").val(true);
            $(this).addClass("active");
            $(".buyer").removeClass("active");
        })
        
        function submitData(type){
        	var url;
        	var dataJson = {};
        	dataJson.id = $("#circleUserId").val();
        	if (type == "kickOut"){
        		if (parseInt($("#trading").val()) != 0){
        			$.toast("该成员有交易未完成，无法踢出！", "text");
        			return;
        		}
        		$.confirm("确定踢出该成员", function() {
        			  //点击确认后的回调函数
	        			url = "/user/circleUser/kickOutByCircleUserId";
	        			submitDataAjax(url,dataJson);
        			  }, function() {
        			  //点击取消后的回调函数
        			  });
        		
        	} else if (type == 'save'){
        		var newIsBuyer = $("#isBuyer").val();
            	var newIsSaler = $("#isSaler").val();
            	if (!checkEmpty(oldIsBuyer) && oldIsBuyer != newIsBuyer){
            		if (parseInt($("#trading").val()) != 0){
            			$.toast("该成员有交易未完成，无法改变角色！", "text");
            			return;
            		}
            	} else if (!checkEmpty(oldIsSaler) && oldIsSaler != newIsSaler){
            		if (parseInt($("#trading").val()) != 0){
            			$.toast("该成员有交易未完成，无法改变角色！", "text");
            			return;
            		}
            	}
            	
        		url = "/user/circleUser/updateCircleUser";
        		dataJson.isBuyer = $("#isBuyer").val();
        		dataJson.isSaler = $("#isSaler").val();
        		var userTagTypes = [];
        		$(".checked:visible").each(function () {
        			userTagTypes.push($(this).attr("userTagType"));
                });
        		dataJson.userTagTypes = userTagTypes;
        		submitDataAjax(url,dataJson);
        	}
        }
        
        //后台 ajax发送数据
        function submitDataAjax(url,dataJson){
        	$.ajax({
        		type:'POST',
        		url:url,
        		data:JSON.stringify(dataJson),
        		contentType:'application/json',
        		dataType:'json',
        		success:function(result){
        			if (result.success){
        				location.href="/user/circleUser/toCircleUserListPage?circleId="+$("#circleId").val()+"&v="+Math.random();
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