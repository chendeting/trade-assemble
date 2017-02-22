<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <meta name="x5-orientation" content="portrait">
    <title>加入交易圈</title>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/index.css">
    <!--weui-->
    <link rel="stylesheet" href="/static/newhope/html/css/weui.min.css">
    <link rel="stylesheet" href="/static/newhope/html/css/huadongjiazai.min.css">
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
        .toolbar{
            text-align:left;
        }
    </style>
</head>
<body>
   <!--part3部分点击提交时弹出-->
    <div class="join_part3" style="display: none;">
         <div class="join_part3_tankuang">
              <div class="join_tankuang_pic">
              </div>
              <div class="join_tankuang_text">
                  <div>您的申请已成功提交</div>
                  <div>请耐心等待管理员联系您</div>
              </div>
              <a href="tel:${circleUserEx.mobile }">
              	  <input type="button" class="join_tankuang_lianxi" value="联系TA"/>
              </a>
              <input type="button" onclick="toCircleList();" class="join_tankuang_queding" value="确定"/>
         </div>
    </div>
    <div class="join_part1">
        <div class="join_part1_head">
            <div class="join_headpic_bg">
            	<c:if test="${empty circleEx.img }">
                	<img class="join_head_pic" src="/static/newhope/html/images/morentu.png"/>
            	</c:if>
            	<c:if test="${!empty circleEx.img }">
                	<img class="join_head_pic" src="${imgServer }${circleEx.img }"/>
            	</c:if>
            </div>
            <div class="join_head_message">
                <div class="join_circle_1">${circleEx.name } </div>
                <div class="join_circle_2">${circleEx.circleDec }</div>
                <div class="join_circle_3">
                    <div style="float: left;">活跃度</div>
                    <img class="vitality_icon" src="/static/newhope/html/images/ic_fire.png"/>
                    <img class="vitality_icon" src="/static/newhope/html/images/ic_fire.png"/>
                    <img class="vitality_icon" src="/static/newhope/html/images/ic_fire.png"/>
                    <div style="float: right;font-size: 0.67rem;">
                      	  成员数量
                        <span>(${circleEx.memberCount })</span>
                    </div>
                </div>
            </div>
            <div style="clear: both;"></div>
        </div>
        <div class="line"></div>
        <div class="join_part1_person">
            <img class="join_person_icon" src="/static/newhope/html/images/ic_lxr.png"/>
            <div class="join_person_lxr">联系人</div>
            <div class="join_person_phone">
                <span>${circleUserEx.name }</span><span style="margin-left: 0.4rem;">${circleUserEx.mobileStr }</span>
            </div>
        </div>
        <div class="line"></div>
        <div class="join_part1_condition">
             <div class="join_condition_1">
                 <img class="join_person_icon" src="/static/newhope/html/images/ic_jrtj.png"/>
                 <div class="join_person_lxr">加入条件</div>
             </div>
             <div class="join_person_2">
                 <div class="join_person_text">${circleEx.circleCondition}</div>
             </div>
        </div>
        <div style="clear: both;"></div>
    </div>
    <div class="wall"></div>
    <div class="join_part2">
    	<form id="joinCircle" action="/user/applyCircle/create" method="post">
    		<input type="hidden" id="openid" name="openid" value="${openid }">
			<input type="hidden" id="headImg" name="headImg" value="${headImg }">
			<input type="hidden" id="nickName" name="nickName" value="${nickName }">
	
	        <div class="join_part2_text">
	            <div class="join_part2_text1">称呼</div>
	            <div class="join_part2_text2">(使用真实姓名让对方觉得靠谱)</div>
	        </div>
	        <input type="hidden" name="parentId" value="${userInfo.parentId }"/>
	        <input type="hidden" name="circleId" value="${circleEx.id }"/>
	        <c:if test="${empty userInfo }">
	        	<input class="join_input_1" placeholder="用户名" id="name" name="name" onkeyup="limitNameLength(this)" maxlength="10" value="${nickName }"/>
	        </c:if>
	        <c:if test="${not empty userInfo }">
	        	<input class="join_input_1" placeholder="用户名" id="name" name="name" onkeyup="limitNameLength(this)" maxlength="10" value="${empty userInfo.name ? userInfo.nickName : userInfo.name }"/>
	        </c:if>
	        <div class="wall_2"></div>
	      	<!--注册过的用户进入这个页面隐藏下面这段DIV-->
	      	<c:if test="${empty userInfo }">
		        <div class="join_zhucebufen">
		            <input class="join_input_1" placeholder="手机号码" id="mobile" name="mobile" onkeyup="value=value.replace(/[^\d]/g,'')"/>
		            <div class="wall_2"></div>
		            <input class="join_input_2" placeholder="请输入发给您的验证码" id="code" name="code"/>
		            <input id="btn-yzm" class="join_input_3" type="button" onclick="sendMobileSmsCode(this)" value="获取验证码"/>
		            <div class="wall_2"></div>
		            <label id="tip" class="join_remind"></label>
		        </div>
	      	</c:if>
	        <div class="join_part2_dzh">
	            <div style="margin-left: 0.7rem;float: left;">打个招呼</div>
	            <input type="hidden" name="circleRole" id="circleRole" value="BUYER"/>
	            <input type="button" class="join_part2_btnbuy" onclick="setCircleRole('SALER',this)" id="buy_btn1" value="我是卖家"/>
	            <input type="button" class="join_part2_btnbuy on" onclick="setCircleRole('BUYER',this)" id="buy_btn2" value="我是买家"/>
	        </div>
	        <textarea maxlength="30" id="applyDec" name="applyDec" class="join_part2_textarea" placeholder="我想加入圈子，请尽快联系我">我想加入圈子，请尽快联系我</textarea>
	        <span class="textarea_beizhu">30字内</span>
	        <div style="clear: both;"></div>
    	</form>
    </div>
    <input class="join_input_submit" type="button" onclick="submitForm()" value="提交"/>
    
    
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
    
