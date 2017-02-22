<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <meta name="x5-orientation" content="portrait">
    <title>发布详情</title>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/weui.min.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/huadongjiazai.min.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/index.css">
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/mengceng.css">
    <script type="text/javascript" charset="UTF-8" src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>
    <!--导入插件-->
	<script type="text/javascript" src="/static/newhope/html/js/jqthumb.min.js"></script>
	<script>
	    $(function() {
	        $(".pic li img").jqthumb({
	            width:'100%',
	            height:'100%',
	            after: function(imgObj){
	                imgObj.css('opacity', 0).animate({opacity: 1}, 2000);
	            }
	        })
	    })
	</script>
    <style type="text/css">
        li{
            list-style: none;
        }
    </style>
	
</head>
<body>

<!--蒙层-->
<div style="display: none" class="mengceng">
    <div class="Divimg">
        <img class="bigImg" src="images/pig_icon.png" alt="">
    </div>
</div>
<div class="lunbo">
    <ul class="pic">
    	<c:if test="${detailType == 'havePublished'}">
    		<c:forEach items="${detailModel.bidInfoImgModelList }" var="bidInfoImgModel">
    			<c:choose>
           			<c:when test="${fn:startsWith(bidInfoImgModel.url,'http') }">
       					<li><img src="${bidInfoImgModel.url }" alt=""></li>
           			</c:when>
           			<c:otherwise>
       					<li><img src="${imgServer }${bidInfoImgModel.url }" alt=""></li>
           			</c:otherwise>
           		</c:choose>
    		</c:forEach>
    	</c:if>
    	<c:if test="${detailType == 'unPublished'}">
    		<c:forEach items="${detailModel.planImgInfoList }" var="planImgInfo">
       			 <li><img src="${planImgInfo.url }" /></li>
    		</c:forEach>
    	</c:if>
    </ul>
    <ul class="btn">
    	<c:if test="${detailType == 'havePublished'}">
    		<c:if test="${fn:length(detailModel.bidInfoImgModelList) > 1 }">
	    		<c:forEach items="${detailModel.bidInfoImgModelList }" var="bidInfoImgModel" varStatus="s">
	    			<c:if test="${s.index == 0 }">
	       				<li style="margin-left:8.25rem;"></li>
	    			</c:if>
	    			<c:if test="${s.index != 0 }">
	       				<li></li>
	    			</c:if>
	    		</c:forEach>
    		</c:if>
    	</c:if>
    	<c:if test="${detailType == 'unPublished'}">
    		<c:if test="${fn:length(detailModel.planImgInfoList) > 1 }">
	    		<c:forEach items="${detailModel.planImgInfoList }" var="planImgInfo" varStatus="s">
	       			<c:if test="${s.index == 0 }">
	       				<li style="margin-left:8.25rem;"></li>
	    			</c:if>
	    			<c:if test="${s.index != 0 }">
	       				<li></li>
	    			</c:if>
	    		</c:forEach>
    		</c:if>
    	</c:if>
    </ul>
