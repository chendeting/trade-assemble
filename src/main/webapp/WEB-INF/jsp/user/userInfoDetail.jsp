<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <title>修改个人信息</title>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/weui.min.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/jquery-weui.min.css"/>
    <link rel="stylesheet" type="text/css" href="/static/newhope/html/css/common.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/changePersonInfo.css"/>
</head>
<body>
    <div class="weui_tab">
        <div class="weui_tab_bd">
            <div id="tab1" class="weui_tab_bd_item">
                <h1 class="doc-head">交易</h1>
            </div>
            <div id="tab2" class="weui_tab_bd_item">
                <h1 class="doc-head">发布</h1>
            </div>
            <div id="tab3" class="weui_tab_bd_item">
                <h1 class="doc-head">消息</h1>
            </div>
            <div id="tab4" class="weui_tab_bd_item weui_tab_bd_item_active">
                <div id="warp">
                    <form id="userForm" class="userForm" action="/user/userInfo/modify" method="post">
                    	<input type="hidden" name="id" id="id" value="${userInfo.id }"/>
                        <p class="name-title">姓名<span>（录入真实姓名让对方觉得真实可靠）</span></p>
                        <p class="p-input"><input class="username" type="text" name="name" id="name" onkeyup="limitNameLength(this)" maxlength="10" value="${userInfo.name }" /></p>
                        <p class="name-title">手机号码<span>（不可更改）</span></p>
                        <p class="p-input"><input class="tel" type="text" name="mobile" id="mobile" value="${userInfo.mobileStr }" readonly="readonly"/></p>
                        <input type="hidden" id="userTagListStr" name="userTagListStr"/>
                    </form>
                    <div class="self-label">
                        <p class="selfLabel">给自己打个标签吧</p>
                        <ul class="all-label">
                            <li>
                            	<img src="/static/newhope/html/images/ic_yang_big.png"/><p>养殖户</p>
                            	<img class="checked" style="display:${empty userTagMap['FARMER'] ? 'none' : 'block'}" userTagType="FARMER" src="/static/newhope/html/images/ic_bao_big_selected.png"/>
                            </li>
                            <li>
                            	<img src="/static/newhope/html/images/ic_fan_big.png"/><p>猪贩子</p>
                            	<img class="checked" style="display:${empty userTagMap['PIG_DEALER'] ? 'none' : 'block'}" userTagType="PIG_DEALER" src="/static/newhope/html/images/ic_bao_big_selected.png"/>
                            </li>
                            <%-- <li>
                            	<img src="/static/newhope/html/images/ic_tu_big.png"/><p>屠宰场</p>
                            	<img class="checked" style="display:${empty userTagMap['SLAUGHTERHOUSES'] ? 'none' : 'block'}" userTagType="SLAUGHTERHOUSES" src="/static/newhope/html/images/ic_bao_big_selected.png"/>
                            </li> --%>
                            <li>
                            	<img src="/static/newhope/html/images/icon_sell@2x.png"/><p>销售员</p>
                            	<img class="checked" style="display:${empty userTagMap['SALES_PERSON'] ? 'none' : 'block'}" userTagType="SALES_PERSON" src="/static/newhope/html/images/ic_bao_big_selected.png"/>
                            </li>
                            <li>
                            	<img src="/static/newhope/html/images/ic_jing_big.png"/><p>猪经济</p>
                            	<img class="checked" style="display:${empty userTagMap['PIG_AGENT'] ? 'none' : 'block'}" userTagType="PIG_AGENT" src="/static/newhope/html/images/ic_bao_big_selected.png"/>
                            </li>
                        </ul>
                    </div>
                    <div class="btn-box">
                        <button class="save-info" onclick="submitForm()">保存</button>
                    </div>
                </div>
            </div>
        </div>
        
        
        <!-- 引入底部菜单 -->
	<%@ include file="../menu/footMenu.jsp"%>
    </div>
    <script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
    <script type="text/javascript" src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="/static/newhope/html/js/jquery-weui.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="/static/trade/js/jquery-form.js"></script>
    <script type="text/javascript" charset="utf-8" src="/static/trade/js/tradeCommon.js"></script>
    <script type="text/javascript" charset="utf-8" src="/static/trade/js/util/strUtil.js"></script>
    <script type="text/javascript">
	    //限制名称最大输入长度
		function limitNameLength(thisObj){
			if (GetLength($(thisObj).val()) > 10) {
				$(thisObj).val(cutstr($(thisObj).val(), 10));
				return;
			}
		}
    
        $(".all-label li").click(function () {
            var checked=$(this).find(".checked");
            if(checked.css("display")=="none"){
                checked.show();
            }else{
                checked.hide();
            }
        });
        
        //提交数据
        function submitForm(){
        	if (checkEmpty($("#name").val())){
        		$.toast("姓名不能为空！","text");
        		return;
        	}
        	var userTagListStr= "";
        	$(".checked:visible").each(function () {
        		userTagListStr += $(this).attr("userTagType")+",";
            });
        	$("#userTagListStr").val(userTagListStr);
        	$("#userForm").ajaxSubmit({
    	        success:  function(result) {
    				if (result.success){
    					location.href="/mine/mineHomePage/mineIndex?v="+Math.random();
    				} else {
    					$.toast(result.msg,"text");
    				}
    			},
    			error:function(){
    				$.toast("操作异常，请联系管理员！","text");
    			}
    		});
        }

      //引入底部菜单时赋值
        initAtag("mine_a_tag");
    </script>
    <!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>