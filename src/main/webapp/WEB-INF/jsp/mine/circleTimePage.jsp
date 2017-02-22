<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta name="x5-orientation" content="portrait">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<meta charset="utf-8">
<title>统一拍卖时间设置</title>
<link type="text/css" rel="stylesheet" href="/static/newhope/html/css/index.css">
<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
<script style="" charset="UTF-8" src="/static/newhope/html/js/jquery-1.8.3.min.js"></script>
<style type="text/css">
.sametime_bg {
	width: 20rem;
	height: 7rem;
	background-color: #ffffff;
	font-family: "Microsoft YaHei";
}

.sametime_1 {
	width: 20rem;
	height: 1rem;
}

.sametime_2 {
	width: 20rem;
	height: 2.5rem;
	line-height: 2.5rem;
	color: #353535;
	font-size: 0.666667rem;
}

.sametime_2_head {
	width: 4rem;
	height: 2.5rem;
	text-align: right;
	float: left;
}

.sametime_2_body {
	width: 15rem;
	height: 2.5rem;
	margin-left: 1rem;
	float: left;
}

.sametime_input {
	width: 6rem;
	height: 2rem;
	border-radius: 1rem;
	border: #dedede solid 1px;
	float: left;
	position: relative;
	margin-top: 0.25rem;
	text-align: center;
	font-size: 0.666667rem;
}

.sametime_fenge {
	width: 2rem;
	height: 2.5rem;
	line-height: 2.5rem;
	text-align: center;
	font-size: 0.777778rem;
	float: left;
}

input {
	margin: 0;
	padding: 0;
	outline: none;
}
</style>
</head>
<body>
	<input type="hidden" id="circleId" value="${requestScope.circleId }" />
	<input type="hidden" id="userId" value="${userId }"/>
	<div>
		<div class="sametime_bg">
			<div class="sametime_1"></div>
			<div class="sametime_2">
				<div class="sametime_2_head">开始时间:</div>
				<div class="sametime_2_body" id="BID_TIME_START">
					<input name="id" type="hidden" value="${circleSettingMap['BID_TIME_START'].id}"/>
					<c:if test="${!empty circleSettingMap['BID_TIME_START']}">
						<input class="sametime_input requireInput" onkeyup="onlyInteger(this)" alertMsg="开拍时间小时不能为空！" id="timeStartHour" value='${fn:split(circleSettingMap["BID_TIME_START"].ruleValue,":")[0] }'  type="number"/>
						<div class="sametime_fenge">:</div>
						<input class="sametime_input requireInput" onkeyup="onlyInteger(this)" alertMsg="开拍时间分钟不能为空！" id="timeStartMinute" value='${fn:split(circleSettingMap["BID_TIME_START"].ruleValue,":")[1] }'  type="number"/>
					</c:if>
					<c:if test="${empty circleSettingMap['BID_TIME_START']}">
						<input class="sametime_input requireInput" onkeyup="onlyInteger(this)" alertMsg="开拍时间小时不能为空！" id="timeStartHour" value="10"  type="number"/>
						<div class="sametime_fenge">:</div>
						<input class="sametime_input requireInput" onkeyup="onlyInteger(this)" alertMsg="开拍时间分钟不能为空！" id="timeStartMinute" value="00"  type="number"/>
					</c:if>
				</div>
			</div>
			<div class="sametime_2">
				<div class="sametime_2_head">结束时间:</div>
				<div class="sametime_2_body" id="BID_TIME_END">
					<input name="id" type="hidden" value="${circleSettingMap['BID_TIME_END'].id}"/>
					<c:if test="${!empty circleSettingMap['BID_TIME_END']}">
						<input class="sametime_input requireInput" onkeyup="onlyInteger(this)" alertMsg="开拍结束时间小时不能为空！" id="timeEndHour" value='${fn:split(circleSettingMap["BID_TIME_END"].ruleValue,":")[0]}'  type="number"/>
						<div class="sametime_fenge">:</div>
						<input class="sametime_input requireInput" onkeyup="onlyInteger(this)" alertMsg="开拍结束时间分钟不能为空！" id="timeEndMinute" value='${fn:split(circleSettingMap["BID_TIME_END"].ruleValue,":")[1]}'  type="number"/>
					</c:if>
					<c:if test="${empty circleSettingMap['BID_TIME_END']}">
						<input class="sametime_input requireInput" onkeyup="onlyInteger(this)" alertMsg="开拍结束时间小时不能为空！" id="timeEndHour" value="22"  type="number"/>
						<div class="sametime_fenge">:</div>
						<input class="sametime_input requireInput" onkeyup="onlyInteger(this)" alertMsg="开拍结束时间分钟不能为空！" id="timeEndMinute" value="00"  type="number"/>
					</c:if>
				</div>
			</div>
			<div class="sametime_1"></div>
		</div>
		<button id="tijiaodingdan" onclick="submitForm()" style="margin-bottom: 1rem; width: 17rem; height: 2.222222rem; margin-top: 1rem; margin-left: 1.5rem; border: none; outline: none; background: #F02B2B; background-image: linear-gradient(-180deg, #F04746 0%, #DD4B39 100%); box-shadow: 0rem 0rem 0.36rem 0rem rgba(235, 72, 66, 0.50); border-radius: 1.5rem; font-size: 1rem; color: #ffffff; font-family: 'Microsoft YaHei'; text-align: center;">确定</button>
	</div>
	 
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
<script type="text/javascript" src="/static/plug-in/layer/layer.js"></script> 
<script type="text/javascript" charset="utf-8" src="/static/trade/js/tradeCommon.js?v=20161119111228"></script>
<script type="text/javascript">

