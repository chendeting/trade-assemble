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
    <title>录入发布信息</title>
    <script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/weui.min.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/huadongjiazai.min.css"/>
    <link rel="stylesheet" type="text/css" href="/static/newhope/html/css/common.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/chooseCircle.css"/>
    <script type="text/javascript" src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>
    <script src="/static/trade/js/tradeCommon.js?v=1"></script>
    <!--动态加载模块-->
    <script src="/static/newhope/html/js/template.js"></script>
</head>
<script type="text/html" id="temp1">
    <li class="circle-list" data-id="{{id}}" priceStatus="{{priceStatus}}">
        <img class="listImg" src="/static/newhope/html/images/btn_xq_radiubox_normal.png"/>
        <div class="circle-info-box">
        {{if img==""}}
        	<img src="/static/newhope/html/images/morentu.png"/>
        {{else}}
        <img src="{{getImgServer()}}{{img}}"/>
        {{/if}}
        <ul class="info-ul">
                <li class="circle-name" >
                    <span>{{name}}</span>

        {{if circleUser.isMaster==true}}
        <img src="/static/newhope/html/images/ic_lable_zjq.png"/>
        {{else}}
        <img src="/static/newhope/html/images/ic_lable_jrq.png"/>
        {{/if}}
        {{if circleType=="PRIVATE"}}
        <img class="sm" src="/static/newhope/html/images/ic_lable_sm.png"/>
        {{else}}
        <img class="sm" src="/static/newhope/html/images/ic_lable_sm.png" style="display:none"/>
        {{/if}}
                    </span>
                </li>
                <li class="activeness">活跃度
                    <img src="/static/newhope/html/images/ic_fire.png"/>
                    <img src="/static/newhope/html/images/ic_fire.png"/>
                    <img src="/static/newhope/html/images/ic_fire.png"/>
                </li>
                <li class="identity">
                 	   我的身份：卖家
                </li>
            </ul>
        </div>
    </li>
