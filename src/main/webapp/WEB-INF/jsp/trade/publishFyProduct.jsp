<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.newhope.zhuxiaoer.trade.common.helper.DateUtils" %>
<% 
// 将过期日期设置为一个过去时间 
response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT"); 
// 设置 HTTP/1.1 no-cache 头 
response.setHeader("Cache-Control", "no-store,no-cache,must-revalidate"); 
// 设置 IE 扩展 HTTP/1.1 no-cache headers， 用户自己添加 
response.addHeader("Cache-Control", "post-check=0, pre-check=0"); 
// 设置标准 HTTP/1.0 no-cache header. 
response.setHeader("Pragma", "no-cache"); 
%> 
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>录入发布消息</title>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
    <meta name="format-detection" content="telephone=no">
    <!--script 适配-->
    <script src="/static/newhope/html/js/htmlsize.js"></script>
    <!--jquery-->
    <script src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>

    <!--引入外部自定义js-->
    
    
    <script src="/static/newhope/html/js/commonFunction.js"></script>

    <!-- 城市选择 -->
    <link rel="stylesheet" href="/static/newhope/html/css/LArea.css">

    <!--动态加载模块-->
    <script src="/static/newhope/html/js/template.js"></script>

    <!-- fontawesome -->
    <link rel="stylesheet" href="/static/newhope/html/css/font-awesome/css/font-awesome.min.css">

    <!--weui-->
    <link rel="stylesheet" href="/static/newhope/html/css/weui.min.css">
    <link rel="stylesheet" href="/static/newhope/html/css/huadongjiazai.min.css">

    <!--引入onsaleing 自定义样式表-->
    <link rel="stylesheet" href="/static/newhope/html/css/common.css"/>
    <link rel="stylesheet" href="/static/newhope/html/css/hj_fabu_(fangyang)_4step.css"/>
    <style type="text/css">
        #mapScreen{
            display: none;
        }

        .weui_select{
            z-index:0;
            outline: medium none;
        }
        
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
		.selectType{
            position: fixed;
            height: 100%;
            width:100%;
            opacity: 0.3;
            top:0;
            z-index:20;
            background: #000;
        }
       .toolbar-inner>a{
            width:3.6111rem;
            height:1.6667rem;
            background: #1BBD3D;
            border-radius: 0.1111rem;
            color:#fff;
            font-size: 0.8333rem;
            text-align: center;
            line-height:1.6667rem;
            margin-right:0.6667rem;
            margin-top:0.2778rem;
        }
        .toolbar .picker-button{
            color:#fff;
            padding:0;
            line-height:1.6667rem;
            height:1.6667rem;
            top:0;
            right:0;
        }

        .toolbar>.toolbar-inner>h1.title{
            margin-left:7.6667rem;
            font-size: 0.7778rem;
            color: #999999;
            width:4.6667rem;
            text-align:center;
            padding-left:0;

        }
        .toolbar{
            background: #fff;
        }
    </style>
</head>
<!--图片上传模板-->
<script type="text/html" id="uploadingImg">
    <div class="photos btn_del">
        <img src="{{photoSrc}}" imgpath="{{imgpath}}" >
    </div>
</script>
<!--切换竞拍日期统一定价渲染模板-->
<script type="text/html" id="dateChangeHaveCirclePrice">
	<div class="weui-col-75">
        <div class="priceList">
			{{each circlePriceList as circlePrice index}}
            	<p class="productPriceLi">
            		<input type="hidden" class="weightMin" value="{{circlePrice.weightMin }}"/>
               		<input type="hidden" class="price" value="{{circlePrice.price }}"/>
               		<input type="hidden" class="isDiscuss" value="{{circlePrice.isDiscuss ? 'true' : 'false' }}"/>
               		{{if circlePrice.price}}
            			￥{{circlePrice.price }}元/KG
               		{{/if}}
               		{{if !circlePrice.price && circlePrice.isDiscuss }}
               			议价
               		{{/if}}
            		{{if circlePrice.weightMax }}
 						<input type="hidden" class="weightMax" value="{{circlePrice.weightMax }}"/>
            			<span>(均重{{circlePrice.weightMin }}-{{circlePrice.weightMax }}KG)</span>
            		{{/if}}
            		{{if !circlePrice.weightMax }}
            			<span>(均重{{circlePrice.weightMin }}KG以上)</span>
            		{{/if}}
            	</p>
			{{/each}}
        </div>
    </div>
