<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<title>我加入的交易圈</title>
<link type="text/css" rel="stylesheet" href="/static/newhope/html/css/index.css">
<link type="text/css" rel="stylesheet" href="/static/newhope/html/css/weui.min.css"/>
<link type="text/css" rel="stylesheet" href="/static/newhope/html/css/huadongjiazai.min.css"/>
<style type="text/css">
       /*提示字段*/
      .weui_toast,.weui_toast_text,.weui_toast_visible{
          width:auto;
          height: auto;
          font-size: 1.25rem;
          line-height: 2.2222rem;
          color:#fff;
          opacity:0.75;
          border-radius: 0.2222rem;
      }
</style>
</head>
<body>
	<div class="myring_bg">
		<div class="myring_module">
			<div class="join_headpic_bg">
				<c:if test="${empty circleEx.img }">
                	<img class="join_head_pic" src="/static/newhope/html/images/pig_icon.png"/>
            	</c:if>
            	<c:if test="${!empty circleEx.img }">
                	<img class="join_head_pic" src="${imgServer }${circleEx.img }"/>
            	</c:if>
			</div>
			<div class="myring_head_message">
				<div class="join_circle_1">
					<span style="float: left;">${circleEx.name}</span> 
					<c:if test="${circleEx.circleType.value=='PRIVATE'}">
						<img class="myring_mold" src="/static/newhope/html/images/ic_lable_sm.png" />
					</c:if>
				</div>
				<div class="join_circle_2">${circleEx.province}${circleEx.city}${circleEx.district}</div>
				<div class="join_circle_2">${circleEx.circleDec}</div>
				<div class="join_circle_3">
					<div style="float: left;">活跃度</div>
					<img class="vitality_icon" src="/static/newhope/html/images/ic_fire.png" /> 
					<img class="vitality_icon" src="/static/newhope/html/images/ic_fire.png" /> 
					<img class="vitality_icon" src="/static/newhope/html/images/ic_fire.png" />
					<div style="float: right; font-size: 0.67rem;">
						成员数量 <span>(${circleEx.memberCount})</span>
					</div>
				</div>
			</div>
			<div style="clear: both;"></div>
		</div>
		<div class="line"></div>
		<div class="myring_module">
			<div class="myring_message">
				<div class="myring_message_text">
					<i> 
						<img class="myring_message_icon" src="/static/newhope/html/images/ic_lxr.png" />
					</i> 
					<span class="myring_message_title">我的圈子身份：</span> 
					<span class="myring_message_content">
						<c:if test="${circleUserEx.isBuyer }">
							买家
						</c:if>
						<c:if test="${circleUserEx.isSaler }">
							卖家
						</c:if>
					</span>
				</div>
				<div class="myring_message_text">
					<i> 
						<img class="myring_message_icon" src="/static/newhope/html/images/ic_time_rq.png" />
					</i> 
					<span class="myring_message_title">我的入圈时间：</span> 
					<span class="myring_message_content"><fmt:formatDate value="${circleUserEx.gmtCreated }" pattern="yyyy-MM-dd" /></span>
				</div>
				<div class="myring_message_text">
					<i> 
						<img class="myring_message_icon" src="/static/newhope/html/images/ic_jyqk.png" />
					</i> 
					<span class="myring_message_title">我的交易情况：</span> 
					<span class="myring_message_content">${circleUserEx.totalTrade }头(${circleUserEx.totalTradeTimes}笔)</span>
				</div>
				<div class="myring_message_text">
					<i> 
						<img class="myring_message_icon" src="/static/newhope/html/images/ic_jyqk_now.png" />
					</i> 
					<span class="myring_message_title">正在交易情况：</span> 
					<input type="hidden" value="${circleUserEx.trading }" id="trading"/>
					<span class="myring_message_content">${circleUserEx.trading }头(${circleUserEx.tradingTimes}笔)</span>
				</div>
			</div>
			<div style="clear: both;"></div>
		</div>
		<div class="line"></div>
		<div class="myring_buy_bg" onclick="changeLocation('/mine/bought/list?circleId=${circleUserEx.circleId }');">
			<i> 
				<img class="myring_buy_icon" src="/static/newhope/html/images/ic_me_mr.png" />
			</i> 
			<span class="myring_buy_text">我买到的 </span> 
			<input class="myring_list_icon" type="button" />
			<div class="myring_but_menber">${circleUserEx.buyerTotalTradeTimes }笔</div>
		</div>
		<div class="line"></div>
		<div class="myring_buy_bg" onclick="changeLocation('/mine/saledProduct/toSaledPage?circleId=${circleUserEx.circleId }');">
			<i> 
				<img class="myring_buy_icon" src="/static/newhope/html/images/ic_me_mc.png" />
			</i> 
			<span class="myring_buy_text">我卖出的</span> 
			<input class="myring_list_icon" type="button" />
			<div class="myring_but_menber">${circleUserEx.salerTotalTradeTimes }笔</div>
		</div>
	</div>
	<input class="myring_submit" type="button" onclick="exitCircle('${circleUserEx.id }')" value="退出该交易圈" />
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
<script type="text/javascript" charset="UTF-8" src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="/static/newhope/html/js/jquery-weui.min.js"></script>
<script type="text/javascript">
	function exitCircle(circleUserId){
		if ($("#trading").val() != 0){
			$.toast("您有交易未完成，无法退出该圈子！", "text");
			return;
		}
		$.confirm("确定退出该交易圈", function() {
				//点击确认后的回调函数
				var dataJson = {
		    		id : circleUserId
				};
				$.ajax({
		       		type:'POST',
		       		url:"/user/circleUser/kickOutByCircleUserId",
		       		data:JSON.stringify( dataJson),
		       		contentType:'application/json',
		       		dataType:'json',
		       		success:function(result){
		       			if (result.success){
		       				location.href="/trade/circle/list?type=whole&v="+Math.random();
		       			} else {
		       				$.toast(result.msg, "text");
		       			}
		       		},
		       		error:function(){
		       			$.toast("操作异常，请联系管理员！", "text");
		       		}
		       	});
			}, function() {
		    	//点击取消后的回调函数
			}
		);
	}
	
	//页面跳转
	function changeLocation(href){
		location.href= href;
	}
</script>
</html>