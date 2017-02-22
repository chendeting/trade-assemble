<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.newhope.zhuxiaoer.trade.common.helper.DateUtils" %>
<%
	String nowDate = DateUtils.formatDate( new java.util.Date());
	String nextDate = DateUtils.formatDate( DateUtils.add( new java.util.Date(),java.util.Calendar.DAY_OF_MONTH, 1 ) );
	String nextNextDate = DateUtils.formatDate( DateUtils.add( new java.util.Date(),java.util.Calendar.DAY_OF_MONTH, 2 ) );
%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta name="x5-orientation" content="portrait">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<meta charset="UTF-8">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="Pragma"content="no-cache">  
<title>我的拍卖场</title>
<link type="text/css" rel="stylesheet" href="/static/newhope/html/css/index.css">
<link rel="stylesheet" type="text/css" href="/static/newhope/html/css/bootstrap.min.css"/>
<link rel="stylesheet" type="text/css" href="/static/newhope/html/css/font-awesome.min.css"/>
<link rel="stylesheet" type="text/css" href="/static/newhope/html/css/mobiscroll_002.css"/>
<link rel="stylesheet" type="text/css" href="/static/newhope/html/css/mobiscroll.css"/>
<link rel="stylesheet" type="text/css" href="/static/newhope/html/css/mobiscroll_003.css"/>
<style type="text/css">
	input {
	    border: none;
	    outline: none;
	}
</style>

</head>
<body style="background-color: #ebebeb">

	<div>
		<input type="hidden" id="circleId" value="${circleId }"/>
		<input type="hidden" id="userId" value="${userId }"/>
		<input type="hidden" id="selfPrice" value="${selfPrice}"/>
		<input type="hidden" id="hasProduct" value="${hasProduct }"/>
		<input type="hidden" id="nowDate" value="<%=nowDate%>"/>
		<input type="hidden" id="circleRole" value="${circleRole.value}"/>
		<input type="hidden" id="dateDiffMapFlag"/>
		
		<div>
			<div class="grounding_1">
				<div class="grounding_message">统一定价</div>
			</div>
		</div>
		<div style="background-color: #ffffff; width: 20rem; height: 1px;">
			<div class="line2"></div>
		</div>
		<div>
			<div class="grounding_1">
				<div class="grounding_message1">竞拍日期</div>
                <div class="grounding_message2">
                	<c:if test="${empty expireDate}">
                    	<input value="<%=nowDate%>" style="height:2.2rem;" class="time_date" readonly="readonly" name="chooseDate" id="chooseDate" type="text" onchange="changeChooseDate(this)"/>
                	</c:if>
                	<c:if test="${!empty expireDate}">
                    	<input value="${expireDate}" style="height:2.2rem;" class="time_date" readonly="readonly" name="chooseDate" id="chooseDate" type="text" onchange="changeChooseDate(this)"/>
                	</c:if>
				</div>
