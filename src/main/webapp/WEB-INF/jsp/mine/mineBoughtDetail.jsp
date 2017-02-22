<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<meta name="format-detection" content="telephone=no">
<meta name="x5-orientation" content="portrait">
<title>详情</title>
<link type="text/css" rel="stylesheet" href="/static/newhope/html/css/index.css">
<link type="text/css" rel="stylesheet" href="/static/newhope/html/css/mengceng.css">
<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
<script type="text/javascript" charset="UTF-8" src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>
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
    });
</script>
<style type="text/css">
    li{
       list-style: none;
    }
</style>
</head>
<body style="background-color: #ffffff;">

<!--蒙层-->
<div style="display: none" class="mengceng">
    <div class="Divimg">
        <img class="bigImg" src="/static/newhope/html/images/pig_icon.png" alt="">
    </div>
</div>
<div class="zhuqunzhaopian">猪群照片</div>
<div class="lunbo">
    <ul class="pic">
	    <c:choose>
	         <c:when test="${empty orderExModel.tradeProductInfoExModel.bidInfoImgModelList}">
	     	 <li><img src="/static/newhope/html/images/morentu.png" /></li>
	      </c:when>
	      <c:otherwise>
	        <c:forEach items="${orderExModel.tradeProductInfoExModel.bidInfoImgModelList}" var="image">
		     	<c:choose>
		     	  <c:when test="${!empty image.url}">
		     	  	<c:choose>
		     	  		<c:when test="${orderExModel.tradeProductInfoExModel.source eq 'FY' }">
		        			<li><img src="${image.url}" /></li>
		     	  		</c:when>
		     	  		<c:otherwise>
		        			<li><img src="${imgServer}${image.url}" /></li>
		     	  		</c:otherwise>
		     	  	</c:choose>
		     	  </c:when>
		     	  <c:otherwise>
		        	<li><img src="/static/newhope/html/images/morentu.png" /></li>
		     	  </c:otherwise>
		     	</c:choose>
	    	</c:forEach>
	      </c:otherwise>
	    </c:choose>
    </ul>
       <c:if test="${!empty orderExModel.tradeProductInfoExModel.bidInfoImgModelList}">
    		<ul class="btn">
		   	 <c:forEach items="${orderExModel.tradeProductInfoExModel.bidInfoImgModelList}" var="image" varStatus="num">
		     	<c:choose>
		     	  <c:when test="${num.index == 0}">
						<c:if test="${ fn:length(orderExModel.tradeProductInfoExModel.bidInfoImgModelList)>1 }">
			        	 	<li style="margin-left:8.25rem;"></li>
						</c:if>	     	      
		     	  </c:when>
		     	  <c:otherwise>
		     	   <li></li>
		     	  </c:otherwise>
		     	</c:choose>
		     </c:forEach>
    		</ul>
   	</c:if>
