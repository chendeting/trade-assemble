<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <meta name="x5-orientation" content="portrait">
    <meta http-equiv="pragram" content="no-cache">  
	<meta http-equiv="cache-control" content="no-cache, must-revalidate"> 
	<meta http-equiv="expires" content="0"> 
    <title>猪小e-交易</title>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/weui.min.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/huadongjiazai.min.css"/>
    <link rel="stylesheet" type="text/css" href="/static/newhope/html/css/common.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/myTradeRecord.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/Published.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/index.css">
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/jiaoyiquan.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/font-awesome/css/font-awesome.min.css"/>
    <script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
    <script type="text/javascript" charset="UTF-8" src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>
    <script src="/static/newhope/html/js/jquery.downCount.js?v=1.0"></script>
    <!--动态加载模块-->
    <script src="/static/newhope/html/js/template.js"></script>
    <script src="/static/newhope/html/js/dateutil.js?v=1.0"></script>
    <script src="/static/trade/js/tradeCommon.js?v=1"></script> 
    <!--导入插件-->
	<script type="text/javascript" src="/static/newhope/html/js/jqthumb.min.js"></script>
	<script>
	function imgVariant(obj){
			obj.find(".circleTrade-img img").jqthumb({
	            width:'100%',
	            height:'100%',
	            after: function(imgObj){
	                imgObj.css('opacity', 0).animate({opacity: 1}, 2000);
	            }
	        })
	}
	
	</script>
	<style type="text/css">
		#warp .filter-condition .fa.timeIcon{
			position:absolute;
			right:70%;
		}
		.sellOver{
			position:absolute;
			top:0;
			right:0;
			font-size: 0.7222rem;
		    height: 1.3888rem;
		    background-color: #f5f5f5;
		    line-height: 1.3888rem;
		    color:#333;
		    font-size:0.6666rem
		    text-align: center;
		    padding:0 0.6666rem;
		}
		.sellOver span{
			color:#4A90E2;
			font-size:0.7222rem;
		}
	</style>
</head>
<body>
<script type="text/html" id="temp1">
    <li class="circleTrade-list">
    <div class="clickDiv" data-id="{{id}}">
		{{if null == bidInfoImgModelList || '' == bidInfoImgModelList}}
        	<div class="circleTrade-img"><img src="/static/newhope/html/images/morentu.png"/></div>
		{{else}}
				{{if bidInfoImgModelList[0].url == '' || null == bidInfoImgModelList[0].url}}
					<div class="circleTrade-img"><img src="/static/newhope/html/images/morentu.png"/></div>
				{{else}}
					{{if source == 'FY'}}
					<div class="circleTrade-img"><img src="{{imgRealPath(bidInfoImgModelList[0].url)}}"/></div>
					{{else}}
					<div class="circleTrade-img"><img src="{{getImgServer()}}{{bidInfoImgModelList[0].url}}"/></div>
					{{/if}}
				{{/if}}
		{{/if}}
        <ul class="pigFarm-info">
            <li class="pigFarm-title">{{pigFarmInfoExModel.name}}</li>
            <li>地址：{{pigFarmInfoExModel.mapAddress==null?pigFarmInfoExModel.address:pigFarmInfoExModel.mapAddress}}</li>
			<%--根据是否定价判断是否设置圈子统一价格(isdiscuss == true(没有设置))--%>
			{{if isDiscuss == true}}
				<li>价格：<span class="pig-price">议价</li>
			{{else}}
				<%--判断圈子是否统一定价--%>
				<%--产品价格表是否有价格(没有价格查询预估均价-如果预估均价不存在，说明圈子开启统一定价，商品价格状态为价格待定)--%>
				{{if null == productPriceList || '' == productPriceList}}
					{{if null == marketingPrice || '' == marketingPrice}}
						<li>价格：<span class="pig-price">价格待定</span>&nbsp;&nbsp;(预估均重{{preAvgWeight}}KG)</li>
					{{else}}
            			<li>价格：<span class="pig-price">￥{{marketingPrice}}/KG</span>&nbsp;&nbsp;(预估均重{{preAvgWeight}}KG)</li>
					{{/if}}
				{{else}}
						{{if prePrice == null || prePrice ==''}}
							<li>价格：<span class="pig-price">议价</span>&nbsp;&nbsp;(预估均重{{preAvgWeight}}KG)</li>	
						{{else}}
							<li>价格：<span class="pig-price">￥{{prePrice}}/KG</span>&nbsp;&nbsp;(预估均重{{preAvgWeight}}KG)</li>	
						{{/if}}
				{{/if}}
			{{/if}}
        </ul>
        <span class="detailInfo"><img src="/static/newhope/html/images/ic_list_detail.png"/></span>
		{{if status == 'IN_TRADING'}}
        	<div class="fromEnd"><span>距结束：</span>
                <ul class="countdown" style="color:#333333;" data-time="{{bidEndTime}}" data-pid="{{id}}">
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
                </ul>
            </div>
		{{else if status == 'BEFORE_AUCTION'}}
        	<div class="fromEnd fromStart"><span>距开始：</span>
            	<ul class="countdown" style="color:#333333;" data-time="{{bidTime}}" data-pid="{{id}}">
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
            	</ul>
        	</div>
		{{else}}
			<div class="fromEnd fromStart" style="display:none"><span>距开始：</span>
            	<ul class="countdown" style="color:#333333;" data-time="{{bidTime}}">
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
            	</ul>
        	</div>
		{{/if}}
        </div>
		<div class="fromCircle"><a href="/user/applyCircle/toApplyPage?circleId={{circleId}}">来自{{circleModel.name}}<img src="/static/newhope/html/images/ic_list_detail.png"/></a></div>
		{{if status == 'IN_TRADING'}}
        <span class="rush-pig">
        <span class="remain-p">剩余<span class="remain-num">{{surplusNumber}}</span>头</span>
			{{if isPrice == true}}
				 {{if null == productPriceList || '' == productPriceList}}
						<span class="rush-p"><input class="rush-btn" style="background-color: #ccc;border-color: #ccc" disabled="disabled" type="button" value="立即抢猪"/></span>
				 {{else}}
					{{if surplusNumber >0}}
        	 			<span class="rush-p"><input class="rush-btn"  type="button" value="立即抢猪" data-id="{{id}}" data-cid="{{circleId}}"/></span>
					{{else}}
						<span class="rush-p"><input class="rush-btn" style="background-color: #ccc;border-color: #ccc" disabled="disabled" type="button" value="已抢光"/></span>
			    	{{/if}}
				 {{/if}}	
			{{else}}
				{{if surplusNumber >0}}
        	 		<span class="rush-p"><input class="rush-btn"  type="button" value="立即抢猪" data-id="{{id}}" data-cid="{{circleId}}"/></span>
				{{else}}
					<span class="rush-p"><input class="rush-btn" style="background-color: #ccc;border-color: #ccc" disabled="disabled" type="button" value="已抢光"/></span>
				{{/if}}
			{{/if}}
        </span>
		{{else if status == 'BEFORE_AUCTION'}}
			<span class="rush-pig">
                <span class="remain-p">剩余<span class="remain-num">{{surplusNumber}}</span>头</span>
                <span class="rush-p">
					{{if hasPushMsg != true}}
                    <input class="alert-btn" type="button" value="提醒我" data-id="{{id}}" data-cid="{{circleId}}"/>
					{{else}}
                   	<input class="quxiao-alert-btn" type="button" value="取消提醒" data-id="{{id}}"/>
					{{/if}}
                </span>
            </span>
		{{else }}
			<span class="rush-pig">
                <span class="remain-p">剩余<span class="remain-num">{{surplusNumber}}</span>头</span>
                <span class="rush-p">
					<img src="/static/newhope/html/images/ic_label_pmyjs.png" class="endImg"/>
                </span>
            </span>
			<div class="sellOver">{{date_format(bidTime)}}<span>竞拍<span></div>
		{{/if}}
    </li>
