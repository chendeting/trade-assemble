<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link type="text/css" rel="stylesheet" href="/static/newhope/html/css/messages.css"/>
<div class="weui_tabbar">
    <a href="/trade/product/list" class="weui_tabbar_item " id="trading_a_tag">
        <div class="weui_tabbar_icon">
            <img class="normal" src="/static/newhope/html/images/btn_tabbar_jy_normal.png" alt="">
            <img class="selected" src="/static/newhope/html/images/btn_tabbar_jy_selected.png"/>
        </div>
        <p class="weui_tabbar_label">交易</p>
    </a>
    <a href="/mine/publishedProduct/toMinePublishedPage" class="weui_tabbar_item" id="publish_a_tag">
        <div class="weui_tabbar_icon">
            <img class="normal" src="/static/newhope/html/images/btn_tabbar_hq_normal.png" alt="">
            <img class="selected" src="/static/newhope/html/images/btn_tabbar_hq_selected.png"/>
        </div>
        <p class="weui_tabbar_label">发布</p>
    </a>
    <a href="/message/allMessages.do" class="weui_tabbar_item" id="message_a_tag">
        <div class="weui_tabbar_icon">
            <img class="normal" src="/static/newhope/html/images/btn_tabbar_xx_normal.png" alt="">
            <img class="selected" src="/static/newhope/html/images/btn_tabbar_xx_selected.png"/>
            <c:if test="${haveMessage }">
        		<span class="haveMsg"></span>
        	</c:if>
        </div>
        <p class="weui_tabbar_label">消息</p>
    </a>
    <a href="/mine/mineHomePage/mineIndex" class="weui_tabbar_item" id="mine_a_tag">
        <div class="weui_tabbar_icon">
            <img class="normal" class="normal" src="/static/newhope/html/images/btn_tabbar_me_normal.png" alt="">
            <img class="selected" src="/static/newhope/html/images/btn_tabbar_me_selected.png"/>
        </div>
        <p class="weui_tabbar_label">我</p>
    </a>
</div>

<script type="text/javascript">
	function initAtag(id){
		$("#"+id).addClass("weui_bar_item_on"); 
	}
</script>