</div>
<div>
    <div class="issued_bg_1">
    	<c:if test="${detailType == 'havePublished'}">
           <div class="issued_yfb_time" id="timeCountdown">
         		<c:choose>
         			<c:when test="${detailModel.status.value == 'BEFORE_AUCTION' }">
         				<div style="float: left;margin-left: 0.5rem;color:#333333;">
         					距开始
        				 </div>
         			</c:when>
         			<c:when test="${detailModel.status.value == 'IN_TRADING' }">
         				<div style="float: left;margin-left: 0.5rem;color:#fa4848;">
         					距结束
        				 </div>
         			</c:when>
         			<c:otherwise>
         				<div style="color:#fa4848;text-align: center;">
         					已结束
         				</div>
         			</c:otherwise>
         		</c:choose>
                <c:if test="${detailModel.status.value == 'BEFORE_AUCTION' || detailModel.status.value == 'IN_TRADING' }">
	                 <ul class="countdown" style="color:#333333;" targetDate='<fmt:formatDate value="${detailModel.status.value == 'BEFORE_AUCTION' ? detailModel.bidTime : detailModel.bidEndTime}" pattern="MM/dd/yyyy HH:mm:ss"/>'>
	                     <li>
	                         <span class="hours" style="float: left;margin-left: 0.4rem;">00</span>
	                     </li>
	                     <li class="seperator" style="float: left;margin-left: 0.2rem">:</li>
	                     <li>
	                         <span class="minutes" style="float: left;margin-left: 0.2rem">00</span>
	                     </li>
	                     <li class="seperator" style="float: left;margin-left: 0.2rem">:</li>
	                     <li>
	                         <span class="seconds" style="float: left;margin-left: 0.2rem">00</span>
	                     </li>
	                     <div style="clear: both;"></div>
	                 </ul>
                </c:if>
           </div>
      	</c:if>
      	<c:if test="${detailType == 'unPublished'}">
          	<c:if test="${!empty overDue }">
	          	<div class="issued_dfb_time">
	              		发布超期${overDue }
	          	</div>
          	</c:if>
      	</c:if>
      	<div class="issued_message_1" >
           	<div class="issued_message_name">${detailType == 'unPublished' ? detailModel.pigFarmerName : (detailType == 'havePublished' ? detailModel.pigFarmInfoExModel.name : '') }</div>
           	<div class="issued_message_date">
               <span style="float: left;">计划出栏日期：</span>
               <label style="float: left;"><fmt:formatDate value="${detailType == 'unPublished' ? detailModel.planDate : (detailType == 'havePublished' ? detailModel.marketingDate : '') }" pattern="yyyy-MM-dd"/></label>
           	</div>
      	</div>
    </div>
    <div class="line"></div>
    <div class="issued_module">
        <div class="issued_bg_2">
        	<c:if test="${detailType == 'havePublished' }">
	            <div class="issued_message_text">
	                <span class="issued_message_title">控料情况：</span>
	                <span class="issued_message_content">${detailModel.controllerFeedstuffInfo.displayName }</span>
	            </div>
        	</c:if>
            <div class="issued_message_text">
                <span class="issued_message_title">发布数量：</span>
                <span class="issued_message_content">${detailType == 'unPublished' ? detailModel.planSaleQuantity : (detailType == 'havePublished' ? detailModel.marketingNumber : '') }头</span>
            </div>
            <div class="issued_message_text">
                <span class="issued_message_title">预估均重：</span>
                <span class="issued_message_content">${detailType == 'unPublished' ? detailModel.planAvgWeight : (detailType == 'havePublished' ? detailModel.preAvgWeight : '') }KG</span>
            </div>
            <div class="issued_message_text">
                <span class="issued_message_title">出栏品种：</span>
                <span class="issued_message_content">${detailModel.pigType.displayName }</span>
            </div>
            <c:if test="${detailType == 'havePublished' }">
            	<input type="hidden" value="${detailModel.pigFarmInfoExModel.lat}" id="lat"/>
            	<input type="hidden" value="${detailModel.pigFarmInfoExModel.lng}" id="lng"/>
            	<input type="hidden" value="${detailModel.pigFarmInfoExModel.mapAddress}" id="mapAddress"/>
	            <div class="issued_message_text">
	                <span class="issued_message_title">交通情况：</span>
	                <span class="issued_message_content">
	                	${detailModel.pigFarmInfoExModel.otherTrifficInfo}${detailModel.pigFarmInfoExModel.limitHeight.displayName}${detailModel.pigFarmInfoExModel.limitLength.displayName}
	                </span>
	            </div>
            </c:if>
            <div style="clear: both;"></div>
        </div>
    </div>
    <div class="line"></div>
    <!--详情已发布页面显示-->
    <c:if test="${detailType == 'havePublished' }">
	    <div class="yifabuxiangqing">
	        <div class="issued_module">
	            <div class="issued_bg_2">
	                <div class="issued_price_head">价格：</div>
	                <div class="issued_price_message">
	                	<c:choose>
	                		<c:when test="${detailModel.isDiscuss }">
	                			<div class="issued_message_text1">
			                        <span>现场议价</span>
			                    </div>
	                		</c:when>
	                		<c:when test="${!empty detailModel.marketingPrice}">
		                		<div class="issued_message_text1">
			                        <span>¥${detailModel.marketingPrice }</span><span>元/KG</span>
			                    </div>
	                		</c:when>
	                		<c:when test="${!empty detailModel.productPriceList}">
	                			<c:forEach items="${detailModel.productPriceList }" var="productPrice">
				                    <div class="issued_message_text1">
				                    	<c:if test="${productPrice.isDiscuss}">
				                    		议价
				                    	</c:if>
				                    	<c:if test="${empty productPrice.isDiscuss || !productPrice.isDiscuss}">
				                        	<span>¥${productPrice.price}</span><span>元/KG</span>&nbsp;
				                    	</c:if>
				                        <span class="issued_junzhong">
					                        <c:if test="${empty productPrice.weightMax}">
				                        		（均重${productPrice.weightMin }KG以上）
					                        </c:if>
					                        <c:if test="${!empty productPrice.weightMax}">
				                        		（均重${productPrice.weightMin }-${productPrice.weightMax }KG）
					                        </c:if>
				                        </span>
				                    </div>
		                		</c:forEach>
	                		</c:when>
	                		<c:otherwise>
	                			<div class="issued_message_text1">
			                        <span>价格待定</span>
			                    </div>
	                		</c:otherwise>
	                	</c:choose>
	                </div>
	                <div style="clear: both;"></div>
	            </div>
	         </div>
	        <div class="line"></div>
	    </div>
    </c:if>
    <div class="issued_module">
        <div class="issued_bg_3">
            <div class="issued_price_head">交割地址：</div>
            <div class="issued_address_message">
               	${detailType == 'unPublished' ? detailModel.dealAddress : (detailType == 'havePublished' ? detailModel.pigFarmInfoExModel.mapAddress : '') }
            </div>
            <input class="issued_navigation" type="button" value="导航" onclick="mapDaoHang()"/>
            <div style="clear: both;"></div>
        </div>
        <div class="issued_module">
            <div class="issued_bg_3">
                <div class="issued_price_head">联系电话：</div>
                <div class="issued_phone_message">
                       ${detailType == 'unPublished' ? detailModel.mobileStr : (detailType == 'havePublished' ? detailModel.pigFarmInfoExModel.mobileStr : '') }
                </div>
                <a href="tel:${detailType == 'unPublished' ? detailModel.mobile : (detailType == 'havePublished' ? detailModel.pigFarmInfoExModel.mobile : '') }">
                	<input class="issued_contact" type="button" value="联系TA"/>
                </a>
                <div style="clear: both;"></div>
            </div>
        </div>
    </div>
