<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>我卖出的</title>
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
    <link rel="stylesheet" href="/static/newhope/html/css/hj_wode_onsaleing.css"/>
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

        .detailPhoto{
            width:100%;
            height:100%;
            position: fixed;
            background:#000;
            z-index:2;
        }
        .Divimg{
            position: fixed;
            width:100%;
            background: #000;
        }
        .Divimg>img{
            background: #000;
            position: fixed;
            width:100%;
            z-index:999;
            padding-top:5rem;
        }

        .DIvdelete{
            display: flex;
            justify-content: center;
            padding-top:27.33rem;
            background: #000;
        }
        #btnDelete{
            position: fixed;
            width:9rem;
            margin:0 auto;
            z-index:9999;
        }
        /*切换卡*/

        /*.weui_navbar_item{*/
            /*background-color:#F5F5F5 !important;*/
            /*font-size: 0.8333rem !important;*/
            /*color: #999 !important;*/
            /*letter-spacing: 0;*/
            /*border:0;*/
        /*}*/
        /*.weui_bar_item_on{*/
            /*background-color:#fff !important;*/
            /*font-size: 0.8333rem !important;*/
            /*color:#1BBD3D  !important;*/
            /*border:0;*/
        /*}*/
        
        /*替换数字*/
        .statusCountSpan{
        	font-size: 0.7222rem;
		    color: #333;
		    line-height: 1.6667rem;
        }
    </style>
</head>
<script type="text/html" id="IN_TRADING">
   <li>
        <a href="/mine/saledProduct/selectSaledProductDetail?productId={{id}}">
            <div>
                <p>竞拍日期:{{bidTime | dateFormat:'yyyy-MM-dd'}}</p>
                <p>猪场名称:{{pigFarmInfoExModel.name}}</p>
            </div>
            <i class="fa fa-chevron-right" aria-hidden="true"></i>
        </a>
        <div>
            <p>发布头数：{{marketingNumber}}头</p>
            <p>剩余数量：{{surplusNumber}}头</p>
            <div class="time">
                <span class="endTitle">距拍卖结束：</span>
                <span class="countdown" targetDate="{{bidEndTime}}" productId="{{id}}"></span>
            </div>
            <div class="orderFrom">
                <span>该发布信息来自{{circleModel.name}}交易圈</span>
            </div>
            {{if isCedan}}
            	<img class="state" src="/static/newhope/html/images/hj/ic_label_fscd.png" alt="">
            {{/if}}
        </div>
    </li>
</script>
<script type="text/html" id="IN_DELIVERY">
   <li>
        <a href="/mine/saledProduct/selectSaledProductDetail?productId={{id}}">
             <div>
                <p>竞拍日期:{{bidTime | dateFormat:'yyyy-MM-dd'}}</p>
                <p>猪场名称:{{pigFarmInfoExModel.name}}</p>
             </div>
             <i class="fa fa-chevron-right" aria-hidden="true"></i>
      	</a>
        <div>
             <p>发布头数：{{marketingNumber}}头</p>
             <p>订购数量：{{bidedNumber}}头</p>
             <p>已交割数量：{{deliveryNum}}头</p>
        	 <div class="orderFrom">
        	    <span>来自{{circleModel.name}}交易圈</span>
       	     </div>
        </div>
   </li>
</script>
<script type="text/html" id="COMPLETE">
  <li>
      <a href="/mine/saledProduct/selectSaledProductDetail?productId={{id}}">
        <div>
           <p>竞拍日期:{{bidTime | dateFormat:'yyyy-MM-dd'}}</p>
           <p>猪场名称:{{pigFarmInfoExModel.name}}</p>
        </div>
        <i class="fa fa-chevron-right" aria-hidden="true"></i>
      </a>
      <div>
         <p>发布头数：{{marketingNumber}}头</p>
         <p>订购数量：{{bidedNumber}}头</p>
         <p>交割数量：{{deliveryNum}}头</p>
         <div class="orderFrom">
            <span>来自{{circleModel.name}}交易圈</span>
         </div>
		{{if isPaodan}}
 		 	<img class="state" src="/static/newhope/html/images/hj/ic_label_ypd.png" alt="">
		{{/if}}
      </div>
   </li>
</script>
<body>