var startHourFlag = true;
var startMinuteFlag = true;
var endHourFlag = true;
var endMinuteFlag = true;

$(function(){
	//只能填入正整数
	$(".wholeNum").keyup(function(){  
		wholeNumCheck(this);
    }).on("paste",function(){  //CTR+V事件处理    
    	wholeNumCheck(this);
    });
	
	//开始时间小时change事件
	$("#timeStartHour").on("change",function(){
		if ( parseInt($(this).val()) < 0 || parseInt($(this).val()) > 23 ){
			startHourFlag = false;
			layer.alert("小时数必须在0到23之间！");
			$(this).val("");
		}else if (!checkEmpty($(this).val()) && !checkEmpty( $("#timeEndHour").val() ) ){
			if ( parseInt($(this).val()) > parseInt($("#timeEndHour").val()) ){
				startHourFlag = false;
				layer.alert("开始拍卖时间必须小于开拍结束时间！");
				$(this).val("");
			} else if ( parseInt($(this).val()) == parseInt($("#timeEndHour").val()) ){
				if (!checkEmpty( $("#timeStartMinute").val() ) && !checkEmpty( $("#timeEndMinute").val() )){
					if ( parseInt($("#timeStartMinute").val()) >= parseInt($("#timeEndMinute").val()) ){
						startHourFlag = false;
						layer.alert("开始拍卖时间必须小于开拍结束时间！");
						$(this).val("");
					}
				}
			}
			
		} 
	});
	
	//开始时间分钟change事件
	$("#timeStartMinute").on("change",function(){
		if ( parseInt($(this).val()) < 0 || parseInt($(this).val()) > 59 ){
			startMinuteFlag = false;
			layer.alert("分钟数必须在0到59之间！");
			$(this).val("");
		}else if ( !checkEmpty($(this).val()) && !checkEmpty( $("#timeEndMinute").val() ) 
				&& !checkEmpty( $("#timeStartHour").val() ) && !checkEmpty( $("#timeEndHour").val() ) ){
			if ( parseInt($("#timeStartHour").val()) == parseInt($("#timeEndHour").val()) && parseInt($(this).val()) >= parseInt($("#timeEndMinute").val())){
				startMinuteFlag = false;
				layer.alert("开始拍卖时间必须小于开拍结束时间！");
				$(this).val("");
			} 
		}
	});
	
	//结束时间小时change事件
	$("#timeEndHour").on("change",function(){
		if ( parseInt($(this).val()) < 0 || parseInt($(this).val()) > 23 ){
			endHourFlag = false;
			layer.alert("小时数必须在0到23之间！");
			$(this).val("");
		}else if (!checkEmpty($(this).val()) && !checkEmpty( $("#timeStartHour").val() ) ){
			if ( parseInt($(this).val()) < parseInt($("#timeStartHour").val()) ){
				endHourFlag = false;
				layer.alert("开拍结束时间必须大于开拍开始时间！");
				$(this).val("");
			} else if ( parseInt($(this).val()) == parseInt($("#timeStartHour").val()) ){
				if (!checkEmpty( $("#timeStartMinute").val() ) && !checkEmpty( $("#timeEndMinute").val() )){
					if ( parseInt($("#timeStartMinute").val()) >= parseInt($("#timeEndMinute").val()) ){
						endHourFlag = false;
						layer.alert("开拍结束时间必须大于开拍开始时间！");
						$(this).val("");
					}
				}
			}
			
		}
	});
	
	//结束时间分钟change事件
	$("#timeEndMinute").on("change",function(){
		if ( parseInt($(this).val()) < 0 || parseInt($(this).val()) > 59 ){
			endMinuteFlag = false;
			layer.alert("分钟数必须在0到59之间！");
			$(this).val("");
		}else if ( !checkEmpty($(this).val()) && !checkEmpty( $("#timeStartMinute").val() ) 
				&& !checkEmpty( $("#timeStartHour").val() ) && !checkEmpty( $("#timeEndHour").val() ) ){
			if ( parseInt($("#timeStartHour").val()) == parseInt($("#timeEndHour").val()) && parseInt($(this).val()) <= parseInt($("#timeStartMinute").val())){
				endMinuteFlag = false;
				layer.alert("开拍结束时间必须大于开拍开始时间！");
				$(this).val("");
			} 
		}
	});
	
});

