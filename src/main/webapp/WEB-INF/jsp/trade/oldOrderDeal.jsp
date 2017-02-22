<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>录入交割消息</title>
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
    <link rel="stylesheet" href="/static/newhope/html/css/hj_wode_saled_(jiaoge)InfoDetail.css?v=201314"/>
    <style type="text/css">
        /*圈子名称相同*/
        .weui_toast,.weui_toast_text,.weui_toast_visible{
            width:12rem;
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

       
        /*切换卡*/

        .weui_navbar_item{
            background-color:#F5F5F5 !important;
            font-size: 0.8333rem !important;
            color: #999 !important;
            letter-spacing: 0;
        }
        .weui_bar_item_on{
            background-color:#fff !important;
            font-size: 0.8333rem !important;
            color: #333333 !important;
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
       
    </style>
</head>
<!--图片上传模板-->
<script type="text/html" id="uploadingImg">
    <div class="photos btn_del">
        <img src="{{photoSrc}}" imgPath="{{imgPath}}">
    </div>
</script>
<body>
<header>
    <div class="jiaoge_title">
    	<input type="hidden" value="${productInfoEx.isDiscuss }" id="isDiscuss"/>
    	<input type="hidden" value="${productInfoEx.marketingPrice }" id="marketingPrice"/>
    	<c:if test="${!empty productInfoEx.productPriceList }">
    		<c:forEach items="${productInfoEx.productPriceList }" var="productPrice">
    			<input type="hidden" class="productPrice" data-weightMin="${productPrice.weightMin }" data-weightMax="${productPrice.weightMax }" data-price="${productPrice.price }"/>
    		</c:forEach>
    	</c:if>
    	
        <div class="weui-row">
            <div class="weui-col-20">
                <img src="${productOrderEx.buyUserHeadImg }" alt="头像">
            </div>
            <div class="weui-col-75">
                <ul>
                    <li class="contactSomeone">
                        <p>${productOrderEx.buyUserRealName }</p>
                        <a href="tel:${productOrderEx.buyUserMobile }">联系他</a>
                    </li>
                    <li>
                        <p>订单时间:
                            <span>&nbsp;<fmt:formatDate value="${productOrderEx.gmtCreated }" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                        </p>
                    </li>
                    <li>
                        <p>拍猪数量:
                            <span>&nbsp;${productOrderEx.count }头</span>
                        </p>
                    </li>
                </ul>

            </div>
        </div>
    </div>
    <div class="jiaoge_change">
        <ul>
            <li>
            	<input type="hidden" id="orderId" name="orderId" value="${productOrderEx.id }"/>
                <div class="weui-row">
                    <div class="weui-col-30">
                        <p>交割情况:</p>
                    </div>
                    <div class="weui-col-70">
                    	<input type="hidden" id="deliveryType" name="deliveryType" value="${empty productOrderEx.orderTradeInfoExModel.deliveryType ? 'JIAOGE' : productOrderEx.orderTradeInfoExModel.deliveryType}"/>
                        <a href="javascript:;"  id="jiaoge" class="weui_btn weui_btn_plain_primary ${empty productOrderEx.orderTradeInfoExModel.deliveryType || productOrderEx.orderTradeInfoExModel.deliveryType=='JIAOGE' ? 'jiaogeActive' : '' }">交割</a>
                        <a href="javascript:;" id="paodan" class="weui_btn weui_btn_plain_primary ${productOrderEx.orderTradeInfoExModel.deliveryType=='PAODAN' ? 'jiaogeActive' : '' }">跑单</a>
                    </div>
                </div>
            </li>

            <li style="display: ${productOrderEx.orderTradeInfoExModel.deliveryType=='PAODAN' ? 'block' : 'none'}" class="liTwo">
                <div class="skipper-box">
                    <p class="skipper-reason">跑单原因</p>
                    <p><textarea class="reason-content" name="remark" id="remark" placeholder="在此输入跑单原因">${productOrderEx.orderTradeInfoExModel.remark}</textarea></p>
                    <p><input class="submit-reason" type="button" value="提交"/></p>
                </div>
            </li>
            <li class="liThree liOut" style="display: ${productOrderEx.orderTradeInfoExModel.deliveryType=='JIAOGE' || empty productOrderEx.orderTradeInfoExModel.deliveryType ? 'block' : 'none'}">
                <div class="weui-row">
                    <div class="weui-col-30">
                        <p class="classify">交割日期:</p>
                    </div>
                    <div class="weui-col-70">
                        <input type="text" id="jiaogeDate" name="deliveryDate" value='<fmt:formatDate value="${productOrderEx.orderTradeInfoExModel.deliveryDate}" pattern="yyyy-MM-dd"/>'>
                        <i class="fa fa-caret-down" aria-hidden="true"></i>
                    </div>
                </div>
            </li>
            <li class="liThree" style="display: ${productOrderEx.orderTradeInfoExModel.deliveryType=='JIAOGE' || empty productOrderEx.orderTradeInfoExModel.deliveryType ? 'block' : 'none'}">
                <div class="weui-row">
                    <div class="weui-col-30">
                        <p>支付方式:</p>
                    </div>
                    <div class="weui-col-70">
                    	<input type="hidden" id="payType" name="payType" value="${empty productOrderEx.orderTradeInfoExModel.payType ? 'transfer' : productOrderEx.orderTradeInfoExModel.payType}"/>
                        <a href="javascript:;" id="transfer" class="weui_btn weui_btn_plain_primary ${empty productOrderEx.orderTradeInfoExModel.payType || productOrderEx.orderTradeInfoExModel.payType == 'transfer' ? 'jiaogeActive' : ''}">转账</a>
                        <a href="javascript:;" id="card" class="weui_btn weui_btn_plain_primary ${productOrderEx.orderTradeInfoExModel.payType == 'card' ? 'jiaogeActive' : ''}">刷卡</a>
                    </div>
                </div>
            </li>
        </ul>
        <div style="display: none" class="bg liTwo">

        </div>
    </div>
</header>

<section class="liThree" style="display: ${productOrderEx.orderTradeInfoExModel.deliveryType=='JIAOGE' || empty productOrderEx.orderTradeInfoExModel.deliveryType ? 'block' : 'none'}">
    <div class="infoTitle">
        <!--页面1 -->
        <div id="listInfo" class="weui-row weui-no-gutter">
	        <c:if test="${!empty detailExModelList }">
	        	<c:forEach items="${detailExModelList}" varStatus="s">
		            <div class="weui-col-33 ${s.index == '0' ? 'btnInfoactive' : '' }" data-info="${s.index+1 }" id="${s.index == '0' ? 'infoOne' : '' }">
		               	 录入信息
		            </div>
	        	</c:forEach>
	        </c:if>
	        <c:if test="${empty detailExModelList }">
	            <div class="weui-col-33 btnInfoactive" data-info="1" id="infoOne">
	               	 录入信息
	            </div>
	        </c:if>
        </div>
        <c:if test="${fn:length(detailExModelList) != '3'}">
	        <div class="weui-col-33" id="addOneinfo">
	            <input type="button" class="addNew"  value="添加一条录入">
	        </div>
        </c:if>
        <c:if test="${fn:length(detailExModelList) == '3'}">
	        <div class="weui-col-33" id="addOneinfo" style="display:none;">
	            <input type="button" class="addNew"  value="添加一条录入">
	        </div>
        </c:if>
    </div>
    <div class="delDiv" id="del" >
        <input type="button" class="delOne" value="删除该条录入信息">
    </div>
    <div class="infoContent infoContent1">
        <ul>
            <li>
                <div class="weui-row weui-no-gutter">
                    <div class="weui-col-25">
                        <p>拉猪头数:</p>
                    </div>
                    <div class="weui-col-75">
                        <input type="number" class="wholeNum" value="${detailExModelList[0].pullPigNum}" data-input="count-quantity" name="pullPigNum" placeholder="请输入头数">
                        <span>头</span>
                    </div>
                </div>
            </li>
            <li>
                <div class="weui-row weui-no-gutter">
                    <div class="weui-col-25">
                        <p>出栏总重:</p>
                    </div>
                    <div class="weui-col-75">
                        <input type="number" class="decimalNum" value="${detailExModelList[0].totalWeight}" data-input="count-weight" name="totalWeight" placeholder="请输入出栏数量">
                        <span>KG</span>
                    </div>
                </div>
            </li>
            <li>
                <div class="weui-row weui-no-gutter">
                    <div class="weui-col-25">
                        <p>复磅总重:</p>
                    </div>
                    <div class="weui-col-75">
                        <input type="number" class="decimalNum" value="${detailExModelList[0].reTotalWeight}" data-input="count-weightBySlaughterhouse" name="reTotalWeight" placeholder="">
                        <span>KG</span>
                    </div>
                </div>
            </li>
        </ul>
        <ul class="priceReduce">
            <li>
                <div class="weui-row weui-no-gutter">
                    <div class="weui-col-25">
                        <p>扣罚金额:</p>
                    </div>
                    <div class="weui-col-75">
                        <input type="number" class="decimalNum" value="${detailExModelList[0].punishAmount}" data-input="count-punishAmount" name="punishAmount" placeholder="">
                        <span>元</span>
                    </div>
                </div>
            </li>
            <li>
                <textarea maxlength="100" placeholder="请输入扣款原因" name="punishReson" id="deductReason1" >${detailExModelList[0].punishReson}</textarea>
                 <p class="addSomePhotos">加入猪只异常照片</p>
                 <div class="addPigPhotos">
                    <div class="addPhotos">
                    	<input type="hidden" name="orderTradeDetailImgList"/>
                        <div class="photoList photoList1">
                        	<c:forEach items="${detailExModelList[0].orderTradeDetailImgList}" var="orderTradeDetailImg">
                        		<div class="photos btn_del">
							        <img src="${imgServer }${orderTradeDetailImg.url }" imgPath="${orderTradeDetailImg.url }">
							    </div>
                        	</c:forEach>
                        </div>
                        <div class="photos addNewphoto addNewphoto1">
                            <img src="/static/newhope/html/images/hj/btn_addimg_normal.png" alt="">
                        </div>
                    </div>
                </div>
            </li>
        </ul>
        <ul class="totalPrice">
            <li>
                <div class="weui-row weui-no-gutter">
                    <div class="weui-col-25">
                        <p>单价:</p>
                    </div>
                    <div class="weui-col-75">
                        <input type="number" class="decimalNum" value="${detailExModelList[0].unitPrice}" data-input="count-price" name="unitPrice" placeholder="请输入价格">
                        <span>元/KG</span>
                    </div>
                </div>
            </li>
            <li>
                <div class="weui-row weui-no-gutter">
                    <div class="weui-col-25">
                        <p>实收金额:</p>
                    </div>
                    <div class="weui-col-75">
                        <input type="number" class="decimalNum" value="${detailExModelList[0].realTotalPrice}" data-input="count-totalAmount" name="realTotalPrice" placeholder="请输入实收金额">
                        <span>元</span>
                    </div>
                </div>
            </li>
            <li>
                <div class="weui-row weui-no-gutter">
                    <div class="weui-col-25">
                        <p>猪只均重:</p>
                    </div>
                    <div class="weui-col-75">
                        <p>
                			<input type="hidden" value="${detailExModelList[0].pigAvgWeight}" name="pigAvgWeight"/>
                        	<span class="count-avgWeight">${detailExModelList[0].pigAvgWeight}</span>KG
                        </p>
                    </div>
                </div>
            </li>
            <li>
                <div class="weui-row weui-no-gutter">
                    <div class="weui-col-25">
                        <p>应收金额:</p>
                    </div>
                    <div class="weui-col-75">
                        <p>
                			<input type="hidden" value="${detailExModelList[0].realAmount}" name="realAmount" />
                        	<span class="count-amountBySlaughterhouse">${detailExModelList[0].realAmount}</span>元
                        </p>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <div style="display: none" class="infoContent infoContent2">
        <ul>
            <li>
                <div class="weui-row weui-no-gutter">
                    <div class="weui-col-25">
                        <p>拉猪头数:</p>
                    </div>
                    <div class="weui-col-75">
                        <input type="number" class="wholeNum" value="${detailExModelList[1].pullPigNum}" data-input="count-quantity" name="pullPigNum" placeholder="请输入头数">
                        <span>头</span>
                    </div>
                </div>
            </li>
            <li>
                <div class="weui-row weui-no-gutter">
                    <div class="weui-col-25">
                        <p>出栏总重:</p>
                    </div>
                    <div class="weui-col-75">
                        <input type="number" class="decimalNum" value="${detailExModelList[1].totalWeight}" data-input="count-weight" name="totalWeight" placeholder="请输入出栏数量">
                        <span>KG</span>
                    </div>
                </div>
            </li>
            <li>
                <div class="weui-row weui-no-gutter">
                    <div class="weui-col-25">
                        <p>复磅总重:</p>
                    </div>
                    <div class="weui-col-75">
                        <input type="number" class="decimalNum" value="${detailExModelList[1].reTotalWeight}" data-input="count-weightBySlaughterhouse" name="reTotalWeight" placeholder="">
                        <span>KG</span>
                    </div>
                </div>
            </li>
        </ul>
        <ul class="priceReduce">
            <li>
                <div class="weui-row weui-no-gutter">
                    <div class="weui-col-25">
                        <p>扣罚金额:</p>
                    </div>
                    <div class="weui-col-75">
                        <input type="number" class="decimalNum" value="${detailExModelList[1].punishAmount}" data-input="count-punishAmount" name="punishAmount" placeholder="">
                        <span>元</span>
                    </div>
                </div>
            </li>
            <li>
                <textarea maxlength="100" placeholder="请输入扣款原因" name="punishReson" id="deductReason2" >${detailExModelList[1].punishReson}</textarea>
               	<p class="addSomePhotos">加入猪只异常照片</p>
                <div class="addPigPhotos">
                    <div class="addPhotos">
                    	<input type="hidden" name="orderTradeDetailImgList"/>
                        <div class="photoList photoList2">
                        	<c:forEach items="${detailExModelList[1].orderTradeDetailImgList}" var="orderTradeDetailImg">
                        		<div class="photos btn_del">
							        <img src="${imgServer }${orderTradeDetailImg.url }" imgPath="${orderTradeDetailImg.url }">
							    </div>
                        	</c:forEach>
                        </div>
                        <div class="photos addNewphoto addNewphoto2">
                            <img src="/static/newhope/html/images/hj/btn_addimg_normal.png" alt="">
                        </div>
                    </div>
                </div>
            </li>
        </ul>
        <ul class="totalPrice">
            <li>
                <div class="weui-row weui-no-gutter">
                    <div class="weui-col-25">
                        <p>单价:</p>
                    </div>
                    <div class="weui-col-75">
                        <input type="number" class="decimalNum" value="${detailExModelList[1].unitPrice}" data-input="count-price" name="unitPrice" placeholder="请输入价格">
                        <span>元/KG</span>
                    </div>
                </div>
            </li>
            <li>
                <div class="weui-row weui-no-gutter">
                    <div class="weui-col-25">
                        <p>实收金额:</p>
                    </div>
                    <div class="weui-col-75">
                        <input type="number" class="decimalNum" value="${detailExModelList[1].realTotalPrice}" data-input="count-totalAmount" name="realTotalPrice" placeholder="请输入实收金额">
                        <span>元</span>
                    </div>
                </div>
            </li>
            <li>
                <div class="weui-row weui-no-gutter">
                    <div class="weui-col-25">
                        <p>猪只均重:</p>
                    </div>
                    <div class="weui-col-75">
                        <p>
                			<input type="hidden" value="${detailExModelList[1].pigAvgWeight}" name="pigAvgWeight"/>
                        	<span class="count-avgWeight">${detailExModelList[1].pigAvgWeight}</span>KG
                        </p>
                    </div>
                </div>
            </li>
            <li>
                <div class="weui-row weui-no-gutter">
                    <div class="weui-col-25">
                        <p>应收金额:</p>
                    </div>
                    <div class="weui-col-75">
                        <p>
                			<input type="hidden" value="${detailExModelList[1].realAmount}" name="realAmount" />
                        	<span class="count-amountBySlaughterhouse">${detailExModelList[1].realAmount}</span>元
                        </p>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <div style="display: none" class="infoContent infoContent3">
        <ul>
            <li>
                <div class="weui-row weui-no-gutter">
                    <div class="weui-col-25">
                        <p>拉猪头数:</p>
                    </div>
                    <div class="weui-col-75">
                        <input type="number" class="wholeNum" value="${detailExModelList[2].pullPigNum}" data-input="count-quantity" name="pullPigNum" placeholder="请输入头数">
                        <span>头</span>
                    </div>
                </div>
            </li>
            <li>
                <div class="weui-row weui-no-gutter">
                    <div class="weui-col-25">
                        <p>出栏总重:</p>
                    </div>
                    <div class="weui-col-75">
                        <input type="number" class="decimalNum"  value="${detailExModelList[2].totalWeight}" data-input="count-weight" name="totalWeight" placeholder="请输入出栏数量">
                        <span>KG</span>
                    </div>
                </div>
            </li>
            <li>
                <div class="weui-row weui-no-gutter">
                    <div class="weui-col-25">
                        <p>复磅总重:</p>
                    </div>
                    <div class="weui-col-75">
                        <input type="number" class="decimalNum"  value="${detailExModelList[2].reTotalWeight}" data-input="count-weightBySlaughterhouse" name="reTotalWeight" placeholder="">
                        <span>KG</span>
                    </div>
                </div>
            </li>
        </ul>
        <ul class="priceReduce">
            <li>
                <div class="weui-row weui-no-gutter">
                    <div class="weui-col-25">
                        <p>扣罚金额:</p>
                    </div>
                    <div class="weui-col-75">
                        <input type="number" class="decimalNum" value="${detailExModelList[2].punishAmount}" data-input="count-punishAmount" name="punishAmount" placeholder="">
                        <span>元</span>
                    </div>
                </div>
            </li>
            <li>
                <textarea maxlength="100" placeholder="请输入扣款原因" name="punishReson" id="deductReason3" >${detailExModelList[2].punishReson}</textarea>
                <p class="addSomePhotos">加入猪只异常照片</p>
                <div class="addPigPhotos">
                    <div class="addPhotos">
                    	<input type="hidden" name="orderTradeDetailImgList"/>
                        <div class="photoList photoList3">
                        	<c:forEach items="${detailExModelList[2].orderTradeDetailImgList}" var="orderTradeDetailImg">
                        		<div class="photos btn_del">
							        <img src="${imgServer }${orderTradeDetailImg.url }" imgPath="${orderTradeDetailImg.url }">
							    </div>
                        	</c:forEach>
                        </div>
                        <div class="photos addNewphoto addNewphoto3">
                            <img src="/static/newhope/html/images/hj/btn_addimg_normal.png" alt="">
                        </div>
                    </div>
                </div>
            </li>
        </ul>
       <ul class="totalPrice">
            <li>
                <div class="weui-row weui-no-gutter">
                    <div class="weui-col-25">
                        <p>单价:</p>
                    </div>
                    <div class="weui-col-75">
                        <input type="number" class="decimalNum" value="${detailExModelList[2].unitPrice}" data-input="count-price" name="unitPrice" placeholder="请输入价格">
                        <span>元/KG</span>
                    </div>
                </div>
            </li>
            <li>
                <div class="weui-row weui-no-gutter">
                    <div class="weui-col-25">
                        <p>实收金额:</p>
                    </div>
                    <div class="weui-col-75">
                        <input type="number" class="decimalNum" value="${detailExModelList[2].realTotalPrice}" data-input="count-totalAmount" name="realTotalPrice" placeholder="请输入实收金额">
                        <span>元</span>
                    </div>
                </div>
            </li>
            <li>
                <div class="weui-row weui-no-gutter">
                    <div class="weui-col-25">
                        <p>猪只均重:</p>
                    </div>
                    <div class="weui-col-75">
                        <p>
                			<input type="hidden" value="${detailExModelList[2].pigAvgWeight}" name="pigAvgWeight"/>
                        	<span class="count-avgWeight">${detailExModelList[2].pigAvgWeight}</span>KG
                        </p>
                    </div>
                </div>
            </li>
            <li>
                <div class="weui-row weui-no-gutter">
                    <div class="weui-col-25">
                        <p>应收金额:</p>
                    </div>
                    <div class="weui-col-75">
                        <p>
                			<input type="hidden" value="${detailExModelList[2].realAmount}" name="realAmount" />
                        	<span class="count-amountBySlaughterhouse">${detailExModelList[2].realAmount}</span>元
                        </p>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <div class="btn_sub">
        <input type="button" class="btn_submit" value="提交"/>
    </div>
</section>

<!--蒙层-->
<div style="display: none" class="mengceng">
    <div class="Divimg">
        <img src="" id="preview">
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
<script src='/static/trade/js/tradeCommon.js' ></script>

<!-- 引入上传图片 -->
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript" src="/static/trade/js/uploadImg.js?v=201654"></script>
<script type="text/javascript" src="/static/trade/js/oldOrderDeal.js?v=20170105"></script>

<script type="text/javascript">
    //自动计算
    $(document).on("blur", ".infoContent input", function () {
        var _box=$(this).closest(".infoContent");
        var _input=$(this).attr("data-input");
        switch (_input) {
            case "count-quantity":
                change_by_quantity();
                break;
            case "count-weight":
                change_by_weight();
                break;
            case "count-weightBySlaughterhouse":
                change_by_weightBySlaughterhouse();
                break;
            case "count-punishAmount":
                change_by_punishAmount();
                break;
            case "count-price":
                change_by_price();
                break;
            case "count-totalAmount":
                change_by_totalAmount();
                break;
        }

        function change_by_quantity(){
            var quantity=parseFloat(_box.find("input[data-input=count-quantity]").val());
            var weightBySlaughterhouse=parseFloat(_box.find("input[data-input=count-weightBySlaughterhouse]").val());
          //均重改变时，价格要变化
            var unitPrice = "";
            if(weightBySlaughterhouse&&quantity){
                unitPrice = getProductPrice(parseFloat(weightBySlaughterhouse/quantity).toFixed(2));
                _box.find(".count-avgWeight").html(parseFloat(weightBySlaughterhouse/quantity).toFixed(2));
                _box.find(".count-avgWeight").prev().val(parseFloat(weightBySlaughterhouse/quantity).toFixed(2));
            }else{
                _box.find(".count-avgWeight").html("0");
                _box.find(".count-avgWeight").prev().val("0");
            }
           	_box.find("input[data-input=count-price]").val(unitPrice);
           	change_by_price();
        }

        function change_by_weight(){
            var quantity=parseFloat(_box.find("input[data-input=count-quantity]").val());
            var weight=parseFloat(_box.find("input[data-input=count-weight]").val());
            weight=weight?weight:0;
            _box.find("input[data-input=count-weightBySlaughterhouse]").val(parseFloat(weight).toFixed(2));
            //均重改变时，价格要变化
            var unitPrice = "";
            if(quantity){
                unitPrice = getProductPrice(parseFloat(weight/quantity).toFixed(2));
                _box.find(".count-avgWeight").html(parseFloat(weight/quantity).toFixed(2));
                _box.find(".count-avgWeight").prev().val(parseFloat(weight/quantity).toFixed(2));
            }else{
                _box.find(".count-avgWeight").html("0");
                _box.find(".count-avgWeight").prev().val("0");
            }
            _box.find("input[data-input=count-price]").val(unitPrice);
            var price=parseFloat(_box.find("input[data-input=count-price]").val());
            if(price){
                _box.find(".count-amountBySlaughterhouse").html(parseFloat(weight*price).toFixed(2));
                _box.find(".count-amountBySlaughterhouse").prev().val(parseFloat(weight*price).toFixed(2));
            }else{
                _box.find(".count-amountBySlaughterhouse").html("0");
                _box.find(".count-amountBySlaughterhouse").prev().val("0");
            }
            change_by_price();
        }

        function change_by_weightBySlaughterhouse(){
            var quantity=parseFloat(_box.find("input[data-input=count-quantity]").val());
            var weightBySlaughterhouse=parseFloat(_box.find("input[data-input=count-weightBySlaughterhouse]").val());
            //均重改变时，价格要变化
            var unitPrice = "";
            if(weightBySlaughterhouse&&quantity){
            	unitPrice = getProductPrice(parseFloat(weightBySlaughterhouse/quantity).toFixed(2));
                _box.find(".count-avgWeight").html(parseFloat(weightBySlaughterhouse/quantity).toFixed(2));
                _box.find(".count-avgWeight").prev().val(parseFloat(weightBySlaughterhouse/quantity).toFixed(2));
            }else{
                _box.find(".count-avgWeight").html("0");
                _box.find(".count-avgWeight").prev().val("0");
            }
            _box.find("input[data-input=count-price]").val(unitPrice);
            var price=parseFloat(_box.find("input[data-input=count-price]").val());
            if(price){
                _box.find(".count-amountBySlaughterhouse").html(parseFloat(weightBySlaughterhouse*price).toFixed(2));
                _box.find(".count-amountBySlaughterhouse").prev().val(parseFloat(weightBySlaughterhouse*price).toFixed(2));
            }else{
                _box.find(".count-amountBySlaughterhouse").html("0");
                _box.find(".count-amountBySlaughterhouse").prev().val("0");
            }
            change_by_price();
            var amountBySlaughterhouse=parseFloat(_box.find(".count-amountBySlaughterhouse").html());
            var punishAmount=parseFloat(_box.find("input[data-input=count-punishAmount]").val());
            punishAmount=punishAmount?punishAmount:0;
            amountBySlaughterhouse=amountBySlaughterhouse?amountBySlaughterhouse:0;
            _box.find("input[data-input=count-totalAmount]").val(parseFloat(amountBySlaughterhouse-punishAmount).toFixed(2));
        }

        function change_by_punishAmount(){
            var punishAmount=parseFloat(_box.find("input[data-input=count-punishAmount]").val());
            var amountBySlaughterhouse=parseFloat(_box.find(".count-amountBySlaughterhouse").html());
            punishAmount=punishAmount?punishAmount:0;
            amountBySlaughterhouse=amountBySlaughterhouse?amountBySlaughterhouse:0;
            _box.find("input[data-input=count-totalAmount]").val(parseFloat(amountBySlaughterhouse-punishAmount).toFixed(2));
        }

        function change_by_price(){
            var price=parseFloat(_box.find("input[data-input=count-price]").val());
            var weightBySlaughterhouse=parseFloat(_box.find("input[data-input=count-weightBySlaughterhouse]").val());
            if(price&&weightBySlaughterhouse){
                _box.find(".count-amountBySlaughterhouse").html(parseFloat(weightBySlaughterhouse*price).toFixed(2));
                _box.find(".count-amountBySlaughterhouse").prev().val(parseFloat(weightBySlaughterhouse*price).toFixed(2));
            }else{
                _box.find(".count-amountBySlaughterhouse").html("0");
                _box.find(".count-amountBySlaughterhouse").prev().val("0");
            }
            var amountBySlaughterhouse=parseFloat(_box.find(".count-amountBySlaughterhouse").html());
            var punishAmount=parseFloat(_box.find("input[data-input=count-punishAmount]").val());
            punishAmount=punishAmount?punishAmount:0;
            amountBySlaughterhouse=amountBySlaughterhouse?amountBySlaughterhouse:0;
            _box.find("input[data-input=count-totalAmount]").val(parseFloat(amountBySlaughterhouse-punishAmount).toFixed(2));
        }

        function change_by_totalAmount(){
            var totalAmount=parseFloat(_box.find("input[data-input=count-totalAmount]").val());
            var weightBySlaughterhouse=parseFloat(_box.find("input[data-input=count-weightBySlaughterhouse]").val());
            var punishAmount=parseFloat(_box.find("input[data-input=count-punishAmount]").val());
            totalAmount=totalAmount?totalAmount:0;
            punishAmount=punishAmount?punishAmount:0;
            _box.find(".count-amountBySlaughterhouse").html(parseFloat(totalAmount+punishAmount).toFixed(2));
            _box.find(".count-amountBySlaughterhouse").prev().val(parseFloat(totalAmount+punishAmount).toFixed(2));
            if(weightBySlaughterhouse&&totalAmount){
                _box.find("input[data-input=count-price]").val(parseFloat((totalAmount+punishAmount)/weightBySlaughterhouse).toFixed(2));
            }else{
                _box.find("input[data-input=count-price]").val("");
            }
        }
    });
    
    //根据均重取拍卖信息相应价格
    function getProductPrice(avgWeight){
    	var unitPrice = "";
    	if (checkEmpty($("#isDiscuss").val()) || $("#isDiscuss").val() == "false"){
    		if (checkEmpty($("#marketingPrice").val())){
    			$(".productPrice").each(function(){
    				var weightMin = $(this).attr("data-weightMin");
    				var weightMax = $(this).attr("data-weightMax");
    				var price = $(this).attr("data-price");
    				if (parseFloat(avgWeight) >= parseFloat(weightMin)){
    					if (checkEmpty(weightMax)){
    						unitPrice =  price;
    					} else if (parseFloat(avgWeight) < parseFloat(weightMax)){
    						unitPrice =  price;
    					}
    				}
    			});
    		} else {
    			unitPrice =  $("#marketingPrice").val();
    		}
    	}
    	return unitPrice;
    }
</script>
<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>


