</div>
<!-- 已发布页面调使用删除修改，隐藏退回发布。待发布页面使用退回，发布，隐藏删除，修改-->
<c:if test="${detailType == 'unPublished'}">
	<input class="issued_input back" type="button" onclick="sendBack('${detailModel.uid }')" value="退回"/>
	<c:if test="${empty overDue }">
		<a href="/trade/product/toPublishPage?source=FY&planId=${detailModel.uid }">
			<input class="issued_input release" type="button" value="发布"/>
		</a>
	</c:if>
</c:if>
<c:if test="${detailType == 'havePublished' && detailModel.status.value == 'BEFORE_AUCTION'}">
	<input class="issued_input delete" type="button" onclick="deleteProduct(${detailModel.id })" value="删除"/>
	<a href="/mine/publishedProduct/toPublishedModifyPage?productId=${detailModel.id }">
		<input class="issued_input alter" type="button" value="修改"/>
	</a>
</c:if>
<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
<script src="/static/newhope/html/js/jquery.downCount.js"></script>
<script type="text/javascript" src="/static/newhope/html/js/jquery-weui.min.js"></script>
<script src="/static/newhope/html/js/dateutil.js?v=1.0"></script>
<script src='/static/trade/js/tradeCommon.js' ></script>
<script type="text/javascript">
    $(function(){
        var listLen = $(".pic li").length, i=0,setInter,speen = 3000;

        $(".btn li:last").css({"margin":"0rem 0rem 0rem 0.5rem"});
        $(".btn li:first").addClass("on");
        $(".pic li:first").show();

        $(".btn li").each(function(index,element){
            $(element).click(function(){
                i = index;
                $(this).addClass("on").siblings().removeClass("on");
                $(".pic li").eq(index).animate({opacity:"show"},200).siblings().animate({opacity:"hide"},200);
            })
            $(element).hover(function(){
                clearInterval(setInter);
            },function(){
                outPlay();
            });
        })


        out_fun = function(){
            if(i < listLen){i++;}else{i=0;};
            $(".btn li").eq(i).addClass("on").siblings().removeClass("on");
            $(".pic li").eq(i).animate({opacity:"show"},2000).siblings().animate({opacity:"hide"},2000);
        }

        outPlay = function(){
            setInter = setInterval("out_fun()",speen);
        }
        outPlay();
        
        //倒计时
        if (!checkEmpty($(".countdown").attr("targetDate"))){
	        $(".countdown").downCount({
	       	   targetDate:$(".countdown").attr("targetDate"),
	     	   nowDate:'${nowDate}',
	           offset: 8
	       }, function () {
	    	   location.reload( true );
	       });
        }
    });
    
    //删除
    function deleteProduct(productId){
    	//在已发布页面点击删除后弹出的警告框
        $.confirm({
            title:'提示',
            text: '确定删除该拍卖信息',
            onOK: function () {
                //点击确认后需进行的操作
                $.ajax({
                	type:"POST",
                	url:"/mine/publishedProduct/deleteById",
                	data:"productId="+productId,
                	dataType:"json",
                	success:function(result){
                		if (result.success){
                			location.href="/mine/publishedProduct/toMinePublishedPage?pageListType='${detailType}'&v="+Math.random();
                		} else {
                			$.toast(result.msg,"text");
                		}
                	},
                	error:function(){
                		$.toast("操作异常，请联系管理员！");
                	}
                });

            }
        });
    }
    
    //退回上市计划
    function sendBack(planId){
    	 //在待发布页面点击退回后弹出的警告框
         $.confirm({
             title:'提示',
             text: '确定退回出栏申请',
             onOK: function () {
            	 $.ajax({
                 	type:"POST",
                 	url:"/mine/publishedProduct/sendBackPlan",
                 	data:"planId="+planId,
                 	dataType:"json",
                 	success:function(result){
                 		if (result.success){
                 			$.toast("拍卖信息删除成功！","text");
                 			location.href="/mine/publishedProduct/toMinePublishedPage?pageListType='${detailType}'&v="+Math.random();
                 		} else {
                 			$.toast(result.msg,"text");
                 		}
                 	},
                 	error:function(){
                 		$.toast("操作异常，请联系管理员！");
                 	}
                 });
             }
         });
    }
    
    //导航
    function mapDaoHang() {
    	var detailType='${detailType}';
		if (detailType == 'havePublished'){
    		loadScript('', $("#lat").val(), $("#lng").val(), $("#mapAddress").val())
    	}else{
    		$.toast("没有定位信息！","text");
    	}
	}
</script>
<!--图片点击放大-->
<script>
    //图片点击事件
    $(document).ready(function(){
	    $(".pic li").click(function(){
	        var imgSrc=$(this).find("img").attr("src");
	        $(".mengceng").find("img").attr("src",imgSrc);
	        $(".mengceng").show();
	        $(".Divimg .bigImg").jqthumb({
	            width:'100%',
	            height:'100%',
	            after: function(imgObj){
	                imgObj.css('opacity', 0).animate({opacity: 1}, 2000);
	            }
	        })
	    })
	    //蒙层点击事件
	    $(".mengceng").on("click",function(){
	        $(".mengceng").hide();
	    })
    })
</script>
<!-- 导航 -->
<%@include file="../map/mapNavigation.html"%>
 
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />

</body>
</html>