</script>
<script type="text/html" id="dateChangeNoCirclePrice">
	{{each circleLevelList as circleLevel index}}
		<li class="productPriceLi">
			<input type="hidden" class="weightMin" value="{{circleLevel.weightMin }}"/>
			{{if circleLevel.weightMax }}
				<input type="hidden" class="weightMax" value="{{circleLevel.weightMax }}"/>
    			<p>均重{{circleLevel.weightMin }}-{{circleLevel.weightMax }}KG</p>
    		{{else}}
    			<p>均重{{circleLevel.weightMin }}KG以上</p>
			{{/if}}
         	<input type="number" class="price priceRequired decimalNum" value="" />
         	<span>元/KG</span>
   		</li>
	{{/each}}
</script>
<body>
<div class="createPigcircle">
	<div class="basic-info">
		<p class="circleName">猪场名称：<span class="name">${tradeInfo.pigFarmInfoExModel.name }</span></p>
		<p class="circleArea">所在地区：<span class="area">${tradeInfo.pigFarmInfoExModel.pigFaramAddress.provName }${tradeInfo.pigFarmInfoExModel.pigFaramAddress.cityName }${tradeInfo.pigFarmInfoExModel.pigFaramAddress.countyName }</span></p>
	</div>
<header>
    <div class="stepAll">
        <div class="step step1 currentStep">1<span>选择圈子</span></div>
        <div class="step step2">2<span>拍卖场信息</span></div>
        <div class="step step3">3<span>商品信息</span></div>
        <div class="step step4">4<span>交割信息</span></div>
    </div>
    <div class="line line1"></div>
    <div class="line line2"></div>
    <div class="line line3"></div>
</header>

