$(function(){
	//只能填入最多两位小数
	$(".decimalNum").keyup(function(){ 
		decimalNumCheck(this);
    }).on("paste",function(){  //CTR+V事件处理    
    	decimalNumCheck(this);
    });
	
	//只能填入正整数
	$(".wholeNum").keyup(function(){  
		wholeNumCheck(this);
    }).on("paste",function(){  //CTR+V事件处理    
    	wholeNumCheck(this);
    });
});

//改变实收金额时
function changeRealPrice(){
//	var receivableTotalPrice = parseFloat($.trim($("#receivableTotalPrice").val()));
//	var realTotalPrice = $.trim($("#realTotalPrice").val());
//	if (checkEmpty(realTotalPrice)){
//		realTotalPrice = 0;
//	}
//	realTotalPrice = parseFloat(realTotalPrice);
	
//	if (receivableTotalPrice != realTotalPrice){
//		$("#remarks").val("实收金额与应收金额相差："+(realTotalPrice - receivableTotalPrice).toFixed(2));
//	} else {
//		$("#remarks").val("");
//	}
}

//点击录入情况的否更改状态
function showEditDiv(orderId,flag){
	//订单未录入交易情况
	if(flag == "no"){
		$("#noEntered").show();
		$("#yesEntered").hide();
	} else {
		$("#noEntered").hide();
		$("#yesEntered").show();
	}
	$("input[name='orderTradeType']").removeAttr("disabled");
	$(".submitBtn").show();
	
	$.ajax({
		type: "POST",
		url: "/mine/saledProduct/selectOrderDetailById",
		cache: false,
		data: "orderId="+orderId,
		dataType: "json",
		success: function(data){
			if(data == 'sessionTimeout'){
                location.href="/trade/mine/sessionTimeout.do?v="+Math.random();//跳转到session失效页面
            }else if (data.success){
				var exOrder = data.data;
				$("#buyUserId").val(exOrder.buyUserId);
				$(".order_part2").find(".order_phone_pic").attr("href","tel:"+exOrder.buyUserMobile);
				if (!checkEmpty(exOrder.buyUserHeadImg)){
					$(".order_part2").find(".order_pic_bg").css("background-image","url("+exOrder.buyUserHeadImg+")");
				}
				var buyUserRealName = exOrder.buyUserRealName;
				if (checkEmpty(buyUserRealName)){
					buyUserRealName = "";
				}
				$("#buyUserRealName").text(buyUserRealName);
				var orderCount = exOrder.count+"头";
				$("#orderCount").text(orderCount);
				$("#orderNum").text(exOrder.orderNumber);
				
				$("#orderId").val(exOrder.id);
				if (exOrder.isEntered == "YES"){
					var orderTrade = exOrder.orderTradeInfo;
					$("input[name='orderTradeType'][value='"+orderTrade.orderTradeType+"']").click();
					$("#orderTradeId").val(orderTrade.id);
					$("#pullPigNum").val(orderTrade.pullPigNum);
					
					$("#pigTotalWeight").val(orderTrade.pigTotalWeight);
					var pigAvgWeight = checkEmpty(orderTrade.pigAvgWeight) ? "" : orderTrade.pigAvgWeight;
					var unitPrice = checkEmpty(orderTrade.unitPrice) ? "" : orderTrade.unitPrice;
					var receivableTotalPrice = checkEmpty(orderTrade.receivableTotalPrice) ? "" : orderTrade.receivableTotalPrice;
					
					$("#pigAvgWeight").val(pigAvgWeight);
					$("#pigAvgWeight").next().text(pigAvgWeight);
					$("#unitPrice").val(unitPrice);
					$("#unitPrice").next().text(unitPrice);
					$("#receivableTotalPrice").val(receivableTotalPrice);
					$("#receivableTotalPrice").next().text(receivableTotalPrice);
					
					$("#realTotalPrice").val(orderTrade.realTotalPrice);
					$("#remarks").val(orderTrade.remarks);
					
					//信息已经过期
					if (data.msg == "EXPIRED" || ( $("#userId").val() != $("#publishUserId").val() && $("#circleRole").val() != 'CREATOR' ) ){
						$("input[name='orderTradeType']").attr( "disabled", "disabled");
						$(".submitBtn").hide();
					}
					
				} else {
					$("input[name='orderTradeType'][value='PULL_PIG']").click();
					$("#pullPigNum").val(exOrder.count);
					if ( $("#userId").val() != $("#publishUserId").val() && $("#circleRole").val() != 'CREATOR' ){
						$("input[name='orderTradeType']").attr( "disabled", "disabled");
						$(".submitBtn").hide();
					}
				}
				
				$(".order_part1").hide();
				$(".order_part2").show();
				
			} else {
				layer.alert(data.msg);
			}
			
		},
		error : function() {
			layer.alert("操作异常，请联系管理员！");
		}
	});
}

//隐藏订单交易情况录入div
function hideEditDiv(){
	$(".order_part1").show();
	$(".order_part2").hide();
	var orderId = $("#orderId").val();
	var orderTradeId = $("#orderTradeId").val();
	$("#orderTradeForm")[0].reset();
	$("#pigAvgWeight").next().text("");
	$("#unitPrice").next().text("");
	$("#receivableTotalPrice").next().text("");
	$("#orderId").val(orderId);
	$("#orderTradeId").val(orderTradeId);
	
}