<section>
    <div id="warp">
        <div class="weui_tab">
            <div class="weui_navbar">
                <a href="#IN_TRADING_DIV" data-id="IN_TRADING" class="weui_navbar_item ${status == 'IN_TRADING' ? 'weui_bar_item_on' : '' }">
                    <span class="jiaoyi_ing ${status == 'IN_TRADING' ? 'tabActive' : '' }">交易中</span>
                </a>
                <a href="#IN_DELIVERY_DIV" data-id="IN_DELIVERY" class="weui_navbar_item ${status == 'IN_DELIVERY' ? 'weui_bar_item_on' : '' }">
                    <span class="jiaoge_ing ${status == 'IN_DELIVERY' ? 'tabActive' : '' }">交割中</span>
                </a>
                <a href="#COMPLETE_DIV" data-id="COMPLETE" class="weui_navbar_item ${status == 'COMPLETE' ? 'weui_bar_item_on' : '' }">
                    <span class="complete ${status == 'COMPLETE' ? 'tabActive' : '' }">完成</span>
                </a>
            </div>
            <div class="clearfloat"></div>
            <div class="weui_tab_bd">
                <div id="IN_TRADING_DIV" class="weui_tab_bd_item ${status == 'IN_TRADING' ? 'weui_tab_bd_item_active' : '' } ">
                    <p>我卖出的共${empty totalCount ? '0' : totalCount}笔，<span>交易中的记录（<span class="statusCountSpan">${statusCount }</span>笔）</span></p>
                    <ul>
                    </ul>
                    <div class="weui-infinite-scroll">
                        <div class="infinite-preloader"></div>
                        <span id="inLoading">正在加载...</span>
                    </div>
                </div>
                <div id="IN_DELIVERY_DIV" class="weui_tab_bd_item ${status == 'IN_DELIVERY' ? 'weui_tab_bd_item_active' : '' }">
                    <p>我卖出的共${empty totalCount ? '0' : totalCount}笔，<span>交割中的记录（<span class="statusCountSpan">${statusCount }</span>笔）</span></p>
                    <ul>
                    </ul>
                    <div class="weui-infinite-scroll">
                        <div class="infinite-preloader"></div>
                        <span id="inLoading">正在加载...</span>
                    </div>
                </div>
                <div id="COMPLETE_DIV" class="weui_tab_bd_item ${status == 'COMPLETE' ? 'weui_tab_bd_item_active' : '' }">
                    <p>我卖出的共${empty totalCount ? '0' : totalCount}笔，<span>已完成的记录（<span class="statusCountSpan">${statusCount }</span>笔）</span></p>
                    <ul>
                    </ul>
                    <div class="weui-infinite-scroll">
                        <div class="infinite-preloader"></div>
                        <span id="inLoading">正在加载...</span>
                    </div>
                </div>
            </div>
        </div>

    </div>

</section>
<!--蒙层-->
<div style="display: none" class="mengceng">
    <div class="Divimg">
        <img src="/static/newhope/html/images/hj/pig_icon.png" alt="">
    </div>
    <div class="DIvdelete">
        <a  href="javascript:;" id="btnDelete" class="weui_btn weui_btn_warn">删除</a>
    </div>
    <div class="detailPhoto">
    </div>
