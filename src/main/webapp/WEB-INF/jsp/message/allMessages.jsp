<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <meta name="x5-orientation" content="portrait">
    <title>消息</title>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/weui.min.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/huadongjiazai.min.css"/>
    <link rel="stylesheet" type="text/css" href="/static/newhope/html/css/common.css"/>
    <!--<link type="text/css" rel="stylesheet" href="/static/newhope/html/css/myTradeRecord.css"/>-->
    <!--<link type="text/css" rel="stylesheet" href="/static/newhope/html/css/Published.css"/>-->
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/font-awesome/css/font-awesome.min.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/messages.css"/>
    <script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
    <script type="text/javascript" charset="UTF-8" src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>
    <script src="/static/newhope/html/js/jquery.downCount.js"></script>
    <!--动态加载模块-->
    <script src="/static/newhope/html/js/template.js"></script>
    
</head>

<body>


<script type="text/html" id="moreData">
{{each pagesObject.objects as obj i}}
	<li class="circle-msg">
		<p class="img-p" onclick="goCategory('{{obj.msgCategory}}', '{{obj.circleId}}')">
			{{if obj.msgCategory == 'SYSTEM'}}
				<img class="system-img-g" src="/static/newhope/html/images/system.png"/>
			{{else}}
				<img class="system-img-g" src="{{imgServer}}{{obj.circleModel.img}}"/>
			{{/if}}
			{{if obj.isReadPar == '0'}}
				<span class="haveMsg"></span>
			{{/if}}
		</p>
		
		<div class="clickDiv">
           <p class="msg-content" msgid={{obj.id}}>
			<span class="title">{{obj.titleDesc}}</span>
			<span class="content">{{obj.content}}</span>
           </p>
           <p class="time">{{obj.timeDesc}}</p>
           <p class="detail-p">
				{{if obj.url != null}}
					<div style="width:3rem;height:3rem;" onclick="goUrl('{{obj.url}}', {{obj.id}}, '{{obj.isReadPar}}', this)">
						<img class="detail-img" src="/static/newhope/html/images/arrow.png"/>
					</div>
				{{else}}
					{{if obj.isReadPar == '0'}}
						<span class="btn know" id="knowed">知道了</span>
					{{/if}}
				{{/if}}
           </p>
		</div>
	</li>
{{/each}}
</script>
<div class="msg-box">
    <ul class="msg-ul">
    </ul>
    <div class="weui-infinite-scroll">
        <div class="infinite-preloader"></div>
        <span id="inLoading">数据加载中...</span>
    </div>
</div>

<!-- 引入底部菜单 -->
<%@ include file="../menu/footMenu.jsp"%>

<script type="text/javascript" src="/static/newhope/html/js/jquery-weui.min.js"></script>
<script type="text/javascript">
    function allClick(){
        //设置消息头像居中
        $(".msg-ul li").each(function(){
            var liHeight=$(this).height();
            var imgHeight=$(this).find(".img-p").height();
            //console.log(imgHeight);
            //console.log(liHeight);
            var imgTop=((liHeight-imgHeight)/2+2)+'px';
            $(this).find(".img-p").css("margin-top",imgTop);
        });

        /* //点击不同的头像跳转到不同的页面
        $(".img-p").click(function(){
            if($(this).parent().hasClass("circle-msg")){
                location.href="cxl_circleMsg.html";
            }else if($(this).parent().hasClass("systemMsg-blue")){
                location.href="cxl_systemBlue.html";
            }else{
                location.href="cxl_systemGreen.html";
            }

        }); */
    }
    allClick();
</script>

<!-- 长按删除 -->
<script>
var timeOutEvent=0;
function longPressDel(){
    	$(".msg-ul li .msg-content").on({
            touchstart: function(e){
            	var obj = $(this);
                timeOutEvent = setTimeout(function(){
                    longPress(obj);
                },800);
                e.preventDefault();
            },
            touchmove: function(){
                clearTimeout(timeOutEvent);
                timeOutEvent = 0;
            },
            touchend: function(){
                clearTimeout(timeOutEvent);
                return false;
            }
        })
}
    function longPress(obj){
        timeOutEvent = 0;
        $.confirm({
            title: '',
            text: '删除该条消息？',
            onOK: function () {
            	//点击删除
            	$.ajax({
        			url : "/message/" + $(obj).attr("msgid"),
        			type : "DELETE",
        			cache : false,
        			success : function(data) {
        				if (data.flag == 'success') {
        					//隐藏标签
        					$(obj).parent().parent().hide();
        				} 
        			},
        			error : function() {
        				$.toast(data.msg, "text");
        			}
        		});
            },
            onCancel: function () {
                //点击取消
            }
        });
    }

