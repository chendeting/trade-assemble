//根据猪场名称判断是否有猪场
var hasPig = false;

//开始时间
var startValue = "";
// 结束时间
var endValue = " ";

// 竞拍框
var myDate1 = new Date();
var currentDate = myDate1.toLocaleDateString();
var myDate2 = new Date(currentDate);
// 获取竞拍时间框的 选择时间
var IdauctionDate = "";

//初始化picker
initPicker();

function initPicker(){
	$("#startTime").picker({
		title: "选择开始时间",
		cols: [
		       {
		    	   textAlign: 'center',
		    	   values: ['00点', '01点', '02点', '03点', '04点', '05点', '06点', '07点', '08点', '09点', '10点', '11点', '12点', '13点', '14点', '15点', '16点', '17点', '18点', '19点', '20点', '21点', '22点', '23点']
		       },
		       {
		    	   textAlign: 'center',
		    	   values: ['00分', '10分', '20分', '30分', '40分', '50分']
		       }
		       ],
		       onChange:function(p, values, displayValues){
		    	   startValue = values;
		       }
	});
	$("#endTime").picker({
		title: "选择结束时间",
		cols: [
		       {
		    	   textAlign: 'center',
		    	   values: ['00点', '01点', '02点', '03点', '04点', '05点', '06点', '07点', '08点', '09点', '10点', '11点', '12点', '13点', '14点', '15点', '16点', '17点', '18点', '19点', '20点', '21点', '22点', '23点']
		       },
		       {
		    	   textAlign: 'center',
		    	   values: ['00分', '10分', '20分', '30分', '40分', '50分']
		       }
		       ],
		       onChange:function(p, values, displayValues){
		    	   endValue = values;
		       }
	});
}
	


//获取圈子的设置和价格
function getCircleSettingAndPrice(circleId,priceDateStr){
	$.ajax({
		type : "POST",
		url : "/trade/circle/queryCircleExSettingAndPrice",
		data:"circleId="+circleId+"&priceDateStr="+priceDateStr,
		dataType:"json",
		success:function(result){
			if (!checkEmpty(result)){
				var isBidtime = result.isBidtime;
				var isLevel = result.isLevel;
				var isPrice = result.isPrice;
				var priceStatus = result.priceStatus;
				$("#isBidtime").val(isBidtime);
				$("#isLevel").val(isLevel);
				$("#isPrice").val(isPrice);
				
				if (isBidtime || isBidtime == "true"){//统一拍卖时间
					var circleSettingList = result.circleSettingList;
					var BID_TIME_START = "";
					var BID_TIME_END = "";
					$.each(circleSettingList,function(i,circleSetting){
						if (circleSetting.ruleType == 'BID_TIME_START'){
							BID_TIME_START = circleSetting.ruleValue;
						} else if (circleSetting.ruleType == 'BID_TIME_END'){
							BID_TIME_END = circleSetting.ruleValue;
						}
					});
					var html = 	'<input type="hidden" name="BID_TIME_START" value="'+BID_TIME_START+'"/>'
			                 +	'<input type="hidden" name="BID_TIME_END" value="'+BID_TIME_END+'"/>'
				             +  '<div class="weui-row fixedTime">'
				             + 		'<p class="fixedStart">'+BID_TIME_START+'</p>'
				             + 		'<span>至</span>'
				             + 		'<p class="fixedEnd">'+BID_TIME_END+'</p>'
				             + 	'</div>';
					$(".time2 > p").siblings().remove();
					$(".time2").append(html);
				} else{ //非统一拍卖时间
					var html = '<div class="weui-row auctionTime">'
				             +     '<div class="weui-col-40 findinput">'
				             +         '<input class="weui_input" id="startTime" name="BID_TIME_START" type="text" value="" placeholder="起始时间">'
				             +         '<i class="fa fa-caret-down" aria-hidden="true"></i>'
				             +     '</div>'
				             +     '<div class="weui-col-6">至</div>'
				             +     '<div class="weui-col-40 findinput">'
				             +         '<input class="weui_input" id="endTime" name="BID_TIME_END" type="text" value="" placeholder="终止时间">'
				             +         '<i class="fa fa-caret-down" aria-hidden="true"></i>'
				             +     '</div>'
				             +  '</div>';
					$(".time2 > p").siblings().remove();
					$(".time2").append(html);
					//初始化picker
					initPicker();
				}
				
				if (isPrice || isPrice=="true"){
					var html = "";
					if (priceStatus == "false"){
						html = '<div class="weui-col-75">'
			                 +     '<p class="notSure">价格待定</p>'
				             + '</div>';
					} else if (priceStatus == "true"){
						html = template('dateChangeHaveCirclePrice', result);
					}
					$("#productPriceListJson").next().remove();
					$("#productPriceListJson").after(html);
					$(".LipriceWrite").hide();
					$(".LipriceWrite").find("ul").empty();
				} else {
					var btnHtml = '<div class="weui-col-75">'
				                +	  '<input name="isDiscuss" id="isDiscuss" type="hidden"/>'
				                +     '<div id="priceWrite" class="btnPrice priceActive">价格录入</div>'
				                +     '<div class="btnPrice">现场议价</div>'
				                + '</div>';
					$("#productPriceListJson").next().remove();
					$("#productPriceListJson").after(btnHtml);
					//初始化价格切换
					btnPriceClick();
					
					var priceHtml = "";
					if (isLevel || isLevel == "true"){
						priceHtml = template('dateChangeNoCirclePrice', result);
					} else{
						priceHtml = '<li class="handWrite">'
								  +		'<input type="number" class="handWrite priceRequired decimalNum" name="marketingPrice" value="" placeholder="请输入出栏价格">'
								  +		'<span class="Kg">元/KG</span>'
								  +	'</li>';
					}
					$(".LipriceWrite").find("ul").empty();
					$(".LipriceWrite").find("ul").append(priceHtml);
					$(".LipriceWrite").show();
				}				
			} 
		},
		error:function(){
			$.toast("操作异常，请联系管理员！","text");
		}
	})
}

