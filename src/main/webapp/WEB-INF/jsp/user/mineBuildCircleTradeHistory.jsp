<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<meta name="format-detection" content="telephone=no">
<meta name="description"
          content="Write an awesome description for your new site here. You can edit this line in _config.yml. It will appear in your document head meta (for Google search results) and in your feed.xml site description.">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>本圈交易历史</title>
<link type="text/css" rel="stylesheet" href="/static/newhope/html/css/weui.min.css"/>
<link type="text/css" rel="stylesheet" href="/static/newhope/html/css/huadongjiazai.min.css"/>
<link rel="stylesheet" href="/static/newhope/html/css/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="/static/newhope/html/css/common.css"/>
<link type="text/css" rel="stylesheet" href="/static/newhope/html/css/myTradeHistory.css"/>
<script type="text/javascript" src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
<script src="/static/newhope/html/js/template.js"></script>
<script type="text/javascript" src="/static/trade/js/tradeCommon.js"></script>
<script src="/static/newhope/html/js/jquery-weui.min.js"></script>
<style type="text/css">
</style>
</head>
<script type="text/html" charset="UTF-8" id="auction_Member">
    <li class="tradeHistory-list">
        <div class="single-title" data-pid='{{id}}' onclick="toDetail(this)">
               <p class="sale-time">拍卖时间:<span>{{bidTime | dateFormat:'yyyy-MM-dd'}}</span></p>
               <p class="saler-name">卖方姓名:<span>{{userInfoModel.name}}</span></p>
			   <img src="/static/newhope/html/images/ic_list_detail.png"/>
		</div>
		<ul class="detail-ul">
            <li><span>发布数量：</span>{{marketingNumber}}</li>
            <li><span>购买人数：</span>{{buyUserCount}}</li>
            <li><span>订购数量：</span>{{bidedNumber}}</li>
            <li><span>交割数量：</span>{{deliveryNum}}</li>
        </ul>
            <div class="history_list1_icon" style="display:none;"></div>
        </div>
        <div class="status-img">
				{{if status == 'IN_TRADING'}}
                	<img src="/static/newhope/html/images/ic_lable_jyz_ys.png"/>
				{{else if status == 'IN_DELIVERY'}}
                	<img src="/static/newhope/html/images/ic_lable_jgz_ys.png"/>
				{{else if status == 'COMPLETE'}}
                	<img  src="/static/newhope/html/images/ic_wc.png"/>
				{{/if}}
		</div>
	</li>
</script>
<body>
    <div id="warp">
        <p class="allTrade" id="totalProductCount">交易记录(<span>0</span>笔)</p>
        <ul class="trade-ul" id="jiaoyijilu">
        </ul>
    </div>
	<div class="weui-infinite-scroll">
		<div class="infinite-preloader"></div>
		信息加载中...
	</div>
	<!--加载-->
	<script type="text/javascript" charset="UTF-8">
		var circleId = '${circleId}';
		$( document.body ).infinite( 500 );

		var loading = false; //状态标记
		var page = 1; //当前显示页数

		//每一页的显示数量
		var limit = 5;
		
		$(function(){
		    //加载模板数据，分页功能
		    $(document.body).infinite(500);
		    //初始化数据
		    getPageData();
		    
		});
		
		//初始化以后，再去按照分页加载条数
	    $(document.body).infinite().on("infinite", function() {
	        if(loading) return;
	        loading = true;
	        setTimeout(function() {
	        	getPageData();
	            loading = false;
	        }, 1000);   //模拟延迟
	    });
		
	    //获取分页数据
	    function getPageData(){
	 	   $.ajax({
	 	        type: 'POST',
	 	        url: '/user/userCircle/queryCirlceTradeHistoryPage',
	 	        data: "circleId="+circleId+"&page="+page+"&limit="+limit,
	 	        dataType: 'json',
	 	        success: function(data){
	 	        	if (data.success){
	 		            var objectList = data.data;
	 		            var resultHtml ="";
	 		            //总的数据长度
	 		            var pageCount = data.pageCount;
	 		            $("#totalProductCount").text("交易记录 ("+data.recordCount+"笔)");
	 		            $.each(objectList,function(index,item){
	 		            	resultHtml += template("auction_Member",item);
	 		            })
	 		            
	 		            if (parseInt( page) >= parseInt(pageCount)){
	 		            	 //销毁下拉插件
	 		            	 $(document.body).destroyInfinite();
	                         $(".weui-infinite-scroll").hide();
	 		            } else if (parseInt(page) < parseInt(pageCount)){
	 		           	 	page++;
	 		            }
	 		            $("#jiaoyijilu").append(resultHtml);
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
	    
	function toDetail(obj){
		var productId = $(obj).data("pid");
		location.href = "/user/userCircle/queryBuildCirlceOderDetail?productId="+productId+"&v="+Math.random();
	}    
	    
	</script>
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>