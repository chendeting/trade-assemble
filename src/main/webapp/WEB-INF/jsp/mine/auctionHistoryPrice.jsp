<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta name="x5-orientation" content="portrait">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<meta charset="UTF-8">
<title>我的定价历史</title>
<link type="text/css" rel="stylesheet" href="/static/newhope/html/css/index.css">
<link type="text/css" rel="stylesheet" href="/static/trade/js/load/js/dropload.css">
<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
</head>
<body>


	<input type="hidden" id="circleId" value="${circleId }"/>
	<c:if test="${!empty circlePriceListMap}">
		<div class="contentDiv">
			<div id="lists">
				<c:forEach items="${circlePriceListMap}" var="circlePriceList">
					<div class="date">${circlePriceList.key}</div>
					<div class="load">
						<div style="width: 20rem; height: 6rem; background-color: #ffffff;">
							<div style="font-size: 0.777778rem; color: #4a90e2; width: 3.8rem; text-align: right; height: 2rem; line-height: 2rem; float: left; position: absolute;">V0价格</div>
							<div style="width: 1px; height: 0.6rem; background-color: #4a90e2; float: left; position: absolute; margin-left: 4.4rem; margin-top: 0.75rem;"></div>
							<c:forEach items="${circlePriceList.value }" var="circlePrice">
								<c:if test="${circlePrice.userLevel == 'V0' }">
									<div class="grounding_lishi">
										<span class="grounding_lishi_text"> ${circlePrice.weightDes}: </span> <span>
											<div class="grounding_lishi_input">
												<label class="label_small_1">${circlePrice.price}</label> <span>&nbsp;元</span>
											</div>
										</span>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<div class="line"></div>
						<div style="width: 20rem; height: 6rem; background-color: #ffffff;">
							<div style="font-size: 0.777778rem; color: #4a90e2; width: 3.8rem; text-align: right; height: 2rem; line-height: 2rem; float: left; position: absolute;">V1价格</div>
							<div style="width: 1px; height: 0.6rem; background-color: #4a90e2; float: left; position: absolute; margin-left: 4.4rem; margin-top: 0.75rem;"></div>
							<c:forEach items="${circlePriceList.value }" var="circlePrice">
								<c:if test="${circlePrice.userLevel == 'V1' }">
									<div class="grounding_lishi">
										<span class="grounding_lishi_text"> ${circlePrice.weightDes}: </span> <span>
											<div class="grounding_lishi_input">
												<label class="label_small_1">${circlePrice.price}</label> <span>&nbsp;元</span>
											</div>
										</span>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</c:if>
	<c:if test="${empty circlePriceListMap }">
		<div class="date">暂无历史定价信息</div>
	</c:if>
	<input type="hidden" id="nextPageIndex" value="${requestScope.currentPage+1 }"/>
	<input type="hidden" id="totalPages" value="${requestScope.totalPages }"/>
	 
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
<script type="text/javascript" src="/static/plug-in/layer/layer.js"></script> 
<script type="text/javascript" charset="utf-8" src="/static/trade/js/load/js/dropload.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('.contentDiv').dropload({
	        scrollArea : window,
	        loadDownFn : function(me){
		       	 if (parseInt($("#nextPageIndex").val()) > parseInt($("#totalPages").val())){
		       		 // 锁定
		             me.lock();
		             // 无数据
		             me.noData();
		             me.resetload();
		       	 } else {
		       		 getDataList(me);
		       	 }
	        }
	    });	
	});
	//点击加载更多数据
	function getDataList(me){
		$.ajax({
			   type: "POST",
			   url: "/mine/auctionHouse/queryPricePageList",
			   cache: false,
			   data: "circleId="+$("#circleId").val()+"&pageIndex="+$("#nextPageIndex").val()+"&pageSize=5",
			   dataType: "json",
			   success: function(data){
				   if(data == 'sessionTimeout'){
	                    location.href="/trade/mine/sessionTimeout.do?v="+Math.random();//跳转到session失效页面
	               }else if (data.success){
					   var map = data.data;
					   var html="";
					   $.each(map,function(mapKey,mapValue){
	  					   html += objectToHtml(mapKey,mapValue);
	  				   });
					   setTimeout(function(){
	                	   $("#lists").append(html);
	                	   me.resetload();
	                   },1000);
					   
		  			   $("#totalPages").val(data.pageCount);
		  			   $("#nextPageIndex").val(parseInt($("#nextPageIndex").val())+1);
				   } else {
					   layer.alert(data.msg);
				   }
				   
			   },
			   error : function() {
				   layer.alert("操作异常，请联系管理员！");
			   }
	 	});
	}
	
	//组装拼接html
	function objectToHtml(mapKey,mapValue){
		var html = 	'<div class="date">'+mapKey+'</div>'
				 + 	'<div class="load">'
				 +		'<div style="width: 20rem; height: 6rem; background-color: #ffffff;">'
				 +			'<div style="font-size: 0.777778rem; color: #4a90e2; width: 3.8rem; text-align: right; height: 2rem; line-height: 2rem; float: left; position: absolute;">V0价格</div>'
				 +			'<div style="width: 1px; height: 0.6rem; background-color: #4a90e2; float: left; position: absolute; margin-left: 4.4rem; margin-top: 0.75rem;"></div>';
		for(var i = 0; i < mapValue.length; i++){
			var circlePrice = mapValue[i];
			if (circlePrice.userLevel == "V0"){
				html +=		'<div class="grounding_lishi">'
					 +			'<span class="grounding_lishi_text"> '+circlePrice.weightDes+': </span>'
					 +			'<span>'
					 +				'<div class="grounding_lishi_input">'
					 +					'<label class="label_small_1">'+circlePrice.price.toFixed(2)+'</label> <span>&nbsp;元</span>'
					 +				'</div>'
					 +			'</span>'
					 +		'</div>';
			}
		}
		html+=			'</div>'
			+			'<div class="line"></div>'
			+			'<div style="width: 20rem; height: 6rem; background-color: #ffffff;">'
			+				'<div style="font-size: 0.777778rem; color: #4a90e2; width: 3.8rem; text-align: right; height: 2rem; line-height: 2rem; float: left; position: absolute;">V1价格</div>'
			+				'<div style="width: 1px; height: 0.6rem; background-color: #4a90e2; float: left; position: absolute; margin-left: 4.4rem; margin-top: 0.75rem;"></div>';
		for(var i = 0; i < mapValue.length; i++){
			var circlePrice = mapValue[i];
			if (circlePrice.userLevel == "V1"){
				html +=		'<div class="grounding_lishi">'
					 +			'<span class="grounding_lishi_text"> '+circlePrice.weightDes+': </span>'
					 +			'<span>'
					 +				'<div class="grounding_lishi_input">'
					 +					'<label class="label_small_1">'+circlePrice.price.toFixed(2)+'</label> <span>&nbsp;元</span>'
					 +				'</div>'
					 +			'</span>'
					 +		'</div>';
			}
		}
		html+=			'</div>'
			+		'</div>';
		return html;
				
	}
</script>
</html>