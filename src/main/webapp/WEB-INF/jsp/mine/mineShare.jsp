<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta charset="UTF-8">
    <title>分享交易圈</title>
    <script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
    <link rel="stylesheet" type="text/css" href="/static/newhope/html/css/common.css"/>
    <script type="text/javascript" src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="/static/newhope/html/js/jquery.qrcode.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/static/newhope/html/css/shareCircle.css"/>
</head>
<body>

    <div id="warp">
        <div class="QR-code">
        	<div  id="qrDiv" class="code">
            </div>
            <div  id="imagQrDiv" class="code">
            </div>
            <p class="area-code">${circleExModel.name }二维码</p>
        </div>
        <div class="share-way">
            <p class="share-where">长按图片分享二维码给您的微信好友</p>
        </div>
    </div>
    
    <script type="text/javascript">
//        $(".weiXin").hover(function () {
//            $(".wxpy").attr("src","/static/newhope/html/images/btn_share_wxpy_selected.png");
//        },function () {
//            $(".wxpy").attr("src","/static/newhope/html/images/btn_share_wxpy_normal.png");
//        })
//        $(".py").hover(function () {
//            $(".pyCircle").attr("src","/static/newhope/html/images/btn_share_wxpyq_selected.png");
//        },function () {
//            $(".pyCircle").attr("src","/static/newhope/html/images/btn_share_wxpyq_normal.png");
//        })

		$("#qrDiv").qrcode(
		{
			width: 200,
			height: 200,
			correctLevel:0,
			text: "${url}"
		});
		
		
		//从 canvas 提取图片 image  
		function convertCanvasToImage(canvas) {  
		    //新Image对象，可以理解为DOM  
		    var image = new Image();  
		    // canvas.toDataURL 返回的是一串Base64编码的URL，当然,浏览器自己肯定支持  
		    // 指定格式 PNG  
		    image.src = canvas.toDataURL("image/png");  
		    return image;  
		}  
		  
		//获取网页中的canvas对象  
		  
		var mycanvas1=document.getElementsByTagName('canvas')[0];  
		  
		//将转换后的img标签插入到html中  
		var img=convertCanvasToImage(mycanvas1);  
		  
		$('#imagQrDiv').append(img);//imagQrDiv表示你要插入的容器id
		$('#qrDiv').hide();
		
		//分享到朋友圈
		function weixinShareTimeline(title,desc,link,imgUrl){
			WeixinJSBridge.invoke('shareTimeline',{
				"img_url":imgUrl,
				//"img_width":"640",
				//"img_height":"640",
				"link":link,
				"desc": desc,
				"title":title
			});	
		}
		
		//发送给好友
		function weixinSendAppMessage(title,desc,link,imgUrl){
			WeixinJSBridge.invoke('sendAppMessage',{
			//"appid":appId,
			"img_url":imgUrl,
			//"img_width":"640",
			//"img_height":"640",
			"link":link,
			"desc":desc,
			"title":title
			});
		}
    </script>
     
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>






