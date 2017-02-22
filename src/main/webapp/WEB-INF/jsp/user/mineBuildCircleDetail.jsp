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
<title>我自建的交易圈</title>
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
				<div class="join_circle_2">
					成员数量<span>(${circleEx.memberCount})</span>
				</div>
				<div class="join_circle_2">${circleEx.province}${circleEx.city}${circleEx.district}</div>
				<div class="join_circle_2">${circleEx.circleDec}</div>
				<div class="join_circle_3">
					<div style="float: left;">活跃度</div>
					<img class="vitality_icon" src="/static/newhope/html/images/ic_fire.png" /> 
					<img class="vitality_icon" src="/static/newhope/html/images/ic_fire.png" /> 
					<img class="vitality_icon" src="/static/newhope/html/images/ic_fire.png" /> 
					<input type="button" class="mybuild_share_icon" onclick="share()"/>
				</div>
			</div>
			<div style="clear: both;"></div>
		</div>
		<div class="line"></div>
		<div class="mybuild_part1_condition">
			<div class="mybuild_condition_1">
				<div class="mybuild_time">创建时间：</div>
				<div class="mybuild_time_text"><fmt:formatDate value="${circleEx.gmtCreated }" pattern="yyyy-MM-dd" /></div>
			</div>
			<div class="mybuild_condition_2">
				<div class="mybuild_jointerm">加入条件：</div>
				<div class="mybuild_jointerm_text">${circleEx.circleCondition }</div>
			</div>
			<div style="clear: both;"></div>
		</div>
		<a href="/trade/circle/handlercircle?circleid=${circleEx.id}">
			<input type="button" value="设置交易圈" class="install_ring" />
		</a>
		<div class="mybuild_grouping">交易圈管理</div>
		<div class="myring_buy_bg" onclick="changeLocation('/trade/circle/circleTradeSetting.do?circleId=${circleEx.id}');">
			<i> 
				<img class="myring_buy_icon" src="/static/newhope/html/images/ic_jygz.png" />
			</i> 
			<span class="myring_buy_text"> 交易规则 </span> 
			<input class="myring_list_icon" type="button" />
		</div>
		<div class="line"></div>
		<div class="myring_buy_bg" onclick="changeLocation('/user/circleUser/toCircleUserListPage?circleId=${circleEx.id}');">
			<i> 
				<img class="myring_buy_icon" src="/static/newhope/html/images/ic_cygl.png" />
			</i> 
			<span class="myring_buy_text"> 成员管理 </span> 
			<input class="myring_list_icon" type="button" />
			<div class="mine_notice_round" style="display: ${empty circleEx.isHaveApply || !circleEx.isHaveApply ? 'none' : ''}"></div>
		</div>
		<div class="line"></div>
		<div class="myring_buy_bg" onclick="changeLocation('/user/userCircle/toCircleTradeHistoryPage?circleId=${circleEx.id}');">
			<i> 
				<img class="myring_buy_icon" src="/static/newhope/html/images/ic_jylh.png" />
			</i> 
			<span class="myring_buy_text"> 交易历史 </span> 
			<input class="myring_list_icon" type="button" />
		</div>
		<div class="mybuild_grouping">我的交易</div>
		<div class="myring_buy_bg"  onclick="changeLocation('/mine/bought/list?circleId=${circleUserEx.circleId }');">
			<i> 
				<img class="myring_buy_icon" src="/static/newhope/html/images/ic_me_mr.png" />
			</i> 
			<span class="myring_buy_text"> 我买到的 </span> 
			<input class="myring_list_icon" type="button" />
			<div class="myring_but_menber">${circleUserEx.buyerTotalTradeTimes }笔</div>
		</div>
		<div class="line"></div>
		<div class="myring_buy_bg" onclick="changeLocation('/mine/saledProduct/toSaledPage?circleId=${circleUserEx.circleId }');">
			<i> 
				<img class="myring_buy_icon" src="/static/newhope/html/images/ic_me_mc.png" />
			</i> 
			<span class="myring_buy_text"> 我卖出的 </span> 
			<input class="myring_list_icon" type="button" />
			<div class="myring_but_menber">${circleUserEx.salerTotalTradeTimes }笔</div>
		</div>
	</div>
	<input class="myring_submit" type="button" onclick="dissolveCircle('${circleEx.id }')" value="解散该交易圈" />
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
<script type="text/javascript" charset="UTF-8" src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="/static/newhope/html/js/jquery-weui.min.js"></script>
<script type="text/javascript">
	//解散交易圈
	function dissolveCircle(circleId){
		$.confirm("确定解散该交易圈", function() {
			  	//点击确认后的回调函数
				$.ajax({
					type:"POST",
					url:"/user/userCircle/dissolveCircleById",
					data:"circleId="+circleId,
					dataType:"json",
					success:function(result){
						if(result.success){
							location.href="/trade/circle/list?type=whole&v="+Math.random();
						} else {
							$.toast(result.msg,"text");
						}
					},
					error:function(){
						$.toast("操作异常，请联系管理员","text");
					}
				});
			}, function() {
				//点击取消后的回调函数
			}
		);
	}
	
	//分享生成二维码
	function share(){
		var shareUrl = "/user/applyCircle/mineShare.do?circleId=${circleEx.id}&circleType=${circleEx.circleType}";
		location.href = shareUrl;
	}
	
	//页面跳转
	function changeLocation(href){
		location.href= href;
	}
</script>
</html>