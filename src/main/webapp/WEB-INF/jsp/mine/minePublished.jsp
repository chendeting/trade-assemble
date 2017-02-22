<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <title>猪小e-发布</title>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/weui.min.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/huadongjiazai.min.css"/>
    <link rel="stylesheet" type="text/css" href="/static/newhope/html/css/common.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/myTradeRecord.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/Published.css"/>
</head>
<script type="text/html" id="un_Published">
    <li class="published-list">
        <div class="floatBox" onclick="selectPublishedProductDetail('{{uid}}','unPublished');">
            <div class="pulished-pic">
				{{if planImgInfoList}}
					<img src="{{planImgInfoList[0].url}}"/>
				{{else}}
					<img src="/static/newhope/html/images/hj/morentu.png" alt="暂无图片"/>
				{{/if}}
			</div>
            <div class="pulished-info">
                <p class="info-title">{{pigFarmerName}}</p>
                <p>发布数量：{{planSaleQuantity}}头</p>
                <p>预估均重：{{planAvgWeight}}KG</p>
                <p>出栏品种：{{pigTypeDisplayName}}</p>
                <p>计划出栏日期：{{planDate | dateFormat:'yyyy-MM-dd'}}</p>
            </div>
			{{if overDue}}
            	<div class="over-due">发布超期{{overDue}}</div>
			{{/if}}
        </div>

        <div class="btn-box">
			{{if overDue == null || overDue == ''}}
            	<p class="published-p" style="display: {{publishedBtn}}">
					<a href="/trade/product/toPublishPage?source=FY&planId={{uid}}">
						<input type="button" value="发布" class="published-btn">
					</a>
				</p>
			{{/if}}
            <p class="send-p"><input type="button" value="退回" class="send-back" onclick="sendBack('{{pigFarmerName}}','{{uid}}')"></p>
        </div>
    </li>
</script>
<script type="text/html" id="have_Published">
    <li class="published-list">
        <div class="floatBox" onclick="selectPublishedProductDetail({{id}},'havePublished');">
            <div class="pulished-pic">
				{{if bidInfoImgModelList}}
					<img src="{{imgRealPath(bidInfoImgModelList[0].url)}}"/>
				{{else}}
					<img src="/static/newhope/html/images/hj/pig_icon.png"/>
				{{/if}}
			</div>
            <div class="pulished-info">
                <p class="info-title">
					{{if pigFarmInfoExModel}}
						{{pigFarmInfoExModel.name}}
					{{/if}}
				</p>
                <p>发布数量：{{marketingNumber}}头</p>
                <p>订购数量：{{bidedNumber}}头</p>
                <p>出栏品种：{{pigTypeDisplayName}}</p>
                <p>价格：
					{{if isDiscuss}}
						<span class="unit-price">
							现场议价
						</span>
					{{else if marketingPrice}}
						<span class="unit-price">
							￥{{marketingPrice}}元/KG
						</span>
					{{else if productPriceList}}
						{{each productPriceList as productPrice index}}
							{{if productPrice.weightMin <= preAvgWeight}}
								{{if productPrice.weightMax}}
									{{if productPrice.weightMax > preAvgWeight}}
										<span class="unit-price">
											{{if productPrice.isDiscuss}}
												议价
											{{else}}
												￥{{productPrice.price}}元/KG
											{{/if}}	
										</span>(均重{{productPrice.weightMin}}-{{productPrice.weightMax}}KG)
									{{/if}}	
								{{else}}
									<span class="unit-price">
										{{if productPrice.isDiscuss}}
											议价
										{{else}}
											￥{{productPrice.price}}元/KG
										{{/if}}	
									</span>(均重{{productPrice.weightMin}}KG以上)
								{{/if}}
							{{/if}}
						{{/each}}
					{{else}}
						<span class="unit-price">
							价格待定
						</span>
					{{/if}}
				</p>
            </div>
			{{if status == 'BEFORE_AUCTION'}}
            	<div class="over-due">
					{{if bidTime-nowDateMillionSeconds > 86400000}}
						{{bidTime | dateFormat:'yyyy-MM-dd'}}开拍
					{{else}}
						距开始
					{{/if}}
			{{else if status == 'IN_TRADING'}}
            	<div class="over-due" style="color: #fa4848;">
					距结束
			{{else}}
            	<div class="over-due" style="color: #fa4848;">
					已结束
			{{/if}}
				{{if status == 'BEFORE_AUCTION' && bidTime-nowDateMillionSeconds <= 86400000 }}
					<span class="fromStart" targetDate="{{bidTime}}" productId="{{id}}">
					</span>
				{{else if status == 'IN_TRADING'}}
					<span class="fromStart" targetDate="{{bidEndTime}}" productId="{{id}}">
					</span>
				{{/if}}
			</div>
        </div>

        <div class="btn-box">
			{{if status == 'BEFORE_AUCTION'}}
            	<input type="button" class="del-btn" onclick="deleteProduct('{{pigFarmInfoExModel.name}}','{{id}}')" value="删除">
				<a href="/mine/publishedProduct/toPublishedModifyPage?productId={{id}}">
            		<input class="recompose" type="button" value="修改">
				</a>
			{{/if}}
        </div>
    </li>