// 控料选择
$("#kongliao").select({
    title: "选择控料情况",
    multi: false,
    input:"控料8小时",
    items: [
        {
            title: "自由采食",
            value: "NATURE"
        },
        {
            title: "控料4小时",
            value: "FOUR_HOURS"
        },
        {
            title: "控料8小时",
            value: "EIGHT_HOURS"
        },
        {
            title: "控料12小时",
            value: "TWELVE_HOURS"
        },
    ],
    onChange:function(d){
    	$("#controllerFeedstuffInfoVal").val(d.values);
    	$(".selectType").css({"display":"none"});
    },
    onOpen:function(){
    	  //取消按钮
        $(".toolbar-inner").append("<input type='button' class='cityPickerCancel close-picker close-select'  value='取消'>");
        $(".selectType").css({"display":"block"});
        $("input").each(function(){
            if($(this).attr("id") === document.activeElement.id){
                $(this).blur();
            }
      })
   },
   onClose:function(){
  	 $(".selectType").css({"display":"none"});    
  }
});
// 出栏品种
$("#pigType").select({
    title: "选择出栏情况",
    multi: false,
    items: [
        {
            title: "黑猪",
            value: "BLACK_PIG"
        },
        {
            title: "土杂猪",
            value: "MISCELLANEOUS_PIG"
        },
        {
            title: "内三元猪",
            value: "INNER_THREE_YUAN"
        },
        {
            title: "外三元猪",
            value: "OUTER_THREE_YUAN"
        },
        {
            title: "内二元猪",
            value: "INNER_TWO_YUAN"
        },
        {
            title: "外二元猪",
            value: "OUTER_TWO_YUAN"
        },
    ],
    onChange: function(d){
    	$("#pigTypeVal").val(d.values);
    	$(".selectType").css({"display":"none"});
    },
    onOpen:function(){
    	  //取消按钮
        $(".toolbar-inner").append("<input type='button' class='cityPickerCancel close-picker close-select'  value='取消'>");
        $(".selectType").css({"display":"block"});
        $("input").each(function(){
            if($(this).attr("id") === document.activeElement.id){
                $(this).blur();
            }
      })
   },
   onClose:function(){
  	 $(".selectType").css({"display":"none"});    
  }
});
// 限制高度操作
$("#heightLimit").select({
    title: "选择限高条件",
    multi: false,
    items: [
        {
            title: "限高低于3.5米",
            value: "TRIFFIC1"
        },
        {
            title: "限高3.5米",
            value: "TRIFFIC2"
        },
        {
            title: "限高4.5米",
            value: "TRIFFIC3"
        },
        {
            title: "限高5米",
            value: "TRIFFIC4"
        },
    ],
    onChange: function(d){
    	$("#limitHeightVal").val(d.values);
    	$(".selectType").css({"display":"none"});
    },
    onOpen:function(){
    	
    	  //取消按钮
        $(".toolbar-inner").append("<input type='button' class='cityPickerCancel close-picker close-select'  value='取消'>");
        $(".selectType").css({"display":"block"});
        $("input").each(function(){
            if($(this).attr("id") === document.activeElement.id){
                $(this).blur();
            }
      })
   },
   onClose:function(){
  	 $(".selectType").css({"display":"none"});    
  }
});
// 限长操作
$("#lengthLimit").select({
    title: "选择限长条件",
    multi: false,
    items: [
        {
            title: "限长小于4.8米",
            value: "TRIFFIC1"
        },
        {
            title: "限长4.8米",
            value: "TRIFFIC2"
        },
        {
            title: "限长5.3米",
            value: "TRIFFIC3"
        },
        {
            title: "限长6.8米",
            value: "TRIFFIC4"
        },
        {
            title: "限长7.2米",
            value: "TRIFFIC5"
        },
        {
            title: "限长9.6米",
            value: "TRIFFIC6"
        },
    ],
    onChange: function(d){
    	$("#limitLengthVal").val(d.values);
    	$(".selectType").css({"display":"none"});
    },
    onOpen:function(){
    	  //取消按钮
        $(".toolbar-inner").append("<input type='button' class='cityPickerCancel close-picker close-select'  value='取消'>");
        $(".selectType").css({"display":"block"});
        $("input").each(function(){
            if($(this).attr("id") === document.activeElement.id){
                $(this).blur();
            }
      })
    },
    onClose:function(){
    	 $(".selectType").css({"display":"none"});    
    }
});