</script>
<script type="text/html" id="quickMakeOrder">
 <%--下订单--%>
		<div class="transaction_tckbg1">
		<div class="tck_xdd">
            	下订单
        </div>
		<div class="tck_line"></div>
		<div class="tck_message_bg">
		    <div class="tck_name_head">{{userInfoModel.name }}</div>
		    <div class="tck_name_message" id="surplusSpan">
		        	剩余{{surplusNumber}}头
		    </div>
		    <div class="tck_message_head">交割地址：</div>
		    <div class="tck_message_text">
		        {{pigFarmInfoExModel.mapAddress==null?pigFarmInfoExModel.address:pigFarmInfoExModel.mapAddress}}
		    </div>
		    <div class="tck_message_head">交通情况：</div>
		    <div class="tck_message_text">
		      	{{if pigFarmInfoExModel.limitLength == 'UNKNOW' && 
					 pigFarmInfoExModel.limitHeight == 'UNKNOW' && 
					('' == pigFarmInfoExModel.otherTrifficInfo|| null == pigFarmInfoExModel.otherTrifficInfo) 
				}}
					未知
				{{else}}
					{{if pigFarmInfoExModel.limitLength != 'UNKNOW' }}
							{{pigFarmInfoExModel.limitLengthDisplayName}}
					{{/if}}
					{{if pigFarmInfoExModel.limitHeight != 'UNKNOW' }}
							{{pigFarmInfoExModel.limitHeightDisplayName}}
					{{/if}}
					{{if pigFarmInfoExModel.otherTrifficInfo!=null && ''!=pigFarmInfoExModel.otherTrifficInfo}}
							{{pigFarmInfoExModel.otherTrifficInfo}}
					{{/if}}
				{{/if}}
		    </div>
		    <div class="tck_message_head">出栏价格：</div>
		    <div class="tck_message_text1">
			{{if isDiscuss == true}}
				<div><span>议价</span></div>
			{{else}}
				{{if productPriceList == '' || null == productPriceList}}
					{{if marketingPrice == null || '' == marketingPrice}}
						<div><span>价格待定</span></div>
					{{else}}
					<div>
						<span>¥{{marketingPrice}}</span><span>元/KG</span><span>（预估均重{{preAvgWeight}}KG）</span>
					</div>
					{{/if}}
				{{else}}
					<div>
						{{if prePrice == null || prePrice==''}}
						<span>议价</span><span class="issued_junzhong">({{preWeightDesc == null ? '未知':preWeightDesc}})</span>
						{{else}}
						<span>¥{{prePrice}}</span><span>元/KG</span><span class="issued_junzhong">({{preWeightDesc == null ? '未知':preWeightDesc}}KG)</span>
						{{/if}}
					</div>
				{{/if}}
			{{/if}}
		    </div>
		    <div style="clear: both;"></div>
		</div>
		<div>
		    <div class="tck_number_head">数量：</div>
		    <input class="tck_number_input" type="number" id="buyCount" placeholder="请输入订购数量"/>
			<input value="{{surplusNumber }}" type="hidden" id="surplusNumber"/>
		    <div class="tck_number_unit">头</div>
		</div>
		<input type="button" class="btn_tck_back" id="quxiaodingdan" value="取消"/>
		<input type="button" class="btn_tck_confirm" id="quedingdingdan" data-pid="{{id}}" value="确定"/>
		</div>
