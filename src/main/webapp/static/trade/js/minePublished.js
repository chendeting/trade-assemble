//图片服务器
var imgServer = $("#imgServer").val();

var meObject;
$(function(){
	 $( ".swiper-slide" ).click( function() {
		//加载中
    	layer.load(1, {
    		time: 5000,
    		shade: [0.5, '#000000']
    	});
		
		if( $( this ).attr( "id" ) == "swiper_btn2" ) {
			getCountDown();
			$( ".part > .daojishi" ).show();
		} else {
			$( ".part > .daojishi" ).hide();
		}
		$( ".deal_buy" ).find( "div.deal_shangjia" ).remove();
		$( ".part" ).find( "div.endProductDiv" ).remove();
		$( ".swiper-wrapper li" ).removeClass( "on" );
		$( this ).parent().addClass( "on" );
		$( ".xiahuaxian" ).hide();
		$( this ).find( "div.xiahuaxian" ).show();

		$( "#totalPages" ).val( "1" );
		$( "#nextPageIndex" ).val( "1" );

		var isEnd = false;
		var beginSearchDateStr = "";
		// 如果是已结束
		if( $( this ).attr( "id" ) == "swiper_btn1" ) {
			isEnd = true;
		} else {
			// 如果是具体日期
			beginSearchDateStr = $( ".on > button" ).attr( "auctionDate" );
		}

		$(".dropload-down").empty();
		
		getDataList( isEnd, beginSearchDateStr );
		
	} );
	 
	//如果是自己的价格，并且有商品，出现倒计时
	if ($(".on").hasClass("swiper-li2")){
		getCountDown();
	}
     
     //下拉刷新
     dropLoad();
     
});

//获取倒计时
function getCountDown(){
	$.ajax({  
        type: "POST",  
        url: "/mine/publishedProduct/selectCountDown",
        data: "specifiedDateStr="+$("#swiper_btn2").attr("auctionDate"),  
        dataType: "json",  
        success: function(data){
        	if(data == 'sessionTimeout'){
                location.href="/trade/mine/sessionTimeout.do?v="+Math.random();//跳转到session失效页面
            }else if (data.success){
           		var dataDiffMap = data.data;
           		//dateDiffMillions为map中的键
           		$( ".part > .daojishi" ).show();
           		$("#dateDiffText").text(data.msg);
           		if (dataDiffMap != null){
           			for (var dateDiffMillions in dataDiffMap){
           				$("#dateDiff").attr("dateDiffMillions",dateDiffMillions);
           				$("#dateDiff").text(dataDiffMap[dateDiffMillions]);
           				//倒计时
           				countDownInterval(dateDiffMillions);
           			}
           		} else {
           			$("#dateDiff").attr("dateDiffMillions","");
           			$("#dateDiff").text("");
           		}
           	} else {
           		layer.alert(data.msg);
           	}
        }  
	});
}

//倒计时
function countDownInterval(dateDiffMillions){
	var interval = setInterval( function(){
     	dateDiffMillions = dateDiffMillions-1000;
     	if (parseInt(dateDiffMillions) < 1000){
     		window.location.reload(true);
     		clearInterval( interval );
     	} else {
     		$("#dateDiff").text(countDown(dateDiffMillions));
     	}
		$("#dateDiff").attr("dateDiffMillions",dateDiffMillions);
     }, 1000 );
}

//上拉刷新
function dropLoad(){
	$('.part').dropload({
        scrollArea : window,
        loadDownFn : function(me){
        	 meObject = me;
	       	 if (parseInt($("#nextPageIndex").val()) > parseInt($("#totalPages").val())){
	       		 // 锁定
	             me.lock();
	             // 无数据
	             me.noData();
	             me.resetload();
	       	 } else {
	       		 var isEnd = false;
	   	    	 var beginSearchDateStr = "";
	   	    	 //如果是已结束
	   	    	 if ($(".on > button").attr("id") == "swiper_btn1"){
	   	    		 isEnd=true;
	   	    	 } else {
	   	    		 //如果是具体日期
	   	    		 beginSearchDateStr = $(".on > button").attr("auctionDate");
	   	    	 }
	       		 getDataList(isEnd,beginSearchDateStr,me);
	       	 }
        }
    });
}

