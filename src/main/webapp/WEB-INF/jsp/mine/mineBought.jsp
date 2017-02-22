<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <meta name="description"
          content="Write an awesome description for your new site here. You can edit this line in _config.yml. It will appear in your document head meta (for Google search results) and in your feed.xml site description.">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>我买到的</title>
    <script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/weui.min.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/huadongjiazai.min.css"/>
    <link rel="stylesheet" type="text/css" href="/static/newhope/html/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="/static/newhope/html/css/myTradeRecord.css"/>
    <link rel="stylesheet" type="text/css" href="/static/newhope/html/css/font-awesome/css/font-awesome.min.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/myBuy.css"/>
    <script type="text/javascript"  src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>
    <script src="/static/newhope/html/js/dateutil.js?v=1.0"></script>
</head>
<body>

    <div id="warp">
        <div class="weui_tab">
            <div class="weui_navbar">
                <a href="#trading" class="weui_navbar_item weui_bar_item_on">
                    <span class="mySell active">交易中</span>
                </a>
                <a href="#completed" class="weui_navbar_item">
                    <span class="mybuy">完成</span>
                </a>
            </div>
            <div class="weui_tab_bd">
                <div id="trading" class="weui_tab_bd_item weui_tab_bd_item_active">
                    <p class="mysell-title">我买到的共<i>${totals}</i>笔，<span>交易中的记录（<i id="trading_records">0</i>笔）</span></p>
                    <ul class="tradingUl">
                        
                    </ul>
                </div>
                <div id="completed" class="weui_tab_bd_item">
                    <p class="mysell-title">我买到的共<i>${totals}</i>笔，<span>完成的记录（<i id="traded_records">0</i>笔）</span></p>
                    <div class="weui_cell">
                        <div class="weui_cell_bd weui_cell_primary">
                            <input class="weui_input" id="start" type="text" value="" placeholder="起始日期">
                            <span class="zhi">至</span>
                            <i class="fa fa-caret-down" aria-hidden="true"></i>
                        </div>
                        <div class="weui_cell_bd weui_cell_primary">
                            <input class="weui_input" id="end" type="text" value="" placeholder="终止日期">
                            <i class="fa fa-caret-down" aria-hidden="true"></i>
                        </div>
                        <div class="btnBox">
                        <input type="button" value="查询" id="search_btn"/>
                        </div>
                    </div>
                    <ul class="tradingUl">
                        
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <input type="hidden" value="${circleId}" id="cid">
    <div id="inline-calendar"></div>
    <div class="weui-infinite-scroll">
        <div class="infinite-preloader"></div>
        <span id="inLoading">正在加载...</span>
    </div>
    <!--jquery weui脚本-->
    <script type="text/javascript" src="/static/newhope/html/js/jquery-weui.min.js"></script>
      <script src="/static/newhope/html/js/template.js"></script>
    <script src="/static/newhope/html/js/fastclick.js"></script>
       <script src="/static/newhope/html/js/dateutil.js?v=1.0"></script>
         <script src="/static/trade/js/tradeCommon.js?v=1"></script> 
    <script id="temp1" type="text/html">
				<li class="tradingList">
							{{if status == 'JIAOGEZHONG'}}
							<div class="trading-head" data-id="{{id}}" onclick="toProductDetail(this)">
							{{else}}
                            <div class="trading-head" data-id="{{id}}" onclick="toDetail(this)">
							{{/if}}
                                <div>
                                    <p class="trading-date">{{gmtCreated}}</p>
                                    <p>{{count}}头（{{tradeProductInfoExModel.pigTypeDisplayName}}）</p>
                                </div>

                                <img class="trading-detail" src="/static/newhope/html/images/ic_list_detail.png"/>
                            </div>
                            <ul class="trading-info">
                                <li>卖家姓名：{{salerName}}</li>
                                <li>卖家电话：{{salerMobileStr}}</li>
                                <li class="trading-address"><span class="title">交割地址：</span><span class="detail">{{mapAddress}}</span></li>
                                <li class="trading-tel"><a href="tel:{{salerMobile}}">联系TA</a></li>
                                {{if status == 'JIAOGEZHONG'}}
									<li class="GPS" data-lat="{{lat}}" data-lng="{{lng}}" onclick="daohang('{{lat}}', '{{lng}}', '{{mapAddress}}')">导航</li>
								{{/if}}
                                {{if status == 'CEDAN'}}
									  <li class="stateImg"><img src="/static/newhope/html/images/ic_label_ycd_yx.png"/></li>
								{{/if}}
                                {{if status == 'PAODAN'}}
									<li class="stateImg"><img src="/static/newhope/html/images/ic_label_ypd_yx.png"/></li>
								{{/if}}
                                {{if status == 'JIAOGE'}}
									<li class="stateImg"><img src="/static/newhope/html/images/ic_label_yjg_yx.png"/></li>
								{{/if}}
                                <li class="fromWhere">来自{{circleName}}</li>
                            </ul>
                  </li>
	</script>
    <script>
        $(function() {
            FastClick.attach(document.body);
        });
    </script>
    <script type="text/javascript">
  //获取当天日期
    var myDate=new Date();
    var todayDate =myDate.getFullYear()+"-";
    todayDate += (String(myDate.getMonth()+1)).length==1?"0"+(myDate.getMonth()+1)+"-":(myDate.getMonth()+1)+"-";
    todayDate += String(myDate.getDate()).length==1?"0"+(myDate.getDate()):myDate.getDate();
    //console.log(todayDate);
        $("#start").calendar({
        	maxDate:todayDate,
            onChange: function (p, values, displayValues) {
            	$("#start").val(values[0]);
    	    	values[0] = values[0].replace(/\-/g, "/");	
    	    	//notSelect = values[0];
    	        $("#end").data("calendar").params.minDate=values[0];
    	        //86400000一天24小时毫秒数
    	        $("#start").data("calendar").value=displayValues;
            }
        });
        $("#end").calendar({
        	maxDate:todayDate,
            onChange: function (p, values, displayValues) {
            	$("#end").val(values[0]);
    	    	values[0] = values[0].replace(/\-/g, "/");	
    	    	//notSelect = values[0];
    	        $("#start").data("calendar").params.maxDate=values[0];
    	      //86400000一天24小时毫秒数
    	        $("#start").data("calendar").value=displayValues;
    	        //console.log(values[0]);
            }
        });
        $(".weui_navbar a").click(function () {
            $(this).children().addClass("active");
            $(this).siblings().children().removeClass("active");
        });

        
        //分页功能
        var loading = false;  //状态标记
        var page = 1;    //当前显示页数

        //每一页的显示数量
        var size = 6;
        var el1=$(".tradingUl:first");
        var el2=$(".tradingUl:last");
        var trading = "/mine/bought/list.json?type=1&circleId="+$("#cid").val();
        var traded =  "/mine/bought/list.json?type=&circleId="+$("#cid").val();
        var url_default;
        var el_default = el1;
        var start ="";
        var end = "";
        //页面初始化时，加载6条数据

        initialPage("GET",trading,el1,"trading","","");
        
