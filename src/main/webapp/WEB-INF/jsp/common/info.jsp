<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta charset="UTF-8">
    <title>提示</title>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/index.css">
    <script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
    <script type="text/javascript" src="/static/trade/js/tradeCommon.js"></script>
</head>
<body>

       <div class="caozuoshibai_icon"></div>
       <div class="caozuoshibai_title">提示</div>
       <div class="caozuoshibai_text">
            	系统出现了异常,请联系客服。。。
       </div>
      <c:choose>
       <c:when test="${hideBack == true }">
       <button onclick="javascript:WeixinJSBridge.call('closeWindow');" id="fanhui" style="display:none;width:17rem;height:2.2rem;margin-top:0.9rem;margin-left:1.5rem;border:none;outline:none;background: #F02B2B;background-image: linear-gradient(-180deg, #F04746 0%, #DD4B39 100%);box-shadow: 0rem 0rem 0.36rem 0rem  rgba(235,72,66,0.50);border-radius: 1.5rem;font-size:1rem;color: #ffffff;font-family: 'Microsoft YaHei';text-align: center;">返&nbsp&nbsp回</button>
       </c:when>
       <c:otherwise>
       <button onclick="javascript:WeixinJSBridge.call('closeWindow');" id="fanhui" style="width:17rem;height:2.2rem;margin-top:0.9rem;margin-left:1.5rem;border:none;outline:none;background: #F02B2B;background-image: linear-gradient(-180deg, #F04746 0%, #DD4B39 100%);box-shadow: 0rem 0rem 0.36rem 0rem  rgba(235,72,66,0.50);border-radius: 1.5rem;font-size:1rem;color: #ffffff;font-family: 'Microsoft YaHei';text-align: center;">返&nbsp&nbsp回</button>
       </c:otherwise>
      </c:choose>
       
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
<script type="text/javascript">
  $(function(){
	  var errMsg = '${errMsg}';
      if(checkObjNotEmpty(errMsg)){
	  $(".caozuoshibai_text").text(errMsg);
  }
  })
</script>
</html>