</script>
<script type="text/javascript">
    //分页功能
    var loading = false;  //状态标记
    var page = 1;    //当前显示页数
    //每一页的显示数量
    var size = 6;
    //页面初始化时，加载8条数据
    $.ajax({
        type: 'GET',
        url: '/message/getAllMessagesPage.do',
        data : {
        	pageIndex : page,
        	pageSize : size
        },
        dataType: 'json',
        success: function(data){
            if(data.success==true){
            	//alert(JSON.stringify(data.pagesObject.objects));
                var result ="";
                //总的数据长度
                //console.log(data.data.totalCount);
                var dataLen = data.pagesObject.totalCount;
                if(dataLen <= 6){
                    //就只加载当前的数据
                    $(".weui-infinite-scroll").css("display","none");
                    $(document.body).destroyInfinite();
                    result = template("moreData", data);
                }else{
                	result = template("moreData", data);
                }
				//alert(result);
                $(".msg-ul").append(result);
                allClick();
                longPressDel();
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
        if(loading) return;
        $(".infinite-preloader").show();
        $("#inLoading").text("正在加载...");
        $("#inLoading").show();
        loading = true;
        page++;
        //发送请求，拿到json数据
        $.ajax({
            type: 'GET',
            url: '/message/getAllMessagesPage.do',
            data : {
            	pageIndex : page,
            	pageSize : size
            },
            dataType: 'json',
            success: function(data){
                loading = false;
                if(data.success==true){
                	console.log(111);
                    var result ="";
                    //总的数据长度
                    var dataLen = data.pagesObject.totalCount;
                    //计算总的页数
                    var totalPage = data.pagesObject.totalPages;
                    result = template("moreData", data);
                    $(".msg-ul").append(result);
                    allClick();
                    longPressDel();
                    //alert(page +" "+ totalPage);
                    if(page >= totalPage){
                        loading=true;
                        $(document.body).destroyInfinite();
                        //$(".weui-infinite-scroll").hide();
                        $(".infinite-preloader").hide();
                        $("#inLoading").text("没有更多数据了哟......");
                    }else{
                        $(".weui-infinite-scroll").show();
                    }

                }else{
                    page--;
                    $(".infinite-preloader").hide();
                    $("#inLoading").text(data.msg);
                }
            },error:function(XMLHttpRequest,textStatus, errorThrown){
                loading=false;
                if(textStatus == 'timeout'){
                    $.toast("连接超时", "text");
                    $(".infinite-preloader").hide();
                    $("#inLoading").hide();
                }else{
                    $.toast("系统内部错误,请联系客服", "text");
                }
            }
        });
    });

    function goCategory(category, circleId){
    	//alert(category);
    	if(category == 'SYSTEM'){
    		location.href = "/message/systemMessages.do?msgCategoryType="+category;
    	}else{
    		location.href = "/message/circleMessages.do?msgCategoryType="+category+"&circleId="+circleId;
    	}
    }
    
    function goUrl(url, id, isReadPar, obj){
    	//alert(isReadPar);
   		if(isReadPar == '0'){
    		$.ajax({
    			url : "/message/updateReadStatus?id=" + id,
    			type : "POST",
    			cache : false,
    			success : function(data) {
    				if (data.flag == 'succeed') {
    					//去掉未读标志
    					$(obj).siblings().find(".haveMsg").hide();
    					$(obj).find("#knowed").hide();
    					if(url){
    						location.href = url;
    					}
    				} 
    			},
    			error : function() {
    				$.toast(data.msg, "text");
    			}
    		});
   		}else{
			if(url){
				location.href = url;
			}
   		}
    }
    
  //引入底部菜单时赋值
  initAtag("message_a_tag");
</script>
 
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>