//确定按钮
$(".picker-button").on("click",function(){
	$(".selectType").css({"display":"none"});
})
$(".close-select").on("click",function(){
	$(".selectType").css({"display":"none"});
})


$(function(){
	var contentNum2 = 0;
    var contentNum3 = 0;
    var contentNum4 = 0;
    
    

    // 1)选择圈子，点击"下一步"，跳到拍卖场页面
    $(".chooseHref").on("click",function(){
        $(this).removeClass("errMes");

    })
    $(".nextStep").on("click",function(){
        if(checkEmpty($("#circleId").val())){
            $(".chooseHref").addClass("errMes");
            $.toast("红框为必填项！","text");
            
        }else{
            $("#step1_chooseCircle").hide();
            $("#step2_auctionInfo").show();

            $(".stepAll>.step2").addClass("currentStep");
            $(".line1").addClass("currentLine");
            
           
        }
    })

    // 2)拍卖圈信息
    // 点击"上一步"，跳到选择圈子页面
    $("#step2Before").on("click",function(){
        $("#step2_auctionInfo").hide();
        $("#step1_chooseCircle").show();

        $(".stepAll>.step2,.stepAll>.step3,.stepAll>.step4").removeClass("currentStep");
        $(".line1,.line2,.line3").removeClass("currentLine");
    });
    // 点击"下一步"，跳到商品信息页面
    $("#step2After").on("click",function(){
        // 不跳转样式
        if(contentNum2 <3){
            // 竞拍时间
            $(".time1 input").each(function(index,item){
                if($(this).val().length == 0){
                    $(".time1").addClass("errMes");
                
                    
                    // 不跳转
                }else{
                    contentNum2++;
                }
            })
            // 起始时间
            $(".time2 input").each(function(index,item){
                if($(this).val().length == 0){
                    $(this).parents().css({"border-color":"#FA4848 "});
                    $(".time2").addClass("errMes");
                    // 不跳转
                }else{
                    contentNum2++;
                }
            })
        }
        // 跳转样式
        if(contentNum2 >= 3){
        	if (!checkEmpty(startValue) && !checkEmpty(endValue)){
	        	// 1）用户自己选择的时间
	        	var startTime = "";
	        	var endTime = "";
	        	startTime = startValue;
	        	endTime = endValue;
	        	IdauctionDate = $("#IdauctionDate").val(); 
	        	
	        	// startTime endTime是用户自己选择的开始和结束时间  **:**
	        	startTime = startTime[0].substring(0,startTime.length) + ":"+ startTime[1].substring(0,startTime.length);
	            endTime = endTime[0].substring(0,endTime.length) + ":" + endTime[1].substring(0,endTime.length);       
	            // IdauctionDate 是用户自己选择的日期
	             
	            // 2）本地时间 return yyyy-MM-dd HH:MM
	        	var nowDate = getNowFormatDateMinute();
	        	
	        	// 3）比较
	        	// 如果时间不对，就不跳转
	        	startTime = IdauctionDate+" "+startTime;
	        	startTime = startTime.split(/[- : \/]/);
	        	startTime = new Date(startTime[0], startTime[1]-1, startTime[2], startTime[3], startTime[4]);
	        	
	        	endTime = IdauctionDate+" "+endTime;
	        	
	        	endTime = endTime.split(/[- : \/]/);
	        	endTime = new Date(endTime[0], endTime[1]-1, endTime[2], endTime[3], endTime[4]);
	        	
	           
	        	nowDate = nowDate.split(/[- : \/]/);
	        	nowDate = new Date(nowDate[0], nowDate[1]-1, nowDate[2], nowDate[3], nowDate[4]);
	        	
	        	// console.log(new Date(IdauctionDate+" "+startTime));
	        	if(startTime >= endTime){
	        		$.toast("结束时间不能等于或者小于开始时间", "text");
	        		return;
	        	}else if(startTime <= nowDate){
	        		$.toast("开始时间不能等于或者小于当前系统时间", "text");
	        		return;
	        	}else if(startTime >= nowDate && startTime < endTime){
	        		// 时间对了	        		
		        	$("#step2_auctionInfo").hide();
	                $("#step3_productInfo").show();
	        	}       	
        	} else {
        		$("#step2_auctionInfo").hide();
        		$("#step3_productInfo").show();
        	}
            
            $(".stepAll>.step3,.stepAll>.step2,.stepAll>.step1").addClass("currentStep");
            $(".line1,.line2").addClass("currentLine");
        } else {
        	$.toast("红框为必填项！","text");
        	contentNum2 = 0;
        }

    });

    // 3)商品信息
    // step 3 出栏价格切换
    btnPriceClick();
    
    // 点击"上一步"，跳到拍卖场页面
    $("#step3Before").on("click",function(){
        $("#step3_productInfo").hide();
        $("#step2_auctionInfo").show();

        $(".stepAll>.step3,.stepAll>.step4").removeClass("currentStep");
        $(".line2").removeClass("currentLine");

    })
    // 点击"下一步"，跳到交割信息页面
    $("#step3After").on("click",function(){
    	var priceSuccess = true;
    	var imgSuccess = true;
    	
    	if ($(".photoList").find(".photos").length == 0){
    		imgSuccess = false;
    	}

    	if ($("#priceWrite").hasClass("priceActive")){
    		$(".priceRequired").each(function(i){
    			if(checkEmpty($(this).val())){
    				$(this).addClass("errMes");
    				priceSuccess = false;
    			} else {
    				$(this).removeClass("errMes");
    			}
    		});
    	}
    	
        // 不跳转样式
    	contentNum3 = 0;
        if(contentNum3 < 4){
            // 竞拍时间
            $("#step3_productInfo>ul>li>.weui-row>.weui-col-75>input[type!='hidden']").each(function(index,item){
                if($(this).val().length == 0){
                    $($(this)).addClass("errMes");
                    // 不跳转
                }else{
                    contentNum3++;
                }
            })
        }
        // 跳转样式
        if(contentNum3 >= 4 && priceSuccess && imgSuccess){
            $("#step3_productInfo").hide();
            $("#step4_jiaoGeInfo").show();

            $(".stepAll>.step4,.stepAll>.step3,.stepAll>.step2,.stepAll>.step1").addClass("currentStep");
            $(".line3,.line2,.line1").addClass("currentLine");
        } else {
        	$.toast("图片、带红框为必填项！","text");
        	contentNum3 = 0
        }
    })
    
    // 4)交割信息
    // 点击"上一步"，跳到拍卖场页面
    $("#step4Before").on("click",function(){
        $("#step4_jiaoGeInfo").hide();
        $("#step3_productInfo").show();

        $(".stepAll>.step4").removeClass("currentStep");
        $(".line3").removeClass("currentLine");

    })
    // 点击"完成"，跳到下一个页面
    $("#step4After").on("click",function(){

        // 不跳转样式
    	var requeireOk = true;
        // 竞拍时间
        $("#step4_jiaoGeInfo>ul>li .weui-col-75>input[type='text']").each(function(index,item){
            if($(this).val().length == 0){
                $(this).addClass("errMes");
                // 不跳转
                requeireOk = false;
            }
        })
        // 跳转样式
        if(requeireOk){
            $("#step3_productInfo").hide();
            $("#step4_jiaoGeInfo").show();

            $(".stepAll>.step4,.stepAll>.step3,.stepAll>.step2,.stepAll>.step1").addClass("currentStep");
            $(".line3,.line2,.line1").addClass("currentLine");
        }
        

        // 跳转判断代码
        if(requeireOk){
        	if (checkEmpty($("#mapAddress").val())){
        		$.toast("交割地址不能为空！","text");
        		return;
        	}
        	submitForm();
        } else{
        	$.toast("带红框为必填项！","text");
        }
    })

    // 图片上传
    $("#addNewphoto").on("click",function(){
    	wxChooseImage("uploadCallback");
    })

    // 图片删除事件
    $(document).on("click", "#btnDelete", function() {
    	 $(".confirmDialog").show();
    });
  // 删除照片取消
    $('.btnphotocancel').on("click",function(){
        $(".confirmDialog").hide();
        $(".mengceng").hide();
        $("header,section").show();
    })
    // 删除图片确认
    $('.btnphotodel').on("click",function(){
        $(".confirmDialog").hide();
        $(".mengceng").hide();
        $("header,section").show();

        selectImgDel.remove();

        $(".photoList>div").each(function(index,item){
            if(index <= 3){
                // 最大上传限度 隐藏上传按钮
                $("#addNewphoto").show();
            }
        })
    })
    
    //点击图片 取消删除
    $(".Divimg>img").on("click",function(){
        $(".mengceng").hide();
        $("header,section").show();
    })

    // 验证表单
    $(".time1 input").on("click",function(){
        $(".time1").removeClass("errMes");
    })
    var count = 0;
    $(".time2 input").on("click",function(){
        if($(this).attr("id") == "startTime"){
            count++;
            $(this).parent().css({"border-color":"#D8D8D8"});
        }
        if($(this).attr("id") == "endTime"){
            count++;
            $(this).parent().css({"border-color":"#D8D8D8"});
        }
        if(count == 2){
            $(".time2").removeClass("errMes");
        }
    })
    $(".weui-col-75 input").on("click",function(){
        $(this).removeClass("errMes");
    })
    $("#step4_jiaoGeInfo>ul>li .weui-col-75>input,#step4_jiaoGeInfo>ul>li>textarea").on("click",function(){
        $(this).removeClass("errMes");
    })
    
     // 猪场名字 点击出现下拉框
    $("#pigCircleName").on("focus",function(){
    	queryPigFaramList($.trim($(this).val()));
    })
    $("#pigCircleName").on("blur",function(){
    	
    	//如果根据输入的猪场名称没有匹配的猪场，清空猪场相关数据
    	if (!hasPig){
    		$("#lng").val("");
   	        $("#lat").val("");
   	        $("#mapAddress").val("");
   	        $("#pigFaramId").val("");
   	        $("#limitLengthVal").val("");
   	        $("#lengthLimit").val("");
   	        $("#limitHeightVal").val("");
   	        $("#heightLimit").val("");
   	        $("#otherTrifficInfo").val("");
   	        $("#pigCircleName").val();
    	}
    	hasPig = false;
    	setTimeout( 
    			function(){  
    				$('.selectPig').hide();
    	        },
    	    100);
    });
    
    // 只能填入最多两位小数
	$(".decimalNum").on("blur",function(){
    	var inputVal = $(this).val();
	   	inputVal = inputVal.replace(/[^\d.]/g,""); //清除"数字"和"."以外的字符
	   	inputVal = inputVal.replace(/^\./g,""); //验证第一个字符是数字而不是.
	   	inputVal = inputVal.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的
	   	inputVal = inputVal.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
	   	inputVal = inputVal.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3'); //只能输入两个小数
	   	$(this).val("");
	   	$(this).val(inputVal);
    });
	
	// 只能填入正整数
	$(".wholeNum").keyup(function(){  
		wholeNumCheck(this);
    }).on("paste",function(){  // CTR+V事件处理
    	wholeNumCheck(this);
    });
})
// step 3 出栏价格切换
function btnPriceClick(){
	$(".btnPrice").on("click",function(){
		if(!$(this).hasClass("priceActive")){
			$(this).addClass("priceActive");
			$(this).siblings().removeClass("priceActive");
		}
		
		if($(this).attr("id") == "priceWrite"){
			// 价格录入
			$("li.LipriceWrite").show();
			$("#isDiscuss").val(false);
		}else{
			$("#isDiscuss").val(true);
			$("li.LipriceWrite").hide();
		}
	})
}