</script>
<body>

    <div id="warp">
        <div class="weui_tab">
            <div class="weui_navbar">
                <a href="#unPublished" pageListType="unPublished" class="weui_navbar_item ${empty pageListType || pageListType == 'unPublished' ? 'weui_bar_item_on' :''  }">
                    <span class="mySell ${empty pageListType || pageListType == 'unPublished' ? 'active' :''  }">待发布</span>
                </a>
                <a href="#havePublished" pageListType="havePublished" class="weui_navbar_item ${pageListType == 'havePublished' ? 'weui_bar_item_on' :''  }">
                    <span class="mybuy ${pageListType == 'havePublished' ? 'active' :''  }">已发布</span>
                </a>
            </div>
            <div class="weui_tab_bd" style="margin-bottom: 3rem;">
                <div id="unPublished" class="weui_tab_bd_item  ${empty pageListType || pageListType == 'unPublished' ? 'weui_tab_bd_item_active' :''  }">
                    <div class="noData" style="display: none">
                        <div class="noData-img"><img src="/static/newhope/html/images/img_fb_default01.png"/></div>
                        <p>暂无放养上市的发布请求，请耐心等待</p>
                    </div>
                    <div class="hideDiv1">
                        <p class="Published-title">待发布（0笔）</p>
                        <ul class="unpublished-box">

                        </ul>
                        <div class="weui-infinite-scroll">
                            <div class="infinite-preloader"></div>
                           		 正在加载...
                        </div>
                    </div>
                   
                </div>
                <div id="havePublished" class="weui_tab_bd_item ${pageListType == 'havePublished' ? 'weui_tab_bd_item_active' :''  }">
                    <div class="noData" style="display: none">
                        <div class="noData-img"><img src="/static/newhope/html/images/img_fb_default02.png"/></div>
                        <p>还未发布过买猪消息赶紧发布一条吧~</p>
                    </div>
                    <div class="hideDiv2">
                        <p class="Published-title">已发布（4笔）</p>
                        <ul class="havepublished-box" >

                        </ul>

                        <div class="weui-infinite-scroll">
                            <div class="infinite-preloader"></div>
                            	正在加载...
                        </div>
                    </div>
                </div>
                

            </div>
        </div>
		 
    </div>
    <div class="published-details">
    	<a href="/trade/product/toPublishPage?source=ZXE"><img src="/static/newhope/html/images/btn_fb_float_normal.png"/></a>
    </div>
    <!-- 引入底部菜单 -->
	<%@ include file="../menu/footMenu.jsp"%>