<!-- 				<div style="float: left;"> -->
<!-- 					<input type="button" class="grounding_select_pic1"> -->
<!-- 				</div> -->
			</div>
		</div>
		<div style="background-color: #ffffff; width: 20rem; height: 1px;">
			<div class="line2"></div>
		</div>
		<div class="load">
			<div id="V0Price" style="width: 20rem; height: 7.7rem; background-color: #ffffff;">
				<div style="font-size: 0.777778rem; color: #4a90e2; width: 3.8rem; text-align: right; height: 2.5rem; line-height: 2.5rem; float: left; position: absolute;">V0价格</div>
				<div style="width: 1px; height: 0.6rem; background-color: #4a90e2; float: left; position: absolute; margin-left: 4.4rem; margin-top: 1rem;"></div>
				<c:forEach items="${priceWeightMap}" var="priceWeight">
					<div class="grounding_luru">
						<input type="hidden" name="weightScop" class="${priceWeight.key}" value="${priceWeight.key}"/>
						<input type="hidden" name="weightDes" value="${priceWeight.value}"/>
						<c:set value="V0_${priceWeight.key }" var="priceMapKey"></c:set>
						<input type="hidden" name="priceId" value="${selfPrice ? circlePriceMap[priceMapKey].id : '0'}"/>
						
						<span class="grounding_luru_text"> ${priceWeight.value}: </span> 
						<span>
							<div class="grounding_luru_input">
								<input class="input_small decimalNum" name="price" value="${circlePriceMap[priceMapKey].price }" type="number" ${circleRole.value == 'CREATOR' ? '' : ' disabled="disabled" '}><span>&nbsp;元</span>
							</div>
						</span>
					</div>
				</c:forEach>
			</div>
			<div class="line2"></div>
			<div id="V1Price" style="width: 20rem; height: 7.7rem; background-color: #ffffff;">
				<div style="font-size: 0.777778rem; color: #4a90e2; width: 3.8rem; text-align: right; height: 2.5rem; line-height: 2.5rem; float: left; position: absolute;">V1价格</div>
				<div style="width: 1px; height: 0.6rem; background-color: #4a90e2; float: left; position: absolute; margin-left: 4.4rem; margin-top: 1rem;"></div>
				<c:forEach items="${priceWeightMap}" var="priceWeight">
					<div class="grounding_luru">
						<input type="hidden" name="weightScop" class="${priceWeight.key}" value="${priceWeight.key}"/>
						<input type="hidden" name="weightDes" value="${priceWeight.value}"/>
						<c:set value="V1_${priceWeight.key }" var="priceMapKey"></c:set>
						<input type="hidden" name="priceId" value="${selfPrice ? circlePriceMap[priceMapKey].id : '0' }"/>
						
						<span class="grounding_luru_text"> ${priceWeight.value}: </span> 
						<span>
							<div class="grounding_luru_input">
								<input class="input_small decimalNum" name="price" value="${circlePriceMap[priceMapKey].price }" type="number" ${circleRole.value == 'CREATOR' ? '' : ' disabled="disabled" '}><span>&nbsp;元</span>
							</div>
						</span>
					</div>
				</c:forEach>
			</div>
			<div style="background-color: #ffffff; width: 20rem; height: 1px; float: left;">
				<div class="line2"></div>
			</div>
		</div>
		<div style="background-color: #ffffff; width: 20rem; height: 1px;display:${circleRole.value == 'CREATOR' ? '' : 'none'};">
			<div class="line2"></div>
		</div>
		<div style="display:${circleRole.value == 'CREATOR' ? '' : 'none'};">
			<div class="grounding_3">
				<div class="grounding_message1 xiugai" id="dateDiffText" style="display: none;">距可修改截止</div>
				<div class="grounding_message2 xiugai" id="dateDiff" style="display: none;"></div>
				
				<button class="revise modifyPriceBut" style="display:none; ">确定</button>
				<button class="revise1" disabled="disabled" style="display:none; ">修改</button>
				<button class="revise2 modifyPriceBut" style="display:none; ">修改</button>
			</div>
		</div>
		<div style="background-color: #ffffff; width: 20rem; height: 1px;">
			<div class="line"></div>
		</div>
		<div>
			<div class="grounding_1" onclick="location.href = '/mine/auctionHouse/toHistoryPage?circleId=${circleId }'">
				<div class="grounding_message">历史定价查看</div>
				<div style="float: left;">
					<input type="button" class="grounding_select_pic1">
				</div>
			</div>
		</div>
		<div class="wall"></div>
		<div>
			<div class="grounding_1">
				<div class="grounding_message">统一拍卖时间</div>
				<div class="grounding_message2">
				
					<span id="BID_TIME_START">${empty circleSeetingMap['BID_TIME_START'] ? '10:00' : circleSeetingMap['BID_TIME_START'].ruleValue}</span>
					-
					<span id="BID_TIME_END">${empty circleSeetingMap['BID_TIME_END'] ? '22:00' : circleSeetingMap['BID_TIME_END'].ruleValue}</span>
				</div>
				<div style="float: left;display:${circleRole.value == 'CREATOR' ? '' : 'none'};" id="modifyCircleTime">
					<a href="javascript:void(0);" id="toTimePage" onclick="toTimePage()">
						<input type="button" class="grounding_select_pic1">
					</a>
				</div>
			</div>
		</div>
		<div class="wall"></div>
		<div>
			<div class="grounding_1">
				<div class="grounding_message">我的拍卖场场成员</div>
				<div class="grounding_message2" style="margin-left: 7.8rem;">${requestScope.totalMember }人</div>
				<div style="float: left;">
					<a href="/mine/auctionHouse/selectCircleUserByCircleId?circleId=${circleId }">
						<input type="button" class="grounding_select_pic1">
					</a>
				</div>
			</div>
		</div>
	</div>
	 
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/bootstrap.min.js"></script>
<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/moment.js"></script>
<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/mobiscroll_002.js"></script>
<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/mobiscroll_004.js"></script>
<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/mobiscroll.js"></script>
<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/mobiscroll_003.js"></script>
<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/mobiscroll_005.js"></script>
<script type="text/javascript" charset="utf-8" src="/static/plug-in/layer/layer.js"></script> 

<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
<script type="text/javascript" charset="utf-8" src="/static/trade/js/mineAuctionHouse.js?v=20161119111229"></script>
<script type="text/javascript" charset="utf-8" src="/static/trade/js/tradeCommon.js"></script>

<script type="text/javascript">
$(function () {
    var currYear = (new Date()).getFullYear();
    var opt={};
    opt.date = {preset : 'date'};
    opt.datetime = {preset : 'datetime'};
    opt.time = {preset : 'time'};
    opt.default = {
        theme: 'android-ics light', //皮肤样式
        display: 'modal', //显示方式
        mode: 'scroller', //日期选择模式
        dateFormat: 'yyyy-mm-dd',
        lang: 'zh',
        showNow: true,
        nowText: "今天",
        minDate: new Date(),
        startYear: currYear, //开始年份
        endYear: currYear + 4 //结束年份
    };
    var optDate = $.extend(opt['date'], opt['default'])
    $("#chooseDate").mobiscroll(optDate);
});
</script>
</html>