</div>
<!--  weui城市选择js -->
<script src="/static/newhope/html/js/jquery-weui.min.js"></script>
<script src="/static/newhope/html/js/city-picker.min.js"></script>
<script src='/static/newhope/html/js/swiper.min.js' ></script>
<script src="/static/newhope/html/js/dateutil.js?v=1.0"></script>
<script type="text/javascript" src="/static/newhope/html/js/jquery.downCount.js"></script>
<script type="text/javascript" charset="utf-8" src="/static/plug-in/layer/layer.js"></script>
<script type="text/javascript">
	//IN_TRADING(交易中),IN_DELIVERY(交割中),COMPLETE(已完成)
	var status  = '${status}';
	var circleId  = '${circleId}';
    var page = 1;    //当前显示页数

    //每一页的显示数量
    var limit = 5;
    var loading = false;  //状态标记
    
	$(function(){
	    $(".weui_navbar a").click(function () {
	    	layer.msg('正在加载中', {
			    icon: 16,
			    shade:  [0.5, '#000000'],
			    time:800,
			    offset: ['45%', '25%']
			   	});
	        $(this).children().addClass("tabActive");
	        $(this).siblings().children().removeClass("tabActive");
	        $(".weui_tab_bd").find("ul").empty();
	        status = $(this).data("id");
	        //加载模板数据，分页功能
	        $("#"+status+"_DIV").find(".weui-infinite-scroll").show();
	        page = 1;
	        loading=false;
	        getPageData("firstClick");
	    })
	    //加载模板数据，分页功能
	    $(document.body).infinite(500);
	    //初始化数据
	    getPageData();
	    
	});
    //初始化以后，再去按照分页加载条数
    $(document.body).infinite(500).on("infinite", function() {
        if(loading) return;
        loading = true;
        setTimeout(function() {
        	getPageData();
            loading = false;
        }, 2000);   //模拟延迟
    });

    //获取分页数据
    function getPageData(firstClick){
 	   $.ajax({
 	        type: 'POST',
 	        url: '/mine/saledProduct/querySaledProductPage',
 	        data: "status="+status+"&circleId="+circleId+"&page="+page+"&limit="+limit,
 	        dataType: 'json',
 	        success: function(data){
 	        	if (data.success){
 		            var objectList = data.data;
 		            //后台传来的服务器时间
 		            var nowDate = data.msg;
 		            var resultHtml ="";
 		            //总的页数长度
 		            var pageCount = data.pageCount;
 		            var productIdArr = [];
 		            $.each(objectList,function(index,item){
 		            	if (status == 'IN_TRADING'){
 		            		productIdArr.push(item.id);
 		            	}
 		            	resultHtml += template(status,item);
 		            })
 		            $("#"+status+"_DIV").find("ul").append(resultHtml);
 		            $("#"+status+"_DIV").find(".statusCountSpan").text(data.recordCount);
 		            
 		            if (parseInt( page) >= parseInt(pageCount)){
 		            	 //销毁下拉插件
 		            	 $(document.body).destroyInfinite();
                         $(".weui-infinite-scroll").hide();
 		            } else if (parseInt(page) < parseInt(pageCount)){
 		            	if (firstClick == "firstClick"){
 		            		$(document.body).infinite(500);
 		            	}
 		           	 	page++;
 		            }
 		            //交易中才会有倒计时
 		            if (status == 'IN_TRADING'){
 		            	$.each(productIdArr,function(i,n){
 		            		var fromStartObj = $("span[productId='"+n+"']");
 		            		//2) 倒计时插件
	  		                fromStartObj.downCount({
	  		                	  targetDate:new Date(parseInt(fromStartObj.attr("targetDate"))).pattern("MM/dd/yyyy HH:mm:ss"),
	  		                	  nowDate:nowDate,
	  		                	  needStr:true,
	  		                      offset: 8
	  		                }, function () {
	  		                	  // 当一个倒计时完成后，向后台发送一次请求，手动调用一次商品状态扫描，改变商品状态
	  		                	  $.ajax({
	  		                		 type:'POST',
	  		                		 url : '/trade/product/changProductStatusById',
	  		                		 data: 'productId='+fromStartObj.attr("productId"),
	  		                		 dataType: 'json',
	  		                		 success:function(result){
	  		                			 if (result.success){
	  		                				location.href="/mine/saledProduct/toSaledPage?status="+status+"&v="+Math.random();
	  		                			 }
	  		                		 }
	  		                	  });
	  		                });
 		            	});
 		            }
 	        	} else {
 	        		$.toast(data.msg,"text");
 	        	}
 	        },
 	        error:function(){
 	        	$.toast("操作异常，请联系管理员！","text");
 	        }
 	    });
    }
    
    /** 
     * 对日期进行格式化， 
     * @param date 要格式化的日期 
     * @param format 进行格式化的模式字符串
     *     支持的模式字母有： 
     *     y:年, 
     *     M:年中的月份(1-12), 
     *     d:月份中的天(1-31), 
     *     h:小时(0-23), 
     *     m:分(0-59), 
     *     s:秒(0-59), 
     *     S:毫秒(0-999),
     *     q:季度(1-4)
     * @return String
     * @author yanis.wang
     * @see	http://yaniswang.com/frontend/2013/02/16/dateformat-performance/
     */
    template.helper('dateFormat', function (date, format) {

        if (typeof date === "string") {
            var mts = date.match(/(\/Date\((\d+)\)\/)/);
            if (mts && mts.length >= 3) {
                date = parseInt(mts[2]);
            }
        }
        date = new Date(date);
        if (!date || date.toUTCString() == "Invalid Date") {
            return "";
        }

        var map = {
            "M": date.getMonth() + 1, //月份 
            "d": date.getDate(), //日 
            "h": date.getHours(), //小时 
            "m": date.getMinutes(), //分 
            "s": date.getSeconds(), //秒 
            "q": Math.floor((date.getMonth() + 3) / 3), //季度 
            "S": date.getMilliseconds() //毫秒 
        };
        

        format = format.replace(/([yMdhmsqS])+/g, function(all, t){
            var v = map[t];
            if(v !== undefined){
                if(all.length > 1){
                    v = '0' + v;
                    v = v.substr(v.length-2);
                }
                return v;
            }
            else if(t === 'y'){
                return (date.getFullYear() + '').substr(4 - all.length);
            }
            return all;
        });
        return format;
    });
</script>
 
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>