<form id="publishForm" action="/trade/product/saveTradeProduct" method="post">
	<section>
		<input type="hidden" id="validateCircle" name="validateCircle" value="${requestScope.validateCircle}"/>
		
		<input type="hidden" id="id" name="id" value="${tradeInfo.id}"/>
		<input type="hidden" id="publishUserId" name="publishUserId" value="${tradeInfo.publishUserId}"/>
		<input type="hidden" id="circleId" name="circleId" value="${circleEx.id}"/>
		<input type="hidden" id="isBidtime" name="isBidtime" value="${circleEx.isBidtime}"/>
		<input type="hidden" id="isLevel" name="isLevel" value="${circleEx.isLevel}"/>
		<input type="hidden" id="isPrice" name="isPrice" value="${circleEx.isPrice}"/>
		<input type="hidden" id="version" name="${tradeInfo.version }"/>
		<input type="hidden" name="source" value="${tradeInfo.source }"/>
		<input type="hidden" name="planId" value="${tradeInfo.planId }"/>
		<input type="hidden" name="status" value="${tradeInfo.status.value }"/>
		<input type="hidden" name="pigFaramId" value="${tradeInfo.pigFaramId }"/>
		<input type="hidden" id="lat" name="lat" value="${tradeInfo.pigFarmInfoExModel.lat }"/>
		<input type="hidden" id="lng" name="lng" value="${tradeInfo.pigFarmInfoExModel.lng }"/>
	    <!--第1步:选择圈子-->
	    <div id="step1_chooseCircle"  >
	        <p class="chooseCircle">选择圈子</p>
	        <div style="display: flex;justify-content: center"><p class="hrefP"><a href="/trade/circle/list?type=choice&source=${source}&planId=${tradeInfo.planId}&&productId=${tradeInfo.id}" class="chooseHref">${empty circleEx.name ? '选择圈子' : circleEx.name }<img src="/static/newhope/html/images/ic_list_detail.png"/></a></p></div>
	        <p class="next-btn"><input type="button" class="nextStep" value="下一步" style="color:#fff"/></p>
	    </div>
	
	    <!--第2步:拍卖场信息-->
	    <div style="display: none" id="step2_auctionInfo">
	        <nav>拍卖场时间信息</nav>
	        <div class="timeInfo">
	            <div class="time1">
	                <p>
	                    <span>竞拍时间</span>
	                    <span class="notNUll">不能为空</span>
	                </p>
	                <div class="weui_row actionDate findinput">
	                    <div class="weui_cell_bd weui_cell_primary">
	                        <input class="weui_input" id="IdauctionDate" name="bidDateStr" value="<fmt:formatDate value='${tradeInfo.bidTime }' pattern="yyyy-MM-dd"/>" type="text">
	                        <i class="fa fa-caret-down" aria-hidden="true"></i>
	                    </div>
	                </div>
	            </div>
	            <div class="time2">
	                <p class="notNUll">
	                    <span class="notNUll">不能为空</span>
	                </p>
	                <c:if test="${circleEx.isBidtime }">
	                	<c:if test="${!empty circleSettingMap }">
		                	<input type="hidden" name="BID_TIME_START" value="${circleSettingMap['BID_TIME_START'].ruleValue}"/>
		                	<input type="hidden" name="BID_TIME_END" value="${circleSettingMap['BID_TIME_END'].ruleValue}"/>
			                <div class="weui-row fixedTime">
			                	<p class="fixedStart">${circleSettingMap['BID_TIME_START'].ruleValue}</p>
			                	<span>至</span>
			                	<p class="fixedEnd">${circleSettingMap['BID_TIME_END'].ruleValue}</p>
			                </div>
	                	</c:if>
	                	<c:if test="${empty circleSettingMap }">
	                		<input type="hidden" name="BID_TIME_START" value="<fmt:formatDate value='${tradeInfo.bidTime }' pattern='HH:mm'/>"/>
		                	<input type="hidden" name="BID_TIME_END" value="<fmt:formatDate value='${tradeInfo.bidEndTime }' pattern='HH:mm'/>"/>
			                <div class="weui-row fixedTime">
			                	<p class="fixedStart"><fmt:formatDate value='${tradeInfo.bidTime }' pattern="HH:mm"/></p>
			                	<span>至</span>
			                	<p class="fixedEnd"><fmt:formatDate value='${tradeInfo.bidEndTime }' pattern="HH:mm"/></p>
			                </div>
	                	</c:if>
	                </c:if>
	                <c:if test="${!circleEx.isBidtime }">
		                <div class="weui-row auctionTime">
		                    <div class="weui-col-40 findinput">
		                        <input class="weui_input" id="startTime" name="BID_TIME_START" type="text" value="<fmt:formatDate value='${tradeInfo.bidTime }' pattern="HH点 mm分"/>" placeholder="起始时间">
		                        <i class="fa fa-caret-down" aria-hidden="true"></i>
		                    </div>
		                    <div class="weui-col-6">至</div>
		                    <div class="weui-col-40 findinput">
		                        <input class="weui_input" id="endTime" name="BID_TIME_END" type="text" value="<fmt:formatDate value='${tradeInfo.bidEndTime }' pattern="HH点 mm分"/>" placeholder="终止时间">
		                        <i class="fa fa-caret-down" aria-hidden="true"></i>
		                    </div>
		                </div>
	                </c:if>
	            </div>
	
	        </div>
	        <div class="weui-row stepChange">
	            <div class="weui-col-50">
	                <input type="button" id="step2Before" value="上一步">
	            </div>
	            <div class="weui-col-50">
	                <input type="button" id="step2After" value="下一步">
	            </div>
	        </div>
	    </div>
	
	    <!--第3步:商品信息-->
	    <div style="display: none" id="step3_productInfo">
	        <nav>拍卖场时间信息</nav>
	        <ul>
	            <li>
	                <div class="weui-row weui-no-gutter">
	                    <div class="weui-col-25">
	                        <p>出栏品种:</p>
	                    </div>
	                    <div class="weui-col-75">
	                    	<input type="hidden" id="pigTypeVal" name="pigType" value="${tradeInfo.pigType }" />
	                        <input type="text" id="pigType" value="${tradeInfo.pigType.displayName }" placeholder="请选择品种">
	                        <i class="fa fa-caret-down" aria-hidden="true"></i>
	                    </div>
	                </div>
	            </li>
	            <li>
	                <div class="weui-row weui-no-gutter">
	                    <div class="weui-col-25">
	                        <p>出栏数量:</p>
	                    </div>
	                    <div class="weui-col-75">
	                        <input type="text" class="wholeNum" name="marketingNumber" readonly="readonly" value="${tradeInfo.marketingNumber }" placeholder="请输入出栏数量">
	                        <span>头</span>
	                    </div>
	                </div>
	            </li>
	            <li>
	                <div class="weui-row weui-no-gutter">
	                    <div class="weui-col-25">
	                        <p>出栏价格:</p>
	                    </div>
	                    <input type="hidden" id="productPriceListJson" name="productPriceListJson"/>
	                    <c:if test="${!circleEx.isPrice }">
		                    <div class="weui-col-75">
		                    	<input name="isDiscuss" id="isDiscuss" value="${tradeInfo.isDiscuss}" type="hidden"/>
		                        <div id="priceWrite" class="btnPrice ${empty tradeInfo.isDiscuss || !tradeInfo.isDiscuss ? 'priceActive' : ''}">价格录入</div>
		                        <div class="btnPrice btnPrice1 ${tradeInfo.isDiscuss ? 'priceActive' : ''}">现场议价</div>
		                    </div>
	                    </c:if>
	                    <c:if test="${circleEx.isPrice }">
	                    	<c:if test="${empty circleEx.circlePriceList }">
			                    <!--待确定-->
			                    <div class="weui-col-75">
			                        <p class="notSure">价格待定</p>
			                    </div>
	                    	</c:if>
	                    	<c:if test="${!empty circleEx.circlePriceList }">
			                    <!--固定价格列表 -->
			                    <div class="weui-col-75">
			                        <div class="priceList">
			                        	<c:forEach items="${circleEx.circlePriceList }" var="circlePrice">
			                            	<p class="productPriceLi">
			                            		<input type="hidden" class="weightMin" value="${circlePrice.weightMin }"/>
				                           		<input type="hidden" class="price" value="${circlePrice.price }"/>
			                            		<input type="hidden" class="isDiscuss" value="${circlePrice.isDiscuss }"/>
			                            		<c:if test="${!empty circlePrice.price}">
			                            			￥${circlePrice.price }元/KG
				                           		</c:if>
				                           		<c:if test="${empty circlePrice.price && circlePrice.isDiscuss }">
				                           			议价
				                           		</c:if>
			                            		<c:if test="${!empty circlePrice.weightMax }">
													<input type="hidden" class="weightMax" value="${circlePrice.weightMax }"/>
			                            			<span>(均重${circlePrice.weightMin }-${circlePrice.weightMax }KG)</span>
			                            		</c:if>
			                            		<c:if test="${empty circlePrice.weightMax }">
			                            			<span>(均重${circlePrice.weightMin }KG以上)</span>
			                            		</c:if>
			                            	</p>
			                        	</c:forEach>
			                        </div>
			                    </div>
	                    	</c:if>
	                    </c:if>
	                </div>
	            </li>
	            <li class="LipriceWrite" style="display: ${(empty tradeInfo.isDiscuss || !tradeInfo.isDiscuss) && !circleEx.isPrice ? 'block' : 'none'};">
	                <ul>
	            		<c:if test="${!circleEx.isPrice  }">
		                	<c:choose>
		                		<c:when test="${!empty tradeInfo.productPriceList }">
			                		<c:forEach items="${tradeInfo.productPriceList }" var="productPrice">
										<li class="productPriceLi">
											<input type="hidden" class="weightMin" value="${productPrice.weightMin }"/>
											<c:if test="${!empty productPrice.weightMax }">
												<input type="hidden" class="weightMax" value="${productPrice.weightMax }"/>
			                           			<p>均重${productPrice.weightMin }-${productPrice.weightMax }KG</p>
			                           		</c:if>
			                           		<c:if test="${empty productPrice.weightMax }">
			                           			<p>均重${productPrice.weightMin }KG以上</p>
			                           		</c:if>
					                        <input type="number" onkeyup="limitInputLength(this,10);" class="price priceRequired decimalNum" value="${productPrice.price }" />
					                        <span>元/KG</span>
					                    </li>
			                       	</c:forEach>
		                		</c:when>
		                		<c:when test="${!empty tradeInfo.marketingPrice }">
			                		<li class="handWrite">
				                        <input type="number" onkeyup="limitInputLength(this,10);" class="handWrite priceRequired decimalNum" name="marketingPrice" value="${tradeInfo.marketingPrice }" placeholder="请输入出栏价格">
				                        <span class="Kg">元/KG</span>
				                    </li>
		                		</c:when>
		                		<c:otherwise>
		                			 <c:if test="${circleEx.isLevel }">
										<!-- 均重列表 -->
										<c:forEach items="${circleEx.circleLevelList }" var="circleLevel">
											<li class="productPriceLi">
												<input type="hidden" class="weightMin" value="${circleLevel.weightMin }"/>
												<c:if test="${!empty circleLevel.weightMax }">
													<input type="hidden" class="weightMax" value="${circleLevel.weightMax }"/>
				                           			<p>均重${circleLevel.weightMin }-${circleLevel.weightMax }KG</p>
				                           		</c:if>
				                           		<c:if test="${empty circleLevel.weightMax }">
				                           			<p>均重${circleLevel.weightMin }KG以上</p>
				                           		</c:if>
						                        <input type="number" onkeyup="limitInputLength(this,10);" class="price priceRequired decimalNum" value="" />
						                        <span>元/KG</span>
						                    </li>
				                       	</c:forEach>
				                	</c:if>
				                	<c:if test="${!circleEx.isLevel }">
				                		<!--手动输入-->
					                    <li class="handWrite">
					                        <input type="number" class="handWrite priceRequired decimalNum" name="marketingPrice" value="" placeholder="请输入出栏价格">
					                        <span class="Kg">元/KG</span>
					                    </li>
				                	</c:if>
		                		</c:otherwise>
		                	</c:choose>
	            		</c:if>
	                </ul>
	            </li>
	            <li>
	                <div class="weui-row weui-no-gutter">
	                    <div class="weui-col-25">
	                        <p>预估均重:</p>
	                    </div>
	                    <div class="weui-col-75">
	                        <input type="text" class="decimalNum" name="preAvgWeight" value="${tradeInfo.preAvgWeight }" placeholder="请输入预估均重">
	                        <span>KG</span>
	                    </div>
	                </div>
	            </li>
	            <li>
	                <div class="weui-row weui-no-gutter">
	                    <div class="weui-col-25">
	                        <p>控料情况:</p>
	                    </div>
	                    <div class="weui-col-75">
	                    	<input type="hidden" id="controllerFeedstuffInfoVal" name="controllerFeedstuffInfo" value="${empty tradeInfo.controllerFeedstuffInfo ? 'EIGHT_HOURS' : tradeInfo.controllerFeedstuffInfo }"/>
	                        <input type="text" id="kongliao" placeholder="控料情况" value="${tradeInfo.controllerFeedstuffInfo.displayName }">
	                        <i class="fa fa-caret-down" aria-hidden="true"></i>
	                    </div>
	                </div>
	            </li>
	        </ul>
	
	        <div class="addPigPhotos">
	            <p>添加照片
	                <span>(最多可以上传4张)</span>
	            </p>
	            <div id="addPhotos">
	            	<input type="hidden" id="photoListJson" name="photoListJson"/>
	                <div class="photoList">
	                	<c:if test="${empty planInfoImgList }">
		                	<c:forEach items="${tradeInfo.bidInfoImgModelList }" var="bidInfoImg">
			                	<div class="photos btn_del">
			                		<c:choose>
			                			<c:when test="${fn:startsWith(bidInfoImg.url,'http') }">
							        		<img src="${bidInfoImg.url }" imgpath="${bidInfoImg.url }" alt="">
			                			</c:when>
			                			<c:otherwise>
							        		<img src="${imgServer }${bidInfoImg.url }" imgpath="${bidInfoImg.url }" alt="">
			                			</c:otherwise>
			                		</c:choose>
							    </div>
		                	</c:forEach>
	                	</c:if>
	                	<c:if test="${!empty planInfoImgList }">
		                	<c:forEach items="${planInfoImgList }" var="planInfoImg">
			                	<div class="photos btn_del">
							        <img src="${planInfoImg.url }" imgpath="${planInfoImg.url }" alt="">
							    </div>
		                	</c:forEach>
	                	</c:if>
	                </div>
	                <c:choose>
	                	<c:when test="${empty planInfoImgList }">
	                		<div class="photos" id="addNewphoto" style="display:${fn:length(tradeInfo.bidInfoImgModelList) >= 4 ? 'none' : '' } ">
			                    <img src="/static/newhope/html/images/hj/btn_addimg_normal.png" alt="">
			                </div>
	                	</c:when>
	                	<c:when test="${!empty planInfoImgList }">
	                		<div class="photos" id="addNewphoto" style="display:${fn:length(planInfoImgList) >= 4 ? 'none' : '' } ">
			                    <img src="/static/newhope/html/images/hj/btn_addimg_normal.png" alt="">
			                </div>
	                	</c:when>
	                </c:choose>
	            </div>
	        </div>
	        <div class="weui-row stepChange">
	            <div class="weui-col-50">
	                <input type="button" id="step3Before" value="上一步">
	            </div>
	            <div class="weui-col-50">
	                <input type="button" id="step3After" value="下一步">
	            </div>
	        </div>
	    </div>
	
	    <!--第4步:交割信息-->
	    <div style="display: none" id="step4_jiaoGeInfo">
	        <nav>填写交割信息</nav>
	        <ul>
	            <li>
	                <div class="weui-row weui-no-gutter">
	                    <div class="weui-col-25">
	                        <p>交割日期:</p>
	                    </div>
	                    <div class="weui-col-75">
	                    	<input type="hidden" name="marketingDate" value="<fmt:formatDate value='${tradeInfo.marketingDate }' pattern='yyyy-MM-dd'/>"/>
	                        <p><fmt:formatDate value="${tradeInfo.marketingDate }" pattern="yyyy-MM-dd"/></p>
	                    </div>
	                </div>
	            </li>
	            <li>
	                <div class="weui-col-25">
	                    <p>交割地址:</p>
	                </div>
	                <div class="weui-col-75">
	                    <input class="addr" type="text" id="mapAddress" readonly="readonly" value="${tradeInfo.pigFarmInfoExModel.mapAddress }" placeholder="请进行定位" name="mapAddress">
	                    <input type="button" id="location" value="定位" />
	                </div>
	
	            </li>
	            <li>
	                <div class="weui-col-25">
	                    <p>交通情况:</p>
	                </div>
	                <div class="weui-col-75 length">
	                	<input type="hidden" id="limitLengthVal" name="limitLength" value="${tradeInfo.pigFarmInfoExModel.limitLength}"/>
	                    <input  type="text" id="lengthLimit" placeholder="限长" value="${tradeInfo.pigFarmInfoExModel.limitLength.displayName }" >
	                    <i class="fa fa-caret-down" aria-hidden="true"></i>
	                </div>
	                <div class="weui-col-75 height">
	                	<input type="hidden" id="limitHeightVal" name="limitHeight" value="${tradeInfo.pigFarmInfoExModel.limitHeight}"/>
	                    <input  type="text" id="heightLimit" placeholder="限高" value="${tradeInfo.pigFarmInfoExModel.limitHeight.displayName }" >
	                    <i class="fa fa-caret-down" aria-hidden="true"></i>
	                </div>
	            </li>
	            <li>
	                <textarea maxlength="15" name="otherTrifficInfo" id="otherTrifficInfo" placeholder="填写其他交通情况">${tradeInfo.pigFarmInfoExModel.otherTrifficInfo}</textarea>
	                <span>15字内</span>
	            </li>
	        </ul>
	        <div class="weui-row stepChange">
	            <div class="weui-col-50">
	                <input type="button" id="step4Before" value="上一步">
	            </div>
	            <div class="weui-col-50">
	                <input type="button" id="step4After" value="完成">
	            </div>
	        </div>
	    </div>
	
	</section>