</script>
<!--下订单-->
<div class="zhezhaoceng" id="xiadingdan" style="display: none;">
</div>
<!--订单成功-->
<div class="zhezhaoceng" id="dingdan_success" style="display: none;">
    <div class="transaction_tckbg">
        <div class="transaction_tck_succespic">
        </div>
        <div class="transaction_tck_headtext">订单提交成功</div>
        <div class="transaction_tck_bodytext">
            <div>您的订单已提交成功，我们将尽快与您</div>
            <div>联系！如需了解订单状态，</div>
            <div>可以到“我买到的”进行查询</div>
        </div>
        <input type="button" class="btn_tck_know" id="zhidaole_success" value="知道了"/>
    </div>
</div>
<!--订单失败-->
<div class="zhezhaoceng" id="dingdan_fail" style="display: none;">
    <div class="transaction_tckbg">
        <div class="transaction_tck_failpic">
        </div>
        <div class="transaction_tck_headtext">订单提交失败</div>
        <div class="transaction_tck_bodytext1">
            <div>下手太慢！</div>
            <div>该订单剩余数量仅剩<span id="fail_notify_count">200</span>头!</div>
        </div>
         <div class="btn_box">
        	<input type="button" class="btn_tck_back" id="zhidaole_fail" value="知道了"/>
        	<input type="button" class="btn_tck_newly" id="chongxinqianggou" value="重新抢购"/>
        </div>
    </div>
</div>
<!--取消提醒-->
<div class="zhezhaoceng" id="tixing_remove" style="display: none;">
    <div class="join_part3_tankuang">
        <div class="transaction_cry_pic">
        </div>
        <div class="transaction_tck_revoketext">
            <div>取消了提醒，可能会错过拍猪哦！</div>
            <div>确定取消提醒吗？</div>
        </div>
        <input type="button" class="btn_tck_back" id="zaikankan" value="再看看"/>
        <input type="button" class="btn_tck_confirm" id="qxtx_queding" value="确定"/>
    </div>
</div>
<!--成功设定提醒-->
<div class="light_remind_success" id="tixing_success" style="display: none;">
    <div>提醒设置成功</div>
</div>

<div id="warp">
    <div class="GPS">
        <a class="GPS-txt" href="#">&emsp;当前城市：<span id="current_city">${sessionScope.cityName}</span><img class="detail-img" src="/static/newhope/html/images/ic_list_detail.png"></a>
    </div>
    <div class="filter-condition">
        <span class="time-lately active"><i style="font-style:normal">时间最近</i></span>
        <i class="fa fa-caret-down timeIcon" aria-hidden="true"></i>
        <span class="distance-lately">距离最近</span>
        <span class="all-circle"><i>所有交易圈</i></span>
        <i class="fa fa-caret-down circleIcon" aria-hidden="true"></i>
        
    </div>
    <div class="chooseCircle circleName">
        <div class="mengban"></div>
        <ul class="chooseCircle-ul">
            <li class="current">所有交易圈<img src="/static/newhope/html/images/ic_myzc_pop_selected.png"/></li>
            <c:forEach items="${circleList}" var="circle">
             <li data-id="${circle.id}"><img src="/static/newhope/html/images/ic_myzc_pop_selected.png"/>${circle.name}</li>
            </c:forEach>
        </ul>
    </div>
    <div class="chooseCircle tradeState">
        <div class="mengban"></div>
        <ul class="chooseCircle-ul">
            <li class="current">时间最近<img src="/static/newhope/html/images/ic_myzc_pop_selected.png"/></li>
            <li data-value = 'BEFORE_AUCTION'>待竞拍<img src="/static/newhope/html/images/ic_myzc_pop_selected.png"/></li>
            <li data-value = 'IN_TRADING'>竞拍中<img src="/static/newhope/html/images/ic_myzc_pop_selected.png"/></li>
            <li data-value = 'COMPLETE'>已结束<img src="/static/newhope/html/images/ic_myzc_pop_selected.png"/></li>
        </ul>
    </div>
   		<div class="ulWarp" style="margin-bottom: 3rem">
		    <ul class="circleTrade-ul">
		      
		    </ul>
			<div class="weui-infinite-scroll">
			    <div class="infinite-preloader"></div>
			    <span id="inLoading">数据加载中...</span>
			</div>
		</div>	