</script>
<body>
    <div id="warp">
        <div class="chooseCircle">
            <p class="haveChoose">已选择圈子：<span class="chooseTitle">江油生猪交易场</span></p>
            <p class="btn-p"><button class="ok-btn">确定</button></p>
        </div>
        <div class="search-box">
            <p>
                <input type="text" class="search-input" name="searchInput" placeholder="请输入你需要查找圈子的名称"/>
                <span class="search-btn">搜索</span>
            </p>
        </div>
        <ul class="circle-ul">

        </ul>
        <div class="weui-infinite-scroll">
            <div class="infinite-preloader"></div>
            <span id="inLoading">正在加载...</span>
        </div>
    </div>

    <script src="/static/newhope/html/js/jquery-weui.min.js"></script>

    <script type="text/javascript">
	//引入外部函数
	template.helper('getImgServer', function () {
		return '${imgServer}';
	});
        var txt_id = "";
        var priceStatus = "";
        //分页功能
        var loading = false;  //状态标记
        var page = 1;    //当前显示页数

        //每一页的显示数量
        var size = 6;

        function clickThing(){
        //点击li时，选中该圈子，并改变其选中图片
        var flag=false;
        $(".circle-list").click(function () {
        	var temId=$(this).attr("dada-id");
        	 priceStatus = $(this).attr("priceStatus");
        	if(temId==txt_id){
        		if(flag==false){
        			$(this).children("img").attr("src","/static/newhope/html/images/btn_xq_radiubox_selected.png");
        			$(this).siblings("li").children("img").attr("src","/static/newhope/html/images/btn_xq_radiubox_normal.png");
        				var circleName=$(this).find(".circle-name").children("span").text();
        					txt_id = $(this).attr("data-id");
        					$(".chooseTitle").html(circleName);
        					$(".chooseCircle").show();
        						flag=true;
        	   }else {
				        $(this).children("img").attr("src","/static/newhope/html/images/btn_xq_radiubox_normal.png");
				        $(".chooseTitle").html('');
				        txt_id = "";
				        flag=false;
				        };
        	}else{
        		$(".listImg").attr("src","/static/newhope/html/images/btn_xq_radiubox_normal.png");
        		$(this).children("img").attr("src","/static/newhope/html/images/btn_xq_radiubox_selected.png");
        		$(this).siblings("li").children("img").attr("src","/static/newhope/html/images/btn_xq_radiubox_normal.png");
        		var circleName=$(this).find(".circle-name").children("span").text();
        		txt_id = $(this).attr("data-id");
        		$(".chooseTitle").html(circleName);
       	 		$(".chooseCircle").show();
        		flag=true;
        }
        });
        }
        //页面初始化时，加载8条数据
        $.ajax({
            type: 'GET',
            url: '/trade/circle/list.json?pageIndex='+page+"&m=0&b=0&s=1&pageSize="+size+"&type=c",
            dataType: 'json',
            success: function(data){
                if(data.success==true){
                    page++;
                    var result ="";
                    //总的数据长度
                    var dataLen = data.data.totalCount;
                    if(dataLen <= 6){
                        //就只加载当前的数据
                        $(".weui-infinite-scroll").css("display","none");
                        $(document.body).destroyInfinite();
                    for(var i = 0;i < dataLen;i++){
                        result += template("temp1",data.data.objects[i]);
                    }
                    }else{
                        $(".weui-infinite-scroll").css("display","none");
                        for(var i = 0;i < size;i++){
                            result += template("temp1",data.data.objects[i]);
                        }
                    }

                    $(".circle-ul").html(result);
                    clickThing();

                }else{
                    $(".infinite-preloader").hide();
                    $("#inLoading").text(data.msg);
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
        });
        //初始化以后，再去按照分页加载条数
        $(document.body).infinite().on("infinite", function() {
            $(".weui-infinite-scroll").show();
            $(".infinite-preloader").show();
            $("#inLoading").text("正在加载...");
            $("#inLoading").show();
            if(loading) return;
            loading = true;
            var inputVal=$(".search-input").val();
            setTimeout(function() {
                page++;
                //发送请求，拿到json数据
                $.ajax({
                    type: 'GET',
                    url: '/trade/circle/list.json?pageIndex='+page+"&m=0&b=0&s=1"+"&name="+inputVal+"&pageSize="+size+"&type=c",
                    dataType: 'json',
                    success: function(data){
                        if(data.success==true){
                            var result ="";
                            //总的数据长度
                            var dataLen = data.data.objects.length;
                            //计算总的页数
                            var totalPage = data.data.totalPages;
                            for(var i = 0;i < dataLen;i++){
                                result += template("temp1",data.data.objects[i]);
                            }
                            $(".circle-ul").append(result);
                            clickThing();
                            if(page == totalPage){

                                $(document.body).destroyInfinite();
                                $(".weui-infinite-scroll").hide();
                            }else{
                                $(".weui-infinite-scroll").show();
                            }


                        }else{
                        	 page--;
                            $(".infinite-preloader").hide();
                            $("#inLoading").text(data.msg);
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
		$("button").click(function () {
			$(this).css("backgroundColor","#23943f");
		});
		$(".search-input").keydown(function () {
			$(this).css("color","#333");
		});
        $(".search-btn").click(function(){
                $(".circle-ul").empty();
                var inputVal=$(".search-input").val();
                $.ajax({
                    type: 'GET',
                    url: '/trade/circle/list.json?pageIndex=1&name='+inputVal+'&m=0&b=0&s=1&pageSize='+size+"&type=c",
                    dataType: 'json',
                    success: function(data){
                        if(data.success==true){
                            page++;
                            var result ="";
                            //总的数据长度
                            var dataLen = data.data.totalCount;
                            if(dataLen <= 6){
                            //就只加载当前的数据
                                $(".weui-infinite-scroll").css("display","none");
                                $(document.body).destroyInfinite();
                                for(var i = 0;i < dataLen;i++){
                                    result += template("temp1",data.data.objects[i]);
                                }
                            }else{
                                $(".weui-infinite-scroll").css("display","none");
                                for(var i = 0;i < size;i++){
                                    result += template("temp1",data.data.objects[i]);
                                }
                            }
                            $(".circle-ul").html(result);

                            //点击li时，选中该圈子，并改变其选中图片
                            var flag=false;

                            clickThing();
                        }else{
                            $(".infinite-preloader").hide();
                            $("#inLoading").text(data.msg);
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
                });
        })
        $(".ok-btn").click(function () {
        	if(checkEmpty(txt_id)){
        		$.toast("请选择圈子", "text");
        		return;
        	}
        	/* if(checkEmpty(priceStatus)||priceStatus !="1"){
        		$.toast("您选择的圈子还未定价", "text");
        		return;
        	} */
        	if(checkEmpty('${productId}')){
            	location.href="/trade/product/toPublishPage?source="+'${source}'+"&circleId="+txt_id+"&planId="+'${planId}'+"&productId=";
        	}else{
        		location.href="/mine/publishedProduct/toPublishedModifyPage?circleId="+txt_id+"&productId="+'${productId}';	
        	}
        })
    </script>
    <!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>