</form>
</div>
<!--蒙层-->
<div style="display: none" class="mengceng">
    <div class="Divimg">
        <img src="" id="preview" >
    </div>
    <div class="DIvdelete">
        <input type="button" id="btnDelete" value="删除" />
    </div>
    <div class="detailPhoto">
    </div>
</div>
<div style="display: none" class="confirmDialog">
	<p>删除这张照片？</p>
    <div>
        <input class="btnphotocancel" type="button" value="取消">
        <input class="btnphotodel" type="button" value="删除">
    </div>
</div>
<!--下拉选择蒙层-->
<div style="display: none" class="selectType">

</div>
<!--  weui城市选择js -->
<script src="/static/newhope/html/js/jquery-weui.min.js"></script>
<script src="/static/newhope/html/js/city-picker.min.js"></script>
<script src='/static/newhope/html/js/swiper.min.js' ></script>
<script type="text/javascript" charset="utf-8" src="/static/trade/js/tradeCommon.js?v=201701131657"></script>
<script type="text/javascript" charset="utf-8" src="/static/trade/js/jquery-form.js"></script>
<script type="text/javascript" charset="utf-8" src="/static/trade/js/publishProduct.js?v=201701061523"></script>
<!-- 引入上传图片 -->
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript" src="/static/trade/js/uploadImg.js?v=201654"></script>
<script type="text/javascript" src="/static/trade/js/util/dateUtil.js"></script>