//只能输入正整数
function onlyInteger(thisObj){
	var objVal = $(thisObj).val();
	if (!checkEmpty(objVal) && objVal.length > 2){
		//从0开始截取长度为2的字符创
		objVal = objVal.substr(0,2);
	}
	var wholeNum = objVal.replace(/^(\-)+/g,"").match(/^[0-9]\d*/);
	wholeNum = wholeNum ? wholeNum : "";
	$(thisObj).val(wholeNum[0]);
}

//将价格组装成json
function circleSettingJson(){
	var expireDate = $("#expireDate").val();
	var userId = $("#userId").val();
	var circleId = $("#circleId").val();
	var circleSetting = [];
	var dataStart={
			creator: userId,
			circleId: circleId,
			id:$("#BID_TIME_START").find("input[name='id']").val(),
			ruleType:"BID_TIME_START",
			ruleValue:$.trim($("#timeStartHour").val())+$.trim(":")+$.trim($("#timeStartMinute").val())
	}
	circleSetting.push(dataStart);
	
	var dataEnd={
			creator: userId,
			circleId: circleId,
			id:$("#BID_TIME_END").find("input[name='id']").val(),
			ruleType:"BID_TIME_END",
			ruleValue:$.trim($("#timeEndHour").val())+$.trim(":")+$.trim($("#timeEndMinute").val())
	}
	circleSetting.push(dataEnd);
	
	return JSON.stringify(circleSetting);
}

// 提交数据
function submitForm() {
	if (startHourFlag && startMinuteFlag && endHourFlag && endMinuteFlag){
		var message = validateForm("requireInput","alertMsg");
		if (checkEmpty(message)){
			//加载中
	    	layer.load(1, {
	    		time: 5000,
	    		shade: [0.5, '#000000']
	    	});
			$.ajax( {
				type: "POST",
				url: "/mine/auctionHouse/saveCircleSetting",
				contentType: "application/json",
				data: circleSettingJson(),
				dataType: "json",
				success: function( data ) {
					if(data == 'sessionTimeout'){
	                    location.href="/trade/mine/sessionTimeout.do?v="+Math.random();//跳转到session失效页面
	                }else if( data.success ) {
						location.href="/mine/auctionHouse/toHousePage?v="+Math.random();
					} else {
						//关闭加载弹出框
			  			layer.closeAll();
						layer.alert( data.msg );
					}
				},
	            error:function(){
	            	//关闭加载弹出框
		  			layer.closeAll();
	            	layer.laert("操作异常，请联系管理员！");
	            }
			} );
		} else {
			layer.alert(message);
		}
	}else {
		startHourFlag = true;
		startMinuteFlag = true;
		endHourFlag = true;
		endMinuteFlag = true;
	}
} 

</script>
</html>