//切换已拉猪和弃单时
function changeTradeType(tradeType){
	//已拉猪
	if (tradeType == 'PULL_PIG'){
		$('#baseInfoDiv').show();
		$('#remarks').val('');
		$('#pullPigNum').val($("#orderCount").text().replace("头",""));
	} else if (tradeType == 'GIVE_UP_ORDER'){
		//弃单
		$('#baseInfoDiv').hide();
		$('#remarks').val('');
		if (checkEmpty($("#orderTradeId").val())){
			$("#pullPigNum").val("");
			$("#pigTotalWeight").val("");
			$("#pigAvgWeight").val("");
			$("#pigAvgWeight").next().text("");
			$("#unitPrice").val("");
			$("#unitPrice").next().text("");
			$("#receivableTotalPrice").val("");
			$("#receivableTotalPrice").next().text("");
			
			$("#realTotalPrice").val("");
		}
	}
}

//提交表单
function submitForm(){
	if ($("input[name='orderTradeType'][value='PULL_PIG']").prop("checked")){
		var message = validateForm("requireInput","alertMsg");
		if (checkEmpty(message)){
			var orderCount = $.trim($("#orderCount").text());
			var pullPigNum = $.trim($("#pullPigNum").val())+"头";
			var receivableTotalPrice = parseFloat($.trim($("#receivableTotalPrice").val()));
			var realTotalPrice = parseFloat($.trim($("#realTotalPrice").val()));
			if ( ( orderCount != pullPigNum || receivableTotalPrice != realTotalPrice ) && checkEmpty( $("#remarks").val() ) ){
				layer.alert("请录入异常情况！");
				return;
			}
		} else {
			layer.alert(message);
			return;
		}
	} else if ($("input[name='orderTradeType'][value='GIVE_UP_ORDER']").prop("checked")){
		if (checkEmpty($("#remarks").val())){
			layer.alert("跑单时，异常信息不能为空！");
			return;
		}
	}
	//加载中
	layer.load(1, {
		time: 5000,
		shade: [0.5, '#000000']
	});
	$("#orderTradeForm").ajaxSubmit({
		success:  function(result) {
			if (result.success){
				window.location.reload( true );
			} else {
				//关闭加载弹出框
				layer.closeAll();
				layer.alert(result.msg);
			}
			
		},
		error:function(){
			//关闭加载弹出框
  			layer.closeAll();
			layer.alert("操作异常，请联系管理员！");
		}
	});
}

//该表拉猪头数和猪只总重时，猪只均重和价格更改
function changePriceAvgWeight(){
	if (!checkEmpty($("#pullPigNum").val()) && !checkEmpty($("#pigTotalWeight").val())){
		var avgWeight = ($("#pigTotalWeight").val()/$("#pullPigNum").val()).toFixed(2);
		$("#pigAvgWeight").val(avgWeight);
		$("#pigAvgWeight").next().text(avgWeight);
		var weightScop;
		if (parseInt(avgWeight) >= 100 && parseInt(avgWeight) < 110){
			weightScop = "AVG_WEIGHT_100TO110";
		} else if (parseInt(avgWeight) >= 110 && parseInt(avgWeight) < 120){
			weightScop = "AVG_WEIGHT_110TO120";
		} else if (parseInt(avgWeight) >= 120){
			weightScop = "AVG_WEIGHT_120";
		} else{
			layer.alert("均重过低，不能出栏!");
			$("#unitPrice").val("");
			$("#unitPrice").next().text("");
			$("#receivableTotalPrice").val("");
			$("#receivableTotalPrice").next().text("");
			
			$("#realTotalPrice").val("");
			$('#remarks').val('');
			return;
		}
		
		$.ajax({
			type: "POST",
			url: "/mine/saledProduct/selectUserLevelByCondition",
			cache: false,
			data: "circleId="+$("#circleId").val()+"&buyUserId="+$("#buyUserId").val(),
			dataType: "json",
			success: function(data){
				if(data == 'sessionTimeout'){
	                   location.href="/trade/mine/sessionTimeout.do?v="+Math.random();//跳转到session失效页面
	            }else if (data.success){
					var userLevel = data.data;
					var unitPrice = $("#"+userLevel+"_"+weightScop).val();
					$("#unitPrice").val(unitPrice);
					$("#unitPrice").next().text(unitPrice);
					$('#remarks').val('');
					
					if (!checkEmpty(unitPrice)){
						var receivableTotalPrice = parseFloat(unitPrice).toFixed( 2 )*parseFloat($("#pigTotalWeight").val()).toFixed( 2 );
						receivableTotalPrice = parseFloat( receivableTotalPrice ).toFixed( 2 );
						
						$("#receivableTotalPrice").val(receivableTotalPrice);
						$("#receivableTotalPrice").next().text(receivableTotalPrice);
						$("#realTotalPrice").val(receivableTotalPrice);
					} else{
						var message="";
						if (checkEmpty(userLevel)){
							message += "<font>该买家在拍卖场中无对应会员等级！</font><br/>";
						} else if(checkEmpty(unitPrice)){
							message += "<font>该商品没有设置价格！<font><br/>";
						}
						layer.alert(message);
					}
				} else {
					layer.alert(data.msg);
				}
				
			},
			error : function() {
				layer.alert("操作异常，请联系管理员！");
			}
		});
	} else {
		$("#pigAvgWeight").val("");
		$("#pigAvgWeight").next().text("");
		$("#unitPrice").val("");
		$("#unitPrice").next().text("");
		$("#receivableTotalPrice").val("");
		$("#receivableTotalPrice").next().text("");
		$("#realTotalPrice").val("");
	}
}
