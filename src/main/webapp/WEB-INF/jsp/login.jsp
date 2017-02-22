<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title></title>
    <link href="static/newhope/login/css/index.css" rel="stylesheet" type="text/css">    
    <link rel="stylesheet" type="text/css" href="static/newhope/login/jgrowl/jquery.jgrowl.min.css" />
    <style>
           .jGrowl .manilla {
				background-color: 		red;
				color: 					white;
			}
    </style>
</head>
<body>
<div id="alertMessage"></div>
<div id="successLogin"></div>
        <div class="top">
            <img src="static/newhope/login/images/system_title.png" style="margin-top:24px;margin-left:6%;position: absolute;">
            <!--<img src="images/fw.png" style=" margin-top: 23px;margin-left:75%;position: absolute;">-->

        </div>
        <div class="body">
            <div class="box">
               <img src="static/newhope/login/images/pic.png" style="margin-top: 51px;margin-left: 48px;position: absolute;">
               <div class="lg-container" style="width: 240px;height: 267px;background-image: url('static/newhope/login/images/denglu-.png') ;margin-top:52px;margin-left:631px;position: absolute; ">
               <form action="main.htm" method="post" name="formLogin" id="formLogin" check="/security/login">
               <input name="userKey" type="hidden" id="userKey" value="D1B5CC2FE46C4CC983C073BCA897935608D926CD32992B5900" />
               <div class="log_head"><h1>用户登录</h1></div>
               <div class="log_row">
                   <img src="static/newhope/login/images/user.png" style="margin-top: 10px;margin-left: 7px;position: absolute">
                   <input type="text" class="input_out" tabindex=1 name="userName" id="userName" iscookie="true" nullmsg=""  placeholder="请输入用户名" onfocus="this.className='input_move'" onblur="this.className='input_out'"/>
               </div>
               <div class="log_row">
                   <img src="static/newhope/login/images/key.png" style="margin-top: 9px;margin-left: 8px;position: absolute">
                   <input type="password" id="password" tabindex=2 name="password" notnull="true" info="密码" title="" iscookie="true" nullmsg="" autocomplete="off" placeholder="请输入密码" class="input_out" onfocus="this.className='input_move'" onblur="this.className='input_out'"/>
               </div>
               <div class="log_row">
               <div class="log_yanzheng">
                   <img src="static/newhope/login/images/123.png" style="margin-top: 10px;margin-left: 8px;position: absolute">
                   
                   <input  placeholder="请输入验证码"  tabindex=3 style=" display: inline;" notnull="true" autocomplete="off"  class="input_out" name="randCode" type="text" id="randCode" title="" value="" nullmsg="" tabindex="3"/> 
						
               </div>
               <div class="log_fasong">
              	<a tabindex="4"
								style="color: #666;cursor:pointer;" class="changepic" id="forGetPassword"><img id="randCodeImage" src="randCodeImage" width="75" height="30"
							   style="position: absolute; margin-left: 10px; color: black" /> 
							</a>
              </div>
               </div>
               <div class="log_forget">
                   <img src="static/newhope/login/images/help.png" style=" margin-top: 3px;position: absolute;cursor:pointer;">

               <div id="forget">
                      <span>忘记密码？</span>
               </div>
               </div>
               <div class="log_login">					
                   <button type="button" tabindex=4 id="but_login" class="submit_out"   onfocus="this.className='submit_move'" onblur="this.className='submit_out'">登&nbsp录</button>
               </div>

           </form>
            </div>
            </div>
            <div class="log_banquan">Copyright © 2016 新希望六和股份有限公司 All right reserved <div>
        </div>
        <!-- Link JScript-->
<script type="text/javascript" src="static/newhope/login/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="static/newhope/login/js/jquery.cookie.js"></script>
<script type="text/javascript" src="static/newhope/login/js/jquery-jrumble.js"></script>
<script type="text/javascript" src="static/newhope/login/js/login.js"></script>
<script src="static/newhope/login/jgrowl/jquery.jgrowl.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#userName").focus();
})
</script>
<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>