// 上传照片后的回调
function uploadCallback(obj){
	uploadCallbackSetValue(obj);
}

// 上传照片后的回调
// 选中的照片
var selectImgDel;
function uploadCallbackSetValue(obj){
	// 上传的真的地址
    var data = {
        photoSrc: obj.imageSrc,
        imgpath: obj.imgPath
    };
    var html =  template('uploadingImg', data);
    // 将新的图片加入到photoList中
    $(".photoList").append(html);
    // 判断上传的照片的数量 >4 ,就不允许上传
    $(".photoList>div").each(function(index,item){
        if(index == 3){
            // 最大上传限度 隐藏上传按钮
            $("#addNewphoto").hide();
        }
    })
    //图片点击事件
	$(".btn_del").each(function(index,item){
	    $(this).click(function(){
	        $(".mengceng").show();
	        $("header,section").hide();
	        $(".basic-info").hide();
	        $("#preview").attr('src', $(this).children("img").attr('src'));
	        // 把当前选中的小图标赋值给全局对象
	        selectImgDel = $(this);
	    })
	})
}
	//图片点击事件
	$(".btn_del").each(function(index,item){
	    $(this).click(function(){
	        $(".mengceng").show();
//	        $("header,section").hide();
//	        $(".basic-info").hide();
	        $("#preview").attr('src', $(this).children("img").attr('src'));
	        // 把当前选中的小图标赋值给全局对象
	        selectImgDel = $(this);
	    })
	})

