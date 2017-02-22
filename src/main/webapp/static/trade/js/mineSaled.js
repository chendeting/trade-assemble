//筛选卖场之前的菜单
var beforeBtnId;

var meObject;
$(function(){
    //正在进行点击事件
	$(".menu_sell_btn_1").click(function(){
		//加载中
    	layer.load(1, {
    		time: 5000,
    		shade: [0.5, '#000000']
    	});
		$("#totalPages").val("1");
		$("#nextPageIndex").val("1");
		
		$("#lists").empty();
		$(".menu_part3" ).hide();
		
		$(".menu_sell li").removeClass("on");
		$(this).parent().addClass("on");
		
		beforeBtnId = "";
		
		$(".dropload-down").empty();
		
		if ($(this).attr("id") == "menu_btn1"){
			getDataList(false);
		} else if ($(this).attr("id") == "menu_btn2"){
			getDataList(true);
		}
		
	});
    
    //筛选卖场
    $( "#menu_btn4" ).click( function() {
		$(".menu_part3" ).toggle();
		if ($(".menu_sell .on").find("button").attr("id") != "menu_btn4"){
			beforeBtnId = $(".menu_sell .on").find("button").attr("id");
			$(".menu_sell li").removeClass("on");
		} else {
			$("#"+beforeBtnId).parent().addClass("on");
		}
		
		$(this).parent().toggleClass("on");
	} );
    
    //上拉刷新
    dropLoad("menu_part1");
});

//上拉刷新
function dropLoad(divClass){
	$('.'+divClass).dropload({
        scrollArea : window,
        loadDownFn : function(me){
        	 meObject = me;
	       	 if ($("#nextPageIndex").val() > $("#totalPages").val()){
	       		 // 锁定
	             me.lock();
	             // 无数据
	             me.noData();
	             me.resetload();
	       	 } else {
	       		if ( $(".on > button").attr("id") == "menu_btn1" ){
	    			getDataList(false,me);
	    		} else if ( $(".on > button").attr("id") == "menu_btn2" ){
	    			getDataList(true,me);
	    		}
	       	 }
        }
    });
}

//点击正在进行，历史订单获取数据
function getDataList(isHistory,me){
	var data = "isHistory="+isHistory+"&pageIndex="+$("#nextPageIndex").val()+"&pageSize=5";
	if ( !checkEmpty($("#circleId").val()) ){
		data += "&circleId="+$("#circleId").val();
	}
	$.ajax({
	   type: "POST",
	   url: "/mine/saledProduct/querySaledProductList",
	   cache: false,
	   data: data,
	   dataType: "json",
	   success: function(data){
		   if(data == 'sessionTimeout'){
               location.href="/trade/mine/sessionTimeout.do?v="+Math.random();//跳转到session失效页面
           }else if (data.success){
			   $("#totalPages").val(data.pageCount);
			   $("#nextPageIndex").val(parseInt($("#nextPageIndex").val())+1);
			   $("#unHistoryMoreData").remove();
			   $("#historyMoreData").remove();
			   
			   var map = data.data;
  			   var html = '';
  			   if (isHistory){
  				   $.each(map,function(mapKey,mapValue){
  					   //历史订单
  					   html += historyObjectToHtml(mapKey,mapValue);
  				   });
  				   
  			   } else{
  				   $.each(map,function(mapKey,mapValue){
  					   //正在进行订单
					   html += unHistoryObjectToHtml(mapKey,mapValue);
				   });
  				 
  			   }
  			   
  			   if (checkEmpty(me)){
  				   $("#lists").append(html);
  			   } else {
  				   setTimeout(function(){
  					   $("#lists").append(html);
  					   me.resetload();
  				   },1000);
  			   }
  			 
  			   if (checkEmpty(me)){
		  			if (parseInt($("#nextPageIndex").val()) <= parseInt($("#totalPages").val())){
		  				if (!checkEmpty(meObject)){
			  				meObject.unlock();
			  				meObject.noData(false);
		  				}
		  				$(".dropload-down").empty().append("<div class='dropload-refresh'>↑上拉加载更多</div>");
		  			} else{
		  				if (!checkEmpty(meObject)){
		  					meObject.lock();
			  				meObject.noData();
		  				}
		  				$(".dropload-down").empty().append("<div class='dropload-refresh'>暂无更多数据</div>");
		  			}
		  			if (!checkEmpty(meObject)){
		  				meObject.resetload();
		  			}
  			   }
  			   //关闭加载弹出框
  			   layer.closeAll();
		   } else {
			   //关闭加载弹出框
  			   layer.closeAll();
  			   
			   layer.alert(data.msg);
		   }
		   
	   },
	   error : function() {
		   //关闭加载弹出框
		   layer.closeAll();
	       layer.alert("操作异常，请联系管理员！");
	   }
   });
}