$(".mySell").click(function(){
	start = "";
	end = "";
	el1.empty();
	el2.empty();
	page = 1;
	el_default =el1;
	url_default = trading;
	initialPage("GET",trading,el1,"trading","","");
})
$(".mybuy").click(function(){
	start = "";
	end = "";
	el1.empty();
	el2.empty();
	page = 1;
	el_default = el2;
	url_default = traded;
	initialPage("GET",traded,el2,"traded","","");
})


        function initialPage(type,url,el,t,start,end) {
			url_default = url;
            $("#inLoading").text("正在加载...");
            //data.pageIndex = page;
            //页面初始化时，加载8条数据
            $.ajax({
                type:type,
                url: url+"&pageIndex="+page+"&pageSize="+size+"&start="+start+"&end="+end,
                success: function(res){
                    //console.log(data.data);
                    if(res.success==true){
                        var result ="";
                        //总的数据长度
                        var dataLen = res.recordCount;
                        if(t == "trading"){
                        	$("#trading_records").html(dataLen);	
                        }else{
                        	$("#traded_records").html(dataLen);	
                        }
                        if(dataLen < 6){
                            //就只加载当前的数据
                            $(".weui-infinite-scroll").hide();
                            $(document.body).destroyInfinite();
                            for(var i = 0;i < dataLen;i++){
                            	res.data[i].gmtCreated = new Date(res.data[i].gmtCreated).pattern("yyyy-MM-dd");
                                result += template("temp1",res.data[i]);
                            }
                        }else{
                            for(var i = 0;i < size;i++){
                            	res.data[i].gmtCreated = new Date(res.data[i].gmtCreated).pattern("yyyy-MM-dd");
                                result += template("temp1",res.data[i]);
                            }
                        }
                        	el.append(result);


                    }else{
                        $(".infinite-preloader").hide();
                        $("#inLoading").text(res.msg);
                    }
                },error:function(XMLHttpRequest,textStatus, errorThrown){
                    if(textStatus == 'timeout'){
                        $.toast("连接超时", "text");
                        $(".infinite-preloader").hide();
                        $("#inLoading").hide();
                    }else{
                        $(".weui-infinite-scroll").hide();
                        $.toast("系统内部错误,请联系客服", "text");
                    }
                }
            });
        };

            //初始化以后，再去按照分页加载条数
            $(document.body).infinite().on("infinite", function() {
                $(".infinite-preloader").show();
                $("#inLoading").text("正在加载...");
                $("#inLoading").show();
                if(loading) return;
                loading = true;
                setTimeout(function() {
                    page++;
                    //search.pageIndex =page;
                    //发送请求，拿到json数据
                    $.ajax({
                        type: "get",
                        url: url_default+"&pageIndex="+page+"&pageSize="+size+"&start="+start+"&end="+end,
                        success: function(res){
                            if(res.success==true){
                                var result ="";
                                //总的数据长度
                                var dataLen = res.data.length;
                                //计算总的页数
                                var totalPage = res.pageCount;
                                for(var i = 0;i < dataLen;i++){
                                	res.data[i].gmtCreated = new Date(res.data[i].gmtCreated).pattern("yyyy-MM-dd");
                                    result += template("temp1",res.data[i]);
                                }
                                
                                el_default.append(result);


                                if(page > totalPage){
                                    $(document.body).destroyInfinite();
                                    $(".weui-infinite-scroll").hide();
                                }else{
                                    $(".weui-infinite-scroll").show();
                                }

                            }else{
                            	 page--;
                                $(".infinite-preloader").hide();
                                $("#inLoading").text(res.msg);
                            }
                        },error:function(XMLHttpRequest,textStatus, errorThrown){
                        	 page--;
                            if(textStatus == 'timeout'){
                                $.toast("连接超时", "text");
                                $(".infinite-preloader").hide();
                                $("#inLoading").hide();
                            }else{
                                $.toast("系统内部错误,请联系客服", "text");
                            }
                        }
                    });
                    loading = false;
                }, 1500);   //模拟延迟
            });
  function toDetail(obj){
	  location.href = "/trade/order/detial/"+$(obj).data("id");
  }          
  function toProductDetail(obj){
	  location.href = "/mine/bought/detail/"+$(obj).data("id");
  }          
  $("#search_btn").click(function(){
	 	start = $("#start").val();  
	 	end = $("#end").val();
/* 		if(checkEmpty(start) || checkEmpty(end)){
			alert("请选择查询日期");
			return;
		} */
		 el1.empty();
		 el2.empty();
		 page = 1;
		 el_default = el2;
		 initialPage("GET",traded,el2,"traded",start,end);
	
  })  
 template.helper('formatDate', function (date) {
	return new Date(date).pattern("yyyy-MM-dd");
}); 
  
  function daohang(lat, lng, mapAddress){
	  loadScript('', lat, lng, mapAddress)
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