// 搜索框添加事件
function sendKeyWord(event){
	var input = $('#pigCircleName');  
    
	// 不是上下方向键
    if(event.keyCode != 38 && event.keyCode != 40){  
        var valText = $.trim(input.val());  
        queryPigFaramList(valText);
        // 当为空的时候，清空
        if (checkEmpty(valText)){
        	$("#lng").val("");
   	        $("#lat").val("");
   	        $("#mapAddress").val("");
   	        $("#pigFaramId").val("");
   	        $("#limitLengthVal").val("");
   	        $("#lengthLimit").val("");
   	        $("#limitHeightVal").val("");
   	        $("#heightLimit").val("");
   	        $("#otherTrifficInfo").val("");
        }
    } 
}
  
// 参数为一个字符串，是搜索输入框中当前的内容
function queryPigFaramList(keyword){
	$.ajax({
		type:"POST",
		url:"/user/pigFaram/queryFaramList",
		data:"name="+keyword,
		dataType:"json",
		success:function(result){
			$(".selectPig").empty();
			 if(result == 'sessionTimeout'){
                 location.href="/trade/mine/sessionTimeout.do?v="+Math.random();// 跳转到session失效页面
             }else if (result.success){
				if (!checkEmpty(result.data) && result.data.length > 0 ){
					var html = template("pigFaramList",result);
					$(".selectPig").html(html);
					$(".selectPig").show();
					hasPig = true;
				}
				
			} else {
				$.toast(result.msg,"text");
			}
		},
		error:function(){
			$.toast("操作异常，请联系管理员！","text");
		}
	});
}

