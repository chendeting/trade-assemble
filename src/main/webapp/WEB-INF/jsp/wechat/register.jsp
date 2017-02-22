<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <title>注册</title>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/index.css">
    <script type="text/javascript" charset="utf-8" src="/static/trade/js/util/strUtil.js"></script>
    <script type="text/javascript" charset="UTF-8" src="/static/newhope/html/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
    <script>
        function checkclick(){
            var checkimg = document.getElementById("checkimg");
            if($("#agree").is(':checked') ){
                $("#agree").attr("checked","unchecked");
                checkimg.src="/static/newhope/html/images/btn_radiubox_normal.png";
				$(".register_input_3").attr("disabled","disabled").css({"backgroundColor":"#ccc","border-color":"#ccc"});
				$(".register_input_4").attr("disabled","disabled").css({"backgroundColor":"#ccc","border-color":"#ccc"});
            } else{
                $("#agree").attr("unchecked","checked");
                checkimg.src="/static/newhope/html/images/btn_radiubox_selected.png";
                $(".register_input_3").removeAttr("disabled").css({"backgroundColor":"#1bbd3d","border-color":"#1bbd3d"});
				$(".register_input_4").removeAttr("disabled").css({"backgroundColor":"#1bbd3d","border-color":"#1bbd3d"});
            }
        }
    </script>
    <script type="text/javascript">

        var InterValObj; //timer变量，控制时间
        var count = 60; //间隔函数，1秒执行
        var curCount;//当前剩余秒数

        function sendMessage() {
            curCount = count;
            //设置button效果，开始计时
            $("#btn-yzm").attr("disabled", "true");
            $("#btn-yzm").val(curCount + "S");
            $("#btn-yzm").addClass("wait");
            InterValObj = window.setInterval(SetRemainTime, 1000); //启动计时器，1秒执行一次
            //向后台发送处理数据
            $.ajax({
                type: "POST", //用POST方式传输
                dataType: "text", //数据格式:JSON
                url: 'Login.ashx', //目标地址
                data: "dealType=" + dealType +"&uid=" + uid + "&code=" + code,
                error: function (XMLHttpRequest, textStatus, errorThrown) { },
                success: function (msg){ }
            });
        }

        //timer处理函数
        function SetRemainTime() {
            if (curCount == 0) {
                window.clearInterval(InterValObj);//停止计时器
                $("#btn-yzm").removeAttr("disabled");//启用按钮
                $("#btn-yzm").val("重新发送验证码");
                $("#btn-yzm").removeClass("wait");
            }
            else {
                curCount--;
                $("#btn-yzm").val(+ curCount + "S");
            }
        }
    </script>
</head>
<body>
<div style="font-size:0.72rem;color:#666666;background-color:#ebebeb;width:20rem;height: 36rem;position:absolute;display: none;" id="xieyi">
    <div style="margin:1rem 1rem 1rem 1rem;line-height: 1rem;width: 18rem;">
        新希望六和股份有限公司(以下简称"新希望六和")在此特别提醒您(用户)在注册成为用户之前，请认真阅读本《用户协议》(以下简称“协议”)，确保您充分理解本协议中各条款。请您审慎阅读并选择接受或不接受本协议。除非您接受本协议所有条款，否则您无权注册、登录或使用本协议所涉服务。您的注册、登录、使用等行为将视为对本协议的接受，并同意接受本协议各项条款的约束。
    </div>
    <div style="line-height: 1rem;margin:0rem 1rem 0rem 1rem;">
        一、注册协议
    </div>
    <div style="margin:1rem 1rem 1rem 1rem;line-height: 1rem;width: 18rem;">
        注册为本协议用户的个人主体的条件：持有中华人民共和国有效身份证明的18周岁以上具有完全民事行为能力的自然人。如您不符合资格，请勿注册，否则本网站有权随时中止或终止您的用户资格。
    </div>
    <div style="line-height: 1rem;margin:0rem 1rem 0rem 1rem;">
        二、本协议组成部分及签署和修订
    </div>
    <div style="margin:1rem 1rem 1rem 1rem;line-height: 1rem;width: 18rem;">
        <div>
            1、本协议的组成部分：包括但不限于本协议全部条款及本网站已经或将来可能发布的各类规则。本协议是您与本网站共同签订的，适用于您在本网站的全部活动，您在本网站的全部行为所产生的权利、义务及法律责任均由您自行承担。
        </div>
        <div>
            2、本网站有权根据需要不时地修改本协议或根据本协议制定、修改各类具体规则并在本网站相关系统板块发布，无需另行单独通知您。若您在本协议及具体规则内容公告变更后继续使用本服务的，表示您已充分阅读、理解并接受修改后的协议和具体规则内容，也将遵循修改后的协议和具体规则使用本网站的服务；同时就您在协议和具体规则修订前通过本网站进行的交易及其效力，视为您已同意并已按照本协议及有关规则进行了相应的授权和追认（新修订的协议与具体规则不要求授权与追认的除外）。若您不同意修改后的协议内容，您应停止使用本网站的服务。
        </div>
    </div>