</div>


<!-- 引入底部菜单 -->
<%@ include file="../menu/footMenu.jsp"%>

<script type="text/javascript" src="/static/newhope/html/js/jquery-weui.min.js"></script>
<script type="text/javascript" charset="utf-8" src="/static/plug-in/layer/layer.js"></script>


<!--倒计时插件-->
<script type="text/javascript">
 
</script>
<!-- 地图 -->
<%@include file="../map/mapPosition2.html"%><!--tabbar切换-->
<script type="text/javascript">
var searchFlag = true;
var imgServer = '${imgServer}';
var circle_id_search = "";
var productStatus_search_param = "";
//==========================================获取当前位置========================================================
	function setDefaultAddress(){
		var current_city_name = $("#current_city").val();//+$("#current_district").val()
		search.lat = $("#current_lat").val();
		search.lng = $("#current_lng").val();
		$("#current_city").text(current_city_name);
		//$(".GPS-txt").attr("href",$(".GPS-txt").attr("href")+"?currentCityName="+current_city_name);
		search.subCity = $("#current_city").text();
		initialPage(search);
		layer.closeAll();
	}
	var callback = function callback() {
		setDefaultAddress();
	}
	$("#trading_a_tag").click(function(){
		location.reload();
	})
//==========================================获取当前位置========================================================
	
template.helper('getImgServer', function () {
	return imgServer;
});
    $(".all-label li").click(function () {
        var checked=$(this).find(".checked");
        if(checked.css("display")=="none"){
            checked.show();
        }else{
            checked.hide();
        }
    });
    $(".weui_navbar a").click(function () {
        $(this).children().addClass("active");
        $(this).siblings().children().removeClass("active");
    });
$(".mengban").click(function(){
    $(this).parent().hide();
    $(".fa").removeClass("fa-caret-up").addClass("fa-caret-down");
});
//分页功能
var loading = false;  //状态标记
var page = 1;    //当前显示页数
//每一页的显示数量
var size = 5;
var search = {
		  //是否位置排序
		  isAddressSort:"",
		  //是否倒计时排序
		  isBidEndTime:1,
		  pageIndex:1,
		  pageSize:5,
		  //statusTypeList:['BEFORE_AUCTION','IN_TRADING'],
		  circleId:"",
		  productStatus:"",
		  lat:"${sessionScope.lat}",
		  lng:"${sessionScope.lng}",
		  subCity:"${sessionScope.cityName}"
		  
  }