// 根据猪场id查询猪场信息
function queryPigFaramInfo(pigFaramId){
	$.ajax({  
        type: "POST",  
        url: "/user/pigFaram/queryPigFaramInfoById",  
        data: "pigFaramId="+pigFaramId,  
        dataType: "json",  
        success: function(data){
        	if(data == 'sessionTimeout'){
                location.href="/trade/mine/sessionTimeout.do?v="+Math.random();// 跳转到session失效页面
            }else if (data.success){
	       		var result = data.data;
	   	        $("#pigCircleName").val(result.name);
	   	        $("#lng").val(result.lng);
	   	        $("#lat").val(result.lat);
	   	        $("#mapAddress").val(result.mapAddress);
	   	        $("#pigFaramId").val(result.id);
	   	        $("#limitLengthVal").val(result.limitLength);
	   	        $("#lengthLimit").val(result.limitLengthDisplayName);
	   	        $("#limitHeightVal").val(result.limitHeight);
	   	        $("#heightLimit").val(result.limitHeightDisplayName);
	   	        $("#otherTrifficInfo").val(result.otherTrifficInfo);
	   	        $(".selectPig").hide();
	   	        
	       	} else {
	       		$.toast(data.msg,"text");
	       	}
      },
      error : function() {
    	  $.toast("操作异常，请联系管理员！","text");
	  }  
  });
}

