<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
<title>卖猪信息</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <title></title>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/index.css">
    <link rel="stylesheet" href="/static/trade/js/load/js/dropload.css">	 
    <style type="text/css">
        ::-webkit-scrollbar{width:0px}
        li{list-style-type: none;
        }
.err-msg{
width:20rem;
height: 2rem;
text-align: center;
line-height:2rem;
color: #848689;
font-size:0.8rem;
margin-top: 0.5rem;
position: absolute;
}
    </style>
</head>
<body >
<div class="box">
   <div style="background-color: RGB(221,221,221)">
    <div class="swiper-container">
        <div class="swiper-wrapper" style="width:33rem;" >
           <ul>
             <c:if test="${hasEndDate == true}">
               <li class="swiper-li">
              	 <button class="swiper-slide swiper_btn">
              	   <span>已结束</span>
              	   <c:choose>
              	   <c:when test="${empty dateList }">
                   <div class="xiahuaxian" style="display: block;"></div>
              	   </c:when>
              	   <c:otherwise>
              	    <div class="xiahuaxian" style="display: none;"></div>
              	   </c:otherwise>
              	   </c:choose> 
                   <input type="hidden" value=""/>
              	 </button>
               </li>
             </c:if>
              <c:forEach items="${dateList}" var="date" varStatus="num">
              <c:choose >
              	<c:when test="${num.index == 0}">
             	  <li class="swiper-lion on">
                     <button class="swiper-slide swiper_btn">
                     	<span><fmt:formatDate value="${date}" pattern="MM月dd日" /></span>
                        <div class="xiahuaxian" style="display: block;"></div>
                         <input type="hidden" value="<fmt:formatDate value="${date}" pattern="yyyy-MM-dd" />">
                     </button>
                     <input type="hidden" id="searchDate" value="<fmt:formatDate value="${date}" pattern="yyyy-MM-dd" />">
             	 </li>
                </c:when>	
              	<c:otherwise>
              		<li class="swiper-lion">
                     <button class="swiper-slide swiper_btn">
                     <span><fmt:formatDate value="${date}" pattern="MM月dd日" /></span>
                       <div class="xiahuaxian" style="display: none"></div>
                     <input type="hidden" value="<fmt:formatDate value="${date}" pattern="yyyy-MM-dd" />">
                     </button>
             		</li>
             	 </c:otherwise>
              </c:choose>
              </c:forEach>
            </ul>
        </div>
    </div>
   </div> 
 <div class="part" style="position: absolute;font-family: 'Microsoft YaHei';">
</div>
</div>
 
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
<script type="text/javascript" charset="UTF-8" src="/static/newhope/html/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
<script type="text/javascript" src="/static/newhope/html/js/dateutil.js"></script>
<script type="text/javascript" src="/static/trade/js/tradeCommon.js"></script>
<script src="/static/trade/js/load/js/dropload.min.js"></script>	
<script type="text/javascript" charset="utf-8" src="/static/plug-in/layer/layer.js"></script> 
<script type="text/javascript">
var totalPage = 1;
var pageSize = 5;
var currentPage = 0;
var imgDomain = '${imgDomain}';
var date = $("#searchDate").val();
$(function(){
	if(date == undefined && '${hasEndDate}' == 'true'){
		date = "";
	}else if(date == undefined && '${hasEndDate}' == 'false'){
		$(".part").append('<div class="err-msg">没有可用的拍卖场信息了</div>');
		return;
	}
	//loadData(date,false,"");
    $(".swiper_btn").click(function(){
    	//加载数据
		layer.load(1,{
			time: 5000,
			shade: [0.3, '#000000']
		});
    	 //控制分页索引
    	 totalPage = 1;
    	 currentPage = 0;
    	 //移除日期button被选中样式
    	 $(".swiper-wrapper li").removeClass("on");
    	 //添加目标button被选中样式
         $(this).parent().addClass("on");
    	 //移除下划线
    	 $(".xiahuaxian").hide();
    	 //添加被选中下划线
         $(this).children().eq(1).show();
         date = $(this).find("input").val();
         $(".swiper_btn").prop("disabled",false);
	     $(this).prop("disabled",true);
         var part = $(".part");
         dropLoad(part);
    });
    
    dropLoad();
})

