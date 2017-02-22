<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta charset="UTF-8">
    <title>新加入的成员</title>
    <!--bootstrap样式-->
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/bootstrap.min.css"/>
    <!--自定义公共样式-->
    <link rel="stylesheet" type="text/css" href="/static/newhope/html/css/common.css"/>
    <!--weui样式-->
    <link rel="stylesheet" type="text/css" href="/static/newhope/html/css/weui.min.css"/>
    <link rel="stylesheet" type="text/css" href="/static/newhope/html/css/jquery-weui.min.css"/>
    <!--自身页面单独样式-->
    <link rel="stylesheet" type="text/css" href="/static/newhope/html/css/newMember.css"/>
</head>
<body>
<div id="warp">
	<c:forEach items="${applyCircleList }" var="applyCircle" varStatus="s">
		<c:if test="${s.index == 0 }">
			<input type="hidden" id="circleId" value="${applyCircle.circleId }"/>
		</c:if>
		<div class="newmember-list" id="newmember-${applyCircle.id}">
	        <div class="headImg">
	        	<c:choose>
           			<c:when test="${fn:startsWith(applyCircle.headImg,'http') }">
	             		<img src="${applyCircle.headImg }"/>
           			</c:when>
           			<c:otherwise>
	             		<img src="${imgServer }${applyCircle.headImg }"/>
           			</c:otherwise>
           		 </c:choose>
	        </div>
	        <ul class="newmember-info">
	            <li class="trueName">${applyCircle.name }
	            	<c:if test="${applyCircle.circleRole.value == 'SALER' }">
	            		<img src="/static/newhope/html/images/ic_lable_mz_blue.png"/>
	        		</c:if>
	        		<c:if test="${applyCircle.circleRole.value == 'BUYER' }">
	            		<img src="/static/newhope/html/images/ic_lable_mz_green.png"/>
	        		</c:if>
	            </li>
	            <li class="member-info">手机：${applyCircle.mobile }</li>
	            <li class="member-info">"${applyCircle.applyDec }"</li>
	        </ul>
	        <div class="isNot">
	            <button type="button" class="disagree" data-toggle="modal" onclick="$('#applyCircleId').val('${applyCircle.id}')" data-target="#myModal">拒绝</button>
	            <button type="button" class="agree submitBtn" onclick="submitAudit('${applyCircle.id}','PASSED')">通过</button>
	        </div>
	    </div>
	</c:forEach>
    <!--拒绝模态框-->
    <div class="modal fade" style="margin-top: 5.333rem" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
            	<input id="applyCircleId" type="hidden"/>
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true"><img src="/static/newhope/html/images/btn_input_delete_normal.png" style="width:1rem;height:1rem"/></span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">拒绝原因</h4>
                </div>
                <div class="modal-body">
                    <textarea class="reason-content" id="refuseReason" maxlength="30" placeholder="没交保证金"></textarea>
                    <span class="maxlength">30字内</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="sendReason submitBtn" onclick="submitAudit($('#applyCircleId').val(),'REFUSED')">发送</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
</div>

<!--字体大小换脚本-->
<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
<!--jquery脚本-->
<script type="text/javascript" src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>
<!--bootstrap脚本-->
<script type="text/javascript" src="/static/newhope/html/js/bootstrap.min.js"></script>
<!--jquery weui脚本-->
<script type="text/javascript" src="/static/newhope/html/js/jquery-weui.min.js"></script>

<script type="text/javascript" charset="utf-8" src="/static/trade/js/tradeCommon.js"></script>
<script type="text/javascript" charset="utf-8" src="/static/plug-in/layer/layer.js"></script> 
<script type="text/javascript">
	//提交审核
	function submitAudit(applyCircleId,auditStatus){
		$(".submitBtn").attr( "disabled","disabled");
		var data = "id="+applyCircleId+'&auditStatus='+auditStatus;
		if (auditStatus == 'REFUSED'){
			if (checkEmpty($("#refuseReason").val())){
				$.toast("拒绝原因不能为空！","text");
				$(".submitBtn").removeAttr( "disabled");
				return;
			}
			data += "&refuseReason="+$("#refuseReason").val();
		}
		$.ajax({
			type: "POST",  
	        url: "/user/applyCircle/audtiApplyCircle",  
	        data: data,  
	        dataType: "json",
	        cache:false,
	        success: function(data){
	        	if (data.success){
	        		$("#newmember-"+applyCircleId).remove();
	        		var text;
	        		if(auditStatus == 'PASSED'){
	        			text = "已通过对方的加入申请";
	        		} else if (auditStatus == 'REFUSED'){
	        			$("#applyCircleId").val("");
	        			$("#refuseReason").val("");
	        			$(".close").click();
	        			
	        			text = "已拒绝对方的加入申请";
	        		}
	                $.toast(text, "text");
	                //如果审核申请表为空
	                if (checkEmpty($(".newmember-list")) || $(".newmember-list").length == 0){
	                	location.href="/user/circleUser/toCircleUserListPage?circleId="+$("#circleId").val()+"&v="+Math.random();
	                } else {
	        			$(".submitBtn").removeAttr( "disabled");
	                }
	        	} else {
	        		$.toast(data.msg, "text");
	        		$(".submitBtn").removeAttr( "disabled");
	        	}
	        },
	        error: function(){
	        	$.toast("操作异常，请联系管理员！", "text");
	        	$(".submitBtn").removeAttr( "disabled");
	        }
		});
	}
</script>
 
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>