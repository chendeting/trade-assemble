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
    <script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/weui.min.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/jquery-weui.min.css"/>
    <!-- fontawesome -->
    <link rel="stylesheet" href="/static/newhope/html/css/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="/static/newhope/html/css/common.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/mySale.css"/>
    <script type="text/javascript" src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>
</head>
<body>

    <div id="warp">
        <header>
            <div class="header-title">
                <p class="title-date"><fmt:formatDate value="${productInfoEx.bidTime }" pattern="yyyy-MM-dd"/></p>
                <p class="title-name">猪场名称：<span class="circleName">${productInfoEx.pigFarmInfoExModel.name }</span></p>
            </div>
            <div class="detailInfo">
                <p class="address">交割地址：<span>${productInfoEx.pigFarmInfoExModel.mapAddress }</span></p>
                <p class="tel">猪场电话：<span>${productInfoEx.pigFarmInfoExModel.mobileStr }</span></p>
                <p class="breed">出栏品种：<span>${productInfoEx.pigType.displayName }</span></p>
                <p class="publishedNum">发布数量：<span>${productInfoEx.marketingNumber }头</span></p>
                <p class="orderNum">订购数量：<span>${productInfoEx.bidedNumber }头</span></p>
                <p class="deliveryNum">交割数量：<span>${empty productInfoEx.deliveryNum ? '0' : productInfoEx.deliveryNum}头</span></p>
                <p class="price">
                	出栏价格：
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
                				价格待定
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
            <ul class="saleUl">
            	<c:forEach items="${productInfoEx.productOrderList }" var="productOrder">
	                <li class="saleList">
	                	<c:if test="${productOrder.status != 'JIAOGEZHONG' && productOrder.status != 'CEDAN'}">
		                    <p class="detail-info" onclick="toOrderTradeDetail(${productOrder.id})">
		                    	订购时间：<fmt:formatDate value="${productOrder.gmtCreated }" pattern="yyyy-MM-dd HH:mm:ss"/>
		                        <img src="/static/newhope/html/images/ic_list_detail.png"/>
		                	</p>
		                </c:if>
		                <c:if test="${productOrder.status == 'JIAOGEZHONG' || productOrder.status == 'CEDAN'}">
		                	 <p class="detail-info">
		                    	订购时间：<fmt:formatDate value="${productOrder.gmtCreated }" pattern="yyyy-MM-dd HH:mm:ss"/>
		                	</p>
		                </c:if>
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
	                            <li class="buyNum">购买数量：<span>${productOrder.count }头</span></li>
	                            <c:if test="${productOrder.status == 'JIAOGE'}">
	                            	<li class="deliveryNum">交割数量：<span>${productOrder.realCount }头</span></li>
	                            </c:if>
	                        </ul>
	                        <a href="tel:${productOrder.buyUserMobile }" class="contactTa">联系TA</a>
	                        <c:if test="${productOrder.status != 'JIAOGEZHONG' }">
		                        <div class="stateImg">
		                        	<c:if test="${productOrder.status == 'JIAOGE' }">
		                        		<img src="/static/newhope/html/images/ic_label_yjg_yx.png"/>
		                        	</c:if>
		                        	<c:if test="${productOrder.status == 'CEDAN' }">
		                        		<img src="/static/newhope/html/images/ic_label_ycd_yx.png"/>
		                        	</c:if>
		                        	<c:if test="${productOrder.status == 'PAODAN' }">
		                        		<img src="/static/newhope/html/images/ic_label_ypd_yx.png"/>
		                        	</c:if>
		                        </div>
	                        </c:if>
	                    </div>
	                    <div class="btn-box">
	                    	<c:if test="${productOrder.status == 'JIAOGE' || productOrder.status == 'PAODAN' }">
	                    		<a href="/trade/orderDeal/toDeal.htm?productOrderId=${productOrder.id}">
	                    			<button type="button" class="edit-delivery">修改交割信息</button>
	                    		</a>
	                    	</c:if>
	                    	<c:if test="${productOrder.status == 'JIAOGEZHONG' }">
	                    		<button type="button" class="revoke" onclick="cheDan(${productOrder.id})">撤单</button>
                        		<a href="/trade/orderDeal/toDeal.htm?productOrderId=${productOrder.id}">
                        			<button type="button" class="delivery">交割</button>
                        		</a>
	                    	</c:if>
	                    </div>
	                </li>
            	</c:forEach>
            </ul>
        </section>
    </div>
    <script src="/static/newhope/html/js/jquery-weui.min.js"></script>
    <script type="text/javascript">
    
    	//撤单
    	function cheDan(productOrderId){
            $.confirm({
                title: '确定撤单',
                text: '撤单后该订单将失效，是否确定撤单？',
                onOK: function () {
                    //点击确认
                    $.ajax({
                    	type:"POST",
                    	url:"/trade/order/revokeOrder",
                    	data:"productOrderId="+productOrderId,
                    	dataType:"json",
                    	success:function(result){
                    		if (result.success){
                    			$.toast("撤单成功！","text");
                    			location.reload(true);
                    		} else {
                    			$.toast(result.msg,"text");
                    		}
                    	},
                    	error:function(){
                    		$.toast("操作异常，请联系管理员！","text");
                    	}
                    });
                }
            });
    	}

    	//跳转到订单交割详细查看
    	function toOrderTradeDetail(productOrderId){
    		location.href="/trade/order/detialForSaler?productOrderId="+productOrderId+"&v="+Math.random();
    	}

    </script>
     
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>