//获取商品数据
function getDataList(isEnd,beginSearchDateStr,me){

	var data = "pageIndex="+$("#nextPageIndex").val()+"&pageSize=5";
	if (isEnd){
		data += '&isEnd='+isEnd;
	} else {
		data += '&beginSearchDateStr='+beginSearchDateStr;
	}
	$.ajax({
		   type: "POST",
		   url: "/mine/publishedProduct/queryPublishedProductList",
		   cache: false,
		   data: data,
		   dataType: "json",
		   success: function(data){
			   if(data == 'sessionTimeout'){
                   location.href="/trade/mine/sessionTimeout.do?v="+Math.random();//跳转到session失效页面
               }else if (data.success){
				   var dataList = data.data;
				   var html = "";
				   if (isEnd){
					   $.each(dataList,function(i,product){
						   html += endObjectToHtml(product);
		  			   });
					   if (checkEmpty(me)){
						   $(".dataPageStatus").before(html);
					   } else {
		                   setTimeout(function(){
		                	   $(".dataPageStatus").before(html);
		                	   me.resetload();
		                   },1000);
					   }
				   } else {
		  			   $.each(dataList,function(i,product){
		  				   html += unEndObjectToHtml(product);
		  			   });
		  			   if (checkEmpty(me)){
		  				   $( ".deal_buy" ).append(html);
		  			   } else {
		  				   setTimeout(function(){
		  					   $( ".deal_buy" ).append(html);
		                	   me.resetload();
		                   },1000);
		  			   }
	  			   }
	  			   $("#totalPages").val(data.pageCount);
	  			   $("#nextPageIndex").val(parseInt($("#nextPageIndex").val())+1);
	  			   if (checkEmpty(me)){
		  				if (parseInt($("#nextPageIndex").val()) <= parseInt($("#totalPages").val())){
		  					if (!checkEmpty(meObject)){
			  					meObject.unlock();
			  					meObject.noData(false);
		  					}
		  					$(".dropload-down").empty().append("<div class='dropload-refresh'>↑上拉加载更多</div>");
		  				} else {
		  					if (!checkEmpty(meObject)){
			  					meObject.lock();
			  					meObject.noData();
		  					}
		  					$(".dropload-down").empty().append("<div class='dropload-noData'>暂无更多数据</div>");
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
	  			   
				   if (!checkEmpty(me)){
					   me.resetload();
				   }
				   layer.alert(data.msg);
			   }
			   
		   },
		   error : function() {
			   //关闭加载弹出框
  			   layer.closeAll();
  			   
			   if (!checkEmpty(me)){
				   me.resetload();
			   }
		       layer.alert("操作异常，请联系管理员！");
		   }
 	});
}

//未结束的数据组装拼接html
function unEndObjectToHtml(tradeProduct){
	var v = new Date();
	var html = '<div class="deal_shangjia">'
	    	 + 		'<div class="deal_shangjia_pic">';
    if (tradeProduct.bidInfoImgModelLst.length > 0){
    	html +=			'<img src="'+imgServer+'/crop/100/100'+tradeProduct.bidInfoImgModelLst[0].url+'" style="width:6.5rem;height: 6.5rem;border-radius: 0.7rem;"/>';
    }else {
    	html +=			'<img src="/static/newhope/html/images/morentu.png" style="width:6.5rem;height: 6.5rem;border-radius: 0.7rem;"/>';
    }
	    html +=		'</div>'
	         +		'<div class="deal_shangjia_text">'
		     +  	 	'<div class="numClass">'
		     +				'<div>'
	         +   				'<span>'+tradeProduct.marketingNumber+'</span>'
	         +   				'<span style="font-size:0.85rem;">头</span>'
	         +				'</div>'
	    	 +				'<div style="font-size:0.666667rem;">';
	if (tradeProduct.surplusNumber == 0){
		html +=					'<span>已售完</span>';
	} else if (tradeProduct.surplusNumber != 0 && tradeProduct.bidedNumber > 0){
		html +=					'<span>已售<span>'+tradeProduct.bidedNumber+'</span>头</span>,<span>剩余<span>'+tradeProduct.surplusNumber+'</span>头</span>';
	}
	    html +=				'</div>'
	         +			'</div>';
	if (tradeProduct.status == 'BEFORE_AUCTION' && (tradeProduct.publishUserId == $("#userId").val() || $("#circleRole").val() == 'CREATOR') ){
		html +=			'<a href="/mine/publishedProduct/selectPublishedProductDetail?productId='+tradeProduct.id+'&v='+new Date()+'&operate=modify">'
			 +				'<button class="btn_edit"></button>'
			 +			'</a>'
			 +			'<button class="btn_delete" onclick="deleteProductById('+tradeProduct.id+')"></button>';
	}else {
		html +=			'<a href="/mine/publishedProduct/selectPublishedProductDetail?productId='+tradeProduct.id+'&v='+new Date()+'&operate=read">'
			 +				'<button class="deal_btn btn_read" style="margin-top:0.4rem;margin-left:5.5rem;position: absolute;float: left;height:1.5rem;">查看详情</button>'
			 +			'</a>';
	}
		html +=		'</div>';
	var farmerName = tradeProduct.farmerName;
	if (checkEmpty(farmerName)){
		farmerName = "";
	}
		html +=		'<div class="deal_shangjia_text2">'
			 +			'<div class="pigFaramName">'+farmerName+'的猪场</div>'
			 +			'<div class="addressDiv">'
			 +				'<div>地址:</div>';
	var addressRegion = tradeProduct.pigFaramAddress.provName + tradeProduct.pigFaramAddress.cityName + tradeProduct.pigFaramAddress.countyName;
	if (addressRegion.length > 13){
		addressRegion = addressRegion.substring(0,12)+"...";
	}
		html +=				'<div title="'+addressRegion+'">&nbsp;'
			 +					addressRegion
			 +				'</div>'
			 +			'</div>';
	var productPriceList = tradeProduct.productPriceList;
	if (null != productPriceList && productPriceList.length > 0){
		var v1Num = 0;
		for(var i = 0; i < productPriceList.length; i ++){
			var productPrice = productPriceList[i];
			if (v1Num ==0 && productPrice.userLevel == 'V1'){
				html += '<div style="margin-top:2rem;" class="priceFirstDiv">'
					 +		'<div style="color:#848689;" class="priceDetailDiv">价格:</div>'
					 +		'<div style="margin-left: 2rem;color:#848689;" class="priceDetailDiv">&nbsp;¥'+productPrice.price.toFixed(2)+'元/kg</div>'
					 +		'<div style="margin-left: 6rem;color:#abaeb3;" class="priceDetailDiv">&nbsp;('+productPrice.weightDes+')</div>'
					 +	'</div>';
				v1Num++;
			} else if(v1Num >0 && productPrice.userLevel == 'V1'){
				html += '<div style="margin-top:'+(v1Num*0.9+2)+'rem;" class="priceOtherDiv">'
				     +		'<div class="priceDetailDiv" style="color:#848689;">&nbsp;¥'+productPrice.price.toFixed(2)+'元/kg</div>'
					 +		'<div class="priceDetailDiv" style="margin-left: 4rem;color:#abaeb3;">&nbsp;('+productPrice.weightDes+')</div>'
					 +	'</div>';
				v1Num++;
			}
		}
	} else {
		html +=			'<div style="margin-top:2rem;" class="priceFirstDiv">'
			 +				'<div style="color:#848689;" class="priceDetailDiv">价格:</div>'
			 +				'<div style="margin-left: 2rem;color:#848689;" class="priceDetailDiv">待定</div>'
			 +			'</div>'
	}
		html +=		'</div>'
			 +	'</div>';
    return html;
}

//拼接结束数据的html
function endObjectToHtml(tradeProduct){
	var html = 	'<div class="endProductDiv box">'
			 +		'<div class="wall"></div>'
			 +		'<div class="deal_buy_1">'
			 +			'<div class="deal_buy_pic">';
	if (tradeProduct.bidInfoImgModelLst.length > 0){
    	html +=				'<img src="'+imgServer+'/crop/100/100'+tradeProduct.bidInfoImgModelLst[0].url+'" style="width:4.5rem;height: 4.5rem;border-radius: 0.2rem;"/>';
    }else {
    	html +=				'<img src="/static/newhope/html/images/morentu.png" style="width:4.5rem;height: 4.5rem;border-radius: 0.2rem;"/>';
    }
	var farmerName = tradeProduct.farmerName;
	if (checkEmpty(farmerName)){
		farmerName = "";
	}
		html +=			'</div>'
			 +			'<div class="deal_buy_message">'
			 +				'<div class="deal_buy_message_1">'+farmerName+'的猪场</div>'
			 +				'<div class="deal_buy_message_2">'
			 +					'<div class="buy_message_head_1">地址:</div>';
	var addressRegion = tradeProduct.pigFaramAddress.provName + tradeProduct.pigFaramAddress.cityName + tradeProduct.pigFaramAddress.countyName;
	if (addressRegion.length > 13){
		addressRegion = addressRegion.substring(0,12)+"...";
	}
	
		html +=					'<div class="buy_message_body_1" title="'+addressRegion+'">&nbsp;'
			 +						addressRegion
			 +					'</div>'
			 +				'</div>'
			 +				'<div class="deal_buy_message_3">';
	
	var productPriceList = tradeProduct.productPriceList;
	if (null != productPriceList && productPriceList.length > 0){
		var v1Num = 0;
		for(var i = 0; i < productPriceList.length; i ++){
			var productPrice = productPriceList[i];
			if (v1Num ==0 && productPrice.userLevel == 'V1'){
				html += 		'<div class="deal_buy_message_4">'
					 +				'<div class="buy_message_head_1">价格:</div>'
					 +				'<div class="buy_message_body_1">¥'+productPrice.price.toFixed(2)+'元/kg</div>'
					 +				'<div class="buy_message_body_2">('+productPrice.weightDes+')</div>'
					 +			'</div>';
				v1Num++;
			} else if(v1Num >0 && productPrice.userLevel == 'V1'){
				html += 		'<div class="deal_buy_message_4">'
					 +				'<div class="buy_message_body_3">¥'+productPrice.price.toFixed(2)+'元/kg</div>'
					 +				'<div class="buy_message_body_2">('+productPrice.weightDes+')</div>'
					 +			'</div>';
				v1Num++;
			}
		}
	} else {
		html +=					'<div class="deal_buy_message_4">'
			 +						'<div class="buy_message_head_1">价格:</div>'
			 +						'<div class="buy_message_head_1">待定</div>'
			 +					'</div>';
	}
		html +=				'</div>'
			 +			'</div>'
			 +			'<div style="width:4.7rem;height:3.75rem;float: left;position: absolute;margin-left: 15.3rem;">'
			 +				'<img src="/static/newhope/html/images/end.png" style="width: 100%;height: 100%;"/>'
			 +			'</div>'
			 +		'</div>'
			 +		'<div class="deal_buy_2">'
			 +			'<div style="float: left;margin-left: 1rem;height:2.3rem;width: 10rem; ">'
			 +				'<div style="height: 1.3rem;line-height: 1.3rem;">'
			 +					'<span style="font-size:1rem;color:#F02B2B;opacity:1;">'+tradeProduct.marketingNumber+'</span>'
			 +					'<span style="font-size:0.833333rem;color:#F02B2B;">头</span>'
			 +				'</div>'
			 +				'<div style="font-size:0.6rem;color:#848689;opacity: 0.6;height: 1rem;line-height: 1rem;">';
	var bidedNumber = tradeProduct.bidedNumber;
	if (checkEmpty(bidedNumber)){
		bidedNumber =0;
	}
		html +=					'<span>售出:&nbsp;<span>'+bidedNumber+'</span>头</span>'
			 +					'<span style="padding-left:0.5rem; ">剩余:&nbsp;<span>'+tradeProduct.surplusNumber+'</span>头</span>'
			 +				'</div>'
			 +			'</div>'
			 +			'<a href="/mine/publishedProduct/selectPublishedProductDetail?productId='+tradeProduct.id+'&v='+new Date()+'&operate=read">'
			 +				'<button class="deal_btn btn_read" >查看详情</button>'
			 +			'</a>'
			 +		'</div>'
			 +		'<div class="wall"></div>'
			 +	'</div>';
	return html;
} 

//删除商品
function deleteProductById(productId){
	if (confirm( "确定删除该拍卖信息？" )){
		
    	$.ajax({
	  		   url: "/mine/publishedProduct/deleteById",
	  		   cache: false,
	  		   data: "productId="+productId,
	  		   dataType: "json",
	  		   success: function(data){
	  			   if(data == 'sessionTimeout'){
	                   location.href="/trade/mine/sessionTimeout.do?v="+Math.random();//跳转到session失效页面
	               }else if (data.success){
	  				   layer.alert("删除成功");
	  				   
	  				   //如果该列表只有一条数据，删除后调到默认界面
	  				   if ($(".part").find("div.deal_shangjia").length == 1){
	  					   location.href = "/mine/publishedProduct/toPublishedList?v="+Math.random();
	  				   } else {
	  					   location.href = "/mine/publishedProduct/toPublishedList?bidDate="+$( "li.on > button" ).attr( "auctionDate" )+"&v="+Math.random();
	  				   }
	  			   } else {
	  				   layer.alert(data.msg);
	  			   }
	  			   
	  		   },
	  		   error : function() {
			       layer.alert("操作异常，请联系管理员！");
			   }
     	});
	}
}
