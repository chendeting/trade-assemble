<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<meta charset="UTF-8">
<meta http-equiv="cache-control" content="no-cache">
<title>订单详情</title>
<link type="text/css" rel="stylesheet"
	href="/static/newhope/html/css/index.css">
<script type="text/javascript" charset="utf-8"
	src="/static/newhope/html/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" charset="utf-8"
	src="/static/newhope/html/js/htmlsize.js"></script>
<style type="text/css">
		body{margin: 0px;  padding: 0px;font-family: "Microsoft YaHei";}
        li {list-style:none;}
        table{margin-left: 0.6rem;}
</style>
</head>
<body style="background-color: #ffffff;">
		<div class="lunbo">
			<ul class="pic">
				<c:forEach
					items="${order.tradeProductInfoExModel.bidInfoImgModelLst}"
					var="image">
					<li><img src="${imgServer}/resize/380/260${image.url}" /></li>
				</c:forEach>
			</ul>
			 <c:if test="${!empty order.tradeProductInfoExModel.bidInfoImgModelLst && fn:length(order.tradeProductInfoExModel.bidInfoImgModelLst) > 1}">
				<ul class="btn">
				<c:forEach
					items="${order.tradeProductInfoExModel.bidInfoImgModelLst}">
					<li></li>
				</c:forEach>
				</ul>
			</c:if>	
		</div>
		<div >
			<div>
				<div class="massage_details1">
						<div class="message_head">联系人:</div>
						<div class="message_text1">
						<c:choose>
						<c:when test="${role eq 'NORMAL'}">${order.tradeProductInfoExModel.publisherRealName}</c:when>
						<c:otherwise>${order.buyUserRealName}</c:otherwise> 
						</c:choose> 
					   </div>
				</div>   	
				<div class="massage_details1">
						<div class="message_head">联系电话:</div>
						<div class="message_text1">
						<c:choose>
						 <c:when test="${role eq 'NORMAL'}">${order.tradeProductInfoExModel.publishUserMobile}</c:when>
						 <c:otherwise>${order.buyUserMobile}</c:otherwise>
						 </c:choose>
						</div>
			   </div>
				<a class="phone" href="tel:<c:choose><c:when test="${role eq 'NORMAL'}">${order.tradeProductInfoExModel.publishUserMobile}</c:when><c:otherwise>${order.buyUserMobile} </c:otherwise></c:choose>"> <img
					src="/static/newhope/html/images/phone.png"
					style="width: 100%; height: 100%;">
				</a>
				<div class="piggery_line"></div>

		</div>
			<div class="piggery_name">${order.tradeProductInfoExModel.farmerName}的猪场</div>
			<div class="piggery_num">
				<span style="font-size: 0.9rem; color: #F02B2B;">购入</span><span
					style="font-size: 1rem; color: #F02B2B;">${order.count}</span><span
					style="font-size: 0.65rem; color: #F02B2B;">头</span>
			</div>
			<div class="piggery_line"></div>
			<div>
			  <div>
			    <div class="massage_details3">
						<div class="message_head">所在地区:</div>
					  	<div class="message_text3">${order.tradeProductInfoExModel.pigFaramAddress.provName}${order.tradeProductInfoExModel.pigFaramAddress.cityName}${order.tradeProductInfoExModel.pigFaramAddress.countyName}${order.tradeProductInfoExModel.pigFaramAddress.townName}</div>
					<div style="clear: both;"></div>
				</div>
				<div class="massage_details3">
					<div class="message_head">详细地址:</div>
					<c:choose>
					  <c:when test="${!empty order.tradeProductInfoExModel.mapAddress}">
					  <div class="message_text3">${order.tradeProductInfoExModel.mapAddress}</div>
					  </c:when>
					  <c:otherwise>
					  <div class="message_text3">${order.tradeProductInfoExModel.adressDetail}</div>
					  </c:otherwise>
					</c:choose>
					<div style="clear: both;"></div>
				</div>
				<div style="width: 20rem; position: relative;">
					<div onclick="mapDaoHang()"
						style="float: left; font-size: 0.666667rem; margin-top: 0.4rem; margin-left: 3.7rem; color: #4a90e2;">导航</div>
					<img  onclick="mapDaoHang()" src="/static/newhope/html/images/Group.png"
						style="width: 1rem; height: 1rem; float: left; margin-left: 0.3rem; margin-top: 0.35rem;" />
		  		</div> 
				<div class="massage_details">
					<div class="message_head">交通状况:</div>
					<div class="message_text">${order.tradeProductInfoExModel.trifficInfo.displayName}</div>
				</div>
				<div class="piggery_line1"></div>
			   </div>	
			</div>
			<div>
				<div class="massage_details">
					<div class="message_head">交割日期:</div>
					<div class="message_text">
						<fmt:formatDate
							value="${order.tradeProductInfoExModel.marketingDate}"
							pattern="yyyy-MM-dd" />
					</div>
				</div>
				<div class="massage_details">
					<div class="message_head">出栏数量:</div>
					<div class="message_text">
						<span>${order.tradeProductInfoExModel.marketingNumber}头</span>
					</div>
				</div>
				<div class="massage_details2">
				 <div class="message_head">出栏价格:</div>
				 <c:choose>
				   <c:when test="${!empty  order.tradeProductInfoExModel.productPriceList }">
				 	<div class="message_text_box">
				 	<c:forEach
						items="${order.tradeProductInfoExModel.productPriceList }"
						var="priceModel" varStatus="num">
						<c:choose>
							<c:when test="${num.index == 0 }">
								<c:choose>
									<c:when test="${role == 'NORMAL'}">
										<div class="message_text">
											<span>${priceModel.price }</span><span>元/kg</span>
											<span style="color: #848689;">(${priceModel.weightDes })</span>
										</div>
									</c:when>
									<c:otherwise>
										<c:if test="${priceModel.userLevel eq 'V0' }">
											<div class="message_text">
												<span>${priceModel.price }</span><span>元/kg</span><span
													style="color: #848689;">(${priceModel.weightDes })</span>
											</div>
										</c:if>
										<c:if test="${priceModel.userLevel eq 'V1' }">
											<div class="message_text">
												<span>${priceModel.price }</span><span>元/kg</span><span
													style="color: #848689;">(${priceModel.weightDes })</span>
											</div>
										</c:if>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${role eq 'NORMAL'}">
										<div class="message_text">
											<span>${priceModel.price }</span><span>元/kg</span>
											<span style="color: #848689;">(${priceModel.weightDes })</span>
										</div>
									</c:when>
									<c:otherwise>
										<c:if test="${priceModel.userLevel eq 'V0' }">
											<div class="message_text">
												<span>${priceModel.price }</span><span>元/kg</span><span
													style="color: #848689;">(${priceModel.weightDes })</span>
											</div>
										</c:if>
										<c:if test="${priceModel.userLevel eq 'V1' }">
											<div class="message_text">
												<span>${priceModel.price }</span><span>元/kg</span><span
													style="color: #848689;">(${priceModel.weightDes })</span>
											</div>
										</c:if>
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					</div>  
				   </c:when>
				   <c:otherwise>
				   <div class="message_text">
						<span>待定</span>
					</div>
				   </c:otherwise>
				 </c:choose>
				</div>
				<div class="massage_details">
					<div class="message_head">出栏类型:</div>
					<div class="message_text">${order.tradeProductInfoExModel.pigType.displayName }</div>
				</div>
				<div class="massage_details">
					<div class="message_head">出栏品级:</div>
					<div class="message_text">${order.tradeProductInfoExModel.level.displayName }</div>
				</div>
				<div class="massage_details">
					<div class="message_head">预估均重:</div>
					<div class="message_text">${order.tradeProductInfoExModel.preAvgWeight} kg</div>
				</div>
				<div class="piggery_line"></div>
			</div>
			<div>
				<div class="massage_details">
					<div class="message_head">控料情况:</div>
					<div class="message_text">${order.tradeProductInfoExModel.controllerFeedstuffInfo.displayName}</div>
				</div>
			</div>
			<div style="width: 20rem;height:0.2rem;background-color: #fff;float: left;"></div>
		</div>
		
		<script type="text/javascript" charset="utf-8" src="/static/plug-in/layer/layer.js"></script> 