</body>
<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
<script type="text/javascript" charset="UTF-8" src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>

<script type="text/javascript" charset="utf-8" src="/static/trade/js/jquery-form.js"></script>
<script type="text/javascript" src="/static/newhope/html/js/jquery-weui.min.js"></script>
<script type="text/javascript" charset="utf-8" src="/static/trade/js/util/strUtil.js"></script>
<script type="text/javascript">
	//限制名称最大输入长度
	function limitNameLength(thisObj){
		if (GetLength($(thisObj).val()) > 15) {
			$(thisObj).val(cutstr($(thisObj).val(), 15));
			return;
		}
	}

   //切换角色
   function setCircleRole(circleRole,thisObj){
	   $("#circleRole").val(circleRole);
	   $(".join_part2_btnbuy").removeClass("on");
	   $(thisObj).toggleClass("on");
	   var applyDec = "";
	   if (circleRole == 'SALER'){
		   applyDec = "我想加入圈子卖猪，请尽快联系我";
	   } else if (circleRole == 'BUYER'){
		   applyDec = "我想加入圈子买猪，请尽快联系我";
	   }
	   $("#applyDec").text(applyDec);
   }
   
   //提交表单
   function submitForm(){
	  if('${empty userInfo }' == 'true'){
		   $("#tip").text('');
			var mobile = $("#mobile").val().trim();
			var code = $("#code").val().trim();
			var name = $("#name").val().trim();
			if (!code) {
				$("#tip").text('请输入验证码');
				$("#code").addClass("wrong");
				return;
			}
			if (!name) {
				$("#tip").text('称呼不能为空');
				$("#name").addClass("wrong");
				return;
			}
			
			if (mobile != oldMobile) {
				$("#tip").text('手机号和接收验证码手机号不一致');
				return;
			}
			if(mobile){
				$("#joinCircle").attr("action","/user/applyCircle/createForRegister");
			}
	   }
	   $("#joinCircle").ajaxSubmit({
	        success:  function(result) {
				if (result.success){
					$(".join_part3").show();
				} else {
					$.toast(result.msg,"text");
				}
			},
			error:function(){
	  			$.toast("操作异常，请联系管理员！","text");
			}
		});
   }
   
   //跳到交易界面
   function toCircleList(){
	   $(".join_tankuang_queding").attr("disabled","disabled");
	   location.href="/trade/product/list?v="+Math.random();
   }
</script>

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
</script>
</html>