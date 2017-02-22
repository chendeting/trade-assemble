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
<title>我的</title>
<script type="text/javascript" charset="UTF-8" src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>

<link type="text/css" rel="stylesheet" href="/static/newhope/html/css/index.css">
<link type="text/css" rel="stylesheet" href="/static/newhope/html/css/weui.min.css"/>
<link type="text/css" rel="stylesheet" href="/static/newhope/html/css/huadongjiazai.min.css"/>
<link rel="stylesheet" type="text/css" href="/static/newhope/html/css/common.css"/>
<link type="text/css" rel="stylesheet" href="/static/newhope/html/css/font-awesome/css/font-awesome.min.css"/>

</head>
<body>
	<input type="hidden" value="${homePageInfo.userInfoModel.id }" id="txt_userId">
	<div class="mine_headpic_bg">
		<div>
			<c:choose>
				<c:when test="${fn:startsWith(homePageInfo.userInfoModel.headImg, 'http://')}">
					<img id="headImg" class="mine_headpic_pic" src="${homePageInfo.userInfoModel.headImg }" onclick="wxChooseImage('uploadCallback');">
				</c:when>
				<c:otherwise>
					<img id="headImg" class="mine_headpic_pic" src="${imgServer }${homePageInfo.userInfoModel.headImg }" onclick="wxChooseImage('uploadCallback');">
				</c:otherwise>
			</c:choose>
		</div>
		<input type="button" class="mine_photograph" />
	</div>
	<div class="line"></div>
	<div class="auction_bg1" onclick="goPage('/user/userInfo/${homePageInfo.userInfoModel.id }')">
		<div class="mine_identity">
			<div class="mine_identity_content">
				<i> 
					<img class="mine_identity_icon" src="/static/newhope/html/images/ic_me_people.png">
				</i> 
				<span style="float: left; margin-left: 0.3rem">${homePageInfo.userInfoModel.name }</span>
			</div>
			<div class="mine_identity_content">
				<span style="float: left; margin-left: 1.2rem;">${homePageInfo.userInfoModel.mobileStr }</span>
			</div>
		</div>
		<div>
			<input class="auction_list_icon" type="button" />
			<div class="mine_identity_xiugai">修改</div>
		</div>
	</div>
	<div class="line"></div>
	<div class="mine_buy_bg" onclick="location.href='/mine/bought/list'">
		<i> 
			<img class="myring_buy_icon" src="/static/newhope/html/images/ic_me_mr.png" />
		</i>
		<span class="mine_buy_text"> 我买到的 </span> 
		<input class="myring_list_icon" type="button" />
		<div class="myring_but_menber">${empty homePageInfo.boughtOrderCount?0:homePageInfo.boughtOrderCount }笔</div>
		<div class="mine_notice_round" style="display: none;"></div>
	</div>
	<div class="line"></div>
	<div class="mine_buy_bg" onclick="location.href='/mine/saledProduct/toSaledPage'">
		<i> 
			<img class="myring_buy_icon" src="/static/newhope/html/images/ic_me_mc.png" />
		</i> 
		<span class="mine_buy_text"> 我卖出的 </span> 
		<input class="myring_list_icon" type="button" />
		<div class="myring_but_menber">${empty homePageInfo.saledProductCount?0:homePageInfo.saledProductCount }笔</div>
		<div class="mine_notice_round" style="display: none;"></div>
	</div>
	<div class="wall"></div>
	<div class="mine_buy_bg" onclick="location.href='/user/pigFaram/toPigFaramListPage'">
		<i> 
			<img class="myring_buy_icon" src="/static/newhope/html/images/ic_me_myzc.png" />
		</i> 
		<div >
			<span class="mine_buy_text"> 我的猪场 </span> 
			<input class="myring_list_icon" type="button" />
			<div class="myring_but_menber">${homePageInfo.pigFaramCount }</div>
		</div>
	</div>
	<div class="line"></div>
	<div class="mine_buy_bg"  onclick="goPage('/trade/circle/list?type=whole')">
		<i>
			<img class="myring_buy_icon" src="/static/newhope/html/images/ic_me_myjyq.png" />
		</i> 
		<span class="mine_buy_text"> 我的交易圈 </span>
		<input class="myring_list_icon" type="button" />
		<div class="myring_but_menber">${homePageInfo.circleCount }</div>
		<div class="mine_notice_round" style="display: ${empty homePageInfo.isHaveApply || !homePageInfo.isHaveApply ? 'none' : '' };"></div>
	</div>
	<div class="line"></div>
	<div class="mine_buy_bg"  onclick="goPage('/mine/mineHomePage/mine/exit.do')">
		<i>
			<img class="myring_buy_icon" src="/static/newhope/html/images/esc.jpg" />
		</i> 
		<span class="mine_buy_text">清除缓存</span>
		<input class="myring_list_icon" type="button" />
		<div class="myring_but_menber"></div>
	</div>
	
<!-- 引入底部菜单 -->
<%@ include file="../menu/footMenu.jsp"%>
 
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
<script type="text/javascript" charset="UTF-8" src="/static/newhope/html/js/jquery-weui.min.js"></script>
<script type="text/javascript" charset="UTF-8" src="/static/newhope/html/js/htmlsize.js"></script>
<script type="text/javascript">
	function goPage(url){
		location.href = url;
	}
</script>

<!-- 引入上传图片 -->
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript" src="/static/trade/js/uploadImg.js?v=2016541354554"></script>
<script type="text/javascript">
//上传照片后的回调
function uploadCallback(obj){
	uploadCallbackSetValue(obj);
}

//上传照片后的回调
function uploadCallbackSetValue(obj){
	//alert(JSON.stringify(obj));
    //imgpath: obj.imgPath
	$("#headImg").attr('src', obj.imageSrc);
	//修改用户头像信息
	$.ajax({
		url : "/user/userInfo/modifyHeadImg.do?&_d=" + new Date(),
		data : {
			userId : '${homePageInfo.userInfoModel.id }',
			headImg : obj.imgPath
		},
		cache : false,
		dataType : 'json',
		success : function(data) {
			if (data.flag == 'succeed') {
				$.toast(data.msg, "text");
			} else {
				$.toast(data.msg, "text");
			}
		}
	});
}

//引入底部菜单时赋值
    initAtag("mine_a_tag");
</script>
</html>