</div>
<div style="position: absolute;z-index:-10;">

	<input type="hidden" id="openid" value="${openid }">
	<input type="hidden" id="headImg" value="${headImg }">
     <div class="head_pic_bg">
     	
     	<c:if test="${empty headImg}">
     		<img class="head_pic_img" src="/static/newhope/html/images/morentu.png"/>
     	</c:if>
     	<c:if test="${not empty headImg}">
     		<img class="head_pic_img" src="${headImg}"/>
     	</c:if>
     </div>
     <div class="register_text">
            <div class="register_text_1">
                姓名
            </div>
            <div class="register_text_2">
                录入真实姓名让用户觉得更可靠
            </div>
     </div>
     <input class="register_input_1" placeholder="请输入用户名" id="name" value="${name }"/>
     <div class="register_text">
             手机号
     </div>
     <input class="register_input_1" placeholder="请输入手机号" id="mobile" onkeyup="value=value.replace(/[^\d]/g,'')"/>
     <div class="register_text">
             验证码
     </div>
     <input class="register_input_2" placeholder="请输入验证码" id="code"/>
     <input id="btn-yzm" class="register_input_3" type="button" onclick="sendMobileSmsCode(this)" value="获取验证码"/>
     <label id="tip" class="register_remind">
     </label>
     <div style="width:20rem;text-align: center;float: left;">
     	<input class="register_input_4" type="button" value="注册" onclick="bind()"/>
     </div>
     <div class="shenming">
         <input type="checkbox" checked="checked" style="display: none;" id="agree" >
         <label class="shengming_check" for="agree" >
             <img  class="checkbox_pic" src="/static/newhope/html/images/btn_radiubox_selected.png"  id="checkimg" onclick="checkclick()">
         </label>
         <div class="shengming_text">
             <div style="float: left"> 我已阅读并同意</div>
             <a class="shengming_xieyi" id="yonghuxieyi">
                                  《猪小e用户协议》
             </a>
         </div>
     </div>
</div>
<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>

<script type="text/javascript" charset="utf-8" src="/static/plug-in/layer/layer.js"></script> 
<script type="text/javascript">
	var oldMobile = "";
	//短信验证码发送变量
	var curMobileCount;
	var countMobile = 60;
	var interValMobile;

	//验证码发送倒计时
	function setMobileRemainTime() {
		if (curMobileCount == -1) {
			window.clearInterval(interValMobile);
			$("#btn-yzm").attr('onclick', 'sendMobileSmsCode(this)');
			$("#btn-yzm").removeAttr("disabled");//启用按钮
            $("#btn-yzm").val("重新发送验证码");
            $("#btn-yzm").removeClass("wait");            
		} else if (curMobileCount == 0) {
			window.clearInterval(interValMobile);
			$("#btn-yzm").attr('onclick', 'sendMobileSmsCode(this)');
			$("#btn-yzm").removeAttr("disabled");//启用按钮
            $("#btn-yzm").val("重新发送验证码");
            $("#btn-yzm").removeClass("wait");
		} else {
		 	$("#btn-yzm").attr("disabled", "true");
            $("#btn-yzm").addClass("wait");
			$("#btn-yzm").val(curMobileCount + "S");
			$("#btn-yzm").removeAttr('onclick');
			curMobileCount--;
		}
	}

	//发送手机注册验证码
	function sendMobileSmsCode(obj) {
		oldMobile = "";
		var mobile = $("#mobile").val().trim();
		if (!isMobile(mobile)) {
			
			$("#tip").text("请输入正确手机号");
			return;
		}
		$("#btn-yzm").removeAttr('onclick');
		curMobileCount = countMobile;
		$.ajax({
			url : "/wechat/sendSmsCodeBind.do?&_d=" + new Date(),
			data : {
				mobile : mobile,
				openid : $("#openid").val()
			},
			cache : false,
			dataType : 'json',
			success : function(data) {
				if (data.flag == 'succeed') {
					
					$("#tip").text(data.msg);
					oldMobile = mobile;
					interValMobile = window.setInterval(setMobileRemainTime, 1000);
				} else {
					$("#btn-yzm").attr('onclick', 'sendMobileSmsCode(this)');
					curMobileCount = -1;
					setMobileRemainTime();
					
					$("#tip").text(data.msg);
					return false;
				}
			}
		});
	}

	/* 微信号和用户手机号的绑定 */
	function bind() {
		$("#tip").text('');
		var mobile = $("#mobile").val().trim();
		var openid = $("#openid").val();
		var code = $("#code").val().trim();
		var name = $("#name").val().trim();
		if (!code) {
			
			$("#tip").text('请输入验证码');
			$("#code").addClass("wrong");
			return;
		}
		/* if (mobile != oldMobile) {
			
			$("#tip").text('手机号和接收验证码手机号不一致');
			return;
		} */
		if (!name) {
			
			$("#tip").text('请输入姓名');
			return;
		}
		
		if(!$("#agree").is(':checked') ){
			$("#tip").text('请同意猪小e用户协议');
			return;
        }

		$.ajax({
			url : "/wechat/register.do",
			type : "POST",
			data : {
				mobile : mobile,
				name : name,
				code : code,
				openid : openid
			},
			cache : false,
			success : function(data) {
				//alert(JSON.stringify(data));
				if (data.flag == 'succeed') {
					WeixinJSBridge.call('closeWindow');
				} else {
					$("#tip").text(data.msg);
					$("#code").addClass("wrong");
				}
			},
			error : function() {

			}
		});
	}

	//验证手机号
	function isMobile(phone) {
		if (!phone) {
			return false;
		}
		var phnum = /^1[3|4|5|7|8]\d{9}$/.test(phone);
		if (phnum == false) {
			return false;
		}
		return true;
	}
	
	//绑定姓名输入框只要10个字符
	$(function() {
		$("#name").bind('keyup', function() {
			if (GetLength($(this).val()) > 10) {
				$(this).val(cutstr($(this).val(), 10));
				return;
			}
		});
	});
	
	$(function(){
        $("#yonghuxieyi").click(function(){
            $("#xieyi").show();
        });
        $("#xieyi").click(function(){
            $("#xieyi").hide();
        });

    });
	
	//获取华为手机的“前往”按键
	document.onkeydown=function(event){
		var e = event || window.event || arguments.callee.caller.arguments[0];
		if(e && e.keyCode==13){ // 华为手机的前往事件
		   //要做的事情
			bind();
		 }            
	}; 
</script>
</html>