//根据日期加载数据
function loadData(searchDate,isAppend,me){
	$(".err-msg").remove();
	$(".dropload-load").parent().remove();
	var part = $(".part");
	if(null != currentPage && totalPage>currentPage){
		++currentPage;
		//清空.part div
		if(!isAppend){
    		part.empty();
		}
	$.ajax({
	   type:"GET",
	   url:"/trade/auctiondata?date="+searchDate+"&pageIndex="+currentPage,
	   cache:false,
	   //async: false,
	   success:function(result){
		//如果出现错误，则展示错误信息
		if(checkObjNotEmpty(result)){
		if(result.success == false){
			--currentPage;
			var resultMsg = result.msg;
			if(checkEmpty(resultMsg)){
				resultMsg = "猪小易正在优化,请稍后再试......";
			}
			part.append("<div class='err-msg'>"+resultMsg+"</div>");
			if (!checkEmpty(me)){
				me.lock();
				me.noData();
				me.resetload();
				$(".dropload-down").empty();
				$(".dropload-down").hide();
				  //关闭加载弹出框
	  			   layer.closeAll();
			}
		}else{
			//setTimeout(function(){$(".dropload-load").parent().remove();}, 1000);
			//根据 ajax返回的数据，设置前台总页数值
			totalPage = result.pageCount;
			var deal_buy = $("<div class='deal_buy'></div>");
			
			$.each(result.data, function(index, auction) {
				if(checkObjNotEmpty(auction)){
				deal_buy.append("<div class='wall'></div>");
				var directUrl = "/trade/product/buypage?circleId="+auction.circleId+"&auctionDate="+new Date(auction.bidTime).pattern("yyyy-MM-dd")+"&name="+auction.auctionName;
				var deal_buy_3 = $("<div class='deal_buy_3' onclick='javascript:location.href=\""+directUrl+"\"'></div>");
				//var deal_buy_3 = $("<div class='deal_buy_3' uri='/trade/product/buypage?circleId="+auction.circleId+"&auctionDate="+new Date(auction.bidTime).pattern("yyyy-MM-dd")+'"></div>");
				
				if(checkObjNotEmpty(auction.auctionImg)){
				deal_buy_3.append("<div class='deal_buy3_pic' style='width:5rem;height: 5rem;border-radius: 0.2rem;'><img src='"+imgDomain+'/crop/100/100'+auction.auctionImg+"' style='width:5rem;height: 5rem;border-radius: 0.2rem;'/></div>");
				}else{
				deal_buy_3.append("<div class='deal_buy3_pic' style='width:5rem;height: 5rem;border-radius: 0.2rem;'><img src='/static/newhope/html/images/Group@2x.png' style='width:5rem;height: 5rem;border-radius: 0.2rem;'/></div>");
					
				}
				var  deal_buy3_text = $('<div class="deal_buy3_text"></div>');
				deal_buy3_text.append("<div class='deal_zhuchang'>"+auction.auctionName+"</div>");
				deal_buy3_text.append("<div class='deal_time'><span>开拍时间:</span><span >&nbsp;&nbsp;"+new Date(auction.bidTime).pattern("yyyy-MM-dd")+"</span><span style='margin-left: 4px;'>&nbsp;"+new Date(auction.bidTime).pattern("hh:mm:ss")+"</span></div>");
				deal_buy3_text.append("<div class='deal_pin'><span>品类:</span><span >&nbsp;&nbsp;"+auction.pigCategoryName+"</span></div>");
				deal_buy3_text.append("<div class='deal_pin'><span>品级:</span><span>&nbsp;&nbsp;"+auction.pigLevelName+"</span></div>");
				if(checkObjNotEmpty(date)){
				  deal_buy3_text.append("<div class='deal_number'><span >数量:</span><span style='color:#F02B2B'><span style='font-size: 1rem;'>&nbsp;"+auction.totalSurplusNumber+"</span>头</span></div>");
				}
				
				deal_buy_3.append(deal_buy3_text);
				
				deal_buy.append(deal_buy_3);
				
				part.append(deal_buy);
				}
			});
			
			if (!checkEmpty(me)){
				me.resetload();
			}
			  //关闭加载弹出框
			   layer.closeAll();
		}
	   }else{
		   part.append("<div class='err-msg'>猪小易正在优化,请稍后再试...</div>");   
	   }
	   },
	   error:function(result){
		   currentPage=0;
		   var part = $(".part");
			//清空.part div
			part.empty();
			if(checkObjNotEmpty(result.msg)){
			part.append("<div class='err-msg'>"+result.msg +"</div>");
			}else{
			part.append("<div class='err-msg'>猪小易正在优化,请稍后再试...</div>");  	
			}
			  //关闭加载弹出框
		    layer.closeAll();
	   }
		
	})
	}else{
		--currentPage;
		var deal_buy = $(".deal_buy_3");
			if(deal_buy.length > pageSize || deal_buy.length == 0){
			part.append("<div class='err-msg'>没有更多拍卖场信息了...</div>")	
		}
		//内有更多数据
		return;
	}
}
function dropLoad(part){
	if(!checkEmpty(part)){
		part.empty();
	}
	  $('.box').dropload({
	        scrollArea : window,
	        loadDownFn : function(me){
	        loadData(date,true,me);
    }
	 });
}

/* $(document).on('click','.deal_buy_3',function(){
	var uri = $(this).attr("uri");
	if(checkObjNotEmpty(uri)){
		location.href=uri;
	}
}) */
</script>
</html>