<!-- 地图 -->
<%@include file="../map/mapPosition2.html"%>
<script type="text/javascript">
$(function(){
	//竞拍时间
	var myDate = new Date();
	var currentDate = getNowFormatDate();
	currentDate = currentDate.split(/[- : \/]/);
	currentDate = new Date(currentDate[0], currentDate[1]-1, currentDate[2]);
	
// 	currentDate = currentDate.replace(/\\/g,",");
	var maxDate = '${tradeInfo.marketingDate }';
	$("#IdauctionDate").calendar({
	    minDate:currentDate,
	    maxDate: maxDate,
        onClose:function(p){
        	$("#validateCircle").val("true");
        	getCircleSettingAndPrice('${circleEx.id}',$("#IdauctionDate").val());
        }
	});
});

//限制长度
function limitInputLength(thisObj,len){
	var stringValue = String($(thisObj).val());
	if ( stringValue.length > len ){
		$(thisObj).val(stringValue.substring( 0, len ));
	}
}

//点击定位按钮的时候
$("#location").on("click",function(e){
    $(".createPigcircle").hide();
    $("#div_mapAddress").show();
    loadScript();
});
var callback1 = function callback1() {
	setDefaultAddress();
}
function setDefaultAddress(){
	$(".createPigcircle").show();
    $("#div_mapAddress").hide();
	$("#lat").val($("#current_lat").val());
	$("#lng").val($("#current_lng").val());
	$("#mapAddress").val($("#current_address").val());
}
//用于返回定位信息
function myPosition(){
	dingwei(callback1);
}
</script>
<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>