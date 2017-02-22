//倒计时显示，传入需要计算的毫秒数
function countDown(dateDiffMillions){
	var text = "";
	if ($.isNumeric(dateDiffMillions)){
		//取小时数
		var hours = Math.floor( dateDiffMillions/3600000);
		//转换为总分钟数，再对总分钟数取余，取出不满小时的分钟数
		var minutes = Math.floor(dateDiffMillions/60000%60);
		//转换为秒数，再对总秒数取余，取出不满分钟的秒数
		var seconds = Math.floor(dateDiffMillions/1000%60);
		text = checkTime(hours)+":"+checkTime(minutes)+":"+checkTime(seconds);
	}
	return text;
}

//验证数据是否为空
function checkEmpty(str){
	if ($.trim(str) == null || $.trim(str) == "null"
		|| $.trim(str) == undefined || $.trim(str) == "undefined"
			|| $.trim(str) == ""){
		return true;
	}
	return false;
}

//验证对象是否为空
function checkObjNotEmpty(obj){
	if (obj == null || obj == "null" || obj == undefined || obj == "undefined"|| obj == ""){
		return false;
	}
	return true;
}

//判断是否小于10，小于10前加0
function checkTime(i) {
    if (i<10){
    	i="0" + i;
    }
    return i;
}

//只能输入非0开头正整数
function wholeNumCheck(thisObj){
	var wholeNum = $(thisObj).val().replace(/^(\-)+/g,"").replace(/^0+/g,"").match(/^[1-9]\d*/);
	wholeNum = wholeNum ? wholeNum : "";
	$(thisObj).val("");
	$(thisObj).val(wholeNum[0]);
}

//只能输入整数、最多两位小数
function decimalNumCheck(thisObj){
	 var inputVal = $(thisObj).val();
	 inputVal = inputVal.replace(/[^\d.]/g,""); //清除"数字"和"."以外的字符
	 inputVal = inputVal.replace(/^\./g,""); //验证第一个字符是数字而不是.
	 inputVal = inputVal.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的
	 inputVal = inputVal.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
	 inputVal = inputVal.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3'); //只能输入两个小数
	 $(thisObj).val(inputVal);
}

//验证数据的必填(requireClass：需要验证必填项的类名，alertMsg：在该类中提示语的属性取值)
function validateForm(requireClass,alertMsg){
	var message = "";
	$("."+requireClass).each(function(i){
		if (checkEmpty($(this).val())){
			message += "<font color='red'>"+$(this).attr(alertMsg)+"</font><br/>";
		}
	})
	return message;
}
//包装location.html数据
function warpMapAddress(province,city,district,lat,lgn){
	$("#current_province").val(province);
	$("#current_city").val(city);
	$("#current_district").val(district);
	$("#current_address").val(province+city+district);
	$("#current_lat").val(lat);
	$("#current_lng").val(lgn);
}

//获取华为手机的“前往”按键
document.onkeydown=function(event){
	 var e = event || window.event || arguments.callee.caller.arguments[0];
	 if(e && e.keyCode == 13){ // 华为手机的前往事件
	    //要做的事情
		 //alert("aaaaaa");
		//window.alert=function(){};
		//preventDefault;
		 //return;
	  } 
//	 if(e && e.keyCode == 36){ // 华为手机的前往事件
//		    //要做的事情	 
//			 alert("aaaaaaaaaaaaaaaaaa");						 
//			 //window.alert=function(){};
//			 //preventDefault;
//			 //return;
//		  } 
	};