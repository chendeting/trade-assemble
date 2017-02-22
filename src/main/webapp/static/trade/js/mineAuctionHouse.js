$( function() {
	//如果是自己的价格，并且有商品，出现倒计时
	if ($("#circleRole").val() == "CREATOR"){
		if ($("#selfPrice").val() == "true" && $("#hasProduct").val() == "true" && $("#nowDate").val() == $("#chooseDate").val()){
			$.ajax({  
	            type: "POST",  
	            url: "/trade/product/selectBeginCountDown",
	            data: "circleId="+$("#circleId").val()+"&specifiedDateStr="+$("#nowDate").val(),
	            dataType: "json",  
	            success: function(data){
	            	if(data == 'sessionTimeout'){
	                    location.href="/trade/mine/sessionTimeout.do?v="+Math.random();//跳转到session失效页面
	                }else if (data.success){
		           		var dataDiffMap = data.data;
		           		if (dataDiffMap != null){
		           			$("#dateDiffMapFlag").val("true");
		           			$(".revise2").removeAttr("style");
		    	    		$(".revise").hide();
		    	    		$(".revise1").hide();
		    	    		//dateDiffMillions为map中的key
		           			for (var dateDiffMillions in dataDiffMap){
		           				$("#dateDiffText").show();
		           				$("#dateDiff").show();
		           				$("#dateDiff").attr("dateDiffMillions",dateDiffMillions);
		           				$("#dateDiff").text(dataDiffMap[dateDiffMillions]);
		           				//倒计时
		           				countDownInterval(dateDiffMillions);
		           			}
		           		} else{
		           			$("#dateDiffMapFlag").val("false");
			           		//表示有商品，并且是自己的价格，但是没有倒计时
			           		if ($("#selfPrice").val() == "true" && $("#hasProduct").val() == "true"){
			           			$(".revise1").removeAttr("style");
			    	    		$(".revise").hide();
			    	    		$(".revise2").hide();
			           		}
		           		}
		           	} else {
		           		layer.alert(data.msg);
		           	}
	            }  
			});
		} else if ($("#selfPrice").val() == "true" ){
			$(".revise2").removeAttr("style");
			$(".revise").hide();
			$(".revise1").hide();
		} else if ($("#selfPrice").val() == "false" ){
			$(".revise").removeAttr("style");
			$(".revise1").hide();
			$(".revise2").hide();
		}
	}
	
    //修改价格
	if ($("#circleRole").val() == "CREATOR"){
	    $(".modifyPriceBut").click(function(){
	    	
	    	var errMsg = "";
	    	$("input[name='price']").each(function(i){
	    		if ($(this).val() == null || $(this).val() == ""){
	    			errMsg = "录入价格时请把价格录入完整！";
	    			return false;
	    		}
	    	});
	    	if ("" != errMsg){
	    		layer.alert(errMsg);
	    		return;
	    	} 
	    	//加载中
	    	layer.load(1, {
	    		time: 5000,
	    		shade: [0.5, '#000000']
	    	});
	    	
	    	$.ajax({  
	            type: "POST",  
	            url: "/mine/auctionHouse/saveCirclePrice",
	            contentType : "application/json",
	            data: circlePriceJson(),  
	            dataType: "json",  
	            success: function(data){
	            	//关闭加载弹出框
		  			layer.closeAll();
		  			if(data == 'sessionTimeout'){
	                    location.href="/trade/mine/sessionTimeout.do?v="+Math.random();//跳转到session失效页面
	                }else if (data.success){
		           		$(".revise1").removeAttr("style");
		    			$(".revise").hide();
		    			$(".revise2").hide();
		    			
		           		var href = "/mine/auctionHouse/toHousePage?v="+Math.random();
		           		if ($("#chooseDate").val() != $("#nowDate").val()){
		           			href += "&chooseDate="+$("#chooseDate").val();
		           		} 
		           		location.href=href;
		           	} else {
		           		//关闭加载弹出框
			  			layer.closeAll();
		           		layer.alert(data.msg);
		           	}
	            },
	            error:function(){
	            	//关闭加载弹出框
		  			layer.closeAll();
	            	layer.laert("操作异常，请联系管理员！");
	            }
		     });
	    });
	}

	//只能填入最多两位小数
	$(".decimalNum").keyup(function(){  
		decimalNumCheck(this);
    }).on("paste",function(){  //CTR+V事件处理    
    	decimalNumCheck(this);
    }).on("blur",function(){
    	//取消掉结尾的.
    	$(this).val($(this).val().replace(/[^\d]$/g,""));
    });
	
});

//倒计时
function countDownInterval(dateDiffMillions){
	 var interval = setInterval( function(){
    	dateDiffMillions = dateDiffMillions-1000;
    	if (parseInt(dateDiffMillions) < 1000){
    		if ($("#chooseDate").val() == $("#nowDate").val()){
	    		//不让修改价格
    			$("#dateDiff").text("已结束");
	    		$(".revise1").removeAttr("style");
	    		$(".revise").hide();
	    		$(".revise2").hide();
    		}
    		clearInterval( interval );
    	} else {
			$("#dateDiff").text(countDown(dateDiffMillions));
    	}
		$("#dateDiff").attr("dateDiffMillions",dateDiffMillions);
    }, 1000 );
}

//改变有效日期时
function changeChooseDate(thisObj){
	var bidDate = $(thisObj).val();
	if ($("#circleRole").val() == "CREATOR"){
		if (bidDate == $("#nowDate").val()){
			if ($("#dateDiffMapFlag").val() == "true"){
				$("#dateDiffText").show();
				$("#dateDiff").show();
			}
		} else {
			$("#dateDiffText").hide();
			$("#dateDiff").hide();
		}
	}
	getCirclePrice($("#circleId").val(),bidDate);
}