<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
<script type="text/javascript" src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="/static/newhope/html/js/jquery.downCount.js"></script>
<script type="text/javascript" charset="utf-8" src="/static/trade/js/tradeCommon.js"></script>
<!--动态加载模块-->
<script src="/static/newhope/html/js/template.js"></script>
<script type="text/javascript" src="/static/newhope/html/js/jquery-weui.min.js"></script>
<script type="text/javascript" charset="utf-8" src="/static/plug-in/layer/layer.js"></script>
<script src="/static/newhope/html/js/dateutil.js?v=1.0"></script>
<script type="text/javascript">
	//unPublished(待发布),havePublished(已发布)
	var pageListType  = '${pageListType}';
    var page = 1;    //当前显示页数

    var imgServer = '${imgServer}';
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
	        $(this).children().addClass("active");
	        $(this).siblings().children().removeClass("active");
	        pageListType = $(this).attr("pageListType");
	        $(".weui_tab_bd_item").removeClass("weui_tab_bd_item_active");
	        $("#"+pageListType).addClass("weui_tab_bd_item_active");
	        $("#havePublished").find(".Published-title").text("已发布（0笔）");
         	$("#unPublished").find(".Published-title").text("待发布（0笔）");
	        $(".unpublished-box").empty();
	        $(".havepublished-box").empty();
	      	//加载模板数据，分页功能
	        $(".weui-infinite-scroll").show();
	        page = 1;
	        loading=false;
	        getPageData("firstClick");
	    });
	    //加载模板数据，分页功能
	    $(document.body).infinite(200);
	    //初始化数据
	    getPageData();
	    //底部按钮选中显示
		initAtag("publish_a_tag");
	    
	});
    
    
    //初始化以后，再去按照分页加载条数
    $(document.body).infinite(200).on("infinite", function() {
        if(loading) return;
        loading = true;
        setTimeout(function() {
        	getPageData();
            loading = false;
        }, 2000);   //模拟延迟
    });

    //退回上市计划
    function sendBack(pigFaramName,planId){
    	 //在待发布页面点击退回后弹出的警告框
         $.confirm({
             title:'提示',
             text: '确定退回'+pigFaramName+'的出栏申请',
             onOK: function () {
            	 $.ajax({
                 	type:"POST",
                 	url:"/mine/publishedProduct/sendBackPlan",
                 	data:"planId="+planId,
                 	dataType:"json",
                 	success:function(result){
                 		if (result.success){
                 			$.toast("上市计划退回成功！","text");
                 			location.href="/mine/publishedProduct/toMinePublishedPage?pageListType="+pageListType+"&v="+Math.random();
                 		} else {
                 			$.toast(result.msg,"text");
                 		}
                 	},
                 	error:function(){
                 		$.toast("操作异常，请联系管理员！","text");
                 	}
                 });
             }
         });
    }
    
    //删除已发布拍卖信息
    function deleteProduct(pigFaramName,productId){
    	//在已发布页面点击删除后弹出的警告框
        $.confirm({
            title:'提示',
            text: '确定删除'+pigFaramName+'的发布信息',
            onOK: function () {
                //点击确认后需进行的操作
                $.ajax({
                	type:"POST",
                	url:"/mine/publishedProduct/deleteById",
                	data:"productId="+productId,
                	dataType:"json",
                	success:function(result){
                		if (result.success){
                			$.toast("拍卖信息删除成功！","text");
                			location.href="/mine/publishedProduct/toMinePublishedPage?pageListType="+pageListType+"&v="+Math.random();
                		} else {
                			$.toast(result.msg,"text");
                		}
                	},
                	error:function(){
                		$.toast("操作异常，请联系管理员！","text");
                	}
                });

            }
        });
    }
    
    //已发布的商品查看详情
    function selectPublishedProductDetail(detailId,detailType){
    	location.href = "/mine/publishedProduct/selectPublishedProductDetail?detailId="+detailId+"&detailType="+detailType+"&v="+Math.random();
    }
    
    //获取分页数据
    function getPageData(firstClick){
 	   $.ajax({
 	        type: 'POST',
 	        url: '/mine/publishedProduct/queryPublishedProductPageList',
 	        data: "pageListType="+pageListType+"&page="+page+"&limit="+limit,
 	        dataType: 'json',
 	        success: function(data){
 	        	if (data.success){
 		            var objectList = data.data;
 		            //后台传来的格式化好的服务器时间
 		            var nowDate = data.msg;
 		            //后台传来的服务器时间毫秒数
 		            var nowDateMillionSeconds = data.nowDate
 		            var resultHtml ="";
 		            //总的数据长度
 		            var pageCount = data.pageCount;
 		            var recordCount = data.recordCount;
 		            var templateId;
 		            var boxClass;
 		            if ("havePublished" == pageListType){
 		            	templateId = "have_Published";
 		            	boxClass = "havepublished-box";
 		            	$("#havePublished").find(".Published-title").text("已发布（"+data.recordCount+"笔）");
	 		            if (recordCount == 0){
	 		            	$("#havePublished").find(".noData").show();
	 		            	$("#havePublished").find(".hideDiv2").hide();
 		            	} else {
	 		            	$("#havePublished").find(".noData").hide();
	 		            	$("#havePublished").find(".hideDiv2").show();
 		            	}
 		            } else {
 		            	templateId = "un_Published";
 		            	boxClass = "unpublished-box";
 		            	$("#unPublished").find(".Published-title").text("待发布（"+data.recordCount+"笔）");
	 		            if (recordCount == 0){
	 		            	$("#unPublished").find(".noData").show();
	 		            	$("#unPublished").find(".hideDiv1").hide();
	 		            } else {
	 		            	$("#unPublished").find(".noData").hide();
	 		            	$("#unPublished").find(".hideDiv1").show();
	 		            }
 		            }
 		            var productIdArr = [];
 		            $.each(objectList,function(index,item){
 		            	productIdArr.push(item.id);
 		            	item.nowDateMillionSeconds = nowDateMillionSeconds;
 		            	resultHtml += template(templateId,item);
 		            })
 		            $("."+boxClass).append(resultHtml);
 		            
 		            if (parseInt( page) >= parseInt(pageCount)){
 		            	 //销毁下拉插件
 		            	 $(document.body).destroyInfinite();
                         $(".weui-infinite-scroll").hide();
 		            } else if (parseInt(page) < parseInt(pageCount)){
 		            	if (firstClick == "firstClick"){
 		            		$(document.body).infinite(200);
 		            	}
 		           	 	page++;
 		            }
 		            
 		            $.each(productIdArr,function(i,n){
 		            	   var fromStartObj = $("span[productId='"+n+"']");
 		            	   if (!checkEmpty(fromStartObj) && fromStartObj.length > 0){
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
	 		                	 			location.href="/mine/publishedProduct/toMinePublishedPage?pageListType="+pageListType+"&v="+Math.random();
	 		                			 }
	 		                		 }
	 		                	  });
	 		                  });
 		            	  }
 		            });
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
    
    //引入外部函数
	template.helper('imgRealPath', function (imgPath) {
		if (new String(imgPath).indexOf( "http") == 0){
			return imgPath;
		} else {
			return imgServer + imgPath;
		}
	});
</script>
 
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>