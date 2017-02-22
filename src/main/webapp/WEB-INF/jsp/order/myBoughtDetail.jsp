<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <meta name="x5-orientation" content="portrait">
    <title>订单详细</title>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/index.css">
    <link rel="stylesheet" href="/static/newhope/html/css/weui.min.css">
    <link rel="stylesheet" href="/static/newhope/html/css/huadongjiazai.min.css">
    <script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
    <script type="text/javascript" charset="UTF-8" src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>
    <script src="/static/newhope/html/js/template.js"></script>
    <style type="text/css">

    </style>
</head>
<body>
      <div class="issued_module">
          <div class="Iget_bg_1">
              <div>
                  <div class="Iget_message_head">卖方：</div>
                  <div class="Iget_message_body">
                    	  ${order.salerName}
                  </div>
              </div>
              <div>
                  <div class="Iget_message_head">手机号码：</div>
                  <div class="Iget_message_body">
                       ${order.salerMobileStr}
                  </div>
              </div>
              <div>
                  <div class="Iget_message_head">订购时间：</div>
                  <div class="Iget_message_body">
                      <span><fmt:formatDate value="${order.gmtCreated}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
                  </div>
              </div>
              <div>
                  <div class="Iget_message_head">订购数量：</div>
                  <div class="Iget_message_body">
                      ${empty order.count?0:order.count}头
                  </div>
              </div>
              <div style="clear: both"></div>
          </div>
      </div>
      <div class="line"></div>
      <div class="mybuild_grouping">交割信息</div>
      <div class="line"></div>
      <div class="issued_module">
          <div class="Iget_bg_1">
              <div>
                  <div class="Iget_message_head">交割地址：</div>
                  <div class="Iget_message_body">
                    ${order.tradeProductInfoExModel.pigFarmInfoExModel.mapAddress }
                  </div>
              </div>
              <div>
                  <div class="Iget_message_head">交割时间：</div>
                  <div class="Iget_message_body">
                  <fmt:formatDate value="${order.orderTradeInfoExModel.deliveryDate}" pattern="yyyy-MM-dd" />
                    
                  </div>
              </div>
              <div>
                  <div class="Iget_message_head">收款方式：</div>
                  <div class="Iget_message_body">
                    ${order.orderTradeInfoExModel.payType.desc}
                  </div>
              </div>
              <div style="clear: both"></div>
          </div>
      </div>
      <div class="line"></div>
   <div id="content">
    <c:if test="${!empty  order.orderTradeInfoExModel.orderTradeDetailExModelList }">
      <c:forEach items="${order.orderTradeInfoExModel.orderTradeDetailExModelList }" var="orderTradeDetail" varStatus="num">
      <div class="issued_module">
          <div class="Iget_list_bg">
              <label class="Iget_list_num">
			       <c:choose>
				        <c:when test="${num.index eq 0 }">第一条</c:when>
				        <c:when test="${num.index eq 1 }">第二条</c:when>
				        <c:when test="${num.index eq 2 }">第三条</c:when>
				        <c:when test="${num.index eq 3 }">第四条</c:when>
				        <c:otherwise>第五条</c:otherwise>
			       </c:choose>       
              </label>
          </div>
          <div class="Iget_bg_1">
              <div class="Iget_item">
                  <div>
                      <div class="Iget_message_head">出栏总重：</div>
                      <div class="Iget_message_body">
                      <fmt:formatNumber value="${empty orderTradeDetail.totalWeight?0:orderTradeDetail.totalWeight}" pattern="0.00"/> KG
                      </div>
                  </div>
                  <div>
                      <div class="Iget_message_head">交割数量：</div>
                      <div class="Iget_message_body">
                           ${empty orderTradeDetail.pullPigNum?0:orderTradeDetail.pullPigNum}头
                      </div>
                  </div>
                  <div>
                      <div class="Iget_message_head"> 交割单价：</div>
                      <div class="Iget_message_body">
                          ¥<fmt:formatNumber value="${empty orderTradeDetail.unitPrice?0:orderTradeDetail.unitPrice}" pattern="0.00"/>（元/KG）
                      </div>
                  </div><div>
                  <div class="Iget_message_head">应收金额：</div>
                  <div class="Iget_message_body">
                     <fmt:formatNumber value="${empty orderTradeDetail.realAmount?0:orderTradeDetail.realAmount}" pattern="0.00"/>元
                  </div>
              </div>
                  <div>
                      <div class="Iget_message_head">实付金额：</div>
                      <div class="Iget_message_body">
                      <fmt:formatNumber value="${empty orderTradeDetail.realTotalPrice?0:orderTradeDetail.realTotalPrice}" pattern="0.00"/>元
                      </div>
                  </div>
                 <c:if test="${!empty orderTradeDetail.punishAmount }">
                  <div>
                      <div class="Iget_message_head">扣罚金额：</div>
                      <div class="Iget_message_body">
                         <fmt:formatNumber value="${empty orderTradeDetail.punishAmount?0:orderTradeDetail.punishAmount}" pattern="0.00"/>元
                      </div>
                  </div>
                  <div>
                      <div class="Iget_message_head">扣罚原因：</div>
                      <div class="Iget_message_body">
                         ${orderTradeDetail.punishReson}
                      </div>
                  </div>
                 </c:if> 
                  <div style="clear: both;"></div>
              </div>
          </div>
          <div style="width: 20rem;height:0.75rem;clear: both;"></div>
      </div>
      <div class="line"></div>
      </c:forEach>
  </c:if>
   </div>
<script src="/static/newhope/html/js/jquery-weui.min.js"></script>
<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>