//获取圈子价格
function getCirclePrice(circleId,bidDateStr){
	$.ajax({  
        type: "POST",  
        url: "/mine/circlePrice/queryListByModel",  
        data: "circleId="+circleId+"&priceDateStr="+bidDateStr,  
        dataType: "json",
        cache:false,
        success: function(data){
        	if(data == 'sessionTimeout'){
                location.href="/trade/mine/sessionTimeout.do?v="+Math.random();//跳转到session失效页面
            }else if (data.success){
	       		var dataList = data.data;
	       		if (null != dataList && dataList.length > 0){
	       			$("#selfPrice").val("true");
	           		var circlePrice;
	       	        for(var i=0; i<dataList.length; i++){
	       	        	circlePrice = dataList[i];
	       	        	$("#"+circlePrice.userLevel+"Price").find("."+circlePrice.weightScop).parent().find("input[name='priceId']").val(circlePrice.id);
	       	        	$("#"+circlePrice.userLevel+"Price").find("."+circlePrice.weightScop).parent().find("input[name='price']").val(circlePrice.price.toFixed(2));
	       	        }
	       	        if ($("#circleRole").val() == "CREATOR"){
		       	        if ($("#chooseDate").val() == $("#nowDate").val()){
	       	        		if ($("#dateDiffMapFlag").val() == "false" && $("#hasProduct").val() == "true"){
	       	        			$(".revise1").removeAttr("style");
			       	        	$(".revise").hide();
			       	        	$(".revise2").hide();
	       	        		} else {
	       	        			$(".revise2").removeAttr("style");
			       	        	$(".revise").hide();
			       	        	$(".revise1").hide();
	       	        		}
		       	        } else {
		       	        	$(".revise2").removeAttr("style");
		       	        	$(".revise").hide();
		       	        	$(".revise1").hide();
		       	        }
	       	        }
	       		} else {
	       			$("input[name='priceId']").val('0');
	       			$("input[name='price']").val('');
	       			if ($("#circleRole").val() == "CREATOR"){
		       			$("#selfPrice").val("false");
		       			$(".revise").removeAttr("style");
			    		$(".revise1").hide();
			    		$(".revise2").hide();
	       			} 
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

//获取圈子指定日期设置
//function getCircleSetting(circleId,expireDateStr){
//	$.ajax({  
//        type: "POST",  
//        url: "/mine/circleSetting/queryListByModel",  
//        data: "circleId="+circleId+"&expireDateStr="+expireDateStr,  
//        dataType: "json",
//        cache:false,
//        success: function(data){
//	       	if (data.success){
//	       		var dataList = data.data;
//	       		if (null != dataList && dataList.length > 0){
//	       			
//	       			if ($("#chooseDate").val() == $("#nowDate").val()){
//       	        		if ($("#dateDiffMapFlag").val() == "false" && $("#hasProduct").val() == "true"){
//       	        			$("#modifyCircleTime").hide();
//       	        		} else {
//       	        			$("#modifyCircleTime").show();
//       	        		}
//	       	        } else {
//	       	        	$("#modifyCircleTime").show();
//	       	        }
//	       			
//	       			$("#circleSeetingMapFlag").val("true");
//	           		var circleSetting;
//	       	        for(var i=0; i<dataList.length; i++){
//	       	        	circleSetting = dataList[i];
//	       	        	$("#"+circleSetting.ruleType).text(circleSetting.ruleValue);
//	       	        }
//	       		} else {
//	       			$("#modifyCircleTime").show();
//	       			$("#circleSeetingMapFlag").val("false");
//	       			$("#BID_TIME_START").text("10:00");
//	       			$("#BID_TIME_END").text("22:00");
//	       		}
//	       	} else {
//	       		layer.alert(data.msg);
//	       	}
//        },
//        error : function() {
//			layer.alert("操作异常，请联系管理员！");
//		} 
//	});
//}

// 将价格组装成json
function circlePriceJson(){
	var chooseDate = $("#chooseDate").val();
	var userId = $("#userId").val();
	var circleId = $("#circleId").val();
	var priceList = [];
	$("#V0Price").find("div.grounding_luru").each(function(i){
		var data={
				priceDate:new Date(chooseDate),
				userLevel:"V0",
				creator: userId,
				circleId: circleId,
				id:$(this).find("input[name='priceId']").val(),
				weightScop:$(this).find("input[name='weightScop']").val(),
				weightDes:$(this).find("input[name='weightDes']").val(),
				price:$(this).find("input[name='price']").val()
		}
		priceList.push(data);
	});
	$("#V1Price").find("div.grounding_luru").each(function(i){
		var data={
				priceDate:new Date(chooseDate),
				userLevel:"V1",
				creator: userId,
				circleId: circleId,
				id:$(this).find("input[name='priceId']").val(),
				weightScop:$(this).find("input[name='weightScop']").val(),
				weightDes:$(this).find("input[name='weightDes']").val(),
				price:$(this).find("input[name='price']").val()
		}
		priceList.push(data);
	});
	return JSON.stringify(priceList);
}

//跳转到设置统一开拍起止时间
function toTimePage(){
	var href="/mine/auctionHouse/toSetTimePage?circleId="+$("#circleId").val()+"&v="+Math.random();
	$("#toTimePage").attr("href",href);
}
