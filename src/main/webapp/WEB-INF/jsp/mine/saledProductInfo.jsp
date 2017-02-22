<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta name="x5-orientation" content="portrait">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<meta charset="UTF-8">
<title>详情</title>
<link type="text/css" rel="stylesheet" href="/static/newhope/html/css/index.css">
<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
<style type="text/css">
body {
	margin: 0px;
	padding: 0px;
	font-family: "Microsoft YaHei";
}

li {
	list-style: none;
}

table {
	margin-left: 0.6rem;
}
</style>
</head>
<body style="background-color: #fff;">

	<div class="Part_1" id="Part_1" style="position: absolute;">
		<div class="lunbo">
			<ul class="pic">
				<c:forEach items="${tradeProductInfo.bidInfoImgModelLst }" var="bidInfoImg">
					<li><img src="${imgServer }/crop/320/300${bidInfoImg.url }" /></li>
				</c:forEach>
			</ul>
			<c:if test="${fn:length(tradeProductInfo.bidInfoImgModelLst) > 1 }">
				<ul class="btn">
					<c:forEach items="${tradeProductInfo.bidInfoImgModelLst }" var="bidInfoImg">
						<li></li>
					</c:forEach>
				</ul>
			</c:if>
		</div>
		<div>
			<a class="phone_1" href="tel:${tradeProductInfo.mobile }"> 
				<img src="/static/newhope/html/images/phone.png" style="width: 100%; height: 100%;">
			</a>
			<div class="piggery_name">${tradeProductInfo.farmerName }的猪场</div>
			<div class="piggery_num">
				<span style="font-size: 0.9rem; color: #F02B2B;">剩余</span>
				<span style="font-size: 1rem; color: #F02B2B;">${tradeProductInfo.surplusNumber }</span>
				<span style="font-size: 0.65rem; color: #F02B2B;">头</span> 
				<span style="font-size: 0.6rem; color: #848689">已售</span>
				<span style="font-size: 0.6rem; color: #848689">${empty tradeProductInfo.bidedNumber ? '0' : tradeProductInfo.bidedNumber}</span>
				<span style="font-size: 0.6rem; color: #848689">头</span>
			</div>
			<div class="piggery_line"></div>
			<div>
				<div class="massage_details3">
	                <div class="message_head">所在地区:</div>
	                <div class="message_text3">
	               		${tradeProductInfo.pigFaramAddress.provName}${tradeProductInfo.pigFaramAddress.cityName}${tradeProductInfo.pigFaramAddress.countyName}${tradeProductInfo.pigFaramAddress.townName}
	                </div>
	                <div style="clear: both;"></div>
	            </div>
	            <div class="massage_details3">
	                <div class="message_head">详细地址:</div>
	                <div class="message_text3">
	                	${tradeProductInfo.adressDetail}
	                </div>
	                <div style="clear: both;"></div>
	            </div>
				<div style="width: 20rem; position: relative;">
					<div onclick="mapDaoHang()" style="float: left; font-size: 0.666667rem; margin-top: 0.4rem; margin-left: 3.7rem; color: #4a90e2;">导航</div>
					<img onclick="mapDaoHang()" src="/static/newhope/html/images/Group.png" style="width: 1rem; height: 1rem; float: left; margin-left: 0.3rem; margin-top: 0.35rem;" />
				</div>
				<div class="massage_details">
					<div class="message_head">交通状况:</div>
					<div class="message_text">${tradeProductInfo.trifficInfo.displayName}</div>
				</div>
				<div class="piggery_line1"></div>
			</div>
			<div>
				<div class="massage_details">
					<div class="message_head">交割日期:</div>
					<div class="message_text"><fmt:formatDate value="${tradeProductInfo.marketingDate}" pattern="yyyy-MM-dd"/></div>
				</div>
				<div class="massage_details">
					<div class="message_head">出栏数量:</div>
					<div class="message_text">
						<span>${tradeProductInfo.marketingNumber}</span>头
					</div>
				</div>
				<div class="massage_details2">
					<div class="message_head">出栏价格:</div>
					<c:if test="${!empty tradeProductInfo.productPriceList }">
						<div class="message_icon">
							<img src="/static/newhope/html/images/v0icon.png" style="width: 1.1rem; height: 1.1rem; margin-top: 0.2rem; margin-left: 0.3rem; position: absolute;" />
						</div>
						<div class="message_text_box">
							<c:forEach items="${tradeProductInfo.productPriceList }" var="productPrice" varStatus="s">
								<c:if test="${productPrice.userLevel == 'V0' }">
									<div class="message_text">
										<span>${productPrice.price }</span>
										<span>元/kg</span>
										<span style="color: #848689;">(${productPrice.weightDes })</span>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<div class="message_icon" style="margin-left: 3.7rem;">
							<img src="/static/newhope/html/images/v1icon.jpg" style="width: 1.1rem; height: 1.1rem; margin-top: 0.2rem; margin-left: 0.3rem; position: absolute;" />
						</div>
						<div class="message_text_box">
							<c:forEach items="${tradeProductInfo.productPriceList }" var="productPrice" varStatus="s">
								<c:if test="${productPrice.userLevel == 'V1' }">
									<div class="message_text">
										<span>${productPrice.price }</span>
										<span>元/kg</span>
										<span style="color: #848689;">(${productPrice.weightDes })</span>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</c:if>
					<c:if test="${empty tradeProductInfo.productPriceList }">
						<div class="message_text">
							待定
						</div>
					</c:if>
				</div>
				<div class="massage_details">
					<div class="message_head">出栏类型:</div>
					<div class="message_text">${tradeProductInfo.pigType.displayName}</div>
				</div>
				<div class="massage_details">
					<div class="message_head">出栏品级:</div>
					<div class="message_text">${tradeProductInfo.level.displayName}</div>
				</div>
				<div class="massage_details">
					<div class="message_head">预估均重:</div>
					<div class="message_text">${tradeProductInfo.preAvgWeight}kg</div>
				</div>
				<div class="piggery_line1"></div>
			</div>
			<div>
				<div class="massage_details">
					<div class="message_head">控料情况:</div>
					<div class="message_text">${tradeProductInfo.controllerFeedstuffInfo.displayName}</div>
				</div>
			</div>
			<div style="width: 20rem; height: 0.5rem; background-color: #fff; float: left;"></div>
			<!-- 
			<c:if test="${!empty tradeProductInfo.bidedNumber && tradeProductInfo.bidedNumber != 0}">
				<a href="/mine/saledProduct/selectSaledProductDetail?productId=${tradeProductInfo.id}">
					<button id="jiaoyixiangqing" style="margin-bottom: 1rem; width: 17rem; height: 2.222222rem; margin-top: 1rem; margin-left: 1.5rem; border: none; outline: none; background: #F02B2B; background-image: linear-gradient(-180deg, #F04746 0%, #DD4B39 100%); box-shadow: 0rem 0rem 0.36rem 0rem rgba(235, 72, 66, 0.50); border-radius: 1.5rem; font-size: 1rem; color: #ffffff; font-family: 'Microsoft YaHei'; text-align: center;">交易详情</button>
				</a>
			</c:if>
			 -->
		</div>
	</div>
	<!-- 导航 -->
	<div class="grounp_tanchu">
	</div>
	<script type="text/javascript" charset="utf-8" src="/static/plug-in/layer/layer.js"></script> 
	<script type="text/javascript">
		$( function() {
			var listLen = $( ".pic li" ).length, i = 0, setInter, speen = 3000;

			$( ".btn li:last" ).css( {
				"margin": "0rem 0rem 0rem 0.5rem"
			} );
			$( ".btn li:first" ).addClass( "on" );
			$( ".pic li:first" ).show();

			$( ".btn li" ).each( function( index, element ) {
				$( element ).click( function() {
					i = index;
					$( this ).addClass( "on" ).siblings().removeClass( "on" );
					$( ".pic li" ).eq( index ).animate( {
						opacity: "show"
					}, 200 ).siblings().animate( {
						opacity: "hide"
					}, 200 );
				} )
				$( element ).hover( function() {
					clearInterval( setInter );
				}, function() {
					outPlay();
				} );
			} )
			out_fun = function() {
				if( i < listLen ) {
					i++;
				} else {
					i = 0;
				}
				;
				$( ".btn li" ).eq( i ).addClass( "on" ).siblings().removeClass( "on" );
				$( ".pic li" ).eq( i ).animate( {
					opacity: "show"
				}, 1000 ).siblings().animate( {
					opacity: "hide"
				}, 1000 );
			}

			outPlay = function() {
				setInter = setInterval( "out_fun()", speen );
			}
			outPlay();
		} );
		function mapDaoHang(){
			if(!'${tradeProductInfo.lat}' || !'${tradeProductInfo.lng}'){
				layer.alert("没有地图定位猪场,无法导航！");
				return;
			}
			 loadScript('daohang','${tradeProductInfo.lat}','${tradeProductInfo.lng}','${tradeProductInfo.mapAddress}');
		} 
	</script>
	  
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>