<script type="text/javascript">
		$(function() {
			var listLen = $(".pic li").length, i = 0, setInter, speen = 5000;

			$(".btn li:last").css({
				"margin" : "0rem 0rem 0rem 0.5rem"
			});
			$(".btn li:first").addClass("on");
			$(".pic li:first").show();

			$(".btn li").each(function(index, element) {
				$(element).click(function() {
					i = index;
					$(this).addClass("on").siblings().removeClass("on");
					$(".pic li").eq(index).animate({
						opacity : "show"
					}, 200).siblings().animate({
						opacity : "hide"
					}, 200);
				})
				$(element).hover(function() {
					clearInterval(setInter);
				}, function() {
					outPlay();
				});
			})

			out_fun = function() {
				if (i < listLen) {
					i++;
				} else {
					i = 0;
				}
				;
				$(".btn li").eq(i).addClass("on").siblings().removeClass("on");
				$(".pic li").eq(i).animate({
					opacity : "show"
				}, 2000).siblings().animate({
					opacity : "hide"
				}, 2000);
			}

			outPlay = function() {
				setInter = setInterval("out_fun()", speen);
			}
			outPlay();
		})
   
   
	function mapDaoHang() {
		if (!'${order.tradeProductInfoExModel.lat}' || !'${order.tradeProductInfoExModel.lng}') {
			layer.alert("没有地图定位猪场,无法导航！");
			return;
		}
		/* loadScript('daohang', '${order.tradeProductInfoExModel.lat}',
				'${order.tradeProductInfoExModel.lng}',
				'${order.tradeProductInfoExModel.mapAddress}'); */
		alert("导航");
	}
</script>
<!-- 导航 -->
<%-- <div class="grounp_tanchu">
	<%@include file="../map/mapNavigation.html"%>
</div> --%>
<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>