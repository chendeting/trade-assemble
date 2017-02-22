<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta name="x5-orientation" content="portrait">
<meta name="format-detection" content="telephone=no">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<meta charset="utf-8">
<title>交易详情</title>
<link type="text/css" rel="stylesheet" href="/static/newhope/html/css/index.css">
<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
<script style="" charset="UTF-8" src="/static/newhope/html/js/jquery-1.8.3.min.js"></script>
<style type="text/css">
input {
	border: none;
	outline: none;
}

input[type="radio"] {
	margin-top: 0rem;
}
.submitBtn{
	margin-bottom: 1rem; 
	width: 17rem; 
	height: 2.222222rem; 
	margin-top: 1rem; 
	margin-left: 1.5rem; 
	border: none; 
	outline: none; 
	background: #F02B2B; 
	background-image: linear-gradient(-180deg, #F04746 0%, #DD4B39 100%); 
	box-shadow: 0rem 0rem 0.36rem 0rem rgba(235, 72, 66, 0.50); 
	border-radius: 1.5rem; 
	font-size: 1rem; 
	color: #ffffff; 
	font-family: 'Microsoft YaHei'; 
	text-align: center;
}
</style>
</head>
<body>
	<div class="order_head">
		<input type="hidden" value="${imgServer}" id="imgServer"/>
		<input type="hidden" value="${userId}" id="userId"/>
		<input type="hidden" value="${circleRole}" id="circleRole"/>
		<input type="hidden" value="${productInfoEx.publishUserId}" id="publishUserId"/>
		
		<input type="hidden" id="productId" value="${productInfoEx.id }"/>
		<input type="hidden" id="circleId" value="${productInfoEx.circleId }"/>
		<c:forEach items="${productInfoEx.productPriceList }" var="productPrice">
			<input type="hidden" id="${productPrice.userLevel }_${productPrice.weightScop }" value="${productPrice.price }"/>
		</c:forEach>
		<div class="order_head_1">${productInfoEx.farmerName }的猪场</div>
		<div class="order_head_2">
			<span> 已卖出： 
				<span style="font-size: 1rem; color: #F02B2B;"> ${empty productInfoEx.bidedNumber ? '0' :productInfoEx.bidedNumber} </span> 
				<span style="font-size: 0.777778rem; color: #F02B2B;">头</span>
			</span> 
			<span> &nbsp;剩余： </span> 
			<span style="font-size: 1rem; color: #F02B2B;"> ${productInfoEx.surplusNumber } </span> 
			<span style="font-size: 0.777778rem; color: #F02B2B;">头</span>
		</div>
	</div>
	<div class="order_part1">
		<c:forEach items="${productInfoEx.exOrderList }" var="exOrder" >
			<div>
				<div class="order_bg_1">
					<c:if test="${!empty exOrder.buyUserHeadImg}">
						<div class="order_pic_bg" style="background-image: url(${exOrder.buyUserHeadImg});"></div>
					</c:if>
					<c:if test="${empty exOrder.buyUserHeadImg}">
						<div class="order_pic_bg"></div>
					</c:if>
					<div class="order_phone_bg">
						<a href="tel:${exOrder.buyUserMobile}" class="order_phone_pic"></a>
					</div>
					<div class="order_text">
						<div class="order_username">${exOrder.buyUserRealName}</div>
						<div class="order_message">
							<div class="order_message_1">拍猪数量:</div>
							<div class="order_message_2">${exOrder.count}头</div>
						</div>
						<div class="order_message">
							<div class="order_message_1">订单号:</div>
							<div class="order_message_2">${exOrder.orderNumber}</div>
						</div>
						<div class="order_message" style="display:${exOrder.isEntered.value == 'NO' ? 'block' : 'none' };">
							<div class="order_message_3">录入情况</div>
							<div class="order_message_4">
								<div class="order_radio1" style="display:none;">是</div>
								<div class="order_radio2"></div>
								<div class="order_radio3" onclick="showEditDiv(${exOrder.id},'no')">否</div>
								<div class="order_radio4" style="display:none;"></div>
							</div>
						</div>
						<div class="order_message" style="display:${exOrder.isEntered.value == 'YES' ? 'block' : 'none' };">
							<div class="order_wancheng_icon"></div>
                          	<div class="order_wancheng_text">已录入信息</div>
						</div>
					</div>
				</div>
				<div class="order_bg_2" style="display: ${exOrder.isEntered.value == 'YES' ? 'block' : 'none' };">
					<div style="margin-left: 6.5rem; position: relative;" onclick="showEditDiv(${exOrder.id})">
						<button class="order_xiala_pic"></button>
						<div class="order_xiala_text">修改更多订单信息</div>
					</div>
				</div>
				<div class="wall"></div>
			</div>
		</c:forEach>
	</div>
	<div class="order_part2" style="display: none;" style="background-color: #fafafc">
		<div class="order_part2_bg"></div>
		<div>
			<div class="order_bg_1">
				<div class="order_pic_bg"></div>
				<div class="order_phone_bg">
					<a href="javascript:void(0);" class="order_phone_pic"></a>
				</div>
				<div class="order_text">
					<input type="hidden" id="buyUserId"/>
					<div class="order_username" id="buyUserRealName"></div>
					<div class="order_message">
						<div class="order_message_1">拍猪数量:</div>
						<div class="order_message_2" id="orderCount"></div>
					</div>
					<div class="order_message">
						<div class="order_message_1">订单号:</div>
						<div class="order_message_2" id="orderNum"></div>
					</div>
					<div class="order_message" id="noEntered">
						<div class="order_message_3">录入情况</div>
						<div class="order_message_5">
							<div class="order_radio1" onclick="hideEditDiv()">是</div>
							<div class="order_radio5" style="display: none;"></div>
							<div class="order_radio3" style="display: none;">否</div>
							<div class="order_radio6"></div>
						</div>
					</div>
					<div class="order_message" id="yesEntered">
						<div class="order_wancheng_icon"></div>
                        <div class="order_wancheng_text">已录入信息</div>
					</div>
				</div>
			</div>
			<div class="order_bg_2">
				<div style="margin-left: 6.5rem; position: relative;" onclick="hideEditDiv()">
					<button class="order_shangla_pic"></button>
					<div class="order_xiala_text">收起订单信息</div>
				</div>
			</div>
			<div class="line"></div>
			<form action="/mine/saledProduct/saveOrderTradeInfo" id="orderTradeForm" method="post">
				<div class="order_check">
					<div class="order_select">
						<div style="float: left; margin-left: 0.5rem;">
							<input class="order_check1" type="radio" name="orderTradeType" value="PULL_PIG" onclick="changeTradeType('PULL_PIG');"><span>&nbsp;已拉猪</span>
						</div>
						<div style="margin-left: 5.3rem; float: left;">
							<input class="order_check2" type="radio" name="orderTradeType" value="GIVE_UP_ORDER"  onclick="changeTradeType('GIVE_UP_ORDER');"><span>&nbsp;跑单</span>
						</div>
					</div>
				</div>
				<div class="line3" style="width: 14rem; height: 1px; background-color: #979797; opacity: 0.2; margin: auto;"></div>
				<div style="width: 20rem; height: 0.8rem;"></div>
				<div id="baseInfoDiv">
					<input type="hidden" id="orderId" name="orderId"/>
					<input type="hidden" id="orderTradeId" name="id"/>
					
					<div class="order_xiala_message1">
						<div class="order_xiala_message_1">拉猪头数:</div>
						<div class="order_xiala_message_2">
							<input type="number" class="order_xiala_message_input wholeNum requireInput" maxlength="7" alertMsg="拉猪头数不能为空！" name="pullPigNum" id = "pullPigNum" onblur="changePriceAvgWeight()"/>
							<div class="order_xiala_message_unit">头</div>
						</div>
					</div>
					<div class="order_xiala_message1">
						<div class="order_xiala_message_1">猪只总重:</div>
						<div class="order_xiala_message_2">
							<input type="number" class="order_xiala_message_input decimalNum requireInput" maxlength="16" alertMsg="猪只总重不能为空！" name="pigTotalWeight" id="pigTotalWeight" onblur="changePriceAvgWeight()"/>
							<div class="order_xiala_message_unit">kg</div>
						</div>
					</div>
					<div class="order_xiala_message1">
						<div class="order_xiala_message_1">猪只均重:</div>
						<div class="order_xiala_message_2">
							<input class="order_xiala_message_input" name="pigAvgWeight" type="hidden" id="pigAvgWeight"/>
							<label class="order_xiala_message_label"></label>
							<div class="order_xiala_message_unit">kg</div>
						</div>
					</div>
					<div class="order_xiala_message1">
						<div class="order_xiala_message_1">单价:</div>
						<div class="order_xiala_message_2">
							<input class="order_xiala_message_input" name="unitPrice" type="hidden" id="unitPrice"/>
							<label class="order_xiala_message_label"></label>
							<div class="order_xiala_message_unit">元/kg</div>
						</div>
					</div>
					<div class="order_xiala_message1">
						<div class="order_xiala_message_1">应收金额:</div>
						<div class="order_xiala_message_2">
							<input class="order_xiala_message_input" name="receivableTotalPrice" type="hidden" id="receivableTotalPrice"/>
							<label class="order_xiala_message_label"></label>
							<div class="order_xiala_message_unit">元</div>
						</div>
					</div>
					<div class="order_xiala_message1">
						<div class="order_xiala_message_1">实收金额:</div>
						<div class="order_xiala_message_2">
							<input type="number" class="order_xiala_message_input decimalNum requireInput" maxlength="20" alertMsg="实收金额不能为空！" name="realTotalPrice" id="realTotalPrice" onchange="changeRealPrice();"/>
							<div class="order_xiala_message_unit">元</div>
						</div>
					</div>
				</div>
				<div class="order_xiala_message2">
					<div class="order_xiala_message_1">异常情况:</div>
					<div class="order_xiala_message_2">
						<textarea class="order_xiala_message_textarea" name="remarks" id="remarks" maxlength="950"></textarea>
					</div>
				</div>
			</form>
			<div>
			</div>
		</div>
		<button class="submitBtn" onclick="submitForm()" type="button">提交</button>
	</div>
	  
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
<script type="text/javascript" charset="utf-8" src="/static/plug-in/layer/layer.js"></script> 
<script type="text/javascript" charset="utf-8" src="/static/trade/js/jquery-form.js"></script>
<script type="text/javascript" src="/static/trade/js/saledProductDetail.js?v=20161119111228"></script>
<script type="text/javascript" charset="utf-8" src="/static/trade/js/tradeCommon.js"></script>
</html>