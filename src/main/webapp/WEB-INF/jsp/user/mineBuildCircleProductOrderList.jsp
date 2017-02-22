<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <meta name="description"
          content="Write an awesome description for your new site here. You can edit this line in _config.yml. It will appear in your document head meta (for Google search results) and in your feed.xml site description.">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><fmt:formatDate value="${productInfoEx.bidTime }" pattern="yyyy-MM-dd"/>详细</title>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/weui.min.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/huadongjiazai.min.css"/>
    <link rel="stylesheet" href="/static/newhope/html/css/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="/static/newhope/html/css/common.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/mySale.css"/>
    <script type="text/javascript" src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
    <script src="/static/newhope/html/js/jquery-weui.min.js"></script>
    <script src="/static/newhope/html/js/template.js"></script>
    <script type="text/javascript" src="/static/trade/js/tradeCommon.js"></script>
    <style type="text/css">
        #warp section .saleUl .saleList .basicInfo-box .stateImg{
            top:0;
        }
        #warp section .saleUl .saleList .detail-info{
            border-bottom-style:none ;
        }
    </style>
</head>
<body>
    <div id="warp">
        <header>
            <div class="header-title">
                <p class="title-date"><fmt:formatDate value="${productInfoEx.bidTime }" pattern="yyyy-MM-dd"/></p>
                <p class="title-name">卖方名字：<span class="circleName">${productInfoEx.userInfoModel.name}</span></p>
            </div>
            <div class="detailInfo">
                <p class="tel">猪场名字：<span>${productInfoEx.pigFarmInfoExModel.name }</span></p>
                <p class="address">交割地址：<span>${productInfoEx.pigFarmInfoExModel.mapAddress}</span></p>
                <p class="breed">出栏品种：<span>${productInfoEx.pigType.displayName }</span></p>
                <p class="publishedNum">发布数量：<span>${empty productInfoEx.marketingNumber?0:productInfoEx.marketingNumber }头</span></p>
                <p class="orderNum">订购数量：<span>${empty productInfoEx.bidedNumber?0:productInfoEx.bidedNumber }头</span></p>
                <p class="deliveryNum">交割数量：<span>${empty productInfoEx.deliveryNum?0:productInfoEx.deliveryNum}头</span></p>
                <p class="price">出栏价格：
					<span>
					
                		<c:choose>
                			<c:when test="${productInfoEx.isDiscuss }">
                				现场议价
                			</c:when>
                			<c:when test="${!empty productInfoEx.marketingPrice }">
                				￥${productInfoEx.marketingPrice }元/KG
                			</c:when>
                			<c:when test="${!empty productInfoEx.productPriceList }">
                				<c:forEach items="${productInfoEx.productPriceList }" var="productPrice">
                					<c:if test="${productPrice.weightMin <= productInfoEx.preAvgWeight}">
                						<c:if test="${empty productPrice.weightMax}">
                							<c:if test="${productPrice.isDiscuss}">
					                    		议价
					                    	</c:if>
					                    	<c:if test="${empty productPrice.isDiscuss || !productPrice.isDiscuss}">
					                        	￥${productPrice.price }元/KG
					                    	</c:if>
                						</c:if>
                						<c:if test="${!empty productPrice.weightMax && productInfoEx.preAvgWeight < productPrice.weightMax}">
                							<c:if test="${productPrice.isDiscuss}">
					                    		议价
					                    	</c:if>
					                    	<c:if test="${empty productPrice.isDiscuss || !productPrice.isDiscuss}">
					                        	￥${productPrice.price }元/KG
					                    	</c:if>
                						</c:if>
                					</c:if>
                				</c:forEach>
                			</c:when>
                			<c:otherwise>
	                			<c:choose>
	                				<c:when test="${empty productInfoEx.productPriceList }">
	                					<c:choose>
	                						<c:when test="${empty productInfoEx.marketingPrice }">
	                							议价
	                						</c:when>
	                						<c:otherwise>
	                						￥${productInfoEx.marketingPrice}/KG
	                						</c:otherwise>
	                					</c:choose>
	                				</c:when>
	                				<c:otherwise>
	                					<c:choose>
	                						<c:when test="${empty productInfoEx.prePrice }">
	                							议价
	                						</c:when>
	                						<c:otherwise>
	                						￥${productInfoEx.prePrice}/KG
	                						</c:otherwise>
	                					</c:choose>
	                				</c:otherwise>
	                			</c:choose>
                			</c:otherwise>
                		</c:choose>
                	</span>
                	（预估均重${productInfoEx.preAvgWeight }KG）
				</p>
                <p class="publishedDate">发布日期：<fmt:formatDate value="${productInfoEx.gmtCreated }" pattern="yyyy-MM-dd"/></p>
            </div>
        </header>
        <div class="allOrderNum">订单数（${fn:length(productInfoEx.productOrderList) }笔）</div>
        <section>
            <ul class="saleUl" id="xiangxi">
               <c:forEach items="${productInfoEx.productOrderList }" var="productOrder">
               <c:choose>
               <c:when test="${productOrder.status == 'JIAOGE'}">
               		<li class="saleList">
	                    <p class="detail-info" data-oid="${productOrder.id}"  onclick="toDetail(this)">订单号：${productOrder.orderNumber}<img src="/static/newhope/html/images/ic_list_detail.png"/></p>
	                    <div class="basicInfo-box">
	                    	<c:choose>
	                    		<c:when test="${fn:startsWith(productOrder.buyUserHeadImg,'http') }">
					        		<img class="userHead" src="${productOrder.buyUserHeadImg }">
	                			</c:when>
	                			<c:otherwise>
					        		<img class="userHead" src="${imgServer }${productOrder.buyUserHeadImg }">
	                			</c:otherwise>
	                    	</c:choose>
	                        <ul class="info-ul">
	                            <li class="userName">${productOrder.buyUserRealName }</li>
	                            <li class="buyNum">拍猪数量：<span>${productOrder.count }头</span></li>
	                            <li class="deliveryNum">交割数量：<span>${productOrder.realCount }头</span></li>
	                        </ul>
	                    </div>
	                </li>
               </c:when>
               <c:otherwise>
               	<li class="saleList">
	                    <p class="detail-info">订单号：${productOrder.orderNumber}</p>
	                    <div class="basicInfo-box noneBorder">
	                    	   <c:choose>
	                    		<c:when test="${fn:startsWith(productOrder.buyUserHeadImg,'http') }">
					        		<img class="userHead trading-head" src="${productOrder.buyUserHeadImg }">
	                			</c:when>
	                			<c:otherwise>
					        		<img class="userHead trading-head" src="${imgServer }${productOrder.buyUserHeadImg }">
	                			</c:otherwise>
	                    	   </c:choose>
	                        <ul class="info-ul">
	                            <li class="userName">${productOrder.buyUserRealName }</li>
	                            <li class="buyNum">拍猪数量：<span>${productOrder.count }头</span></li>
	                        </ul>
	                        <div class="stateImg">
	                        <c:if test="${productOrder.status == 'JIAOGEZHONG'}">
	                        <img src="/static/newhope/html/images/ic_lable_jyq_jyz.png"/>
	                        </c:if>
	                        <c:if test="${productOrder.status == 'CEDAN'}">
	                        <img src="/static/newhope/html/images/ic_lable_jyq_cd.png"/>
	                        </c:if>
	                        <c:if test="${productOrder.status == 'PAODAN'}">
	                        <img src="/static/newhope/html/images/ic_lable_jyq_pmz.png"/>
	                        </c:if>
	                        </div>
	                    </div>
	                </li>
               </c:otherwise>
               </c:choose>  
			</c:forEach>
            </ul>
        </section>
    </div>
    <script type="text/javascript">
		function toDetail(obj){
			var orderId = $(obj).data("oid");
			if(checkObjNotEmpty(orderId)){
				location.href="/trade/order/detialForSaler?productOrderId="+orderId+"&v="+Math.random()+"&type=show";
			}
	} 
    </script>
    <!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>