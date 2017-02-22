<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <meta name="x5-orientation" content="portrait">
    <title>我的拍卖场成员</title>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/index.css">
    <style type="text/css">
        .auction_bg1{
            width: 20rem;
            height:4rem;
            background-color: #ffffff;
            font-size:0.83rem;
            color:#333333;
            line-height: 4rem;
        }
        .auction_notice_pic{
            width: 2.5rem;
            height: 2.5rem;
            border-radius:1.25rem;
            margin-left: 0.7rem;
            margin-top:0.75rem;
            float: left;
            background-image: url("/static/newhope/html/images/ic_sqjr_notifaction.png");
            background-size: cover;

        }
        .auction_notice_text{
            float: left;
            margin-left: 0.8rem;
        }
        .auction_notice_round{
            width: 0.6rem;
            height: 0.6rem;
            border-radius: 0.3rem;
            background-color:#fa4848;
            float: right;
            margin-right: 0.1rem;
            margin-top: 1.7rem;
        }
        .auction_list_icon{
            width: 0.84rem;
            height:0.84rem;
            background: url("/static/newhope/html/images/ic_list_detail.png") no-repeat;
            background-size:cover;
            border: none;
            float: right;
            margin-right:0.7rem;
            margin-top:1.58rem;
        }
        .auction_bg2{
            width: 20rem;
            height:2.22rem;
            background-color: #ffffff;
            font-size:0.83rem;
            color:#4a4a4a;
            line-height: 2.22rem;
        }
        .auction_menber_num{
            float: left;
            margin-left: 0.7rem;
        }
        .auction_bg3{
            background-color: #ffffff;
            width: 20rem;
            height: 5rem;
            font-size:0.83rem;
            color:#333333;
        }
        .auction_head_bg{
            width:2.5rem;
            height: 2.5rem;
            border-radius:1.25rem;
            float: left;
            margin-left:0.7rem;
            margin-top: 1.25rem;
        }
        .auction_head_pic{
            width:2.5rem;
            height: 2.5rem;
            border-radius:1.25rem;
            background-size: cover;
        }
        .auction_list1_icon{
            width: 0.84rem;
            height:0.84rem;
            background: url("/static/newhope/html/images/ic_list_detail.png") no-repeat;
            background-size:cover;
            border: none;
            float: right;
            margin-right:0.7rem;
            margin-top:2.08rem;
        }
        .auction_menber_message{
            float: left;
            height:2.5rem;
            width: 8rem;
            margin-left: 0.8rem;
            margin-top: 1.25rem;
        }
        .auction_menber_name{
            height: 1.3rem;
            line-height: 1.3rem;
        }
        .auction_menber_phone{
            height: 1.2rem;
            line-height: 1.2rem;
            font-size: 0.72rem;
            color:#999999;
        }
        .auction_mold_bg{
            width: 1rem;
            height: 1rem;
            border-radius: 0.5rem;
            float: right;
            margin-right: 0.1rem;
            margin-top: 2rem;
        }
        .auction_mold_icon{
            width: 1rem;
            height: 1rem;
            border-radius: 0.5rem;
            background-size: cover;
        }
    </style>
</head>
<body>

	 <c:if test="${!empty applyCount && applyCount > 0 }">
	     <div class="auction_bg1" onclick="toLocationHref('/user/applyCircle/queryExModelList?circleId=${circleId}')">
	           <div class="auction_notice_pic">
	           </div>
	           <div class="auction_notice_text">
	               <span>${applyCount}</span>
	               <span>人申请加入</span>
	           </div>
	           <input class="auction_list_icon" type="button"/>
	           <div class="auction_notice_round"></div>
	     </div>
	     <div class="wall"></div>
	 </c:if>
     <div class="auction_bg2">
         <div class="auction_menber_num">
             <span>成员数量</span>
             <span>(${fn:length(circleUserExList)})</span>
         </div>
     </div>
     <c:forEach items="${circleUserExList}" var="circleUserEx">
     	 <div class="line"></div>
	     <div class="auction_bg3" onclick="toLocationHref('/user/circleUser/circleUserDatail?circleUserId=${circleUserEx.id}')">
	         <div class="auction_head_bg">
	         	<c:choose>
           			<c:when test="${fn:startsWith(circleUserEx.headImg,'http') }">
	             		<img class="auction_head_pic" src="${circleUserEx.headImg }"/>
           			</c:when>
           			<c:otherwise>
	             		<img class="auction_head_pic" src="${imgServer }${circleUserEx.headImg }"/>
           			</c:otherwise>
           		 </c:choose>
	         </div>
	         <div class="auction_menber_message">
	              <div class="auction_menber_name">${circleUserEx.name }</div>
	              <div class="auction_menber_phone">手机：<span>${circleUserEx.mobileStr }</span></div>
	         </div>
	         <input class="auction_list1_icon" type="button"/>
	         <c:forEach items="${circleUserEx.userTagTypes }" var="userTagType">
	          	  <i class="auction_mold_bg">
	         	  	   <c:if test="${userTagType.value == 'CASH_DEPOSIT' }">
	         	  	   		<img class="auction_mold_icon" src="/static/newhope/html/images/ic_bao_big.png"/>
	         	  	   </c:if>
	         	  	   <c:if test="${userTagType.value == 'FARMER' }">
	         	  	   		<img class="auction_mold_icon" src="/static/newhope/html/images/ic_yang_big.png"/>
	         	  	   </c:if>
	         	  	   <c:if test="${userTagType.value == 'PIG_DEALER' }">
	         	  	   		<img class="auction_mold_icon" src="PIG_DEALER"/>
	         	  	   </c:if>
	         	  	   <c:if test="${userTagType.value == 'SLAUGHTERHOUSES' }">
	         	  	   		<img class="auction_mold_icon" src="/static/newhope/html/images/ic_tu_big.png"/>
	         	  	   </c:if>
	         	  	   <c:if test="${userTagType.value == 'PIG_AGENT' }">
	         	  	   		<img class="auction_mold_icon" src="/static/newhope/html/images/ic_jing_big.png"/>
	         	  	   </c:if>
	         	  </i>
	         </c:forEach>
	     </div>
     </c:forEach>
      
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
<script type="text/javascript" charset="UTF-8" src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
	//地址跳转
	function toLocationHref(urlLocation){
		location.href = urlLocation+"&v="+Math.random();
	}
</script>
</html>