    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    <title>我的交易圈</title>
    <script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/weui.min.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/huadongjiazai.min.css"/>
    <link rel="stylesheet" type="text/css" href="/static/newhope/html/css/common.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/myTradeCircle.css"/>
    <script type="text/javascript" src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>
    <!--动态加载模块-->
    <script src="/static/newhope/html/js/template.js"></script>
</head>
<body>

<script type="text/html" id="temp1">
    <li class="circle-list">
    <div class="info-img"><img src="/static/newhope/html/images/ic_list_detail.png"/></div>
    <div class="circle-info-box" data-id={{circleUser.id}} onclick="goDetialPage(this)">
        {{if img==""}}
        <img src="/static/newhope/html/images/morentu.png"/>
        {{else}}
        <img src="{{getImgServer()}}{{img}}"/>
        {{/if}}
            <ul class="info-ul">
                <li class="circle-name">
                    <span>{{name}}
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
                  {{if circleUser.isMaster == true}}
						{{if circleUser.isSaler == true}}
							我的身份：圈主&nbsp;卖家
						{{else if circleUser.isBuyer == true}}
							我的身份：圈主&nbsp;买家
						{{else}}
							我的身份：圈主
						{{/if}}
				  {{else}}
						{{if circleUser.isSaler == true}}
							我的身份：卖家
						{{else if circleUser.isBuyer ==true}}
							我的身份：买家
						{{else}}
							我的身份：未知
						{{/if}}
				  {{/if}}
                </li>
            </ul>
        </div>
    {{if isPrice==true && circleUser.isMaster == true}}
    <button class="unified-price" style="display: block" value="{{id}}" onclick="toSetPricePage(this)">
  	  统一定价
    </button>
    {{/if}}
	{{if isHaveApply==true && circleUser.isMaster==true}}
	<div class="redDot"></div>
	{{/if}}
    </li>
</script>
<body>
<div id="warp">
    <div class="chooseCircle" style="border-bottom: 0.0555rem solid #d8d8d8">
        <p class="haveChoose">交易圈数量（<span id="totalCircles">0</span>个）</span></p>
        <p class="btn-p"><button class="ok-btn">新建交易圈</button></p>
    </div>
    <ul class="circle-ul">

    </ul>

    <div class="weui-infinite-scroll">
        <div class="infinite-preloader">
        </div>
       <span id="inLoading">正在加载...</span>
    </div>
</div>
<script src="/static/newhope/html/js/jquery-weui.min.js"></script>

    <script type="text/javascript">
	template.helper('getImgServer', function () {
		return '${imgServer}';
	});
    var publishType = '${publishType}';
    //分页功能
    var loading = false;  //状态标记
    var page = 1;    //当前显示页数

    //每一页的显示数量
    var size = 7;

    //页面初始化时，加载7条数据
    $.ajax({
        type: 'GET',
        url: '/trade/circle/list.json?pageIndex='+page+"&m=1&b=1&s=1&pageSize="+size,
        dataType: 'json',
        success: function(data){
            if(data.success==true){
                $("#totalCircles").text(data.data.totalCount);

                var result ="";
                //总的数据长度
                var dataLen = data.data.totalCount;
                if(dataLen <= 7){
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

                $(".circle-ul").append(result);

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

        setTimeout(function() {
        page++;
            //发送请求，拿到json数据
            $.ajax({
                type: 'GET',
                url: '/trade/circle/list.json?pageIndex='+page+"&m=1&b=1&s=1&pageSize="+size,
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
                        if(page == totalPage){

                            $(document.body).destroyInfinite();
                            $(".weui-infinite-scroll").hide();
                        }else{
                            $(".weui-infinite-scroll").show();
                        }

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
            loading = false;
        }, 1500);   //模拟延迟
    });
    $("button").click(function () {

        $(this).css("backgroundColor","#23943f");
    });
    $(".search-input").keydown(function () {

        $(this).css("color","#333");
    });
    $(".ok-btn").click(function () {

    	location.href= "/trade/circle/handlercircle";

    });
    function toSetPricePage(o){
    	location.href = "/circle/circlePrice//toCirclePriceSettingPage?circleId="+$(o).val();
    }
    function goDetialPage(o){
    	location.href = "/user/userCircle/joinedCircleDetail?circleUserId="+$(o).data("id");	
    }
    </script>
      
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>