</div>
<div>
    <div class="transaction_bg_1">
        <a class="transaction_contact" style=" text-decoration:none;line-height:1.5rem;text-align: center;" href="tel:${orderExModel.tradeProductInfoExModel.userInfoModel.mobile }">联系TA</a>
        <div class="transaction_message_1" >
            <div class="iGot_number">
                <div class="transaction_number_residue">
                    已订购${empty orderExModel.count? 0:orderExModel.count}头
                </div>
            </div>
            <div class="transaction_name">
                <span style="float: left;">卖家：</span>
                <label style="float: left;">${orderExModel.tradeProductInfoExModel.userInfoModel.name }</label>
            </div>
        </div>
    </div>
    <div class="line"></div>
    <div class="issued_module">
        <input class="transaction_navigation" type="button" value="导航" onclick="mapDaoHang()">
        <div class="transaction_bg_2">
            <div class="transaction_head">猪场名字：</div>
            <div class="transaction_message">
                ${orderExModel.tradeProductInfoExModel.pigFarmInfoExModel.name }
            </div>
            <div class="transaction_head">交割地址：</div>
            <div class="transaction_message">
                  ${orderExModel.tradeProductInfoExModel.pigFarmInfoExModel.mapAddress }
            </div>
            <div class="transaction_head">交通情况：</div>
            <div class="transaction_message">
                <c:choose>
                <c:when test="${orderExModel.tradeProductInfoExModel.pigFarmInfoExModel.limitLength.value eq 'UNKNOW' and  orderExModel.tradeProductInfoExModel.pigFarmInfoExModel.limitHeight.value eq'UNKNOW' and empty orderExModel.tradeProductInfoExModel.pigFarmInfoExModel.otherTrifficInfo}">
                  	未知
                </c:when>
                <c:otherwise>
                	<c:if test="${orderExModel.tradeProductInfoExModel.pigFarmInfoExModel.limitLength.value ne 'UNKNOW' }">
                		${orderExModel.tradeProductInfoExModel.pigFarmInfoExModel.limitLength.displayName}
                	</c:if>
                	<c:if test="${orderExModel.tradeProductInfoExModel.pigFarmInfoExModel.limitHeight.value ne 'UNKNOW' }">
                		${orderExModel.tradeProductInfoExModel.pigFarmInfoExModel.limitHeight.displayName}
                	</c:if>
                	<c:if test="${! empty orderExModel.tradeProductInfoExModel.pigFarmInfoExModel.otherTrifficInfo }">
                		${orderExModel.tradeProductInfoExModel.pigFarmInfoExModel.otherTrifficInfo}
                	</c:if>
                </c:otherwise>
              </c:choose>
            </div>
            <div style="clear: both;"></div>
        </div>
    </div>
    <div class="line"></div>
    <div class="issued_module">
        <div class="transaction_bg_2">
            <div class="transaction_head">交割日期：</div>
            <div class="transaction_message">
               <fmt:formatDate value="${orderExModel.tradeProductInfoExModel.marketingDate}" pattern="yyyy-MM-dd" />
            </div>
            <div class="transaction_head">出栏数量：</div>
            <div class="transaction_message">
                       ${orderExModel.tradeProductInfoExModel.marketingNumber}头
            </div>
            <div class="transaction_head">出栏品种：</div>
            <div class="transaction_message">
               ${orderExModel.tradeProductInfoExModel.pigType.displayName} 
            </div>
            <c:choose>
              <c:when test="${orderExModel.tradeProductInfoExModel.isDiscuss == true}">
              <!--议价显示-->
	            <div>
	                <div class="transaction_head">出栏价格：</div>
	                <div class="transaction_message">议价</div>
	            </div>
              </c:when>
              <c:otherwise>
                <c:choose>
                 <c:when test="${empty orderExModel.tradeProductInfoExModel.productPriceList }">
                 <!--均价显示-->
		            <div>
		                 <div class="transaction_head">出栏价格：</div>
		                 <div class="transaction_message">
		                 	<c:choose>
		                 	<c:when test="${empty orderExModel.tradeProductInfoExModel.marketingPrice}">
		                 		<span>价格待定</span>
		                 	</c:when>
		                 	<c:otherwise>
		                 		<span>¥<fmt:formatNumber value="${orderExModel.tradeProductInfoExModel.marketingPrice}" pattern="0.00"/></span><span>元/KG</span>
		                 	</c:otherwise>
		                 	</c:choose>
		                 </div>
		            </div>
		            <div class="transaction_head">预估均重：</div>
            		<div class="transaction_message">
               			${orderExModel.tradeProductInfoExModel.preAvgWeight}KG
            		</div>
                 </c:when>
                 <c:otherwise>
		<!--定价分级显示-->
            <div>
                <div class="transaction_head">出栏价格：</div>
                <div class="transaction_message">
                  <c:forEach items="${orderExModel.tradeProductInfoExModel.productPriceList }" var="productPrice">
                    <div class="transaction_message_text">
                    	<c:choose>
	                    	<c:when test="${empty productPrice.price}">
	                        <span>议价</span><span class="issued_junzhong">（${productPrice.weightDes eq null ? '未知':productPrice.weightDes}）</span>
	                    	</c:when>
	                    	<c:otherwise>
	                        <span>¥<fmt:formatNumber value="${productPrice.price}" pattern="0.00"/></span><span>元/KG</span>&nbsp;<span class="issued_junzhong">（${productPrice.weightDes eq null ? '未知':productPrice.weightDes}）</span>
	                    	</c:otherwise>
                    	</c:choose>
                    </div>
                  </c:forEach>
                </div>
            </div>
            <div class="transaction_head">预估均重：</div>
            <div class="transaction_message">
               ${orderExModel.tradeProductInfoExModel.preAvgWeight}KG
            </div>
                 </c:otherwise>
                </c:choose>
              </c:otherwise>
            </c:choose>
            <div style="clear: both;"></div>
        </div>
    </div>
    <div class="line"></div>
    <div class="issued_module">
        <div class="transaction_bg_2">
            <div class="transaction_head">控料情况：</div>
            <div class="transaction_message">
              ${orderExModel.tradeProductInfoExModel.controllerFeedstuffInfo.displayName }
            </div>
            <div style="clear: both;"></div>
        </div>
    </div>
</div>
<!--图片点击放大-->
<script>
$(function(){
    var listLen = $(".pic li").length, i=0,setInter,speen = 5000;

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
})
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
    	function mapDaoHang() {
		//alert('${orderExModel.tradeProductInfoExModel.pigFarmInfoExModel.lat}' + '  ' + '${orderExModel.tradeProductInfoExModel.pigFarmInfoExModel.lng}'+'${orderExModel.tradeProductInfoExModel.pigFarmInfoExModel.mapAddress}');
		loadScript('', '${orderExModel.tradeProductInfoExModel.pigFarmInfoExModel.lat}', '${orderExModel.tradeProductInfoExModel.pigFarmInfoExModel.lng}', '${orderExModel.tradeProductInfoExModel.pigFarmInfoExModel.mapAddress}')
	}
</script>
<!-- 导航 -->
<%@include file="../map/mapNavigation.html"%>
 
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>