// 提交表单
function submitForm(){
	$("#step4After").attr("disabled","disabled");
	productPriceJson();
	imgListJson();
	$("#publishForm").ajaxSubmit({
		success:  function(result) {
			if (result.success){
				$.toast("保存成功！","text");
				window.location.href = "/mine/publishedProduct/toMinePublishedPage?pageListType=havePublished&v="+Math.random();
			} else {
				$.toast(result.msg,"text");
				if ("当前圈子属性已改变，请重新发布信息！" == result.msg){
					setTimeout( function(){
							window.location.reload( true );
						}, 1500 );
				} else {
					$("#step4After").removeAttr("disabled");
					
				}
			}
			
		},
		error:function(){
			$.toast("操作异常，请联系管理员","text");
			$("#step4After").removeAttr("disabled");
		}
	});
}

// 将价格组装成json
function productPriceJson(){
	if (!checkEmpty($(".productPriceLi")) && $(".productPriceLi").length > 0){
		var productPriceArr = [];
		$(".productPriceLi").each(function(i){
			var productPriceJson = {
				weightMin:$(this).find(".weightMin").val(),	
				price:$(this).find(".price").val(),	
				isDiscuss:$(this).find(".isDiscuss").val(),	
			};
			if (!checkEmpty($(this).find(".weightMax").val())){
				productPriceJson.weightMax = $(this).find(".weightMax").val();
			}
			productPriceArr.push(productPriceJson);
		});
		$("#productPriceListJson").val(JSON.stringify(productPriceArr));
	}
}

// 将图片组装成json字符串
function imgListJson(){
	var list = []; 
	$(".photoList").find(".photos").each(function(index,item){
		if ($.trim($(this).find("img").attr("imgpath")) != "" ){
			var data = {
				url : $(this).find("img").attr("imgpath")
			};
			list.push(data);
		}
	});
	$("#photoListJson").val(JSON.stringify(list));
}