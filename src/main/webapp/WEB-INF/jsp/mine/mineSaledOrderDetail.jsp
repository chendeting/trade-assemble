<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<meta name="format-detection" content="telephone=no">
<meta name="x5-orientation" content="portrait">
<title>订单详细</title>
<link type="text/css" rel="stylesheet" href="/static/newhope/html/css/index.css">
<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
<script type="text/javascript" charset="UTF-8" src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="/static/newhope/html/css/swiper.min.css">

</head>
<body style="background-color: #ffffff">


<section>
	<div class="handover_top_bg">
		<div class="handover_headpic_bg">
			<c:choose>
       			<c:when test="${fn:startsWith(productOrderEx.buyUserHeadImg,'http') }">
   					<img class="handover_head_pic" src="${productOrderEx.buyUserHeadImg }" />
       			</c:when>
       			<c:otherwise>
   					<img class="handover_head_pic" src="${imgServer }${productOrderEx.buyUserHeadImg }">
       			</c:otherwise>
       		</c:choose>
		</div>
		<div class="handover_top_bg1">
			<div>${productOrderEx.buyUserRealName }</div>
			<div>
				<div class="handover_top_message_head">手机号码：</div>
				<div class="handover_top_message_body">${productOrderEx.buyUserMobileStr }</div>
			</div>
			<div>
				<div class="handover_top_message_head">订购数量：</div>
				<div class="handover_top_message_body">${productOrderEx.count }头</div>
			</div>
			<div style="clear: both"></div>
		</div>
	</div>
	<div class="line"></div>
	<div class="mybuild_grouping">交割信息</div>
	<div class="line"></div>
	<!--正常交割-->
	<c:if test="${productOrderEx.status.value == 'JIAOGE' }">
		<div class="jiaogexinxi">
			<div class="issued_module">
				<div class="Iget_bg_1">
					<div class="handover_message_bg">
						<div class="Iget_message_head">交割日期：</div>
						<div class="handover_message_body"><fmt:formatDate value="${productOrderEx.orderTradeInfoExModel.deliveryDate}" pattern="yyyy-MM-dd"/></div>
					</div>
					<div class="handover_message_bg">
						<div class="Iget_message_head">交割数量：</div>
						<div class="handover_message_body">${productOrderEx.realCount}头</div>
					</div>
					<div class="handover_message_bg">
						<div class="Iget_message_head">实收总额：</div>
						<div class="handover_message_body">${productOrderEx.orderRealTotalPrice}元</div>
					</div>
					<div class="handover_message_bg">
						<div class="Iget_message_head">收款方式：</div>
						<div class="handover_message_body">${productOrderEx.orderTradeInfoExModel.payType.desc}</div>
					</div>
					<c:if test="${empty type }">
						<a href="/trade/orderDeal/toDeal.htm?productOrderId=${productOrderEx.id}">
							<input class="handover_alter_btn" type="button" value="修改交割信息" />
						</a>
					</c:if>
					<div style="clear: both"></div>
				</div>
			</div>
			<div class="line"></div>
			<div id="content">
				<c:forEach items="${productOrderEx.orderTradeInfoExModel.orderTradeDetailExModelList}" var="orderTradeDetail" varStatus="s">
					<div class="issued_module">
						<div class="Iget_list_bg">
							<label class="Iget_list_num">
								<c:choose>
									<c:when test="${s.index == 0 }">
										第一条
									</c:when>
									<c:when test="${s.index == 1 }">
										第二条
									</c:when>
									<c:when test="${s.index == 2 }">
										第三条
									</c:when>
									<c:when test="${s.index == 3 }">
										第四条
									</c:when>
									<c:when test="${s.index == 4 }">
										第五条
									</c:when>
								</c:choose>
							</label>
						</div>
						<div class="Iget_bg_1">
							<div class="Iget_item">
								<div>
									<div class="Iget_message_head">交割数量：</div>
									<div class="Iget_message_body">${orderTradeDetail.pullPigNum }头</div>
								</div>
								<div>
									<div class="Iget_message_head">交割单价：</div>
									<div class="Iget_message_body">¥${orderTradeDetail.unitPrice }元/KG</div>
								</div>
								<div>
									<div class="Iget_message_head">出栏均重：</div>
									<c:choose>
										 <c:when test="${orderTradeDetail.pullPigNum eq 0}">
											<div class="Iget_message_body"><fmt:formatNumber value="0" pattern="##.##" minFractionDigits="2"  />KG</div>
										 </c:when>
										 <c:otherwise>
											<div class="Iget_message_body"><fmt:formatNumber value="${orderTradeDetail.totalWeight/orderTradeDetail.pullPigNum}" pattern="##.##" minFractionDigits="2"  />KG</div>
										 </c:otherwise>
										</c:choose>
								</div>
								<div>
									<div class="Iget_message_head">出栏总重：</div>
									<div class="Iget_message_body">${orderTradeDetail.totalWeight }KG</div>
								</div>
								<div>
									<div class="Iget_message_head">复磅均重：</div>
									<div class="Iget_message_body"><fmt:formatNumber value="${orderTradeDetail.pigAvgWeight}" pattern="##.##" minFractionDigits="2"  />KG</div>
								</div>
								<div>
									<div class="Iget_message_head">复磅总重：</div>
									<div class="Iget_message_body">${orderTradeDetail.reTotalWeight }KG</div>
								</div>
								<div>
									<div class="Iget_message_head">应收金额：</div>
									<div class="Iget_message_body">${orderTradeDetail.realAmount }元</div>
								</div>
								<div>
									<div class="Iget_message_head">实付金额：</div>
									<div class="Iget_message_body">${orderTradeDetail.realTotalPrice }元</div>
								</div>
								<c:if test="${!empty orderTradeDetail.punishAmount }">
									<div>
										<div class="Iget_message_head">扣罚金额：</div>
										<div class="Iget_message_body">${orderTradeDetail.punishAmount }元</div>
									</div>
									<div>
										<div class="Iget_message_head">扣罚原因：</div>
										<div class="Iget_message_body">${orderTradeDetail.punishReson }</div>
										<div style="width: 19.3rem; height: 0.5rem; clear: both;"></div>
										<c:if test="${!empty orderTradeDetail.orderTradeDetailImgList }">
											<div class="handover_message_bg1">异常猪只图片：</div>
											<ul class="yichangImgList">
												<c:forEach items="${orderTradeDetail.orderTradeDetailImgList }" var="orderTradeDetailImg">
				                                	<li><img class="yichang_pic" src="${imgServer }${orderTradeDetailImg.url }" alt=""></li>				                             
												</c:forEach>
				                            </ul>
										</c:if>
									</div>
								</c:if>
								<div style="clear: both;"></div>
							</div>
						</div>
					</div>
					<div class="line"></div>
				</c:forEach>
			</div>
		</div>
	</c:if>
	<!--交割跑单-->
	<c:if test="${productOrderEx.status.value == 'PAODAN'  }">
		<div class="jiaogepaodan">
			<div class="issued_module">
				<div class="Iget_bg_1">
					<div class="handover_message_bg">
						<div class="Iget_message_head">交割日期：</div>
						<div class="handover_message_body"><fmt:formatDate value="${productOrderEx.orderTradeInfoExModel.deliveryDate}" pattern="yyyy-MM-dd"/></div>
					</div>
					<div class="handover_message_bg">
						<div class="Iget_message_head">交割数量：</div>
						<div class="handover_message_body">${productOrderEx.realCount}头</div>
					</div>
					<div class="handover_message_bg">
						<div class="Iget_message_head">交割状态：</div>
						<div class="handover_message_body">${productOrderEx.status.displayName}</div>
					</div>
					<a href="/trade/orderDeal/toDeal.htm?productOrderId=${productOrderEx.id}">
						<input class="handover_alter_btn" type="button" value="修改交割信息" />
					</a>
					<div style="clear: both"></div>
				</div>
			</div>
			<div class="line"></div>
			<div class="handover_message_bg2">跑单原因：</div>
			<div class="handover_message_bg3">${productOrderEx.orderTradeInfoExModel.remark}</div>
		</div>
	</c:if>
</section>
	
	<!--蒙层-->
<div style="display: none" class="mengceng">
    <!-- Swiper -->
    <div class="Divimg">
        <img class="bigImg" src="" alt="">
    </div>
</div>
<!--图片点击放大-->
<script>
    //图片点击事件
    $("ul.yichangImgList>li>img").each(function(index,item){

        $(this).click(function(){
        	//获取图片路径
        	$(".mengceng").find("img").attr("src",$(this).attr("src"));
            $(".mengceng").show();
        })
    });
    //蒙层点击事件
    $(".mengceng").on("click",function(){
        $(".mengceng").hide();
    })
</script>
 
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>