//组装拼接正在进行html
function unHistoryObjectToHtml(mapKey,mapValue){
	var html = "";
	if($("#lists").find("div.date[bidTime='"+mapKey+"']").length == 0){
		html = 		'<div class="date" bidTime="'+mapKey+'">'+mapKey+'</div>';
	} 
    for (var i = 0; i < mapValue.length; i++){
	   var tradeProduct = mapValue[i];
	   html += 		'<div class="massage">'
	   		+ 			'<div class="massage_body" >'
	   		+				'<div onclick="toSaledProductInfo('+tradeProduct.id+')">';
	   var farmerName = tradeProduct.farmerName;
	   if (checkEmpty(farmerName)){
		   farmerName = "";
	   }
	   html	+= 					'<div class="massage_text_head">' + farmerName + '的猪场</div>'
	   		+ 					'<div class="massage_text_body">'
            + 						'<span>地址:</span>'
            + 						'<span style="margin-left: 4px;">'
        	+ 						tradeProduct.pigFaramAddress.provName+tradeProduct.pigFaramAddress.cityName+tradeProduct.pigFaramAddress.countyName
        	+ 						'</span>'
        	+					'</div>'
        	+				'</div>'
			+  				'<div class="massage_text_body">'
			+					'<span>买猪人:</span>'
			+ 					'<span style="margin-left: 4px;">';
		var exOrderList = tradeProduct.exOrderList;
		if( null != exOrderList && exOrderList.length > 0 ) {
			for( var j = 0; j < exOrderList.length; j++ ) {
				 var exOrder = exOrderList[j];
				 var buyUserRealName=exOrder.buyUserRealName;
				 if (checkEmpty(buyUserRealName) ){
					 buyUserRealName = "";
				 }
				 html += 			buyUserRealName
				 	  +				'(' + exOrder.totalCount + '头)';
				 if (j < exOrderList.length-1){
					 html +=		'、';
				 }  
			}
		}
		html +=					'</span>'
			 +				'</div>'	
			 + 				'<div class="massage_text_buttom">'
       		 + 					'<span >卖出:</span>'
       		 + 					'<span style="margin-left: 1rem;color: red">';
		var bidedNumber = tradeProduct.bidedNumber;
       	if (tradeProduct.bidedNumber == null || tradeProduct.bidedNumber == "null"){
       		bidedNumber = 0;
       	}
       	html +=						'<span style="font-size: 1rem;">' + bidedNumber + '</span>头'
       		 + 					'</span>'
       		 + 					'<span style="margin-left: 1rem;color: #3884ff">（剩余' + tradeProduct.surplusNumber + '头）  </span>'
       		 + 				'</div>';
       	if( null != exOrderList && exOrderList.length > 0 ) {
       		 html += 		'<a href="/mine/saledProduct/selectSaledProductDetail?productId='+tradeProduct.id+'">'
       		 	  + 			'<button class="massage_text_btn">交易详情</button>'
       		      + 		'</a>';
       	}
       	html +=			'</div>'
       		 + 			'<div class="wall"></div>'
   			 + 		'</div>';
    }
    return html;
}