var seckillUrl = "";
var oid = "";
var isClickConfirm = false;
var this_obj;

    //页面初始化时，加载6条数据
  
    function initialPage(data) {
    	 $("#inLoading").text("正在加载...");
    	 var el=$(".circleTrade-ul");
    	 data.pageIndex = page;
        //页面初始化时，加载8条数据
        $.ajax({
            type:'POST',
            url: '/trade/product/list.json',
            dataType: 'json',
            contentType:"application/json", 
            data:JSON.stringify(data),
            success: function(data){
                if(data.success==true){
                    var result ="";
                    //总的数据长度
                    var dataLen = data.data.totalCount;
                    if(dataLen <= 5)
                    {
                        //就只加载当前的数据
                        $(".weui-infinite-scroll").css("display","none");
                        $(document.body).destroyInfinite();
                        for(var i = 0;i < dataLen;i++)
	                        {
                        		var resData = data.data.objects[i];
	                            if(checkObjNotEmpty(resData))
		                        {
	                            	if(checkObjNotEmpty(resData.marketingPrice))
	         						{
	             						resData.marketingPrice = (resData.marketingPrice).toFixed(2);
	             					} 
	                            	if(checkObjNotEmpty(resData.prePrice))
	                            	{
	                            		resData.prePrice = (resData.prePrice).toFixed(2);
	                            	}
	                            	if(checkObjNotEmpty(resData.productPriceList))
	                            	{
	                            		$.each(resData.productPriceList,function(k,v){
	                            			if(checkObjNotEmpty(resData.productPriceList[k].price)){
	                            			resData.productPriceList[k].price = (resData.productPriceList[k].price).toFixed(2);
	                            			}
	                            		})
	                            	}
			                         el.append(template("temp1",resData));
			                            var this_ = $("ul.countdown:last");
			                            //2) 倒计时插件
				                            if(resData.id == this_.data("pid"))
					                            {
				                            	 console.log(resData.status+"1");
					                           	  	this_.downCount({
					                                 	targetDate:new Date(parseInt(this_.data("time"))).pattern("MM/dd/yyyy HH:mm:ss"),
					                                 	nowDate:new Date(data.nowDate).pattern("MM/dd/yyyy HH:mm:ss"),
					                                     offset: 8
					                                 }, function () {
					                                	 $.ajax({
					    	 		                		 type:'POST',
					    	 		                		 url : '/trade/product/changProductStatusById',
					    	 		                		 data: 'productId='+resData.id,
					    	 		                		 dataType: 'json',
					    	 		                		 success:function(result){
					    	 		                			 if (result.success){
					    	 		                	 			location.reload();
					    	 		                			 }
					    	 		                		 }
					    	 		                	  });
					                                 }); 
					                            }
		        				}
	                        }
                    }else{
                        for(var i = 0;i < size;i++){
         					var resData = data.data.objects[i];
         					if(checkObjNotEmpty(resData))
         					{
         						if(checkObjNotEmpty(resData.marketingPrice))
         						{
             						resData.marketingPrice = (resData.marketingPrice).toFixed(2);
             					} 
                            	if(checkObjNotEmpty(resData.prePrice))
                            	{
                            		resData.prePrice = (resData.prePrice).toFixed(2);
                            	}
                            	if(checkObjNotEmpty(resData.productPriceList))
                            	{
                            		$.each(resData.productPriceList,function(k,v){
                            		if(checkObjNotEmpty(resData.productPriceList[k].price))
                            		{	
                            			resData.productPriceList[k].price = (resData.productPriceList[k].price).toFixed(2);
                            		}
                            		})
                            	}
                                el.append(template("temp1",resData));
                                imgVariant($(".clickDiv[data-id='"+resData.id+"']"));
                                var this_ = $("ul.countdown:last");
                                //2) 倒计时插件
                                if(resData.id == this_.data("pid")){
                                	 console.log(resData.status+"2");
                               	 this_.downCount({
                                     	targetDate:new Date(parseInt(this_.data("time"))).pattern("MM/dd/yyyy HH:mm:ss"),
                                     	nowDate:new Date(data.nowDate).pattern("MM/dd/yyyy HH:mm:ss"),
                                         offset: 8
                                     }, function () {
                                    	 $.ajax({
	    	 		                		 type:'POST',
	    	 		                		 url : '/trade/product/changProductStatusById',
	    	 		                		 data: 'productId='+resData.id,
	    	 		                		 dataType: 'json',
	    	 		                		 success:function(result){
	    	 		                			 if (result.success){
	    	 		                	 			location.reload();
	    	 		                			 }
	    	 		                		 }
	    	 		                	  });
                                     }); 
                                }
         					}
                        }
                    }
                    //el.append(result);
                    searchFlag = true;
                }else{
                    $(".infinite-preloader").hide();
                    $("#inLoading").text(data.msg);
                    searchFlag = true;
                }
            },error:function(XMLHttpRequest,textStatus, errorThrown){
                if(textStatus == 'timeout'){
                    $.toast("连接超时", "text");
                    $(".infinite-preloader").hide();
                    $("#inLoading").hide();
                }else{
                    $.toast("系统内部错误,请联系客服", "text");
                }
                searchFlag = true;
            }
        });
    }
    
    //立即抢猪
    $(document).on("click",".rush-btn",function(){
        	$("body","html").css("overflow","hidden");
        	seckillUrl = "";
        	var productId = $(this).data("id");
        	var cid = $(this).data("cid");
        	$.ajax({
        		url:"/trade/product/"+productId,
        		cache:false,
        		success:function(res){
        			if(res.success){
        				$("#xiadingdan").empty();
        				 seckillUrl = res.msg;
        				 var resData = res.data;
        				 if(checkObjNotEmpty(resData))
        				 {
        					 if(checkObjNotEmpty(resData.marketingPrice)){
            					resData.marketingPrice = (resData.marketingPrice).toFixed(2);
            					} 
                           	if(checkObjNotEmpty(resData.prePrice)){
                           		resData.prePrice = (resData.prePrice).toFixed(2);
                           	}
                           	if(checkObjNotEmpty(resData.productPriceList)){
                           		$.each(resData.productPriceList,function(k,v){
                           		if(checkObjNotEmpty(resData.productPriceList[k].price))
                           		{
                           			resData.productPriceList[k].price = (resData.productPriceList[k].price).toFixed(2);
                           		}
                           	 })
                           	}
             				 var showMakeOrder = template("quickMakeOrder",resData);
             				 $("#xiadingdan").append(showMakeOrder);
             				 $("#xiadingdan").show(); 
        				 }
        			}else{
        				if(res.msg == 'error03'){
        					location.href=res.data+"?circleId="+cid;
        				}
        				else if(res.msg == 'error02')
        				{
        					$.toast(res.data,"text");
        				}else if(res.msg == 'error01')
        				{
        					location.href=res.data+"?circleId="+cid;
        					// $.toast(res.data,"text");
        				}else{
        					$.toast("系统内部错误,请联系客服","text");
        				}
        			}
        		},error:function(XMLHttpRequest,textStatus, errorThrown){
                    if(textStatus == 'timeout'){
                        $.toast("连接超时", "text");
                        $(".infinite-preloader").hide();
                        $("#inLoading").hide();
                    }else{
                        $.toast("系统内部错误,请联系客服", "text");
                    }
                }
        	})
        	
           
        });
    $(document).on("click","#quxiaodingdan",function(){
    	$(".transaction_tckbg1").css("top","5.5rem");
    	$("body","html").css("overflow","auto");
    	if(!isClickConfirm){
    	 $("#xiadingdan").hide();
    	}else{
    	 location.reload();	
    	}
    })
    $(document).on("focus",".transaction_tckbg1 .tck_number_input",function(){
    	$(".transaction_tckbg1").css("top","0");
    });  
    $(document).on("click","#quedingdingdan",function(){
    	//debugger;
    	$(".transaction_tckbg1").css("top","5.5rem");
    	var this_obj = $(this);
    	this_obj.prop("disabled",true);
    	$("body","html").css("overflow","auto");
    	var boyCount = $("#buyCount").val();
    	var pid = this_obj.data("pid");
    	if(checkEmpty(boyCount)){
    		this_obj.prop("disabled",false);
    		$.toast("请输入购买数量","text");
    		return;
    	}
    	if(checkEmpty(seckillUrl)){
    		this_obj.prop("disabled",false);
    		$.toast("非法的访问方式","text");
    		return;
    	}
    	isClickConfirm = true;
    	$.ajax({
    		url:seckillUrl+"?pid="+pid+"&count="+boyCount,
			cache:false,
			type : 'post',
			success:function(res){
				if(res.success){
					//$("#oid").val(result.data);
					$("#buyCount").val("");
					 oid = res.data;
					 $("#xiadingdan").hide();
			         $("#dingdan_success").show();
				}else{
					this_obj.prop("disabled",false);
					if("count_err" == res.msg){
						$("#buyCount").val(res.data.surplusNumber);
						$("#surplusNumber").val(res.data.surplusNumber);
						//下单剩余
						$("#surplusSpan").text("剩余"+res.data.surplusNumber+"头");
						//剩余
						$(".transaction_number_residue").text("剩余"+res.data.surplusNumber+"头");
						//已售
						$(".transaction_number_sell").text("已售"+res.data.bidedNumber+"头");
						 if(res.data.surplusNumber > 0){
								$("#xiadingdan").hide();
								$("#fail_notify_count").text(res.data.surplusNumber);
								$("#dingdan_fail").show();
							}else{
								$("#fail_notify_count").text("0");
								$(".btn_box").empty();
								$(".btn_box").append('<input type="button" class="btn_tck_know"  id="fail_notify_zhidaole" value="知道了"/>');
								$("#xiadingdan").hide();
								$("#dingdan_fail").show();
							} 
					}else{
						 $.toast(res.msg, "text");      
		            	  setTimeout(function(){
		            	 	location.reload();
		            	  },2000);
					}	
				}
			},
			error:function(XMLHttpRequest,textStatus, errorThrown){
				  if(textStatus == 'timeout'){
					  this_obj.prop("disabled",false);
					  $.toast("连接超时", "text");
				  }
			   }
    	})
    })
          $("#zhidaole_success").click(function(){
            	if(checkObjNotEmpty(oid)){
    	         	location.href="/mine/bought/list";      
                 }else{
    	         	location.href="/mine/bought/list";      
                 }
            });
    
        //提醒我弹窗
        $(document).on("click",".alert-btn",function(){
        	var this_ = $(this);
        	var pid = this_.data("id");
        	var cid = this_.data("cid");
        	$.ajax({
        		url:"/trade/product/remind/"+pid,
        		cache:false,
        		success:function(res){
        		   if(res.success){
	            	  //===============================这里改变提醒状态
                   		 this_.addClass("quxiao-alert-btn");
	            		 this_.val("取消提醒");
	            		 this_.removeClass("alert-btn");
	                     $("#tixing_success").show ().delay (3000).fadeOut ();
	                     this_.show();
        		  }else{
        			if(res.msg == 'error03'){
        				location.href=res.data+"?circleId="+cid;
      				}
      				else if(res.msg == 'error02')
      				{
      					$.toast(res.data,"text");
      				}else if(res.msg == 'error01')
      				{
      					//$.toast(res.data,"text");
      					location.href=res.data+"?circleId="+cid;
      				}else{
      					$.toast("系统内部错误,请联系客服","text");
      				}        		  
        		 }	 
        		},
        		error:function(XMLHttpRequest,textStatus, errorThrown){
					   if(textStatus == 'timeout'){
						  $.toast("连接超时", "text");
					  } 
				   }
        	})
        });
        
        $("#qxtx_queding").click(function(){
        	 var pid = this_obj.data("id");
          		$.ajax({
          		url:"/trade/product/cancleRemind/"+pid,
          		cache:false,
          		success:function(res){
          		   if(res.success){
  	            	if(res.msg == 'sessionTimeout'){
  	            	  location.href=res.data;	
  	            	}else{
  	            	  //===============================这里改变提醒状态
                     	 this_obj.addClass("alert-btn");
                     	 this_obj.val("提醒我");
                     	 this_obj.removeClass("quxiao-alert-btn");
     		 			 $("#tixing_remove").hide();
     		 			 this_obj.show();
  	            	}
          		  }else{
          			 $.toast(res.msg, "text");      
               	  	setTimeout(function(){
               	 	location.href="/trade/product/list";
               	  },2000);
          			}	 
          		},
          		error:function(XMLHttpRequest,textStatus, errorThrown){
  					   if(textStatus == 'timeout'){
  						  $.toast("连接超时", "text");
  					  } 
  				   }
          	})
        });
        $(document).on("click",".quxiao-alert-btn",function(){
        	$("#tixing_remove").show();
        	this_obj = $(this);
        });
        $("#zaikankan").click(function(){
            $("#tixing_remove").hide();
        });
    <!--交易圈页面事件-->
    $(".filter-condition>span").click(function () {
    	if(searchFlag){	
	    	loading=false;
	        $(this).addClass("active").siblings("span").removeClass("active");
	        $(".chooseCircle").hide();
	        $(".fa").removeClass("fa-caret-up").addClass("fa-caret-down");
    	}
    });
    $(".all-circle").click(function () {
    	if(searchFlag){	
        	$(".circleName").show();
        	$(".circleIcon").removeClass("fa-caret-down").addClass("fa-caret-up");
    	}
    });
    $(".time-lately").click(function () {
    	if(searchFlag){	
        	$(".tradeState").show();
        	$(".timeIcon").removeClass("fa-caret-down").addClass("fa-caret-up");
    	}
    });
    $(".circleName .chooseCircle-ul>li").click(function () {
    	if(searchFlag){
        $(this).addClass("current").siblings("li").removeClass("current");
        var circleName=$(this).text();
        $(".all-circle").find("i").html(circleName);
        $(".chooseCircle").hide();
        $(".circleIcon").removeClass("fa-caret-up").addClass("fa-caret-down");
    	//设置按圈子查询的条件
        search.circleId = $(this).data("id");
        circle_id_search =   $(this).data("id");
        search.productStatus = productStatus_search_param;
    	page =1;
    	$(".circleTrade-ul").empty();
    	searchFlag =false;
       	initialPage(search);
    	}
    });
    $(".tradeState .chooseCircle-ul>li").click(function () {
    	if(searchFlag){
        $(this).addClass("current").siblings("li").removeClass("current");
        var stateName=$(this).text();
        $(".time-lately").find("i").html(stateName);
        $(".chooseCircle").hide();
        $(".timeIcon").removeClass("fa-caret-up").addClass("fa-caret-down");
    	//设置按圈子查询的条件
        search.circleId = circle_id_search;
    	search.productStatus = $(this).data("value");
    	productStatus_search_param = $(this).data("value");
       	$(".circleTrade-ul").empty();
    	page =1;
    	search.isAddressSort ="";
    	search.isBidEndTime =1;
    	searchFlag =false;
       	initialPage(search);
    	}
    });
    <!--订单失败弹窗控制-->
    $(function(){
        $("#zhidaole_fail").click(function(){
        	location.reload();
        });
        $(document).on("click","#fail_notify_zhidaole",function(){
        	location.reload();
        });
        $("#chongxinqianggou").click(function(){
            $("#dingdan_fail").hide();
            //$("#quedingdingdan").prop("disabled",false);
            $("#xiadingdan").show();
        });
    });
    
    <!--提醒弹窗控制-->

    //初始化以后，再去按照分页加载条数
    $("#warp").infinite(200).on("infinite", function() {
    	if(loading) return;
        $(".infinite-preloader").show();
        $("#inLoading").text("正在加载...");
        $("#inLoading").show();
        loading = true;
        	 page++;
             search.pageIndex =page;
                 //发送请求，拿到json数据
                 $.ajax({
                     type: 'POST',
                     url: '/trade/product/list.json',
                     dataType: 'json',
                     contentType:"application/json", 
                     data:JSON.stringify(search),
                     success: function(data){
                    	 loading = false;
                         if(data.success==true){
                      
                             var result ="";
                             //总的数据长度
                             var dataLen = data.data.objects.length;
                             //计算总的页数
                             var totalPage = data.data.totalPages?data.data.totalPages:0;
                            
                             for(var i = 0;i < dataLen;i++){
                            	var resData = data.data.objects[i];
                            	if(checkObjNotEmpty(resData))
                            	{
                            		if(checkObjNotEmpty(resData.marketingPrice))
                            		{
                  						resData.marketingPrice = (resData.marketingPrice).toFixed(2);
                  					} 
                                 	if(checkObjNotEmpty(resData.prePrice))
                                 	{
                                 		resData.prePrice = (resData.prePrice).toFixed(2);
                                 	}
                                 	if(checkObjNotEmpty(resData.productPriceList))
                                 	{
                                 		$.each(resData.productPriceList,function(k,v){
                                 			if(checkObjNotEmpty(resData.productPriceList[k].price))
                                 			{
                                 			resData.productPriceList[k].price = (resData.productPriceList[k].price).toFixed(2);
                                 			}
                                 		})
                                 	}
                                 $(".circleTrade-ul").append(template("temp1",resData));
                                     var this_ = $("ul.countdown:last");
                                     //2) 倒计时插件
                                     if(resData.id == this_.data("pid"))
                                     {
                                    	 console.log(resData.status+"3");
                                    	 this_.downCount({
                                          	targetDate:new Date(parseInt(this_.data("time"))).pattern("MM/dd/yyyy HH:mm:ss"),
                                          	nowDate:new Date(data.nowDate).pattern("MM/dd/yyyy HH:mm:ss"),
                                              offset: 8
                                          }, function () {
                                        	  $.ajax({
			    	 		                		 type:'POST',
			    	 		                		 url : '/trade/product/changProductStatusById',
			    	 		                		 data: 'productId='+resData.id,
			    	 		                		 dataType: 'json',
			    	 		                		 success:function(result){
			    	 		                			 if (result.success){
			    	 		                	 			location.reload();
			    	 		                			 }
			    	 		                		 }
			    	 		                	  });
                                          }); 
                                     }
                            	}
                            	imgVariant($(".clickDiv[data-id='"+resData.id+"']"));
                             }
                             
                             if(page >= totalPage){
                            	 loading = true;
                                 $(document.body).destroyInfinite();
                                 $(".weui-infinite-scroll").show();
                                 $(".infinite-preloader").hide();
                                 $("#inLoading").text("没有更多数据了");
                             }else{
                                 $(".weui-infinite-scroll").show();
                                
                             }
                             searchFlag = true;
                         }else{
                         	page--;
                             $(".infinite-preloader").hide();
                             $("#inLoading").text(data.msg);
                             searchFlag = true;
                         }
                     },error:function(XMLHttpRequest,textStatus, errorThrown){
                    	 loading = false;
                         if(textStatus == 'timeout'){
                             $.toast("连接超时", "text");
                             $(".infinite-preloader").hide();
                             $("#inLoading").hide();
                         }else{
                             $.toast("系统内部错误,请联系客服", "text");
                         }
                         searchFlag = true;
                     }
                 });
                 
        
    });

    function toSetPricePage(o){
        location.href = "/circle/circlePrice/toCirclePriceSettingPage?circleId="+$(o).val();
    }
    function goDetialPage(o){
        location.href = "/user/userCircle/joinedCircleDetail?circleUserId="+$(o).data("id");
    }