//组装拼接历史订单
function historyObjectToHtml(mapKey,mapValue){
	var html = "";
	if($("#lists").find("div.date[bidTime='"+mapKey+"']").length == 0){
		html = 		'<div class="date" bidTime="'+mapKey+'">'+mapKey+'</div>';
	} 
    for (var i = 0; i < mapValue.length; i++){
	   var tradeProduct = mapValue[i];
	   html += 		'<div class="massage">'
	   		+ 			'<div class="massage_body1" >'
	   		+				'<div style="margin-left: 0.4rem;">'
	   		+					'<div onclick="toSaledProductInfo('+tradeProduct.id+')">';
	   var farmerName = tradeProduct.farmerName;
	   if (checkEmpty(farmerName)){
		   farmerName = "";
	   }
	   html	+= 						'<div class="massage_text_head">' + farmerName + '的猪场</div>'
	   		+ 						'<div class="massage_text_body">'
            + 							'<span>地址:</span>'
            + 							'<span style="margin-left: 4px;">'
        	+ 								tradeProduct.pigFaramAddress.provName+tradeProduct.pigFaramAddress.cityName+tradeProduct.pigFaramAddress.countyName
        	+ 							'</span>'
        	+						'</div>'
        	+					'</div>'
		    + 					'<div class="massage_text_body1">'
			+						'<span>买猪人:</span>'
			+ 						'<span style="margin-left: 0.3rem;">';
		var exOrderList = tradeProduct.exOrderList;
		if( null != exOrderList && exOrderList.length > 0 ) {
			for( var j = 0; j < exOrderList.length; j++ ) {
				 var exOrder = exOrderList[j];
				 var buyUserRealName=exOrder.buyUserRealName;
				 if (checkEmpty(buyUserRealName) ){
					 buyUserRealName = "";
				 }
				 html += 			buyUserRealName
				 	  +				'(' + exOrder.totalCount + '头)';
				 if (j < exOrderList.length-1){
					 html +=		'、';
				 }  
			}
		}
		html +=						'</span>'
			 +					'</div>'
		     +					'<div style="height: 0.6rem; margin: auto;"></div>'
			 +				'</div>'
			 +			'</div>'
			 +			'<div class="massage_body2">'
			 +				'<div style="margin-left: 0.4rem; position: absolute; float: left;">'
        	 + 					'<div class="massage_text_buttom1">'
       		 + 						'<span style="font-size: 0.833333rem;">卖出:</span>'
       		 + 						'<span style="margin-left: 0.3rem;color: red">';
		var bidedNumber = tradeProduct.bidedNumber;
       	if (tradeProduct.bidedNumber == null || tradeProduct.bidedNumber == "null"){
       		bidedNumber = 0;
       	}
       	html +=							'<span style="font-size: 1rem;">' + bidedNumber + '</span>头'
       		 + 						'</span>'
       		 + 						'<span style="margin-left: 0.2rem;color: #3884ff">（剩余' + tradeProduct.surplusNumber + '头）  </span>'
       		 + 					'</div>';
       	if( null != exOrderList && exOrderList.length > 0 ) {
      		 html += 			'<a href="/mine/saledProduct/selectSaledProductDetail?productId='+tradeProduct.id+'">'
      		 	  + 				'<button class="massage_text_btn" style="margin-top: -0.7rem;">交易详情</button>'
      		      + 			'</a>';
      	}
      	html += 			'</div>'
       		 +			'</div>'
       		 + 			'<div class="wall"></div>'
   			 + 		'</div>';
    }
    return html;
}

//点击拍卖场触发
function changeCircle(thisObj){
	$(".maichang_btn").removeClass("clicked");
	$(thisObj).addClass("clicked");
	$(".maichang_btn:not(.clicked)").removeClass("on");
	$(thisObj).toggleClass("on");
}

//筛选拍卖场点击确认、重置按钮
function reloadData(flag){
	if (flag == "reset"){
		$("#circleId").val("");
		$(".maichang_btn").removeClass("on");
	} else if (flag == "confirm"){
		$("#circleId").val($(".maichang_btn_bg").find(".on").attr("circleId"));
		if (undefined == beforeBtnId || "" == beforeBtnId 
				|| null == beforeBtnId || "null" == beforeBtnId){
			layer.alert("您当前没有数据，无需切换拍卖场");
			return;
		}
		$("#"+beforeBtnId).click();
	}
}

//跳转到商品详情
function toSaledProductInfo(productId){
	location.href="/mine/saledProduct/toSaledProductInfo?productId="+productId;
}