$(document).on("click",".clickDiv",function(){
	var pid = $(this).data("id");
	location.href="/trade/product/detial/"+pid;
});
//距离最近排序
$(".distance-lately").click(function(){
	if(searchFlag){
	$(".circleTrade-ul").empty();
		page =1;
		search.isAddressSort =1;
		search.isBidEndTime ="";
		search.circleId = circle_id_search;
		search.productStatus = productStatus_search_param;
		searchFlag =false;
	   	 initialPage(search);
	}
	
});
//时间最近排序
/* $(".time-lately").click(function(){
	if(searchFlag){
	$(".circleTrade-ul").empty();
	page =1;
	search.isAddressSort ="";
	search.isBidEndTime =1;
		searchFlag =false;
   	  initialPage(search);
	}
}); */
//购买数量输入后，控制最大购买数
$(document).on("keyup","#buyCount",function(){	
	wholeNumCheck($(this));
	var buyCount = parseInt($(this).val());
	var surplusNumber = parseInt($("#surplusNumber").val());
	if(buyCount>surplusNumber){
	 $(this).val(surplusNumber);	
	}
});
$(".GPS").click(function(){
	location.href="/trade/position/opencity?currentCityName="+$("#current_city").text();
})

//调用定位，获取位置信息
 $(function(){
		if(checkEmpty('${sessionScope.cityName}')||checkEmpty('${sessionScope.lat}')||checkEmpty('${sessionScope.lng}')){
			layer.msg('位置获取中', {
			    icon: 16,
			    shade:  [0.5, '#000000'],
			    time:10000,
			    offset: ['45%', '25%']
			   	});
			loadLocation(callback);
		}else{
			initialPage(search);
		}
 })
 //引入外部函数
	template.helper('imgRealPath', function (imgPath) {
		if (new String(imgPath).indexOf( "http") == 0){
			return imgPath;
		} else {
			return imgServer + imgPath;
		}
	});
//引入外部函数
template.helper('date_format', function (date) {
	if(checkObjNotEmpty(date)){
		return new Date(date).pattern("yyyy-MM-dd") 
	}
});
	
//引入底部菜单时赋值
initAtag("trading_a_tag");
</script>
<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>